pipeline {
    agent any
    environment {
        REGISTRY = '58910810/capstone_cloud_devops' 
    }
    stages {
        stage('Checking out git repo') {
            steps {
                echo 'Checkout...'
                checkout scm
            }
        }

        stage('Checking environment') {
            steps {
                echo 'Checking environment...'
                sh 'git --version'
                echo "Branch: ${env.BRANCH_NAME}"
                sh 'docker -v'
            }
        }

        stage('Lint HTML') {
            steps {
                sh 'tidy -q -e *.html'
            }
        }

        stage('Build') {
            steps {
                sh 'echo Building...'
            }
        }

        stage('Build Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD "
                    sh "docker build -t ${REGISTRY} ."
                    sh "docker tag ${REGISTRY} ${REGISTRY}"
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh "docker push ${REGISTRY}"
                echo 'Pushed to docker hub'
            }
        }

        stage('Deploying') {
            steps {
                echo 'Deploying to AWS...'
                withAWS(credentials: 'aws', region: 'us-est-2') {
                    sh 'aws eks --region us-est-2 update-kubeconfig --name capstonecluster'
                    sh 'kubectl config use-context arn:aws:eks:us-est-2:576136082284:cluster/capstonecluster'
                    sh 'kubectl set image deployments/capstone-app capstone-app=${REGISTRY}'
                    sh 'kubectl apply -f k8-deploy.yml'
                    sh 'kubectl get nodes'
                    sh 'kubectl get deployment'
                    sh 'kubectl get pod -o wide'
                    sh 'kubectl get service/capstone-app'
                }
            }
        }
        stage('Cleaning up') {
            steps {
                echo 'Cleaning up...'
                sh 'docker system prune'
            }
        }
    }
}
