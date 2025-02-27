from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/cdn/config', methods=['GET'])
def get_config():
    return jsonify({"cache_policy": "LRU", "geo_routing": "enabled"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)