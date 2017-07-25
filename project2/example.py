from flask import Flask, jsonify

# Se crea el objeto Flask
app = Flask(__name__)

_tasks = [  
    {"id": 1, "title": u"task 1", "description": u"task 1 description"},
    {"id": 2, "title": u"task 2", "description": u"task 2 description"},
    {"id": 3, "title": u"task 3", "description": u"task 3 description"},
]

# Obtener todos los tasks
@app.route("/api/v0.1/tasks", methods = ["GET"])
def get_tasks():  
    return jsonify({"tasks": _tasks})   

# Para correr el programa
if __name__ == "__main__":  
    app.run(debug=True)
