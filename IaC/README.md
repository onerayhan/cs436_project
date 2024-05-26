# Terraform GKE and Kubernetes Setup

This repository contains a Terraform configuration for setting up a Google Kubernetes Engine (GKE) cluster and deploying Kubernetes resources.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed.
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) installed.
- A Google Cloud Platform (GCP) project.
- A GCP service account with the necessary permissions.
- `kubectl` installed and configured.

## Setup

### 1. Create Service Account and Credentials File

1. Go to the [Google Cloud Console](https://console.cloud.google.com/).
2. Navigate to **IAM & Admin > Service Accounts**.
3. Click **Create Service Account**.
4. Provide a name and description for the service account, then click **Create**.
5. Assign the following roles to the service account:
   - Kubernetes Engine Admin
   - Compute Admin
   - Service Account User
6. Click **Done**.
7. Click on the newly created service account, then navigate to the **Keys** tab.
8. Click **Add Key > Create New Key**, select **JSON**, and click **Create**.
9. Save the JSON file as `credentials.json` and place it in the root of this repository.

### 2. Initialize Terraform
terraform init

### 3. Apply the Terraform Configuration
terraform apply -var="project_id=your-gcp-project-id"

### 4. Configure kubectl
gcloud container clusters get-credentials tinode-cluster --zone europe-west1-b --project your-gcp-project-id

### 5. Verify the Deployment
kubectl get nodes
kubectl get pods
kubectl get svc

### Cleanup
terraform destroy -var="project_id=your-gcp-project-id"


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
