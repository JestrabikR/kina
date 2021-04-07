from flask import Flask, render_template, request, redirect, url_for, session
from flask_mysqldb import MySQL, MySQLdb
import bcrypt
import yaml


app = Flask(__name__)

db = yaml.safe_load(open('db.yaml'))

app.config['MYSQL_HOST'] = db['mysql_host']
app.config['MYSQL_USER'] = db['mysql_user']
app.config['MYSQL_PASSWORD'] = db['mysql_password']
app.config['MYSQL_DB'] = db['mysql_db']
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

mysql = MySQL(app)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/register', methods=["GET","POST"])
def register():
   if request.method == 'GET':
      return render_template('register.html')
   else:
      name = request.form['name']
      email = request.form['email']
      password = request.form['password'].encode('utf-8')
      hash_password = bcrypt.hashpw(password, bcrypt.gensalt())

      cur = mysql.connection.cursor()
      cur.execute("INSERT INTO uzivatele (jmeno, email, heslo) VALUES (%s, %s, %s)",(name,email,hash_password,))
      mysql.connection.commit()
      session['name'] = name
      session['email'] = email
      return redirect(url_for("index"))

@app.route("/login", methods=["GET","POST"])
def login():
   if request.method == "POST":
      email = request.form['email']
      password = request.form['password'].encode('utf-8')

      cur = mysql.connection.cursor()
      cur.execute("SELECT * FROM uzivatele WHERE email=%s",(email,))
      user = cur.fetchone()
      cur.close()

      if len(user) > 0:
         if bcrypt.hashpw(password, user['heslo'].encode('utf-8')) == user['heslo'].encode('utf-8'):
            session['name'] = user['jmeno']
            session['email'] = user['email']
            return render_template('index.html')
         else:
            return "Password or user does not match"
   else:
      return render_template('login.html')

@app.route('/logout')
def logout():
   session.clear()
   return render_template("index.html")

@app.route('/filmy')
def filmy():
    cursor = mysql.connection.cursor()
    result = cursor.execute('SELECT * FROM filmy')
    if result > 0:
        filmDetails = cursor.fetchall()
        return render_template('filmy.html', filmDetails=filmDetails)

@app.route('/herci')
def herci():
    cursor = mysql.connection.cursor()
    result = cursor.execute('SELECT * FROM herci')
    if result > 0:
        actorDetails = cursor.fetchall()
        return render_template('herci.html', actorDetails=actorDetails)

@app.route('/promitani')
def promitani():
   cursor = mysql.connection.cursor()
   result = cursor.execute('SELECT * FROM promitani')
   if result > 0:
      promitaniDetails = cursor.fetchall()
      return render_template('promitani.html', promitaniDetails=promitaniDetails)
   return 

@app.route('/addMovie', methods=["GET","POST"])
def addMovie():
   try:
      session['name'] != None
   except:
      return render_template('unauthorized.html')
   else:
      if request.method == 'GET':
         cursor = mysql.connection.cursor()
         cursor.execute('SELECT * FROM typy_filmu')
         types = cursor.fetchall()

         cursor.execute('SELECT * FROM zanry_filmu')
         genres = cursor.fetchall()

         return render_template('add_movie.html', types=types, genres=genres)
      else:
         movie_name = request.form['movie_name']
         length = request.form['length']
         type = request.form['type']
         genre = request.form['genre']

         cur = mysql.connection.cursor()
         cur.execute("INSERT INTO filmy (nazev, delka, id_typu_filmu, id_zanru_filmu) VALUES (%s, %s, %s, %s)",(movie_name,length,type,genre))
         mysql.connection.commit()
         return redirect(url_for("filmy"))
   
      

@app.route('/film')
def film():
   return render_template('film.html')

@app.route('/herec')
def herec():
   return render_template('herec.html')

if __name__ == "__main__":
   app.secret_key = "e7f0dec981313d3643b748acee5aa4f2"
   app.run(debug=True, threaded=True)
