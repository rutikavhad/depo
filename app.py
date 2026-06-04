from flask import Flask, render_template, request, redirect, url_for
from flask_login import LoginManager, login_user, login_required
from flask_login import logout_user, current_user

from datetime import date,datetime
from functools import wraps
from flask import abort
from db import db #ORM BASED
from model import *
# from model import Student, Teacher, Staff

import os
from werkzeug.utils import secure_filename

UPLOAD_FOLDER = "static/uploads/notes"



app = Flask(__name__)

app.config["SECRET_KEY"] = "secret123"

app.config["SQLALCHEMY_DATABASE_URI"] = \
"postgresql://matrix:1234@localhost/dept"

db.init_app(app)

login_manager = LoginManager()
login_manager.init_app(app)

login_manager.login_view = "login"

app.config["UPLOAD_FOLDER"] = UPLOAD_FOLDER


@app.route('/',methods=['GET'])
def home():
    return render_template("home.html")


@login_manager.user_loader
def load_user(user_id):

    role, actual_id = user_id.split(":")

    if role == "student":
        return Student.query.get(int(actual_id))

    if role == "teacher":
        return Teacher.query.get(int(actual_id))

    if role == "staff":
        return Staff.query.get(int(actual_id))

    return None

####################################################################################################################################################
#LOGIN ALL
@app.route("/login", methods=["GET", "POST"])
def login():

    if request.method == "POST":

        email = request.form["email"]
        password = request.form["password"]
        role = request.form["role"]

        user = None

        if role == "student":
            user = Student.query.filter_by(email=email).first()

        elif role == "teacher":
            user = Teacher.query.filter_by(email=email).first()

        elif role == "staff":
            user = Staff.query.filter_by(email=email).first()

        if user and user.password == password:
            login_user(user)

            if role == "student":
                return redirect(url_for("student"))

            if role == "teacher":
                return redirect(url_for("teacher"))

            if role == "staff":
                return redirect(url_for("staff"))

    return render_template("login.html")

#ROLE DETECTER FOR SECURE LOGIN
def role_required(role):
    def wrapper(func):
        @wraps(func)
        def decorated(*args, **kwargs):
            if not current_user.is_authenticated:
                return login_manager.unauthorized()
            if current_user.role != role:
                abort(403)
            return func(*args, **kwargs)
        return decorated
    return wrapper

####################################################################################################################################################
#ALL
#dashboards
@app.route('/student-dashboard')
@login_required
@role_required("student")
def student():
    time=datetime.now().hour
    stud = Student.query.filter_by(email=current_user.email).first()
    return render_template("stud_dash.html",student=stud,time=time)


@app.route('/teacher-dashboard')
@login_required
@role_required("teacher")
def teacher():
    time=datetime.now().hour
    tea=Teacher.query.filter_by(email=current_user.email).first()
    return render_template("teach_dash.html",s=tea,time=time)


@app.route('/staff-dashboard')
@login_required
@role_required("staff")
def staff():
    time=datetime.now().hour
    tea=Staff.query.filter_by(email=current_user.email).first()
    return render_template("staff_dash.html",tea=tea,time=time)



@app.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('login'))



@app.route("/dashboard")
@login_required
def dashboard():
    role = current_user.role
    if "student" in role:
        return redirect(url_for("student"))

    elif "teacher" in role:
        return redirect(url_for("teacher"))

    elif "staff" in role:
        return redirect(url_for("staff"))

    return "Role not found", 404

####################################################################################################################################################
#Profile Edit
@app.route("/profile", methods=["GET", "POST"])
@login_required
def edit_profile():

    user = current_user
    role = user.role

    student = teacher = staff = None
    # role = None

    # Detect role
    if "student" in role:
        role = "student"
        student = Student.query.filter_by(email=role).first()

    elif "teacher" in role:
        role = "teacher"
        teacher = Teacher.query.filter_by(email=role).first()

    elif "staff" in role:
        role = "staff"
        staff = Staff.query.filter_by(email=role).first()

    
    if request.method == "POST":

        if role == "student":
            student.fname = request.form["fname"]
            student.lname = request.form["lname"]
            student.phone = request.form["phone"]
            student.year = request.form["year"]
            student.cource = request.form["cource"]

        elif role == "teacher":
            teacher.fname = request.form["fname"]
            teacher.lname = request.form["lname"]
            teacher.phone = request.form["phone"]
            teacher.department = request.form["department"]

        elif role == "staff":
            staff.fname = request.form["fname"]
            staff.lname = request.form["lname"]
            staff.phone = request.form["phone"]
            staff.designation = request.form["designation"]

        db.session.commit()
        return redirect(url_for("edit_profile"))

    return render_template(
        "edit_profile.html",
        student=student,
        teacher=teacher,
        staff=staff,
        role=role
    )

