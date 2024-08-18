
from flask import Flask, jsonify
from datetime import datetime

app = Flask(__name__)

@app.route('/time', methods=['GET'])
def get_time():
    now = datetime.now()
    return jsonify({'current_time': now.isoformat()})

@app.route('/ready', methods=['GET'])
def ready():
    # You can include additional logic to check if your app is ready
    return jsonify({'status': 'ready'}), 200

@app.route('/healthz', methods=['GET'])
def healthz():
    # Include additional health checks if needed
    return jsonify({'status': 'healthy'}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
