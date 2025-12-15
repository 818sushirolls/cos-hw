#!/bin/bash
# Load Test Script for eShopOnContainers
# Run this from a pod with hey installed, or from a machine with access to the cluster

echo "=========================================="
echo "eShopOnContainers Load Test Script"
echo "=========================================="

# Configuration - adjust these URLs based on your setup
WEBMVC_URL="http://webmvc.eshop.local"
CATALOG_URL="http://api.eshop.local/catalog-api"
BASKET_URL="http://api.eshop.local/basket-api"

echo ""
echo "Starting WebMVC load test..."
echo "Running for 2 minutes with 50 concurrent connections..."
hey -z 2m -c 50 -q 10 $WEBMVC_URL &

echo ""
echo "Starting Catalog API load test..."
hey -z 2m -c 30 -q 15 $CATALOG_URL/api/v1/catalog/items &

echo ""
echo "Starting Basket API load test..."
hey -z 2m -c 20 -q 10 $BASKET_URL/api/v1/basket &

wait
echo ""
echo "=========================================="
echo "Load tests completed!"
echo "=========================================="

