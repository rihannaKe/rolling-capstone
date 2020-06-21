Launch AWS Ec2  
- Install jenkins
`sudo apt-get update`
`sudo apt install -y default-jdk`
```wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -  ```
```sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'```
`sudo apt-get update`
`sudo apt-get install -y jenkins `
`sudo cat /var/lib/jenkins/secrets/initialAdminPassword`

install jenkins necessary plugins ex.
- BlueOcean
- Pipeline: AWS Steps
- Kubernetes Continuous Deploy


- Install Docker in EC2 instance.
`sudo apt install docker.io`
info link: https://phoenixnap.com/kb/how-to-install-docker-on-ubuntu-18-04
`sudo usermod -a -G docker <username>`

- Install aws cli, 
https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html
aws-cli
`curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"`
`unzip awscliv2.zip`
`sudo ./aws/install`
`aws configure`
Install and configure kubectl
`curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/kubectl`
`chmod +x ./kubectl`
`mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin`
`echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc`
`kubectl version --short --client`

Install eksctl
`curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp`
`sudo mv /tmp/eksctl /usr/local/bin`
`eksctl version`
Create the cluster
``` eksctl create cluster --name Kapstone --version 1.16 --nodegroup-name kapstone-workers --node-type t2.medium --nodes 3 --nodes-min 1 --nodes-max 4 --node-ami auto --region us-east-2 ```

From local machine or ec2 instance where aws configure is configured execute
`./aws/create_infrastructure.sh` 
`./aws/create_eks.sh`
`./aws/create_worker_nodes.sh`
