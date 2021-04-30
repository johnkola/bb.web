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

ibmcloud login -a cloud.ibm.com -apikey YxaF7mgbfnGmQJSckZiMxlrVwPj0Ssr4MIGLEAV20Tiu -r us-east -g Default
ibmcloud ks cluster config --cluster c229pavw0ht6snnn198g
ibmcloud plugin install container-service
ibmcloud plugin install observe-service
ibmcloud plugin list
kubectl config current-context

ibmcloud cr build --no-cache --quiet --tag us.icr.io/bb-web/bb-web:lts --build-arg JAR_FILE=./target/*.jar .
sudo docker build -t johnkola/bb-web:lts --build-arg JAR_FILE=./target/*.jar .
sudo docker run johnkola/bb-web:lts
sudo docker push johnkola/bb-web:lts
kubectl get nodes

#helm install bb-web ./eih-base-helm --namespace csi-dev --create-namespace
helm delete web-app --namespace csi-dev
helm install  web-app ./web-app --namespace csi-dev --create-namespace
helm template web-app ./web-app --namespace csi-dev --create-namespace
helm upgrade  web-app ./web-app --namespace csi-dev --create-namespace

docker push us.icr.io/bb-web/bb-web:lts

docker login -u iamapikey -p YxaF7mgbfnGmQJSckZiMxlrVwPj0Ssr4MIGLEAV20Tiu https://private.us.icr.io


