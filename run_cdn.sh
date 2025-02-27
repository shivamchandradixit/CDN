#!/bin/bash

echo "Starting CDN System..."

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

# Start Core CDN Caching System (C++)
echo "Starting CDN Caching System..."
g++ cdn_caching.cpp -o cdn_cache && ./cdn_cache &

echo "CDN System Running!"
