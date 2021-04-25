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
                git branch: 'develop', url: 'https://github.com/johnkola/activeweb.git'
            }
        }
        
        stage("Compilation and Analysis") {
            steps{
                parallel (
                    'Compilation' : {
                        sh "mvn clean install -DskipTests"
                    },
                    'Static Analysis' : {
                        sh "mvn checkstyle:checkstyle"
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

        stage("Tests and Deployment") {
            steps{
                parallel (
                    'Running unit tests' :{
                        script {
                            try{
                                sh 'mvn test -Punit'
                            }finally {
                                //step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*UnitTest.xml'])
                            }
                        }
                    },
                    'Running integration tests' :{
                        script {
                            try{
                                sh "mvn test -Pintegration"
                            }finally {
                                //step([$class: 'JUnitResultArchiver', testResults: '**/target/surefire-reports/TEST-*IntegrationTest.xml'])
                            }
                        }
                    }
                )
            }
        }
    }
}
