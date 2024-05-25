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
- From gcloud shell after a vm is created in the preferred zone and region with firewall rules allowing ingress tcp:3306 and tcp:6060:
- sudo apt update
- sudo apt install docker
- sudo apt install docker-compose
- sudo docker network create tinode-net
- sudo docker run --name mysql --network tinode-net --restart always --env MYSQL_ALLOW_EMPTY_PASSWORD=yes -d mysql:5.7
- sudo docker run -p 6060:6060 -d --name tinode-srv --network tinode-net tinode/tinode-mysql:latest

### A 3 Node cluster setup
- From gcloud shell after a vm is created in the preferred zone and region with firewall rules allowing ingress tcp:3306 and tcp:6060:
- sudo apt update
- sudo vim cluster.yml -> add manually or copy the cluster.yml from cloud shell
- sudo apt install docker
- sudo apt install docker-compose
-docker-compose -f cluster.yml up -d

### Google Kubernetes Engine Managed Environment with horizontal pod autoscaling

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

## Fancy-Store
For Learning purposes Fancy Store labs are completed with added architectures. The Application were built on 4 different Architectures

### Deployed on Cloud Run as a Monolith

### Deployed as Microservices with Compute engine MIG's with Load Balancer and Health Checks

### Deployed as Microservices with Google Kubernetes Engine 

Since these labs give Badges when they are completed and resources allocated are limited no testing is made on them and no proof images are added. Deployment Architectures are added as a starting point. In order to see proofs that we did them check: [Infrastructure Modernization Badge](https://www.credly.com/badges/c422b6ea-c22f-44cf-b9ba-b91758a21e2d/public_url), Also : [The Basics of Google Cloud Compute Skill Badge](https://www.credly.com/badges/c67da24a-c8fa-4a05-a076-669d2ed5efb3/public_url)

## SUMMARY

Hosting Tinode Chat Application on Google Cloud Platform using Kubernetes

For our project, we successfully deployed the Tinode chat application on the Google Cloud Platform (GCP). Initially, we used Docker Compose to containerize and manage the application, but to improve scalability and overall project quality, we transitioned to using Google Kubernetes Engine (GKE).

Here's an overview of our process:

### 1. Initial Deployment with Docker Compose:

- Containerization: We use Tinode's ready-to-use docker images, ensuring that all dependencies and configurations were encapsulated within Docker images.
- Management with Docker Compose: We used Docker Compose to define and run multi-container Docker applications. This setup allowed us to easily manage and orchestrate the different services needed by the Tinode application on a single-node environment.

### 2. Transition to Google Kubernetes Engine:
   
- Starting from Scratch: Rather than transferring our Docker setup directly, we built a new deployment from scratch specifically for Kubernetes. This involved creating Kubernetes manifests (YAML files) for deploying the Tinode application components as Kubernetes pods.
- Deployment on GKE: We utilized GKE to manage our Kubernetes clusters. GKE's managed environment provided robust features such as automated upgrades, scaling, and integrated monitoring.

### 3. Implementing Horizontal Pod Autoscaling:
   
- Configuration of HPA: We set up Horizontal Pod Autoscaling (HPA) within our GKE environment. HPA was configured to monitor the application’s performance metrics, such as CPU utilization, and automatically adjust the number of pods to handle varying workloads.
- Dynamic Scaling: This setup allowed our application to scale out (increase the number of pods) during high traffic periods and scale in (decrease the number of pods) during low traffic periods, ensuring efficient use of resources.

By rebuilding our deployment for Kubernetes and leveraging the capabilities of GKE and HPA, we significantly enhanced the scalability, reliability, and performance of the Tinode chat application. This comprehensive approach not only improved the quality of our project but also provided a robust foundation for future growth and complex use cases.
