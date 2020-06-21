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

    stage('Deploying') {
        echo 'Deploying to AWS...'
        withAWS(credentials: 'demo-eks-credentials', region: 'us-east-2') {
            sh 'aws eks --region us-east-2 update-kubeconfig --name Kapstone'
        }
    }

    stage('Deploying through kubectl') {
        withKubeConfig([credentialsId: 'kubectl-user', serverUrl: 'https://api.k8s.my-company.com']) {
            sh 'kubectl config use-context arn:aws:eks:us-east-2:576136082284:cluster/Kapstone'
            sh 'kubectl  set image deployments/capstone-app capstone-app=${REGISTRY}'
            sh 'kubectl  apply -f k8-deploy.yml'
            sh 'kubectl  get nodes'
            sh 'kubectl  get deployment'
            sh 'kubectl  get pod -o wide'
            sh 'kubectl  get service/capstone-app'
        }
    }

    stage('Cleaning up') {
        echo 'Cleaning up...'
        sh 'docker system prune'
    }
}
