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
- sudo docker-compose -f cluster.yml up -d

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

### Hosting Tinode Chat Application
For our school project, we successfully deployed the Tinode chat application on the Google Cloud Platform (GCP). Initially, we used Docker Compose to containerize and manage the application, but to enhance scalability, reliability, and overall project quality, we transitioned to using Google Kubernetes Engine (GKE) with advanced features such as Horizontal Pod Autoscaling (HPA).


### 1. Initial Deployment with Docker Compose:
- Containerization: We use Tinode's ready-to-use docker images, ensuring that all dependencies and configurations were encapsulated within Docker images.
- Management with Docker Compose: Using Docker Compose, we defined a multi-container environment necessary for the Tinode application. Docker Compose allowed us to manage and orchestrate these containers locally, making it easier to develop and test the application. This setup included services for the Tinode server, database (MySQL), and any other necessary components.

### 2. Transition to Google Kubernetes Engine:
- Rebuilding for Kubernetes:
  - Kubernetes Manifests: We did not directly transfer our Docker setup to Kubernetes. Instead, we rebuilt the deployment from scratch, creating Kubernetes         manifests (YAML files) that defined the desired state of our application components. These manifests included:
  - Deployments: For managing the Tinode application pods.
  - Services: To expose the Tinode application internally within the cluster and externally to users.
  - ConfigMaps and Secrets: For managing configuration data and sensitive information, respectively.
  - Persistent Volume Claims (PVCs): To handle storage needs for components like the database.
- Deployment on GKE: We deployed the Kubernetes setup on GKE, benefiting from GKE’s managed environment which offers features like automated cluster management, integrated monitoring, and logging through Google Cloud's operations suite (formerly Stackdriver).

### 3. Implementing Horizontal Pod Autoscaling:
- HPA Configuration:
  - Metrics Collection: We configured HPA to use Kubernetes metrics (such as CPU and memory usage) to monitor the performance of our application pods.
  - Autoscaling Policies: Based on these metrics, we set up scaling policies that automatically adjust the number of pods. For example, if CPU usage exceeds       50%, HPA will scale out by adding more pods. Conversely, if CPU usage drops below 50%, HPA will scale in by reducing the number of pods.
- Dynamic Scaling Benefits:
  - Resource Efficiency: This dynamic scaling ensures that our application efficiently uses resources, scaling up during peak traffic periods to maintain           performance and scaling down during low traffic periods to save costs.
  - Resilience: By automatically adjusting to workload changes, the application remains resilient and maintains high availability even under varying traffic conditions.

### 4.Testing with Locust:
- Load Testing: We used Locust, a popular open-source load testing tool, to simulate high traffic conditions and evaluate the performance and scalability of our application.
- Results: Under high traffic conditions, we observed that the application scaled up automatically, increasing the number of pods to handle the load. Once we stopped sending requests and the traffic decreased, the application scaled down automatically, reducing the number of pods to conserve resources.
- 
### 5.Additional Enhancements:
- Monitoring and Logging: Utilizing Google Cloud’s operations suite, we implemented comprehensive monitoring and logging for our Kubernetes cluster. This allowed us to track application performance, detect issues early, and maintain detailed logs for troubleshooting.

By rebuilding our deployment for Kubernetes and leveraging the advanced capabilities of GKE, HPA, and load testing with Locust, we significantly enhanced the scalability, reliability, and performance of the Tinode chat application. This comprehensive approach not only improved the quality of our project but also provided a robust, future-proof foundation for potential growth and more complex use cases.
