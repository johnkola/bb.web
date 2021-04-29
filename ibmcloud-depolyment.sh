#kubectl config view
#kubectl config current-context

#ibmcloud login -r 'us-south' -u 'john.kolahdouzan@gmail.com' -p 'Alfred110'
#ibmcloud ks cluster ls
#kubectl get svc -o wide
#ibmcloud cr namespace-add bb-web
#ibmcloud cr image-list
#minikube addons enable ingress
#helm install bb-web ./eih-base-helm --namespace csi-dev --create-namespace --set service.type=NodePort
#helm install bb-web ./eih-base-helm --namespace csi-dev --create-namespace --set ingress.enabled=true --set image.repository=nginx
#kubectl get ingress -n csi-dev  --watch
#kubectl get svc -n csi-dev



ibmcloud login -a cloud.ibm.com -apikey YxaF7mgbfnGmQJSckZiMxlrVwPj0Ssr4MIGLEAV20Tiu --no-region

ibmcloud cr build --no-cache --quiet --tag us.icr.io/bb-web/bb-web:lts --build-arg JAR_FILE=./target/*.jar .

helm install bb-web ./eih-base-helm --namespace csi-dev --create-namespace







