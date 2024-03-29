# Using flask, render_template and request from flask
from flask import Flask, render_template, request, session, redirect
# Using flask SQL Alchemy tool
from flask_sqlalchemy import SQLAlchemy
# Using flask-mail service
from flask_mail import Mail
# Using datetime module to get current date and time
from datetime import datetime
# Using json module to convert our file from binary to json format
import json
# os module for file manipulation
import os
# math module for mathematics
import math
# this module secures application from bad filenames which can crash our app
from werkzeug.utils import secure_filename

# File opening code in python
with open('config.json', 'r') as c:
    params = json.load(c)["params"]

local_server = True

app = Flask(__name__)

# setting Secret key
app.secret_key = 'super-secret-key'
# Setting the upload location for the folder
app.config['UPLOAD_FOLDER'] = params['upload_location']

# Configuring for mailing service in our app
app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT=465,
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params['gmail-user'],
    MAIL_PASSWORD=params['gmail-password']
)
mail = Mail(app)

# Setting, either local server or prod server, change uri
if (local_server):
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']

# Connecting our App with our Database using SQLAlchemy
# app.config['SQLALCHEMY_DATABASE_URI']="mysql://username:password@localhost:db_name"
# app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:@localhost/codingthunder'


db = SQLAlchemy(app)


# Creating a class, having our column values as its attributes, and setting their properties
class Contact(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), unique=False, nullable=False)
    phone_num = db.Column(db.String(12), nullable=False)
    msg = db.Column(db.String(50), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    email = db.Column(db.String(20), nullable=False)


# Creating a class Post, having our columns for Post
class Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(21), nullable=False)
    content = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    img_file = db.Column(db.String(12), nullable=True)
    tagline = db.Column(db.String(30), nullable=False)


# App routing for /
@app.route('/')
def home():
    # pagination logic
    # this will fetch all posts
    posts = Posts.query.filter_by().all()
    last = math.ceil(len(posts) / int(params['no_of_posts']))
    page = request.args.get('page')
    if (not str(page).isnumeric()):
        page = 1

    page = int(page)
    posts = posts[(page - 1) * int(params['no_of_posts']):(page - 1) * int(params['no_of_posts']) + int(
        params['no_of_posts'])]
    if (page == 1):
        prev = "#"
        next = "/?page=" + str(page + 1)
    elif (page == last):
        next = "#"
        prev = "/?page=" + str(page - 1)
    else:
        prev = "/?page=" + str(page - 1)
        next = "/?page=" + str(page + 1)
    # ALl post rendering logic
    # post = Posts.query.filter_by().all()[0:params['no_of_posts']]
    return render_template('index.html', params=params, posts=posts, prev=prev, next=next)


# App routing for contact page, alongwith POST method to post our form data from client to server.
@app.route('/contact', methods=['GET', 'POST'])
def contact():
    if (request.method == 'POST'):
        '''Add entry to the database'''
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')

        entry = Contact(name=name, phone_num=phone, msg=message, date=datetime.now(), email=email)

        db.session.add(entry)
        db.session.commit()

        mail.send_message('New Message from ' + name,
                          sender=email,
                          recipients=[params['gmail-user']],
                          body=message + "\n" + phone
                          )

    return render_template('contact.html', params=params)


# App route for Post
@app.route("/post/<string:post_slug>", methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html', params=params, post=post)


# App route for /about
@app.route('/about')
def about():
    return render_template('about.html', params=params)


@app.route('/dashboard', methods=['GET', 'POST'])
def dashboard():
    if ('user' in session and session['user'] == params['admin_user']):
        posts = Posts.query.all()
        return render_template('dashboard.html', params=params, posts=posts)

    if (request.method == 'POST'):
        username = request.form.get('uname')
        password = request.form.get('pass')
        if (username == params['admin_user'] and password == params['admin_password']):
            session['user'] = username
            posts = Posts.query.all()
            return render_template('dashboard.html', params=params, posts=posts)

    return render_template('login.html', params=params)


@app.route('/edit/<string:sno>', methods=['GET', 'POST'])
def edit(sno):
    if ('user' in session and session['user'] == params['admin_user']):
        if (request.method == 'POST'):
            box_title = request.form.get('title')
            tline = request.form.get('tline')
            slug = request.form.get('slug')
            content = request.form.get('content')
            img_file = request.form.get('img_file')
            date = datetime.now()

            if (sno == '0'):
                post = Posts(title=box_title, tagline=tline, slug=slug, content=content, img_file=img_file, date=date)
                db.session.add(post)
                db.session.commit()
            else:
                post = Posts.query.filter_by(sno=sno).first()
                post.title = box_title
                post.slug = slug
                post.content = content
                post.tagline = tline
                post.date = date
                post.img_file = img_file
                db.session.commit()
                return redirect('/edit/' + sno)

        post = Posts.query.filter_by(sno=sno).first()
        return render_template('edit.html', params=params, post=post,sno=sno)


# Uploading file route function
@app.route('/uploader', methods=['GET', 'POST'])
def uploader():
    if ('user' in session and session['user'] == params['admin_user']):
        if (request.method == 'POST'):
            f = request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
            return "Uploaded Successfully"


# logout endpoint
@app.route('/logout')
def logout():
    # deleting user session
    session.pop('user')
    return redirect('/dashboard')


# Post delete endpoint
@app.route('/delete/<string:sno>', methods=['GET', 'POST'])
def delete(sno):
    if ('user' in session and session['user'] == params['admin_user']):
        post = Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect('/dashboard')


# Running our app, with debug=True, which shows us errors on our homepage screen
app.run(debug=True)
