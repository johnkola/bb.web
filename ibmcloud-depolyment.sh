#kubectl config view
#kubectl config current-context

#ibmcloud login -r 'us-south' -u 'john.kolahdouzan@gmail.com' -p 'Alfred110'
#ibmcloud ks cluster ls
#kubectl get svc -o wide

#ibmcloud cr namespace-add bb-web
#ibmcloud cr image-list

ibmcloud cr build --no-cache --quiet --tag us.icr.io/bb-web/bluebird:1 --build-arg JAR_FILE=./target/*.jar .

