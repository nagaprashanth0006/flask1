#!/bin/bash

docker build -t flask1 --network=host --no-cache .
docker tag flask1 nagaprashanth0006/flask1
docker push nagaprashanth0006/flask1

#kubectl delete pod test || true
#kubectl run test --image=nagaprashanth0006/flask1 --restart=Never
kubectl apply -f /root/k8s/flask1_deploy.yaml

while true
do
	kubectl get pods | grep "flask1" | grep "Running"
	if [ $? -eq 0 ]
	then
		break;
	else
		echo "Waiting for pod to be created..."
		sleep 1
	fi
done

#kubectl port-forward pod/test 8080:9091 --address=192.168.0.131

#kubectl expose --name flask1-service --protocol=TCP --port=8080 --target-port=9091 --type=NodePort deployment flask1
kubectl expose deployment flask1 --type=NodePort --name=flask-service --nodeport=30051
