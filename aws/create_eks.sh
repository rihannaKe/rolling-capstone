aws cloudformation create-stack --stack-name udacity-capstone-eks --template-body file://aws/eks.yml --parameters file://aws/eks.json --region us-east-2 --capabilities CAPABILITY_IAM
