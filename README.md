# cs436_project
This is the Repository for the project in CS436
# Group Members 
  Ayhan Salih Öner
  Eren Çavuş
  Gürsel Yiğit Pekgöz
  Yarkın Akyosun

# Tinode and Fancy Store 
We Chose to Ran 2 different applications in different architectures to get our hands dirty and to gain an experience in GCP.
One of them is a chat app with a generalized monolithic architecture and a couple microservice plug-ins called Tinode.
The other one is a microservice arcihtectured online shop called fancy store. Fancy Store was an example lab provided by Google Cloud Skills Boost their lab files can be found in [Build a Website on Google Cloud](https://www.cloudskillsboost.google/course_templates/638)


## Tinode
Tinode is an open source chat app with multiple features including messaging, group messaging, web calls, data exporting, location sharing etc.
It is ran on multiple configurations

### Single Vm instance with everything in it

### A 3 Node cluster setup

### Google Kubernetes Engine Managed Environment

In order to run Tinode in a Google Kubernetes managed environment run this command in the google cloud shell and also do not forget to add .yml files to your shell account:

- gcloud config set compute/zone europe-west1-b  -> or any other zone you desire
- gcloud compute disks create mysql-disk --size=10GB --type=pd-ssd
- gcloud container clusters create tinode-cluster
- gcloud container clusters get-credentials tinode-cluster
- kubectl apply -f mysql-pv-pvc.yml
- kubectl apply -f mysql-deployment.yml
- kubectl apply -f tinode-deployment.yml
- kubectl apply -f exporter-deployment.yml
- kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
- kubectl apply -f hpa.yml
