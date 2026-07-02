--
-- PostgreSQL database dump
--

\restrict 1jpt9Tetn11N2loWepepjyNP8m40GQYaQB2pwi8iECjuahXIlyGF6wHAr1E2g13

-- Dumped from database version 18.1 (Debian 18.1-2)
-- Dumped by pg_dump version 18.1 (Debian 18.1-2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: assignment; Type: TABLE; Schema: public; Owner: matrix
--

CREATE TABLE public.assignment (
    id integer NOT NULL,
    title character varying(200),
    description text,
    subject_id integer,
    teacher_id integer,
    due_date date,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_date date DEFAULT CURRENT_DATE
);


ALTER TABLE public.assignment OWNER TO matrix;

--
-- Name: assignment_id_seq; Type: SEQUENCE; Schema: public; Owner: matrix
--

CREATE SEQUENCE public.assignment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.assignment_id_seq OWNER TO matrix;

--
-- Name: assignment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: matrix
--

ALTER SEQUENCE public.assignment_id_seq OWNED BY public.assignment.id;


--
-- Name: assignment_submission; Type: TABLE; Schema: public; Owner: matrix
--

CREATE TABLE public.assignment_submission (
    id integer NOT NULL,
    assignment_id integer,
    student_id integer,
    file_path text,
    submitted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    marks integer,
    remarks text
);


ALTER TABLE public.assignment_submission OWNER TO matrix;

--
-- Name: assignment_submission_id_seq; Type: SEQUENCE; Schema: public; Owner: matrix
--

CREATE SEQUENCE public.assignment_submission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.assignment_submission_id_seq OWNER TO matrix;

--
-- Name: assignment_submission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: matrix
--

ALTER SEQUENCE public.assignment_submission_id_seq OWNED BY public.assignment_submission.id;


--
-- Name: attendance; Type: TABLE; Schema: public; Owner: matrix
--

CREATE TABLE public.attendance (
    id integer NOT NULL,
    student_id integer,
    subject_id integer,
    attendance_date date,
    status character varying(10)
);


ALTER TABLE public.attendance OWNER TO matrix;

--
-- Name: attendance_id_seq; Type: SEQUENCE; Schema: public; Owner: matrix
--

CREATE SEQUENCE public.attendance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.attendance_id_seq OWNER TO matrix;

--
-- Name: attendance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: matrix
--

ALTER SEQUENCE public.attendance_id_seq OWNED BY public.attendance.id;


--
-- Name: course_info; Type: TABLE; Schema: public; Owner: matrix
--

CREATE TABLE public.course_info (
    id integer NOT NULL,
    course character varying(50) NOT NULL,
    year character varying(10) NOT NULL
);


ALTER TABLE public.course_info OWNER TO matrix;

--
-- Name: course_info_id_seq; Type: SEQUENCE; Schema: public; Owner: matrix
--

CREATE SEQUENCE public.course_info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.course_info_id_seq OWNER TO matrix;

--
-- Name: course_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: matrix
--

ALTER SEQUENCE public.course_info_id_seq OWNED BY public.course_info.id;


--
-- Name: notes; Type: TABLE; Schema: public; Owner: matrix
--

CREATE TABLE public.notes (
    id integer NOT NULL,
    title character varying(200),
    subject_id integer,
    teacher_id integer,
    file_path text,
    uploaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.notes OWNER TO matrix;

--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: matrix
--

CREATE SEQUENCE public.notes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notes_id_seq OWNER TO matrix;

--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: matrix
--

ALTER SEQUENCE public.notes_id_seq OWNED BY public.notes.id;


--
-- Name: notice; Type: TABLE; Schema: public; Owner: matrix
--

CREATE TABLE public.notice (
    id integer NOT NULL,
    title character varying(200),
    description text,
    created_by integer,
    creator_role character varying(20),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.notice OWNER TO matrix;

--
-- Name: notice_id_seq; Type: SEQUENCE; Schema: public; Owner: matrix
--

CREATE SEQUENCE public.notice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notice_id_seq OWNER TO matrix;

--
-- Name: notice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: matrix
--

ALTER SEQUENCE public.notice_id_seq OWNED BY public.notice.id;


--
-- Name: result; Type: TABLE; Schema: public; Owner: matrix
--

CREATE TABLE public.result (
    id integer NOT NULL,
    student_id integer,
    subject_id integer,
    teacher_id integer,
    marks integer,
    grade character varying(5),
    semester character varying(20),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.result OWNER TO matrix;

--
-- Name: result_id_seq; Type: SEQUENCE; Schema: public; Owner: matrix
--

CREATE SEQUENCE public.result_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.result_id_seq OWNER TO matrix;

--
-- Name: result_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: matrix
--

ALTER SEQUENCE public.result_id_seq OWNED BY public.result.id;


--
-- Name: staff; Type: TABLE; Schema: public; Owner: matrix
--

CREATE TABLE public.staff (
    id integer NOT NULL,
    email character varying(255),
    password character varying(255),
    fname character varying(50),
    lname character varying(50),
    phone character varying(15),
    designation character varying(100),
    role character varying(50)
);


ALTER TABLE public.staff OWNER TO matrix;

--
-- Name: staff_id_seq; Type: SEQUENCE; Schema: public; Owner: matrix
--

CREATE SEQUENCE public.staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.staff_id_seq OWNER TO matrix;

--
-- Name: staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: matrix
--

ALTER SEQUENCE public.staff_id_seq OWNED BY public.staff.id;


--
-- Name: student; Type: TABLE; Schema: public; Owner: matrix
--

CREATE TABLE public.student (
    id integer NOT NULL,
    email character varying(255),
    password character varying(30),
    fname character varying(50),
    lname character varying(50),
    phone character varying(15),
    year character varying(10),
    cource character varying(100),
    role character varying(50),
    academic_year integer DEFAULT (EXTRACT(year FROM CURRENT_DATE))::integer NOT NULL
);


ALTER TABLE public.student OWNER TO matrix;

--
-- Name: student_answer; Type: TABLE; Schema: public; Owner: matrix
--

CREATE TABLE public.student_answer (
    id integer NOT NULL,
    attempt_id integer,
    question_id integer,
    selected_answer character(1)
);


ALTER TABLE public.student_answer OWNER TO matrix;

--
-- Name: student_answer_id_seq; Type: SEQUENCE; Schema: public; Owner: matrix
--

CREATE SEQUENCE public.student_answer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_answer_id_seq OWNER TO matrix;

--
-- Name: student_answer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: matrix
--

ALTER SEQUENCE public.student_answer_id_seq OWNED BY public.student_answer.id;


--
-- Name: student_id_seq; Type: SEQUENCE; Schema: public; Owner: matrix
--

CREATE SEQUENCE public.student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_id_seq OWNER TO matrix;

--
-- Name: student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: matrix
--

ALTER SEQUENCE public.student_id_seq OWNED BY public.student.id;


--
-- Name: student_subject; Type: TABLE; Schema: public; Owner: matrix
--

CREATE TABLE public.student_subject (
    id integer NOT NULL,
    student_id integer,
    subject_id integer
);


ALTER TABLE public.student_subject OWNER TO matrix;

--
-- Name: student_subject_id_seq; Type: SEQUENCE; Schema: public; Owner: matrix
--

CREATE SEQUENCE public.student_subject_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_subject_id_seq OWNER TO matrix;

--
-- Name: student_subject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: matrix
--

ALTER SEQUENCE public.student_subject_id_seq OWNED BY public.student_subject.id;


--
-- Name: subject; Type: TABLE; Schema: public; Owner: matrix
--

CREATE TABLE public.subject (
    id integer NOT NULL,
    subject_name character varying(100),
    subject_code character varying(20),
    course character varying(100),
    year character varying(10),
    teacher_id integer,
    academic_year integer DEFAULT (EXTRACT(year FROM CURRENT_DATE))::integer
);


ALTER TABLE public.subject OWNER TO matrix;

--
-- Name: subject_id_seq; Type: SEQUENCE; Schema: public; Owner: matrix
--

CREATE SEQUENCE public.subject_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subject_id_seq OWNER TO matrix;

--
-- Name: subject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: matrix
--

ALTER SEQUENCE public.subject_id_seq OWNED BY public.subject.id;


--
-- Name: teacher; Type: TABLE; Schema: public; Owner: matrix
--

CREATE TABLE public.teacher (
    id integer NOT NULL,
    email character varying(255),
    password character varying(255),
    fname character varying(50),
    lname character varying(50),
    phone character varying(15),
    department character varying(100),
    role character varying(50)
);


ALTER TABLE public.teacher OWNER TO matrix;

--
-- Name: teacher_id_seq; Type: SEQUENCE; Schema: public; Owner: matrix
--

CREATE SEQUENCE public.teacher_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.teacher_id_seq OWNER TO matrix;

--
-- Name: teacher_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: matrix
--

ALTER SEQUENCE public.teacher_id_seq OWNED BY public.teacher.id;


--
-- Name: assignment id; Type: DEFAULT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.assignment ALTER COLUMN id SET DEFAULT nextval('public.assignment_id_seq'::regclass);


--
-- Name: assignment_submission id; Type: DEFAULT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.assignment_submission ALTER COLUMN id SET DEFAULT nextval('public.assignment_submission_id_seq'::regclass);


--
-- Name: attendance id; Type: DEFAULT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.attendance ALTER COLUMN id SET DEFAULT nextval('public.attendance_id_seq'::regclass);


--
-- Name: course_info id; Type: DEFAULT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.course_info ALTER COLUMN id SET DEFAULT nextval('public.course_info_id_seq'::regclass);


--
-- Name: notes id; Type: DEFAULT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.notes ALTER COLUMN id SET DEFAULT nextval('public.notes_id_seq'::regclass);


--
-- Name: notice id; Type: DEFAULT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.notice ALTER COLUMN id SET DEFAULT nextval('public.notice_id_seq'::regclass);


--
-- Name: result id; Type: DEFAULT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.result ALTER COLUMN id SET DEFAULT nextval('public.result_id_seq'::regclass);


--
-- Name: staff id; Type: DEFAULT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.staff ALTER COLUMN id SET DEFAULT nextval('public.staff_id_seq'::regclass);


--
-- Name: student id; Type: DEFAULT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.student ALTER COLUMN id SET DEFAULT nextval('public.student_id_seq'::regclass);


--
-- Name: student_answer id; Type: DEFAULT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.student_answer ALTER COLUMN id SET DEFAULT nextval('public.student_answer_id_seq'::regclass);


--
-- Name: student_subject id; Type: DEFAULT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.student_subject ALTER COLUMN id SET DEFAULT nextval('public.student_subject_id_seq'::regclass);


--
-- Name: subject id; Type: DEFAULT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.subject ALTER COLUMN id SET DEFAULT nextval('public.subject_id_seq'::regclass);


--
-- Name: teacher id; Type: DEFAULT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.teacher ALTER COLUMN id SET DEFAULT nextval('public.teacher_id_seq'::regclass);


--
-- Data for Name: assignment; Type: TABLE DATA; Schema: public; Owner: matrix
--

COPY public.assignment (id, title, description, subject_id, teacher_id, due_date, created_at, created_date) FROM stdin;
1	Normalization Assignment	Explain 1NF, 2NF and 3NF with examples	4	1	2026-07-20	2026-06-02 12:48:29.086085	2026-06-23
2	Python File Handling	Create file handling program	5	1	2026-07-25	2026-06-02 12:48:29.086085	2026-06-23
6	array	array	10	1	2026-07-01	2026-06-23 16:46:14.627835	2026-06-23
\.


--
-- Data for Name: assignment_submission; Type: TABLE DATA; Schema: public; Owner: matrix
--

COPY public.assignment_submission (id, assignment_id, student_id, file_path, submitted_at, marks, remarks) FROM stdin;
3	2	1	uploads/assignments/style.css	2026-06-02 15:22:10.416389	20	Good work
2	1	3	uploads/assignments/priya_dbms.pdf	2026-06-02 12:49:26.286566	25	keep go
1	1	1	uploads/assignments/amit_dbms.pdf	2026-06-02 12:49:26.286566	18	Good work
\.


--
-- Data for Name: attendance; Type: TABLE DATA; Schema: public; Owner: matrix
--

COPY public.attendance (id, student_id, subject_id, attendance_date, status) FROM stdin;
6	1	4	2026-06-01	Present
7	4	4	2026-06-01	Absent
8	3	5	2026-06-01	Present
9	1	5	2026-06-01	Present
10	5	6	2026-06-01	Present
11	6	\N	2026-06-02	Present
\.


--
-- Data for Name: course_info; Type: TABLE DATA; Schema: public; Owner: matrix
--

COPY public.course_info (id, course, year) FROM stdin;
1	MCA	FY
2	MCA	SY
3	MSC	FY
4	MSC	SY
5	BCA	FY
6	BCA	SY
7	BCA	TY
8	BSC	FY
9	BSC	SY
10	BSC	TY
\.


--
-- Data for Name: notes; Type: TABLE DATA; Schema: public; Owner: matrix
--

COPY public.notes (id, title, subject_id, teacher_id, file_path, uploaded_at) FROM stdin;
1	DBMS Unit 1 Notes	4	1	uploads/notes/dbms_unit1.pdf	2026-06-02 13:05:36.886325
2	Python Basics	5	1	uploads/notes/python_basics.pdf	2026-06-02 13:05:36.886325
\.


--
-- Data for Name: notice; Type: TABLE DATA; Schema: public; Owner: matrix
--

COPY public.notice (id, title, description, created_by, creator_role, created_at) FROM stdin;
1	Internal Exam Schedule	Internal exams will start from July 15	1	teacher	2026-06-02 13:04:38.917533
2	Fee Submission Reminder	Last date for fee payment is June 30	1	staff	2026-06-02 13:04:38.917533
\.


--
-- Data for Name: result; Type: TABLE DATA; Schema: public; Owner: matrix
--

COPY public.result (id, student_id, subject_id, teacher_id, marks, grade, semester, created_at) FROM stdin;
1	1	4	1	85	A	Sem-3	2026-06-02 13:04:15.026562
2	4	4	1	78	B	Sem-3	2026-06-02 13:04:15.026562
3	3	4	1	91	A+	Sem-3	2026-06-02 13:04:15.026562
4	1	5	1	88	A	Sem-3	2026-06-02 13:04:15.026562
\.


--
-- Data for Name: staff; Type: TABLE DATA; Schema: public; Owner: matrix
--

COPY public.staff (id, email, password, fname, lname, phone, designation, role) FROM stdin;
4	admin1@staff.com	123456	Admin	User	9876543230	Administrator	staff
5	office@staff.com	123456	Office	Staff	9876543231	Clerk	staff
1	admin@staff.com	admin123	adam	admin	9988776655	Administrator	staff
\.


--
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: matrix
--

COPY public.student (id, email, password, fname, lname, phone, year, cource, role, academic_year) FROM stdin;
6	patil@mail.com	1234	rohit	patil	1234567890	TY	MSC	student	2026
9	raje@gmail.com	1234	swapnil	raje	00000000	FY	MCA	student	2026
3	amit@student.com	123456	Amit	Patil	9876543220	FY	MCA	student	2026
1	admin@student.com	admin123	ram	sham	9876543210	FY	MCA	student	2026
4	priya@student.com	123456	Priya	Sharma	9876543221	SY	MSC	student	2026
5	rohit@student.com	123456	Rohit	Kumar	9876543222	TY	MSC	student	2026
\.


--
-- Data for Name: student_answer; Type: TABLE DATA; Schema: public; Owner: matrix
--

COPY public.student_answer (id, attempt_id, question_id, selected_answer) FROM stdin;
\.


--
-- Data for Name: student_subject; Type: TABLE DATA; Schema: public; Owner: matrix
--

COPY public.student_subject (id, student_id, subject_id) FROM stdin;
15	1	4
16	1	5
17	1	6
18	4	4
19	4	5
20	3	4
21	3	6
\.


--
-- Data for Name: subject; Type: TABLE DATA; Schema: public; Owner: matrix
--

COPY public.subject (id, subject_name, subject_code, course, year, teacher_id, academic_year) FROM stdin;
4	Database Management System	DBMS101	MSC	FY	1	2026
5	Python Programming	PY101	MSC	SY	1	2026
6	Operating System	OS101	MSC	SY	3	2026
10	JAVA	101	MCA	FY	1	2026
\.


--
-- Data for Name: teacher; Type: TABLE DATA; Schema: public; Owner: matrix
--

COPY public.teacher (id, email, password, fname, lname, phone, department, role) FROM stdin;
1	admin@teacher.com	admin123	Robert	Brown	9123456780	Computer Science	teacher
3	john@teacher.com	123456	John	Smith	9876543210	Computer	teacher
4	alice@teacher.com	123456	Alice	Johnson	9876543211	Computer	teacher
\.


--
-- Name: assignment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: matrix
--

SELECT pg_catalog.setval('public.assignment_id_seq', 6, true);


--
-- Name: assignment_submission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: matrix
--

SELECT pg_catalog.setval('public.assignment_submission_id_seq', 3, true);


--
-- Name: attendance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: matrix
--

SELECT pg_catalog.setval('public.attendance_id_seq', 11, true);


--
-- Name: course_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: matrix
--

SELECT pg_catalog.setval('public.course_info_id_seq', 10, true);


--
-- Name: notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: matrix
--

SELECT pg_catalog.setval('public.notes_id_seq', 2, true);


--
-- Name: notice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: matrix
--

SELECT pg_catalog.setval('public.notice_id_seq', 3, true);


--
-- Name: result_id_seq; Type: SEQUENCE SET; Schema: public; Owner: matrix
--

SELECT pg_catalog.setval('public.result_id_seq', 4, true);


--
-- Name: staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: matrix
--

SELECT pg_catalog.setval('public.staff_id_seq', 5, true);


--
-- Name: student_answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: matrix
--

SELECT pg_catalog.setval('public.student_answer_id_seq', 1, false);


--
-- Name: student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: matrix
--

SELECT pg_catalog.setval('public.student_id_seq', 9, true);


--
-- Name: student_subject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: matrix
--

SELECT pg_catalog.setval('public.student_subject_id_seq', 21, true);


--
-- Name: subject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: matrix
--

SELECT pg_catalog.setval('public.subject_id_seq', 11, true);


--
-- Name: teacher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: matrix
--

SELECT pg_catalog.setval('public.teacher_id_seq', 6, true);


--
-- Name: assignment assignment_pkey; Type: CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.assignment
    ADD CONSTRAINT assignment_pkey PRIMARY KEY (id);


--
-- Name: assignment_submission assignment_submission_pkey; Type: CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.assignment_submission
    ADD CONSTRAINT assignment_submission_pkey PRIMARY KEY (id);


--
-- Name: attendance attendance_pkey; Type: CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_pkey PRIMARY KEY (id);


--
-- Name: course_info course_info_pkey; Type: CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.course_info
    ADD CONSTRAINT course_info_pkey PRIMARY KEY (id);


--
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: notice notice_pkey; Type: CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.notice
    ADD CONSTRAINT notice_pkey PRIMARY KEY (id);


--
-- Name: result result_pkey; Type: CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.result
    ADD CONSTRAINT result_pkey PRIMARY KEY (id);


--
-- Name: staff staff_email_key; Type: CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_email_key UNIQUE (email);


--
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (id);


--
-- Name: student_answer student_answer_pkey; Type: CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.student_answer
    ADD CONSTRAINT student_answer_pkey PRIMARY KEY (id);


--
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (id);


--
-- Name: student_subject student_subject_pkey; Type: CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.student_subject
    ADD CONSTRAINT student_subject_pkey PRIMARY KEY (id);


--
-- Name: subject subject_pkey; Type: CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT subject_pkey PRIMARY KEY (id);


--
-- Name: teacher teacher_email_key; Type: CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT teacher_email_key UNIQUE (email);


--
-- Name: teacher teacher_pkey; Type: CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT teacher_pkey PRIMARY KEY (id);


--
-- Name: subject unique_subject_code; Type: CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT unique_subject_code UNIQUE (subject_code);


--
-- Name: assignment assignment_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.assignment
    ADD CONSTRAINT assignment_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subject(id);


--
-- Name: assignment_submission assignment_submission_assignment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.assignment_submission
    ADD CONSTRAINT assignment_submission_assignment_id_fkey FOREIGN KEY (assignment_id) REFERENCES public.assignment(id);


--
-- Name: assignment_submission assignment_submission_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.assignment_submission
    ADD CONSTRAINT assignment_submission_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id);


--
-- Name: assignment assignment_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.assignment
    ADD CONSTRAINT assignment_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public.teacher(id);


--
-- Name: attendance attendance_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id);


--
-- Name: attendance attendance_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subject(id);


--
-- Name: notes notes_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subject(id);


--
-- Name: notes notes_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public.teacher(id);


--
-- Name: result result_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.result
    ADD CONSTRAINT result_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id);


--
-- Name: result result_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.result
    ADD CONSTRAINT result_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subject(id);


--
-- Name: result result_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.result
    ADD CONSTRAINT result_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public.teacher(id);


--
-- Name: student_subject student_subject_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.student_subject
    ADD CONSTRAINT student_subject_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id);


--
-- Name: student_subject student_subject_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.student_subject
    ADD CONSTRAINT student_subject_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subject(id);


--
-- Name: subject subject_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: matrix
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT subject_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public.teacher(id);


--
-- PostgreSQL database dump complete
--

\unrestrict 1jpt9Tetn11N2loWepepjyNP8m40GQYaQB2pwi8iECjuahXIlyGF6wHAr1E2g13

