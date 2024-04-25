# Coworking Space Service

## Guide

### Dependencies

1. Install `aws-cli`, `eksctl`, and `kubectl`.
2. Create an `AWS Codebuild` project

    - Source: Select GitHub and choose the repository (do not choose public repo).
    - Enable webhook push event to build when there are pushes on the GitHub repository or start the build manually.
    - Config only run on branch master by setting srouce version as `refs/heads/master`

3. a private `ECR` registry

### Build pipeline

1. Dockerfile:
    - Use the `python:3.10-slim-buster` base image for the Python-based application on ECR public repository.
    - Specify the working directory as `/app`.
    - Copy the `requirements.txt` file from the source code to the workingdirectory.
    - Install Python dependencies.
    - Copy all Python source code to the working directory.
    - Run the application with the `python` command.

2. AWS CodeBuild `buildspec.yml`:

   Log in to Docker to push/pull from ECR repo.

   ```
   aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $(aws sts get-caller-identity --query "Account" --output text).dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com
   ```

   Build the image:

   ```
   docker-compose -f docker-compose-build.yml build
   ```

   Push the built Docker image to ECR:

   ```
    docker-compose -f docker-compose-build.yml push
   ```

### K8s deployment

1. Create EKS Cluster:

   ```
   eksctl create cluster --name coworking-cluster --region us-east-1 --nodegroup-name coworking-cluster --node-type t3.small --nodes 2 --nodes-min 2 --nodes-max 3
   
   # update kubectl config
   aws eks --region us-east-1 update-kubeconfig --name coworking-cluster
   ```

   To delete cluster:

   ```
   eksctl delete cluster --name coworking-cluster --region us-east-1
   ```

2. Create config map:

   Go to the folder `k8s`.
   Update the value for below variables: POSTGRES_HOST, POSTGRES_PORT, POSTGRES_USERNAME, POSTGRES_PASSWORD,
   POSTGRES_NAME inside file `config.yml`.

   Run command to create secret:

   ```
   kubectl apply -f config.yml
   ```

   Create secret:

   Navigate to the `deployment` folder.
   Update the values with the output of:

   ```shell
   echo -n "<your secret username/password" | base64
   ```

   Run the command to create the secret:

   ```
   kubectl apply -f secrets.yml
   ```

3. Deploy database:

   ```
   kubectl apply -f postgres.yml
   ```

   then update the variables inside `db/seed.sh` script and run it to setup the database.

4. Deploy Coworking app:

   ```
   kubectl apply -f coworking.yml
   ```

5. Add CloudWatch to the EKS cluster:

Add `CloudWatchAgentServerPolicy` to EKS `Node group` role (do not mistake with cluster role):

```
aws iam attach-role-policy \
--role-name eksctl-coworking-cluster-nodegroup-NodeInstanceRole-bSEhFKNqHQ8e \
--policy-arn arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy
```

Add addon cloudwatch to EKS, can add manually on AWS console in cluster -> `Add-ons` tab:

```
aws eks create-addon --cluster-name coworking-cluster --addon-name amazon-cloudwatch-observability
```

To trigger log group creation, query the app:

```shell
curl <coworking service endpoint>:5153/api/reports/daily_usage
```

### Verify

View all services deployed to the cluster:

```
kubectl get svc
```

View all pods:

```
kubectl get pods
```

and also verify the CloudWatch logs.
