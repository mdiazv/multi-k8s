docker build -t migueldiazv/multi-client:latest -t migueldiazv/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t migueldiazv/multi-server:latest -t migueldiazv/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t migueldiazv/multi-worker:latest -t migueldiazv/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push migueldiazv/multi-client
docker push migueldiazv/multi-server
docker push migueldiazv/multi-worker
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=migueldiazv/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=migueldiazv/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=migueldiazv/multi-worker:$GIT_SHA
