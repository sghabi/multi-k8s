docker build -t sghabi/multi-client:latest -t sghabi/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t sghabi/multi-server:latest -t sghabi/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t sghabi/multi-worker:latest -t sghabi/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push sghabi/multi-client:$GIT_SHA
docker push sghabi/multi-server:$GIT_SHA
docker push sghabi/multi-worker:$GIT_SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sghabi/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=sghabi/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=sghabi/multi-worker:$GIT_SHA