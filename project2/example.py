import os
from flask import Flask, jsonify
from flask_sqlalchemy import SQLAlchemy

# Se crea el objeto Flask
app = Flask(__name__)

# Configuramos el accesso a MYSQL. Se asume que existe el usuario user con pass password
# y la bd example
DB_USER = os.getenv("EXAMPLE_DB_USER", "user")
DB_PASSWORD = os.getenv("EXAMPLE_DB_PASSWORD", "password")
DB_HOST = os.getenv("EXAMPLE_DB_HOST", "localhost")
DB_NAME = os.getenv("EXAMPLE_DB_NAME", "example")

# "mysql://user:password@localhost/example"
SQLALCHEMY_DATABASE_URI = "mysql://" + DB_USER + ":" \
                                     + DB_PASSWORD + "@" \
                                     + DB_HOST + "/" \
                                     + DB_NAME

app.config["SQLALCHEMY_DATABASE_URI"] = SQLALCHEMY_DATABASE_URI
db = SQLAlchemy(app)

class Task(db.Model):
	
	# Columnas en la tabla Task
	id = db.Column(db.Integer, primary_key=True)
	task = db.Column(db.String(80), unique=True)
	description = db.Column(db.String(200), unique=False)

	def __init__(self, task, description):
		self.task = task
		self.description = description

	def __repr__(self):
		return "<Task %r>" % self.task

db.create_all()
db.session.commit()

"""
_tasks = [
	{"id": 1, "title": u"task 1", "description": u"task 1 description"},
	{"id": 2, "title": u"task 2", "description": u"task 2 description"},
	{"id": 3, "title": u"task 3", "description": u"task 3 description"},
]
"""

# Obtener todos los tasks
@app.route("/api/v0.1/tasks", methods = ["GET"])
def get_tasks():
	tasks = Task.query.all()

	output = []
	for task in tasks:
		row = {}
		for field in Task.__table__.c:
			row[str(field).split('.')[1]] = getattr(task, str(field).split('.')[1], None)
		output.append(row)

	#return jsonify({"tasks": _tasks})	
	return jsonify({"tasks": output})

# Para correr el programa
if __name__ == "__main__":
	app.run(debug=True)
