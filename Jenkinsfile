def app
pipeline {
    agent any

    tools{
        maven 'M3'
    }
     
    stages {

        stage ('Clone the project'){
            steps{ 
                sh "java -version"
                sh "git --version"
                sh "mvn --version"
            }
        }
        
        stage("Compilation and Analysis") {
            steps{

                parallel (
                    'Compilation' : {
                        sh "mvn clean install -DskipTests"
                    },
                    'Static Analysis' : {
                       sh "mvn checkstyle:checkstyle-aggregate"
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
//                                 sh 'mvn test -Punit'
//                             }finally {
//                                 //step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*UnitTest.xml'])
//                             }
//                         }
//                     },
//                     'Running integration tests' :{
//                         script {
//                             try{
//                                 sh "mvn test -Pintegration"
//                             }finally {
//                                 //step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*IntegrationTest.xml'])
//                             }
//                         }
//                     }
//                 )
//             }
//         }
        stage("Package..") {
            steps{
                sh "mvn package"
            }
        }

         stage('Build image') {
            steps {
                    script {
                        app = docker.build("johnkola/bb-web")                    }
            }
         }

        stage('Push image') {
        		steps {
                    script {
                        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-registry-credential') {
                            app.push("${env.BUILD_NUMBER}")
                            app.push("latest")
                            }
                            echo "Trying to Push Docker Build to DockerHub"
                }
                }
        }

    }
}
