
public.ecr.aws/g4l4r0t9/udacity


```shell
eksctl create cluster --name coworking-cluster --region us-east-1 --nodegroup-name my-nodes --node-type t3.small --nodes 1 --nodes-min 1 --nodes-max 2
aws eks --region us-east-1 update-kubeconfig --name coworking-cluster
kubectl config current-context


PGPASSWORD="$DB_PASSWORD" psql --host 127.0.0.1 -U myuser -d mydatabase -p 5433 < <FILE_NAME.sql>

docker-compose -f docker-compose-build.yml build


kubectl get pods
kubectl describe pod ...

kubectl apply -f pvc.yaml
kubectl apply -f pv.yaml
kubectl apply -f postgresql-deployment.yaml


eksctl delete cluster --name coworking-cluster --region us-east-1

```
