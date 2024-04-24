## ECR repository

### public repo

public.ecr.aws/g4l4r0t9/coworking-analytics

```shell
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws
```

### private repo

URI would look something like this `077294513465.dkr.ecr.us-east-1.amazonaws.com/coworking-analytics`.

```shell
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 077294513465.dkr.ecr.us-east-1.amazonaws.com
```



```shell
eksctl create cluster --name coworking-cluster --region us-east-1 --nodegroup-name coworking-cluster --node-type t3.small --nodes 2 --nodes-min 2 --nodes-max 3
aws eks --region us-east-1 update-kubeconfig --name coworking-cluster
eksctl delete cluster --name coworking-cluster --region us-east-1

# Install the Amazon CloudWatch Observability EKS add-on
aws iam attach-role-policy \
--role-name eksctl-coworking-cluster-nodegroup-NodeInstanceRole-bSEhFKNqHQ8e \
--policy-arn arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy

aws eks create-addon --cluster-name coworking-cluster --addon-name amazon-cloudwatch-observability

curl ac376f66df8074eba8d9eb06b75820eb-348459222.us-east-1.elb.amazonaws.com:5153/api/reports/daily_usage


kubectl config current-context


cd k8s
kubectl apply -f config.yml
kubectl apply -f postgres.yml
kubectl get svc
# then update config
kubectl apply -f coworking.yml

kubectl get pods
kubectl describe pod []
kubectl exec postgresql-7c55d8cc7-2hd7w -- printenv

kubectl port-forward service/postgresql-service 5433:5432 &
ps aux | grep 'kubectl port-forward' | grep -v grep | awk '{print $2}' | xargs -r kill

# run the sql
cd ../db
./seed.sh

kubectl delete deployment []
kubectl delete --all deployment
kubectl delete --all pods
kubectl delete --all pvc
kubectl delete --all pv
```


```shell
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/g4l4r0t9

docker-compose -f docker-compose-build.yml build

# login
aws ecr get-login-password | docker login -u AWS --password-stdin "https://$(aws sts get-caller-identity --query 'Account' --output text).dkr.ecr.us-east-1.amazonaws.com"
docker-compose -f docker-compose-build.yml push

echo -n "?" | base64





```

Insight: Deprecated APIs removed in Kubernetes v1.32

Client Version: version.Info{Major:"1", Minor:"23", GitVersion:"v1.23.6", GitCommit:"ad3338546da947756e8a88aa6822e9c11e7eac22", GitTreeState:"clean", BuildDate:"2022-04-14T08:49:13Z", GoVersion:"go1.17.9", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"29+", GitVersion:"v1.29.3-eks-adc7111", GitCommit:"c8f33fb3fdd7ee39809c260233424fb73ce1893b", GitTreeState:"clean", BuildDate:"2024-04-01T19:25:15Z", GoVersion:"go1.21.8", Compiler:"gc", Platform:"linux/amd64"}
WARNING: version difference between client (1.23) and server (1.29) exceeds the supported minor version skew of +/-1