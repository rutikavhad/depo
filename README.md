# 🎓 Department Management System

A web-based **Department Management System** built using **Flask**, **SQLAlchemy**, and **PostgreSQL**. The system provides separate dashboards for **Students**, **Teachers**, and **Staff**, allowing each user to access features based on their assigned role.

---

## ✨ Features

### 🔐 Authentication
- Role-based login
- Student Login
- Teacher Login
- Staff Login
- Secure session management using Flask-Login

### 👨‍🎓 Student Module
- View Dashboard
- View Profile
- View Assigned Subjects
- Download Notes
- View Assignments
- Submit Assignments
- Check Attendance
- View Results
- Read Notices

### 👨‍🏫 Teacher Module
- Teacher Dashboard
- View Students
- Manage Assignments
- Upload Notes
- Manage Attendance
- View Assignment Submissions
- Publish Notices

### 👨‍💼 Staff Module
- Staff Dashboard
- Manage Students
- Manage Teachers
- Manage Courses/Subjects
- Publish Notices
- Generate Reports

---

## 🛠 Tech Stack

| Technology | Usage |
|------------|-------|
| Python | Backend |
| Flask | Web Framework |
| SQLAlchemy | ORM |
| PostgreSQL | Database |
| Flask-Login | Authentication |
| HTML | Templates |
| CSS | Styling |
| Jinja2 | Template Engine |

---

## 📂 Project Structure

```
Dept_system/
│
├── app.py                 # Main Flask application
├── model.py               # Database models
├── db.py                  # SQLAlchemy configuration
├── requirements.txt
├── dept_backup.sql        # Database backup
│
├── templates/
│    ├── Student Pages
│    ├── Teacher Pages
│    ├── Staff Pages
│    └── Login & Home
│
├── static/
│    ├── css/
│    ├── images/
│    └── uploads/
│
└── README.md
```

---

## 🗄 Database Models

The project includes models for:

- Student
- Teacher
- Staff
- Subject
- StudentSubject
- Assignment
- Assignment Submission
- Attendance
- Notice
- Notes

---

## 🚀 Installation

### Clone Repository

```bash
git clone https://github.com/rutikavhad/Dept_system.git
cd Dept_system
```

### Create Virtual Environment

```bash
python -m venv venv
```

Activate the environment

**Windows**

```bash
venv\Scripts\activate
```

**Linux / macOS**

```bash
source venv/bin/activate
```

### Install Dependencies

```bash
pip install -r requirements.txt
```

---

## ⚙ Database Setup

Create a PostgreSQL database.

Example:

```sql
CREATE DATABASE dept;
```

Restore the provided backup:

```bash
psql -U postgres -d dept < dept_backup.sql
```

Update the database connection inside **app.py** if needed.

```python
app.config["SQLALCHEMY_DATABASE_URI"] = \
"postgresql://username:password@localhost/dept"
```

---

## ▶ Running the Application

```bash
python app.py
```

Open your browser

```
http://127.0.0.1:5000
```

---

## 📌 Available Modules

### Student

- Dashboard
- Profile
- Subjects
- Assignments
- Results
- Attendance
- Notes
- Notices

### Teacher

- Dashboard
- Student Management
- Assignments
- Notes
- Attendance
- Assignment Submissions
- Notices

### Staff

- Dashboard
- Student Management
- Teacher Management
- Course Management
- Notices
- Reports

---

## 🔒 Authentication

The application uses **Flask-Login** for authentication and implements:

- Session Management
- Role-Based Authorization
- Protected Routes
- Login Required Decorators

Supported Roles:

- Student
- Teacher
- Staff

---

## 📈 Future Improvements

- Password Hashing
- Email Notifications
- Admin Panel
- REST API
- Dashboard Analytics
- File Validation
- Search & Filtering
- Docker Support

---

## 👨‍💻 Author

**Rutik Avhad**

GitHub: https://github.com/rutikavhad

---

## 📄 License

This project is developed for educational purposes. Feel free to use and modify it for learning.
