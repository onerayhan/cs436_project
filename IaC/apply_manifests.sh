#!/bin/bash

kubectl apply -f k8s/mysql-pv-pvc.yml
kubectl apply -f k8s/mysql-deployment.yml
kubectl apply -f k8s/tinode-deployment.yml
kubectl apply -f k8s/exporter-deployment.yml
kubectl apply -f k8s/components.yaml
kubectl apply -f k8s/hpa.yml
