provider "google" {
  credentials = file("./credentials.json")
  project     = var.project_id
  region      = "europe-west1"
  zone        = "europe-west1-b"
}

provider "kubernetes" {
  host                   = google_container_cluster.primary.endpoint
  token                  = data.google_client_config.default.access_token
  client_certificate     = base64decode(google_container_cluster.primary.master_auth.0.client_certificate)
  client_key             = base64decode(google_container_cluster.primary.master_auth.0.client_key)
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
}

data "google_client_config" "default" {}

resource "google_compute_disk" "mysql_disk" {
  name  = "mysql-disk"
  type  = "pd-ssd"
  size  = 10
  zone  = "europe-west1-b"
}

resource "google_container_cluster" "primary" {
  name     = "tinode-cluster"
  location = "europe-west1-b"

  initial_node_count = 3

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}

resource "null_resource" "apply_manifests" {
  provisioner "local-exec" {
    command = "${path.module}/apply_manifests.sh"
  }
}