#This main internel section

#STUDENT SECTION

####################################################################################################################################################

@app.route("/student/courses")
@login_required
@role_required("student")
def student_courses():

    mappings = StudentSubject.query.filter_by(
        student_id=current_user.id
    ).all()

    subjects = []

    for m in mappings:
        subject = Subject.query.get(m.subject_id)
        if subject:
            subjects.append(subject)

    return render_template(
        "student_courses.html",
        subjects=subjects
    )


@app.route("/student/assignments")
@login_required
@role_required("student")
def student_assignments():

    assignments = Assignment.query.all()

    submissions = AssignmentSubmission.query.filter_by(
        student_id=current_user.id
    ).all()

    submission_map = {
        s.assignment_id:s
        for s in submissions
    }

    return render_template(
        "student_assignments.html",
        assignments=assignments,
        submission_map=submission_map
    )

@app.route(
"/student/submit-assignment/<int:id>",
methods=["GET","POST"]
)
@login_required
@role_required("student")
def submit_assignment(id):

    assignment = Assignment.query.get_or_404(id)

    if request.method == "POST":

        file = request.files["file"]

        filename = secure_filename(
            file.filename
        )

        file.save(
            os.path.join(
                "static/uploads/assignments",
                filename
            )
        )

        submission = AssignmentSubmission(

            assignment_id=id,

            student_id=current_user.id,

            file_path=
            f"uploads/assignments/{filename}"

        )

        db.session.add(submission)
        db.session.commit()

        return redirect(
            url_for("student_assignments")
        )

    return render_template(
        "submit_assignment.html",
        assignment=assignment
    )

@app.route("/student/results")
@login_required
@role_required("student")
def student_results():

    results = Result.query.filter_by(
        student_id=current_user.id
    ).all()

    subjects = Subject.query.all()

    subject_map = {
        s.id: s.subject_name
        for s in subjects
    }

    return render_template(
        "student_results.html",
        results=results,
        subject_map=subject_map
    )


@app.route("/student/notices")
@login_required
@role_required("student")
def student_notices():

    notices = Notice.query.all()

    return render_template(
        "student_notices.html",
        notices=notices
    )


@app.route("/student/attendance")
@login_required
@role_required("student")
def student_attendance():

    attendance = Attendance.query.filter_by(
        student_id=current_user.id
    ).all()

    return render_template(
        "student_attendance.html",
        attendance=attendance
    )


@app.route("/student/notes")
@login_required
@role_required("student")
def student_notes():

    notes = Notes.query.all()

    return render_template(
        "student_notes.html",
        notes=notes
    )
####################################################################################################################################################
#TEACHER SECTION

@app.route("/teacher/students")
@login_required
@role_required("teacher")
def teacher_students():

    students = Student.query.all()

    return render_template(
        "teacher_students.html",
        students=students
    )


@app.route("/teacher/assignments", methods=["GET", "POST"])
@login_required
@role_required("teacher")
def teacher_assignments():

    if request.method == "POST":

        assignment = Assignment(
            title=request.form["title"],
            description=request.form["description"],
            subject_id=request.form["subject_id"],
            teacher_id=current_user.id,
            due_date=request.form["due_date"]
        )

        db.session.add(assignment)
        db.session.commit()

        return redirect(url_for("teacher_assignments"))

    assignments = Assignment.query.all()
    subjects = Subject.query.all()

    return render_template(
        "teacher_assignments.html",
        assignments=assignments,
        subjects=subjects
    )

@app.route("/teacher/delete-assignment/<int:id>")
@login_required
@role_required("teacher")
def delete_assignment(id):

    assignment = Assignment.query.get_or_404(id)

    db.session.delete(assignment)
    db.session.commit()

    return redirect(url_for("teacher_assignments"))


