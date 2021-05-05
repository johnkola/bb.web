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

#Install the IBM Cloud CLI


ibmcloud login -a https://cloud.ibm.com -apikey ue7-3G7AQAxKL9jVMLXhZBC5Kw82PA4F1BiQQbozG4Iw -r us-south -g Default
ibmcloud ks cluster config --cluster c225rl1d0qbq4r52kp10
ibmcloud plugin install container-service
ibmcloud plugin install container-registry
ibmcloud plugin install observe-service
ibmcloud plugin list

#Install the Docker CLI
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo docker run hello-world


sudo service docker stop
sudo rm -rf /var/lib/docker
sudo service docker start
sudo systemctl restart docker
sudo chmod 666 /var/run/docker.sock

sudo docker build -t johnkola/bb-web:lts --build-arg JAR_FILE=./target/*.jar .
sudo docker run johnkola/bb-web:lts
sudo docker push johnkola/bb-web:lts

#Install the Container Registry plug-in.
ibmcloud plugin install container-registry -r 'IBM Cloud'
ibmcloud login -a https://cloud.ibm.com -apikey ue7-3G7AQAxKL9jVMLXhZBC5Kw82PA4F1BiQQbozG4Iw -r us-south -g Default

ibmcloud cr build --no-cache --quiet --tag us.icr.io/bb-web/bb-web:lts --build-arg JAR_FILE=./target/*.jar .
kubectl get nodes
kubectl config current-context

#helm install bb-web ./eih-base-helm --namespace csi-dev --create-namespace
helm delete bb-web --namespace csi-dev
helm install  bb-web ./bb-web --namespace csi-dev --create-namespace
helm template bb-web ./bb-web --namespace csi-dev --create-namespace
helm upgrade  bb-web ./bb-web --namespace csi-dev --create-namespace

docker push us.icr.io/bb-web/bb-web:lts

docker login -u iamapikey -p YxaF7mgbfnGmQJSckZiMxlrVwPj0Ssr4MIGLEAV20Tiu https://private.us.icr.io

######GOLD
#*****
sudo docker exec -u 0 -it  jenkins-blueocean  bash
#*****
kubectl config get-contexts
kubectl config get-clusters
kubectl config get-users
kubectl config use-context

ibmcloud ks cluster ls
ibmcloud ks cluster config --cluster mycluster-free

kubectl get secret all-icr-io -n default -o yaml | sed 's/default/csi-dev/g' | kubectl create -n csi-dev -f -
