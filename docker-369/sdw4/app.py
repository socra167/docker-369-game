from flask import Flask
from flask import request
import requests
import sys
app = Flask(__name__)

@app.route('/')
def send():
	num = request.args.get('num')
	tmp = int(num)
	# if number is over 369, then stop sending
	if (tmp > 369):
		return ''
	count = 0
	output = ''
	# check 369
	while(tmp != 0):
		if (tmp%10 == 3 or tmp%10 == 6 or tmp%10 == 9):
			output = output + 'JJAK! '
			count = count + 1
		tmp = tmp // 10
	# if there isn't 369, just print number
	if (count == 0):
		print(num, file=sys.stderr)
	else:
		print(output, file=sys.stderr)
	try:
		# send number with GET (url)
		response = requests.get('http://sdw1:5000/?num=' + str(int(num)+1))
	except requests.exceptions.RequestException as e:
		print('\n Cannot reach the service. \n', file=sys.stderr)
		return 'ERROR\n'
	return ''
	
if __name__ == "__main__":
	app.run(host = '0.0.0.0', port = 5003, debug = True)