@app.route("/teacher/submissions", methods=["GET","POST"])
@login_required
@role_required("teacher")
def teacher_submissions():

    edit_id = request.args.get("edit")

    if request.method == "POST":

        submission = AssignmentSubmission.query.get(
            request.form["submission_id"]
        )

        submission.marks = request.form["marks"]
        submission.remarks = request.form["remarks"]

        db.session.commit()

        return redirect(
            url_for("teacher_submissions")
        )

    submissions = AssignmentSubmission.query.all()

    students = Student.query.all()
    assignments = Assignment.query.all()

    student_map = {
        s.id:f"{s.fname} {s.lname}"
        for s in students
    }

    assignment_map = {
        a.id:a.title
        for a in assignments
    }

    return render_template(
        "teacher_submissions.html",
        submissions=submissions,
        student_map=student_map,
        assignment_map=assignment_map,
        edit_id=edit_id
    )



@app.route("/teacher/notes", methods=["GET","POST"])
@login_required
@role_required("teacher")
def teacher_notes():

    if request.method == "POST":

        file = request.files["note_file"]

        filename = secure_filename(file.filename)

        file.save(
            os.path.join(
                app.config["UPLOAD_FOLDER"],
                filename
            )
        )

        note = Notes(
            title=request.form["title"],
            subject_id=request.form["subject_id"],
            teacher_id=current_user.id,
            file_path=f"uploads/notes/{filename}"
        )

        db.session.add(note)
        db.session.commit()

        return redirect(url_for("teacher_notes"))

    notes = Notes.query.all()
    subjects = Subject.query.all()

    return render_template(
        "teacher_notes.html",
        notes=notes,
        subjects=subjects
    )

@app.route("/teacher/delete-note/<int:id>")
@login_required
@role_required("teacher")
def delete_note(id):

    note = Notes.query.get_or_404(id)

    db.session.delete(note)
    db.session.commit()

    return redirect(url_for("teacher_notes"))


@app.route("/teacher/marks", methods=["GET", "POST"])
@login_required
@role_required("teacher")
def teacher_marks():

    if request.method == "POST":

        result = Result(
            student_id=request.form["student_id"],
            subject_id=request.form["subject_id"],
            teacher_id=current_user.id,
            marks=request.form["marks"],
            grade=request.form["grade"],
            semester=request.form["semester"]
        )

        db.session.add(result)
        db.session.commit()

        return redirect(url_for("teacher_marks"))

    results = Result.query.all()

    students = Student.query.all()
    subjects = Subject.query.all()

    student_map = {
        s.id: f"{s.fname} {s.lname}"
        for s in students
    }

    subject_map = {
        s.id: s.subject_name
        for s in subjects
    }

    return render_template(
        "teacher_marks.html",
        results=results,
        students=students,
        subjects=subjects,
        student_map=student_map,
        subject_map=subject_map
    )

@app.route("/teacher/attendance", methods=["GET", "POST"])
@login_required
@role_required("teacher")
def teacher_attendance():
    today=date.today()

    if request.method == "POST":

        attendance = Attendance(
            student_id=request.form["student_id"],
            attendance_date=request.form["attendance_date"],
            status=request.form["status"]
        )

        db.session.add(attendance)
        db.session.commit()

        return redirect(url_for("teacher_attendance"))

    attendance = Attendance.query.all()
    students = Student.query.all()

    student_map = {
        s.id: f"{s.fname} {s.lname}"
        for s in students
    }

    return render_template(
        "teacher_attendance.html",
        attendance=attendance,
        students=students,
        student_map=student_map,
        today=today
    )
@app.route("/teacher/notices", methods=["GET", "POST"])
@login_required
@role_required("teacher")
def teacher_notices():

    if request.method == "POST":

        notice = Notice(
            title=request.form["title"],
            description=request.form["description"],
            created_by=current_user.id,
            creator_role="teacher"
        )

        db.session.add(notice)
        db.session.commit()

        return redirect(url_for("teacher_notices"))

    notices = Notice.query.all()

    return render_template(
        "teacher_notices.html",
        notices=notices
    )
