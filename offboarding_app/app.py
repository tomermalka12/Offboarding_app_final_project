# offboarding_app/gui_app.py
from flask import Flask, render_template, request
import subprocess

app = Flask(__name__)

@app.route("/", methods=["GET"])
def index():
    return render_template("wizard.html")

@app.route("/offboard", methods=["POST"])
def offboard():
    username = request.form.get("username")

    if not username:
        return "Username is required", 400

    try:
        # Call the bash script with the username
        result = subprocess.run(
            ["bash", "scripts/initial_script01.sh", username],
            capture_output=True,
            text=True,
            check=True
        )
        return f"<h3>Employee {username} successfully offboarded.</h3><pre>{result.stdout}</pre>"
    except subprocess.CalledProcessError as e:
        return f"<h3>Error while offboarding {username}</h3><pre>{e.stderr}</pre>", 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8081, debug=True)

