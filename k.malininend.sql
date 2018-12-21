01-14 10:50:00
92	101	26	\N	2016-01-19 13:09:00
96	75	29	\N	2016-01-16 10:46:00
129	6	18	3	2016-01-26 10:32:00
130	2	18	2	2016-01-26 10:51:00
132	19	24	3	2016-01-26 10:55:00
133	8	30	4	2016-01-26 10:33:00
134	6	30	3	2016-01-26 10:13:00
135	4	30	3	2016-01-26 10:58:00
136	7	18	3	2016-01-26 10:04:00
137	101	26	3	2016-01-26 10:21:00
138	75	29	4	2016-01-26 10:53:00
131	75	19	\N	2016-01-26 10:13:00
139	75	19	\N	\N
\.

SELECT pg_catalog.setval('marks_id_seq', 139, true);

--
-- semesters 
--
CREATE TABLE semesters (
    id smallint NOT NULL
);

COPY semesters (id) FROM stdin;
1
2
3
4
5
6
7
8
\.

--
-- students 
--
CREATE TABLE students (
    id integer NOT NULL,
    lastname character varying(80),
    firstname character varying(80),
    group_id integer,
    sex character varying(6)
);

CREATE SEQUENCE students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
    
ALTER TABLE ONLY students ALTER COLUMN id SET DEFAULT nextval('students_id_seq'::regclass);

COPY students (id, lastname, firstname, group_id, sex) FROM stdin;
3	Korolev	Konstantin	4	male
7	Maylatova	Ekaterina	4	male
9	Khaliullina	Liya	4	male
101	Kaplun	Igor	2	male
19	Pomazkova	Galina	2	male
75	Ustinova	Svetlana	3	male
5	Levdic	Veronica	4	male
1	Kiriluk	Anton	4	male
2	Koreshkova	Natalya	4	female
4	Le	Ian	4	female
6	Logosha	Elizaveta	4	female
8	Prokhorenko	Philipp	4	female
24	Livotova	Wassilisa	2	female
34	Logachev	Mikhail	1	female
172	Shulga	Valentin	\N	female
78	Avdeenko	Dmitrii	\N	female
10	Vlad	Andrei	4	female
\.

SELECT pg_catalog.setval('students_id_seq', 172, false);

--
-- students_hobbies_relations 
--
CREATE TABLE students_hobbies_relations (
    students_id integer NOT NULL,
    hobbies_id integer NOT NULL
);


--
-- subjects 
--
CREATE TABLE subjects (
    id smallint NOT NULL,
    name character varying(80)
);


CREATE SEQUENCE subjects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE subjects_id_seq OWNED BY subjects.id;

ALTER TABLE ONLY subjects ALTER COLUMN id SET DEFAULT nextval('subjects_id_seq'::regclass);

COPY subjects (id, name) FROM stdin;
1	mathematical analysis
2	higher mathematics
3	differential equations
4	physical culture
5	databases and network technologies
6	programming technology
\.

SELECT pg_catalog.setval('subjects_id_seq', 6, true);

--
-- CONSTRAINTS
--
ALTER TABLE ONLY examinations
    ADD CONSTRAINT examinations_pkey PRIMARY KEY (id);

ALTER TABLE ONLY groups_examinations
    ADD CONSTRAINT groups_examinations_pkey PRIMARY KEY (id);

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);

ALTER TABLE ONLY hobbies
    ADD CONSTRAINT hobbies_pkey PRIMARY KEY (id);

ALTER TABLE ONLY marks
    ADD CONSTRAINT marks_pkey PRIMARY KEY (id);

ALTER TABLE ONLY semesters
    ADD CONSTRAINT semesters_pkey PRIMARY KEY (id);

ALTER TABLE ONLY students_hobbies_relations
    ADD CONSTRAINT students_hobbies_relations_pkey PRIMARY KEY (students_id, hobbies_id);

ALTER TABLE ONLY students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);

ALTER TABLE ONLY subjects
    ADD CONSTRAINT subjects_pkey PRIMARY KEY (id);
    
ALTER TABLE ONLY students
    ADD CONSTRAINT students_group_id_fkey FOREIGN KEY (group_id) REFERENCES groups(id) ON UPDATE RESTRICT ON DELETE RESTRICT;



