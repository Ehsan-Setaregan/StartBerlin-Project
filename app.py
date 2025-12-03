from flask import Flask

# Name der App
app = Flask(__name__)

# Routing
@app.route('/')
def home():
	return "StartBerlin Project is Up!"

# Running
if __name__ == '__main__':
	app.run(host='0.0.0.0', port=5000)


