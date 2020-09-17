docker build -t jmy98/multi-client:latest -t jmy98/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jmy98/multi-server:latest -t jmy98/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jmy98/multi-worker:latest -t jmy98/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jmy98/multi-client:latest
docker push jmy98/multi-server:latest
docker push jmy98/multi-worker:latest

docker push jmy98/multi-client:$SHA
docker push jmy98/multi-server:$SHA
docker push jmy98/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=jmy98/multi-client:$SHA
kubectl set image deployments/server-deployment server=jmy98/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jmy98/multi-worker:$SHA