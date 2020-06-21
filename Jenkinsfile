node {
    def REGISTRY = '58910810/capstone_cloud_devops'

    stage('Checking out git repo') {
        echo 'Checkout...'
        checkout scm
    }

    stage('Checking environment') {
        echo 'Checking environment...'
        sh 'git --version'
        echo "Branch: ${env.BRANCH_NAME}"
        sh 'docker -v'
    }

    stage('Lint HTML') {
        sh 'tidy -q -e *.html'
    }

    stage('Build') {
        sh 'echo Building...'
    }

    stage('Build Docker Image') {
        withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
            sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD "
            sh "docker build -t ${REGISTRY} ."
            sh "docker tag ${REGISTRY} ${REGISTRY}"
        }
    }

    stage('Push Docker Image') {
        sh "docker push ${REGISTRY}"
        echo 'Pushed to docker hub'
    }

    stage('Update Image') {
        echo 'Deploying to config image update ...'
        withAWS(credentials: 'demo-eks-credentials', region: 'us-east-2') {
            sh 'aws eks --region us-east-2 update-kubeconfig --name Kapstone'
            sh '˜/bin/kubectl config use-context arn:aws:eks:us-east-2:576136082284:cluster/Kapstone'
            sh '˜/bin/kubectl apply -f k8-deploy.yml'
            sh '˜/bin/kubectl set image deployments/capstone-app capstone-app=58910810/capstone_cloud_devops'
        }
    }

    stage('Deploy check') {
        echo 'Deploying to check satus...'
        withAWS(credentials: 'demo-eks-credentials', region: 'us-east-2') {
            sh '˜/bin/kubectl get deployment'
            sh '˜/bin/kubectl get nodes'
            sh '˜/bin/kubectl get pod -o wide'
            sh '˜/bin/kubectl get service/capstone-app'
            sh '˜/bin/kubectl rollout status deployment capstone-app'
            sh '˜/bin/kubectl get deployment'
        }
    }

    stage('Deploy see') {
        echo 'Deploying to check deployment...'
        withAWS(credentials: 'demo-eks-credentials', region: 'us-east-2') {
            sh '˜/bin/kubectl get deployment'
        }
    }

    stage('Cleaning up') {
        echo 'Cleaning up...'
        sh 'docker system prune'
    }
}
