# GKE and Kubernetes Setup Manually

## Prerequisites
- Google Cloud Project
- GCP Service Account with necessary permissions
- Provisioned Google Cloud Shell(It's free)
## Detailed Setup
### 1. Copy Kubernetes Files
1. Go to the [Google Cloud Console](https://console.cloud.google.com/).
2. From Google Cloud Shell -> Open Editor
3. Copy The files inside "kubernetes_files" to your editor in GCP
### 2. Run Deployment Files
In Google Cloud Shell:
- gcloud config set compute/zone europe-west1-b -> or any other zone you desire
- gcloud compute disks create mysql-disk --size=10GB --type=pd-ssd
- gcloud container clusters create tinode-cluster
- gcloud container clusters get-credentials tinode-cluster
- kubectl apply -f mysql-pv-pvc.yml
- kubectl apply -f mysql-deployment.yml
- kubectl apply -f tinode-deployment.yml
- kubectl apply -f exporter-deployment.yml
- kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
- kubectl apply -f hpa.yml
### 3. Verify the Deployment
kubectl get nodes
kubectl get pods
kubectl get svc
### 4. See the Website
Run:
- kubectl get services

To see the external Ip Of the Load Balancer. The application will be accesible through this IP
### 5. Cleanup Resources
To cleanup resources run:
- gcloud container clusters delete tinode-cluster

Find the Persistent disks and PVC's
- gcloud compute disks list
  
Delete them
- gcloud compute disks delete <disk-name>

Replace <disk-name> with the disks in the list command
All is cleaned up
