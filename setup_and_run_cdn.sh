#!/bin/bash

echo "Setting up and Starting CDN System..."

# Update package lists
echo "Updating system packages..."
sudo apt update -y

# Install dependencies for C++, Go, Python, and Node.js
echo "Installing required dependencies..."
sudo apt install -y g++ redis-server python3 python3-pip nodejs npm golang cargo

# Install Python dependencies
echo "Installing Python dependencies..."
pip3 install flask prometheus_client

# Start Redis Server
echo "Starting Redis..."
sudo systemctl enable redis --now

# Compile and Run C++ CDN Cache System
echo "Compiling and Starting CDN Caching System..."
g++ cdn_caching.cpp -o cdn_cache && ./cdn_cache &

# Start Load Balancer (Go)
echo "Starting Load Balancer..."
go run load_balancer.go &

# Start CDN Control Plane (Python)
echo "Starting CDN Control Plane API..."
python3 cdn_control.py &

# Start API Gateway (Go)
echo "Starting API Gateway..."
go run api_gateway.go &

# Start CDN Security System (Rust)
echo "Starting CDN Security Module..."
cargo run --manifest-path cdn_security/Cargo.toml &

# Start CDN Monitoring (Python with Prometheus)
echo "Starting CDN Monitoring Service..."
python3 cdn_monitor.py &

# Start Edge Function (JavaScript - Cloudflare Worker Simulation)
echo "Starting Edge Computing Function..."
node edge_function.js &

echo "CDN System Setup Complete and Running!"

# Keep the script running
wait
