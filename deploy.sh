docker build -t artemshaleyko/multi-client:latest -t artemshaleyko/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t artemshaleyko/multi-server:latest -t artemshaleyko/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t artemshaleyko/multi-worker:latest -t artemshaleyko/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push artemshaleyko/multi-client:latest
docker push artemshaleyko/multi-server:latest
docker push artemshaleyko/multi-worker:latest

docker push artemshaleyko/multi-client:$SHA
docker push artemshaleyko/multi-server:$SHA
docker push artemshaleyko/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=artemshaleyko/multi-client:$SHA
kubectl set image deployments/server-deployment server=artemshaleyko/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=artemshaleyko/multi-worker:$SHA