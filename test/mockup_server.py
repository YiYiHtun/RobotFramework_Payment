# mock_server.py
from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/mock-payment/process', methods=['POST'])
def process_payment():
    #form_data = request.form.to_dict()  # Convert ImmutableMultiDict to regular dict
    #return jsonify(form_data), 200
    return jsonify(request.json), 200  # or 400 for failure

if __name__ == '__main__':
    app.run(port=3000)