@app.route("/teacher/delete-notice/<int:id>")
@login_required
@role_required("teacher")
def teacher_delete_notice(id):

    notice = Notice.query.get_or_404(id)

    db.session.delete(notice)
    db.session.commit()

    return redirect(url_for("teacher_notices"))




####################################################################################################################################
#STAFF SECTION
@app.route("/staff/students", methods=["GET","POST"])
@login_required
@role_required("staff")
def staff_students():

    if request.method == "POST":

        student = Student(
            fname=request.form["fname"],
            lname=request.form["lname"],
            email=request.form["email"],
            password=request.form["password"],
            phone=request.form["phone"],
            year=request.form["year"],
            cource=request.form["cource"],
            role="student"
        )

        db.session.add(student)
        db.session.commit()

        return redirect(url_for("staff_students"))

    students = Student.query.all()

    return render_template(
        "staff_students.html",
        students=students
    )

@app.route("/staff/delete-student/<int:id>")
@login_required
@role_required("staff")
def delete_student(id):

    student = Student.query.get_or_404(id)

    db.session.delete(student)
    db.session.commit()

    return redirect(url_for("staff_students"))



@app.route("/staff/teachers", methods=["GET", "POST"])
@login_required
@role_required("staff")
def staff_teachers():

    if request.method == "POST":

        teacher = Teacher(
            fname=request.form["fname"],
            lname=request.form["lname"],
            email=request.form["email"],
            password=request.form["password"],
            phone=request.form["phone"],
            department=request.form["department"],
            role="teacher"
        )

        db.session.add(teacher)
        db.session.commit()

        return redirect(url_for("staff_teachers"))

    teachers = Teacher.query.all()

    return render_template(
        "staff_teachers.html",
        teachers=teachers
    )



@app.route("/staff/delete-teacher/<int:id>")
@login_required
@role_required("staff")
def delete_teacher(id):

    teacher = Teacher.query.get_or_404(id)

    db.session.delete(teacher)
    db.session.commit()

    return redirect(url_for("staff_teachers"))



@app.route("/staff/courses", methods=["GET", "POST"])
@login_required
@role_required("staff")
def staff_courses():

    if request.method == "POST":

        subject = Subject(
            subject_name=request.form["subject_name"],
            subject_code=request.form["subject_code"],
            course=request.form["course"],
            year=request.form["year"],
            teacher_id=request.form["teacher_id"]
        )

        db.session.add(subject)
        db.session.commit()

        return redirect(url_for("staff_courses"))

    subjects = Subject.query.all()
    teachers = Teacher.query.all()

    teacher_map = {
        t.id: f"{t.fname} {t.lname}"
        for t in teachers
    }

    return render_template(
        "staff_courses.html",
        subjects=subjects,
        teachers=teachers,
        teacher_map=teacher_map
    )


@app.route("/staff/delete-course/<int:id>")
@login_required
@role_required("staff")
def delete_course(id):

    subject = Subject.query.get_or_404(id)

    db.session.delete(subject)
    db.session.commit()

    return redirect(url_for("staff_courses"))


@app.route("/staff/notices", methods=["GET", "POST"])
@login_required
@role_required("staff")
def staff_notices():

    if request.method == "POST":

        notice = Notice(
            title=request.form["title"],
            description=request.form["description"],
            created_by=current_user.id,
            creator_role="staff"
        )

        db.session.add(notice)
        db.session.commit()

        return redirect(url_for("staff_notices"))

    notices = Notice.query.all()

    return render_template(
        "staff_notices.html",
        notices=notices
    )

@app.route("/staff/delete-notice/<int:id>")
@login_required
@role_required("staff")
def delete_notice(id):

    notice = Notice.query.get(id)

    db.session.delete(notice)
    db.session.commit()

    return redirect(url_for("staff_notices"))




@app.route("/staff/reports")
@login_required
@role_required("staff")
def staff_reports():

    total_students = Student.query.count()
    total_teachers = Teacher.query.count()
    total_staff = Staff.query.count()
    total_subjects = Subject.query.count()

    return render_template(
        "staff_reports.html",
        total_students=total_students,
        total_teachers=total_teachers,
        total_staff=total_staff,
        total_subjects=total_subjects
    )


####################################################################################################################################################
#RUN APP
if __name__=="__main__":
    app.run(debug=True)
