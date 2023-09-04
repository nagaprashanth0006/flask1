from flask import Flask
import configparser
from os.path import exists

config_file = 'config.ini'
text_file = 'data.txt'
name = "World"
data = "Empty"
if exists(config_file):
    print("Config file found. Reading it...")
    config = configparser.ConfigParser()
    config.read(config_file)
    section = 'APP_CONFIG'
    if config.has_section(section):
        if config.has_option(section, 'Name'):
            name = config.get(section, 'Name')
            print(f"Got name:{name}")
else:
    print("Config file not found")

if exists(text_file):
    with open(text_file) as fp:
        data = fp.read()

app = Flask(__name__)

@app.route('/')
def hello_world():
    return f'Hello {name}\n'

@app.route('/data')
def get_data():
    return f'Data:\n\n{data}\n'

if __name__ == '__main__':
    app.run(port="9091", debug=True)
