# cs436_project
This is the Repository for the project in CS436


# Group Members 
  Ayhan Salih Öner
  Eren...
  Yiğit Pekgöz
  Yarkın Akyosun
# Project Description
We would like to use Rocket.Chat as our backend application. Our aim is to use a Google Kubernetes Engine (GKE) to containerize Rocket.Chat and run it in a managed Kubernetes Environment. As a database Rocket chat needs us to use MongoDB as a Database so we might use Cloud SQL or MongoDB atlas which are available on GCP marketplace and also if time permits we might implement an automated backup solution. We have no aim to handle media uploads because of our price restrictions but we plan on storing text messages sent by the users. We are eager to familiarize ourselves with IAM policies to manage user access to our resources securely. Also we aim to Use load balancers to divide the load into multiple servers and test how it behaves under heavy traffic. In order to prevent concurrency issues in the database we aim to connect each server to the same database. We also would like to implement auto scaling features and load balancing as IaC with terraform or Ansible. If time permits we might consider building a CI/CD pipeline for continuous deployment into our backend application.
