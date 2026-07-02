from db import db
from flask_login import UserMixin

from datetime import datetime,date


class Student(UserMixin, db.Model):
    __tablename__ = "student"

    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(255))
    password = db.Column(db.String(30))
    fname=db.Column(db.String(50))
    lname=db.Column(db.String(50))
    phone=db.Column(db.String(15))
    year=db.Column(db.String(10))
    cource=db.Column(db.String(100))
    role = db.Column(db.String(20))
    academic_year = db.Column(
        db.Integer,
        default=lambda: datetime.now().year
    )
     

    def get_id(self):
        return f"student:{self.id}"


class Teacher(UserMixin, db.Model):
    __tablename__ = "teacher"

    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(255))
    password = db.Column(db.String(255))
    fname=db.Column(db.String(50))
    lname=db.Column(db.String(50))
    phone=db.Column(db.String(15))
    department=db.Column(db.String(100))
    role = db.Column(db.String(50))  # FIXED

    def get_id(self):
        return f"teacher:{self.id}"


class Staff(UserMixin, db.Model):
    __tablename__ = "staff"

    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(255))
    password = db.Column(db.String(255))
    fname=db.Column(db.String(100))
    lname=db.Column(db.String(50))
    phone=db.Column(db.String(15))
    designation=db.Column(db.String(100))
    role = db.Column(db.String(20))  # FIXED

    def get_id(self):
        return f"staff:{self.id}"\
        
#main inside data
class Subject(db.Model):
    __tablename__ = "subject"

    id = db.Column(db.Integer, primary_key=True)
    subject_name = db.Column(db.String(100))
    subject_code = db.Column(db.String(20),unique=True,nullable=False)
    course = db.Column(db.String(100))
    year = db.Column(db.String(10))
    academic_year = db.Column(
    db.Integer,
    default=lambda: datetime.now().year)
    teacher_id = db.Column(db.Integer)


class StudentSubject(db.Model):
    __tablename__ = "student_subject"

    id = db.Column(db.Integer, primary_key=True)
    student_id = db.Column(db.Integer)
    subject_id = db.Column(db.Integer)


class Assignment(db.Model):
    __tablename__ = "assignment"

    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(200))
    description = db.Column(db.Text)
    subject_id = db.Column(db.Integer)
    teacher_id = db.Column(db.Integer)
    due_date = db.Column(db.Date)
    created_date = db.Column(db.Date,default=date.today)


class Attendance(db.Model):
    __tablename__ = "attendance"

    id = db.Column(db.Integer, primary_key=True)
    student_id = db.Column(db.Integer)
    subject_id = db.Column(db.Integer, nullable=True)
    attendance_date = db.Column(db.Date,default=date.today)
    status = db.Column(db.String(20))


class Result(db.Model):
    __tablename__ = "result"

    id = db.Column(db.Integer, primary_key=True)
    student_id = db.Column(db.Integer)
    subject_id = db.Column(db.Integer)
    teacher_id = db.Column(db.Integer)
    marks = db.Column(db.Integer)
    grade = db.Column(db.String(10))
    semester = db.Column(db.String(20))


class Notice(db.Model):
    __tablename__ = "notice"

    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(200))
    description = db.Column(db.Text)
    created_by = db.Column(db.Integer)
    creator_role = db.Column(db.String(20))




class AssignmentSubmission(db.Model):
    __tablename__ = "assignment_submission"

    id = db.Column(db.Integer, primary_key=True)

    assignment_id = db.Column(db.Integer)

    student_id = db.Column(db.Integer)

    file_path = db.Column(db.String(300))

    submitted_at = db.Column(
        db.DateTime,
        server_default=db.func.now()
    )

    marks = db.Column(db.Integer)

    remarks = db.Column(db.Text)

#############################################
#teacher
class Notes(db.Model):
    __tablename__ = "notes"

    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(200))
    subject_id = db.Column(db.Integer)
    teacher_id = db.Column(db.Integer)
    file_path = db.Column(db.String(300))

class CourseYear(db.Model):
    __tablename__ = "course_info"

    id = db.Column(db.Integer, primary_key=True)
    course = db.Column(db.String(50), nullable=False)
    year = db.Column(db.String(10), nullable=False)
    ###########################