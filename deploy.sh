docker build -t peterjwhiting/multi-client:latest -t peterjwhiting/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t peterjwhiting/multi-server:latest -t peterjwhiting/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t peterjwhiting/multi-worker:latest -t peterjwhiting/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push peterjwhiting/multi-client:latest
docker push peterjwhiting/multi-server:latest
docker push peterjwhiting/multi-worker:latest
docker push peterjwhiting/multi-client:$SHA
docker push peterjwhiting/multi-server:$SHA
docker push peterjwhiting/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=peterjwhiting/multi-server:$SHA
kubectl set image deployments/client-deployment client=peterjwhiting/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=peterjwhiting/multi-worker:$SHA