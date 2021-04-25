#!groovy
def app
def version
def description
def name

pipeline {
    agent any

    tools {
        maven 'M3'
    }


    stages {

        stage('Clone the project') {
            steps {
                script {
                    version = sh script: 'mvn help:evaluate -Dexpression=project.version -q -DforceStdout', returnStdout: true
                    name = sh script: 'mvn help:evaluate -Dexpression=project.name -q -DforceStdout', returnStdout: true
                    description = sh script: 'mvn help:evaluate -Dexpression=project.description -q -DforceStdout', returnStdout: true
                }

                sh "java -version"
                sh "git --version"
                sh "./mvnw --version"
                echo("name: ${name}")
                echo("version: ${version}")
                echo("description: ${description}")
            }
        }

        stage("Compilation and Analysis") {
            when {
                expression { "${params.fullBuild}" }
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
                expression { "${params.fullBuild}" }
            }
            steps {
                sh "./mvnw package"
            }
        }

        stage('Build image') {
            steps {
                script {
                    app = docker.build("johnkola/bb-web")
                }
            }
        }

        stage('Push image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-registry-credential') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                        app.push("${version}")
                    }
                    echo "Trying to Push Docker Build to DockerHub"
                }
            }
        }

    }
}
