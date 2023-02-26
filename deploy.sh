docker build -t erangaheshan/multi-client:latest -t erangaheshan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t erangaheshan/multi-server:latest -t erangaheshan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t erangaheshan/multi-worker:latest -t erangaheshan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push erangaheshan/multi-client:latest
docker push erangaheshan/multi-server:latest
docker push erangaheshan/multi-worker:latest

docker push erangaheshan/multi-client:$SHA
docker push erangaheshan/multi-server:$SHA
docker push erangaheshan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=erangaheshan/multi-client:$SHA
kubectl set image deployments/server-deployment server=erangaheshan/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=erangaheshan/multi-worker:$SHA
