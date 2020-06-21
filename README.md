## CAPSTONE PROJECT UDACITY CLOUD DEVOPS NANODEGREE

### project overview
This porject :
* Uses CloudFormation for creating the need infrastrucure and for creating the EKS cluster and working nodes. All scripts are found inside the aws folder of this project
* Uses Jenkins to implement Continuous Integration and Continuous Deployment
* Uses pipelines for:
	- 'Checking out git repo' 
	- 'Checking environment'
    - 'Checking environment'
    - 'Linting HTML'
	- 'Build Docker Image'
	- 'Deploying in EKS'

### Deployment strategy
The choosen deployment strategy is the  K8 rolling update strategy as configured in the  k8-deploy.yml file.This strategy aims to prevent application downtime by keeping at least some instances up-and-running at any point in time while performing the updates.

## The app
Here the depoloyed app is just a simple static html file 

## the repo
Here is the github repo : https://github.com/rihannaKe/rolling-capstone
Temp. app url abf1d8ba060ae4fe280c2cc4ae2683fa-222617348.us-east-2.elb.amazonaws.com 