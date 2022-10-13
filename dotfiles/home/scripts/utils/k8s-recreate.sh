#!/bin/bash

echo "=== Create kind cluster ==="
kind delete cluster -n kind || true
kind create cluster -n kind
kubectl config use-context kind-kind

echo "=== Install Kyverno ==="
# kyverno https://kyverno.io/docs/installation/#install-kyverno-using-yamls
kubectl create -f https://raw.githubusercontent.com/kyverno/kyverno/release-1.7/config/release/install.yaml

echo "=== Install Istio ==="
# istio https://istio.io/latest/docs/setup/platform-setup/kind/
# istioctl install --set profile=demo -y
# kubectl label namespace default istio-injection=enabled
