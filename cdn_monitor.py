from flask import Flask, Response
from prometheus_client import Counter, generate_latest

app = Flask(__name__)

cdn_requests = Counter('cdn_requests', 'Total CDN Requests')

@app.route('/metrics')
def metrics():
    return Response(generate_latest(), mimetype='text/plain')

@app.route('/request')
def handle_request():
    cdn_requests.inc()
    return "Request Logged"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)