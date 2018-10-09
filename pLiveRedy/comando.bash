kubectl run alpaca-prod \
--image=gcr.io/kuar-demo/kuard-amd64:1 \
--replicas=3 \
--port=8080 \
--labels="ver=1,app=alpaca,env=prod" \
--dry-run -oyaml > alpaca-prod-deployment.yaml

#si no funciona copiar y pegar multilinea---->
kubectl run alpaca-prod --image=gcr.io/kuar-demo/kuard-amd64:1 --replicas=3 --port=8080 --labels="ver=1,app=alpaca,env=prod" --dry-run -oyaml > alpaca-prod-deployment.yaml

# editar y agregar liveness y readiness
#         readinessProbe:
#           httpGet:
#             path: /ready
#             port: 8080
#           periodSeconds: 2
#           initialDelaySeconds: 0
#           failureThreshold: 3
#           successThreshold: 1
#         livenessProbe:
#           httpGet:
#             path: /healthy
#             port: 8080
#           initialDelaySeconds: 5
#           timeoutSeconds: 1
#           periodSeconds: 10
#           failureThreshold: 3  

kubectl apply -f alpaca-prod-deployment.yaml

kubectl expose deployment alpaca-prod --port=8080 --target-port=8080 --dry-run -oyaml > alpaca-prod-service.yaml
# editar y agregar dentre de spec:
# type: NodePort 

minikube service alpaca-prod --url


#terminal 2
kubectl get endpoints alpaca-prod --watch

#terminal 3
kubectl get pods 

#terminal 1
kubectl port-forward unPodDelTerminal3 8888:8080

#teminal 4
#hacer un curl porque sino no se ve que cambia el pod que sirve, por el cache del browser
#curl http://192.168.39.207:30207 |grep host
#repetir para ver como rota el pod que atiende