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


app.secret_key = "e7f0dec981313d3643b748acee5aa4f2"
mysql = MySQL(app)

#decorator for unauthorized access
def authorize(func):
   def wrapper(*args, **kwargs):
      try:
         session['name'] != None
      except:
         return render_template('unauthorized.html')
      else:
        return func(*args, **kwargs)
   wrapper.__name__ = func.__name__
   return wrapper

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
   result = cursor.execute('SELECT zanry_filmu.nazev_zanru, filmy.nazev, filmy.delka, filmy.id_typu_filmu, typy_filmu.typ_filmu FROM filmy JOIN zanry_filmu ON filmy.id_zanru_filmu = zanry_filmu.id_zanru JOIN typy_filmu ON filmy.id_typu_filmu = typy_filmu.id_typu')
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

@app.route('/saly')
def saly():
   cursor = mysql.connection.cursor()
   result = cursor.execute('SELECT * FROM saly')
   if result > 0:
      salyDetails = cursor.fetchall()
      return render_template('saly.html', salyDetails=salyDetails)
   return 

@app.route('/addMovie', methods=["GET","POST"])
@authorize
def addMovie():
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
   
      
@app.route('/addHall', methods=["GET","POST"])
@authorize
def addHall():
   if request.method == 'GET':
      return render_template('add_hall.html')
   else:
      hall_number = request.form['hall_number']
      projection_type = request.form['projection_type']
      sound_type = request.form['sound_type']
      projection_id = request.form['projection_id']

      cur = mysql.connection.cursor()
      cur.execute("INSERT INTO saly (cislo_salu, typ_promitani, typ_ozvuceni, id_promitani) VALUES (%s, %s, %s, %s)",(hall_number,projection_type,sound_type,projection_id))
      mysql.connection.commit()
      return redirect(url_for("saly"))

@app.route('/addActor', methods=["GET","POST"])
@authorize
def addActor():
   if request.method == 'GET':
      return render_template('add_actor.html')
   else:
      first_name = request.form['first_name']
      last_name = request.form['last_name']
      birth_date = request.form['birth_date']
      character = request.form['character']

      cur = mysql.connection.cursor()
      cur.execute("INSERT INTO herci (jmeno, prijmeni, datum_narozeni, jmeno_postavy) VALUES (%s, %s, %s, %s)",(first_name,last_name,birth_date,character))
      mysql.connection.commit()
      return redirect(url_for("herci"))

@app.route('/updatemovie/<int:id>', methods=["GET","POST"])
@authorize
def updateMovie(id):
   if request.method == 'GET':
      #load data from db insert into input
      cursor = mysql.connection.cursor()
      cursor.execute("SELECT * FROM filmy WHERE id_filmu=%s",(id,))
      film = cursor.fetchall()

      cursor = mysql.connection.cursor()
      cursor.execute('SELECT * FROM typy_filmu')
      types = cursor.fetchall()

      cursor.execute('SELECT * FROM zanry_filmu')
      genres = cursor.fetchall()

      return render_template('update_movie.html',data=film, types=types, genres=genres)
   else:
      movie_name = request.form['movie_name']
      length = request.form['length']
      type = request.form['type']
      genre = request.form['genre']

      cur = mysql.connection.cursor()
      cur.execute("UPDATE filmy SET nazev = %s, delka =%s, id_typu_filmu=%s, id_zanru_filmu=%s WHERE id_filmu=%s",(movie_name,length,type,genre,id))
      mysql.connection.commit()
      return redirect(url_for("filmy"))

@app.route('/delete/<int:id>')
@authorize
def delete(id):
   cursor = mysql.connection.cursor()
   cursor.execute("DELETE FROM filmy WHERE id_filmu=%s",(id,))
   mysql.connection.commit()
   return redirect(url_for("filmy"))

@app.route('/deleteActor/<int:id>')
@authorize
def deleteActor(id):
   cursor = mysql.connection.cursor()
   cursor.execute("DELETE FROM herci WHERE id_herce=%s",(id,))
   mysql.connection.commit()
   return redirect(url_for("herci"))

@app.route('/updatehall/<int:id>', methods=["GET","POST"])
@authorize
def updateHall(id):
   if request.method == 'GET':
      #load data from db insert into input
      cursor = mysql.connection.cursor()
      cursor.execute("SELECT * FROM saly WHERE id_salu=%s",(id,))
      sal = cursor.fetchall()

      return render_template('update_hall.html',data=sal)
   else:
      hall_number = request.form['hall_number']
      projection_type = request.form['projection_type']
      sound_type = request.form['sound_type']

      cur = mysql.connection.cursor()
      cur.execute("UPDATE saly SET cislo_salu = %s, typ_promitani =%s, typ_ozvuceni=%s WHERE id_salu=%s",(hall_number,projection_type,sound_type,id))
      mysql.connection.commit()
      return redirect(url_for("saly"))

if __name__ == "__main__":
   app.run(debug=True, threaded=True)
