#!groovy
def app_docker
def app_version
def app_description
def app_name
def app_artifactId
def app_registry_hub_docker_namespace = "johnkola"
def app_registry_hub_docker = "https://registry.hub.docker.com"
def app_image_name
def docker_hub_registry_credential
pipeline {
    agent any

    tools {
        maven 'M3'
    }
//
//    environment {
//            docker_hub_registry_credential = credential("docker_hub_registry_credential")
//    }

    stages {
        stage('Set the params') {
            steps {

                withCredentials([usernamePassword(credentialsId: 'amazon', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    // available as an env variable, but will be masked if you try to print it out any which way
                    // note: single quotes prevent Groovy interpolation; expansion is by Bourne Shell, which is what you want
                    sh 'echo $PASSWORD'
                    // also available as a Groovy variable
                    echo USERNAME
                    // or inside double quotes for string interpolation
                    echo "username is $USERNAME"
                }

                sh "java -version"
                sh "git --version"
                sh "./mvnw --version"
                script {
                    app_version = sh script: 'mvn help:evaluate -Dexpression=project.version -q -DforceStdout', returnStdout: true
                    app_name = sh script: 'mvn help:evaluate -Dexpression=project.name -q -DforceStdout', returnStdout: true
                    app_description = sh script: 'mvn help:evaluate -Dexpression=project.description -q -DforceStdout', returnStdout: true
                    app_artifactId = sh script: 'mvn help:evaluate -Dexpression=project.artifactId -q -DforceStdout', returnStdout: true
                    app_image_name = "${app_registry_hub_docker_namespace}/${app_name}"
                }
                echo("name: ${app_name}\nversion: ${app_version}\ndescription: ${app_description}\nartifactId: ${app_artifactId}\nimage_name: ${app_image_name}")
            }
        }

        stage("Compilation and Analysis") {
            when {
                expression { params.fullBuild == true }
            }
            steps {
                parallel(
                        'Compilation': {
                            sh "./mvnw clean install -DskipTests"
                        },
                        'Static Analysis': {
                            sh "./mvnw checkstyle:checkstyle-aggregate"
                            // step([$class: 'CheckStylePublisher',
                            //   canRunOnFailed: true,
                            //   defaultEncoding: '',
                            //   healthy: '100',
                            //   pattern: '**/target/checkstyle-result.xml',
                            //   unHealthy: '90',
                            //   useStableBuildAsReference: true
                            // ])
                        }
                )
            }
        }

//         stage("Tests and Deployment") {
//             steps{
//                 parallel (
//                     'Running unit tests' :{
//                         script {
//                             try{
//                                 sh './mvnw test -Punit'
//                             }finally {
//                                 //step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*UnitTest.xml'])
//                             }
//                         }
//                     },
//                     'Running integration tests' :{
//                         script {
//                             try{
//                                 sh "./mvnw test -Pintegration"
//                             }finally {
//                                 //step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*IntegrationTest.xml'])
//                             }
//                         }
//                     }
//                 )
//             }
//         }
        stage("Package..") {
            when {
                expression { params.fullBuild == true }
            }
            steps {
                sh "./mvnw package"
            }
        }

        stage('Build image') {
            steps {
                script {
                    app_docker = docker.build("${app_image_name}")
                }
            }
        }

        stage('Push image') {
            steps {
                script {
                    try {
                        docker.withRegistry("${app_registry_hub_docker}", "${docker-hub-registry-credential}") {
                            app_docker.push("${env.BUILD_NUMBER}")
                            app_docker.push("${env.GIT_BRANCH}".replaceAll("origin/", "") + "-lts")
                            app_docker.push("${env.GIT_BRANCH}".replaceAll("origin/", "") + "-${version}")
                        }
                    }catch (e){
                        echo "error ${e.getMessage()}"
                    }

                }
                echo "Trying to Push Docker Build to DockerHub"
            }
        }

        stage('K8s') {
            steps {
                script {
                    sh
                    """
                        helm version
                    """
                    echo "Trying to Push Docker Build to DockerHub"
                }
            }
        }
    }
}
