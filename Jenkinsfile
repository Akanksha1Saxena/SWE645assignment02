pipeline {
    agent any
    environment {
        DOCKER_CREDENTIALS = credentials('dockerhub') 
    }
    stages {
        stage('Test Credentials') {
            steps {
                sh 'echo "Docker Username: $DOCKER_CREDENTIALS_USR"'
            }
        }

        stage('Build WAR') {
             steps {
            script {
                    sh 'rm -f target/Studentsurvey.war'
                    sh 'jar -cvf target/Studentsurvey.war -C "src/main/webapp" .'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build  --no-cache -t akanshasaxena1/studentsurvey645:0.1 .'  // Build image
            }
        }

        stage('Docker Login') {
            steps {
                sh 'echo $DOCKER_CREDENTIALS_PSW | docker login -u $DOCKER_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                sh 'docker push akanshasaxena1/studentsurvey645:0.1'  // Push image
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                 sh 'kubectl set image deployment/swe645assignment2-deploy container-0=akanshasaxena1/studentsurvey645:0.1 -n default'
                 sh 'kubectl rollout restart deployment/swe645assignment2-deploy -n default'
                 sh 'kubectl rollout status deployment/swe645assignment2-deploy -n default'
            }
        }
    }
    
    post {
        success {
            echo 'Deployment Successful!'
        }
        failure {
            echo 'Deployment Failed!'
        }
    }
}
