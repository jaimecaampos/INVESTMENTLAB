from dotenv import loadenv
import os
from flask import Flask, request, jsonify, session, redirect, url_for, render_template
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
import datetime
from werkzeug.security import generate_password_hash


app = Flask(__name__)
app.secret_key = "super_secret_key" #sesiones

port = "6666"
url = "localhost"

username = os.environ.get("POSTGRES_USER")
password = os.environ.get("POSTGRES_PASSWORD")

app.config["SQLALCHEMY_DATABASE_URI"] = f"postgresql://{username}:{password}@localhost:5432/myapp"
CORS(app)

db = SQLAlchemy(app)

class Users(db.Model):
    __tablename__ = "users"

    id_user = db.Column(db.BigInteger, primary_key=True)
    name = db.Column(db.String(150), nullable=False)
    username = db.Column(db.String(150), unique=True, nullable=False)
    email = db.Column(db.String(150), unique=True, nullable=False)
    password = db.Column(db.String(150), nullable=False)

    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

@app.get("/")
async def checkRoot():
    return "Estoy prendido pa"


@app.route("/createUser", methods=["POST"])
def createUser():

    data = request.get_json()
    hashed_password = generate_password_hash(data["password"])

    if not data:
        return jsonify({"error": "No data received"}), 400

    

    new_user = Users(
        name=data["name"],
        username=data["username"],
        email=data["email"],
        password=hashed_password
    )

    db.session.add(new_user)
    db.session.commit()

    session["user_id"] = new_user.id_user
    session["username"] = new_user.username

    return jsonify({"redirect": "/dashboard"})


@app.route("/dashboard") #para la vista 
def dashboard():

    if "user_id" not in session:
        return redirect(url_for("login_page"))

    return render_template("dashboard.html")

