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

