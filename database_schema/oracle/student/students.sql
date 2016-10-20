REM tables.sql
REM Oracle9i PL/SQL Programming by Scott Urman

REM This file will drop and create all of the tables used
REM for the examples.  Data is inserted into the students,
REM rooms, classes, and registered_students tables.

REM This script can be run from SQL*Plus.


PROMPT student_sequence...
DROP SEQUENCE student_sequence;

CREATE SEQUENCE student_sequence
  START WITH 10000
  INCREMENT BY 1;

PROMPT students table...
DROP TABLE students CASCADE CONSTRAINTS;

CREATE TABLE students (
  id               NUMBER(5) PRIMARY KEY,
  first_name       VARCHAR2(20),
  last_name        VARCHAR2(20),
  major            VARCHAR2(30),
  current_credits  NUMBER(3)
  );

INSERT INTO students (id, first_name, last_name, major, current_credits)
  VALUES (student_sequence.NEXTVAL, 'Scott', 'Smith', 'Computer Science', 11);

INSERT INTO students (id, first_name, last_name, major, current_credits)
  VALUES (student_sequence.NEXTVAL, 'Margaret', 'Mason', 'History', 4);

INSERT INTO students (id, first_name, last_name, major, current_credits)
  VALUES (student_sequence.NEXTVAL, 'Joanne', 'Junebug', 'Computer Science', 8);

INSERT INTO students (id, first_name, last_name, major, current_credits)
  VALUES (student_sequence.NEXTVAL, 'Manish', 'Murgatroid',  'Economics', 8);

INSERT INTO students(id, first_name, last_name, major, current_credits)
  VALUES(student_sequence.NEXTVAL, 'Patrick', 'Poll', 'History', 4);

INSERT INTO students(id, first_name, last_name, major, current_credits)
  VALUES (student_sequence.NEXTVAL, 'Timothy', 'Taller', 'History', 4);

INSERT INTO students(id, first_name, last_name, major, current_credits)
  VALUES (student_sequence.NEXTVAL, 'Barbara', 'Blues', 'Economics', 7);

INSERT INTO students(id, first_name, last_name, major, current_credits)
  VALUES (student_sequence.NEXTVAL, 'David', 'Dinsmore', 'Music', 4);

INSERT INTO students(id, first_name, last_name, major, current_credits)
  VALUES (student_sequence.NEXTVAL, 'Ester', 'Elegant', 'Nutrition', 8);

INSERT INTO students(id, first_name, last_name, major, current_credits)
  VALUES (student_sequence.NEXTVAL, 'Rose', 'Riznit', 'Music', 7);

INSERT INTO STUDENTS(id, first_name, last_name, major, current_credits)
  VALUES (student_sequence.NEXTVAL, 'Rita', 'Razmataz', 'Nutrition', 8);

INSERT INTO students(id, first_name, last_name, major, current_credits)
  VALUES (student_sequence.NEXTVAL, 'Shay', 'Shariatpanahy', 'Computer Science', 3);

DROP TABLE major_stats;

CREATE TABLE major_stats (
  major          VARCHAR2(30),
  total_credits  NUMBER,
  total_students NUMBER);

INSERT INTO major_stats (major, total_credits, total_students)
  VALUES ('Computer Science', 22, 3);

INSERT INTO major_stats (major, total_credits, total_students)
  VALUES ('History', 12, 3);

INSERT INTO major_stats (major, total_credits, total_students)
  VALUES ('Economics', 15, 2);

INSERT INTO major_stats (major, total_credits, total_students)
  VALUES ('Music', 11, 2);

INSERT INTO major_stats (major, total_credits, total_students)
  VALUES ('Nutrition', 16, 2);

PROMPT room_sequence...
DROP SEQUENCE room_sequence;

CREATE SEQUENCE room_sequence
  START WITH 20000
  INCREMENT BY 1;

PROMPT rooms table...
DROP TABLE rooms CASCADE CONSTRAINTS;

CREATE TABLE rooms (
  room_id          NUMBER(5) PRIMARY KEY,
  building         VARCHAR2(15),
  room_number      NUMBER(4),
  number_seats     NUMBER(4),
  description      VARCHAR2(50)
  );

INSERT INTO rooms (room_id, building, room_number, number_seats, description)
  VALUES (room_sequence.NEXTVAL, 'Building 7', 201, 1000, 'Large Lecture Hall');

INSERT INTO rooms (room_id, building, room_number, number_seats, description)
  VALUES (room_sequence.NEXTVAL, 'Building 6', 101, 500, 'Small Lecture Hall');

INSERT INTO rooms (room_id, building, room_number, number_seats, description)
  VALUES (room_sequence.NEXTVAL, 'Building 6', 150, 50,'Discussion Room A');

INSERT INTO rooms (room_id, building, room_number, number_seats, description)
  VALUES (room_sequence.NEXTVAL, 'Building 6', 160, 50,'Discussion Room B');

INSERT INTO rooms (room_id, building, room_number, number_seats, description)
  VALUES (room_sequence.NEXTVAL, 'Building 6', 170, 50, 'Discussion Room C');

INSERT INTO rooms (room_id, building, room_number, number_seats, description)
  VALUES (room_sequence.NEXTVAL, 'Music Building', 100, 10, 'Music Practice Room');

INSERT INTO rooms (room_id, building, room_number, number_seats, description)
  VALUES (room_sequence.NEXTVAL, 'Music Building', 200, 1000, 'Concert Room');

INSERT INTO rooms (room_id, building, room_number, number_seats, description)
  VALUES (room_sequence.NEXTVAL, 'Building 7', 300, 75, 'Discussion Room D');

INSERT INTO rooms (room_id, building, room_number, number_seats, description)
  VALUES (room_sequence.NEXTVAL, 'Building 7', 310, 50, 'Discussion Room E');

PROMPT classes table...
DROP TABLE classes CASCADE CONSTRAINTS;

CREATE TABLE classes (
  department       CHAR(3),
  course           NUMBER(3),
  description      VARCHAR2(2000),
  max_students     NUMBER(3),
  current_students NUMBER(3),
  num_credits      NUMBER(1),
  room_id          NUMBER(5),
  CONSTRAINT classes_department_course
    PRIMARY KEY (department, course),
  CONSTRAINT classes_room_id
    FOREIGN KEY (room_id) REFERENCES rooms (room_id)
  );

INSERT INTO classes(department, course, description, max_students, current_students, num_credits, room_id)
  VALUES ('HIS', 101, 'History 101', 30, 11, 4, 20000);

INSERT INTO classes(department, course, description, max_students, current_students, num_credits, room_id)
  VALUES ('HIS', 301, 'History 301', 30, 0, 4, 20004);

INSERT INTO classes(department, course, description, max_students, current_students, num_credits, room_id)
  VALUES ('CS', 101, 'Computer Science 101', 50, 0, 4, 20001);

INSERT INTO classes(department, course, description, max_students,  current_students, num_credits, room_id)
  VALUES ('ECN', 203, 'Economics 203', 15, 0, 3, 20002);

INSERT INTO classes(department, course, description, max_students, current_students, num_credits, room_id)
  VALUES ('CS', 102, 'Computer Science 102', 35, 3, 4, 20003);

INSERT INTO classes(department, course, description, max_students, current_students, num_credits, room_id)
  VALUES ('MUS', 410, 'Music 410', 5, 4, 3, 20005);

INSERT INTO classes(department, course, description, max_students, current_students, num_credits, room_id)
  VALUES ('ECN', 101, 'Economics 101', 50, 0, 4, 20007);

INSERT INTO classes(department, course, description, max_students, current_students, num_credits, room_id)
  VALUES ('NUT', 307, 'Nutrition 307', 20, 2, 4, 20008);

INSERT INTO classes(department, course, description, max_students, current_students, num_credits, room_id)
  VALUES ('MUS', 100, 'Music 100', 100, 0, 3, NULL);

PROMPT registered_students table...
DROP TABLE registered_students CASCADE CONSTRAINTS;

CREATE TABLE registered_students (
  student_id NUMBER(5) NOT NULL,
  department CHAR(3)   NOT NULL,
  course     NUMBER(3) NOT NULL,
  grade      CHAR(1),
  CONSTRAINT rs_grade
    CHECK (grade IN ('A', 'B', 'C', 'D', 'E')),
  CONSTRAINT rs_student_id
    FOREIGN KEY (student_id) REFERENCES students (id),
  CONSTRAINT rs_department_course
    FOREIGN KEY (department, course)
    REFERENCES classes (department, course)
  );

INSERT INTO registered_students (student_id, department, course, grade)
  VALUES (10000, 'CS', 102, 'A');

INSERT INTO registered_students (student_id, department, course, grade)
  VALUES (10002, 'CS', 102, 'B');

INSERT INTO registered_students (student_id, department, course, grade)
  VALUES (10003, 'CS', 102, 'C');

INSERT INTO registered_students (student_id, department, course, grade)
  VALUES (10000, 'HIS', 101, 'A');

INSERT INTO registered_students (student_id, department, course, grade)
  VALUES (10001, 'HIS', 101, 'B');

INSERT INTO registered_students (student_id, department, course, grade)
  VALUES (10002, 'HIS', 101, 'B');

INSERT INTO registered_students (student_id, department, course, grade)
  VALUES (10003, 'HIS', 101, 'A');

INSERT INTO registered_students (student_id, department, course, grade)
  VALUES (10004, 'HIS', 101, 'C');

INSERT INTO registered_students (student_id, department, course, grade)
  VALUES (10005, 'HIS', 101, 'C');

INSERT INTO registered_students (student_id, department, course, grade)
  VALUES (10006, 'HIS', 101, 'E');

INSERT INTO registered_students (student_id, department, course, grade)
  VALUES (10007, 'HIS', 101, 'B');

INSERT INTO registered_students (student_id, department, course, grade)
  VALUES (10008, 'HIS', 101, 'A');

INSERT INTO registered_students (student_id, department, course, grade)
  VALUES (10009, 'HIS', 101, 'D');

INSERT INTO registered_students (student_id, department, course, grade)
  VALUES (10010, 'HIS', 101, 'A');

INSERT INTO registered_students (student_id, department, course,  grade)
  VALUES (10008, 'NUT', 307, 'A');

INSERT INTO registered_students (student_id, department, course,  grade)
  VALUES (10010, 'NUT', 307, 'A');

INSERT INTO registered_students (student_id, department, course, grade)
  VALUES (10009, 'MUS', 410, 'B');

INSERT INTO registered_students (student_id, department, course, grade)
  VALUES (10006, 'MUS', 410, 'E');

INSERT INTO registered_students (student_id, department, course, grade)
  VALUES (10011, 'MUS', 410, 'B');

INSERT INTO registered_students (student_id, department, course, grade)
  VALUES (10000, 'MUS', 410, 'B');

PROMPT RS_audit...
DROP TABLE RS_audit;

CREATE TABLE RS_audit (
  change_type    CHAR(1)     NOT NULL,
  changed_by     VARCHAR2(8) NOT NULL,
  timestamp      DATE        NOT NULL,
  old_student_id NUMBER(5),
  old_department CHAR(3),
  old_course     NUMBER(3),
  old_grade      CHAR(1),
  new_student_id NUMBER(5),
  new_department CHAR(3),
  new_course     NUMBER(3),
  new_grade      CHAR(1)
  );

PROMPT log_table...
DROP TABLE log_table;

CREATE TABLE log_table (
  code             NUMBER,
  message          VARCHAR2(200),
  info             VARCHAR2(100)
  );

PROMPT temp_table...
DROP TABLE temp_table;

CREATE TABLE temp_table (
  num_col    NUMBER,
  char_col   VARCHAR2(60)
  );


CREATE OR REPLACE TYPE NumTab AS TABLE OF NUMBER;
/

CREATE OR REPLACE TYPE NumVar AS VARRAY(25) OF NUMBER;
/

CREATE OR REPLACE PACKAGE IndexBy AS
  TYPE NumTab IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
END IndexBy;
/

DROP TABLE books CASCADE CONSTRAINTS;

CREATE TABLE books (
  catalog_number NUMBER(4)     PRIMARY KEY,
  title          VARCHAR2(40),
  author1        VARCHAR2(40),
  author2        VARCHAR2(40),
  author3        VARCHAR2(40),
  author4        VARCHAR2(40)
);

INSERT INTO books (catalog_number, title, author1)
  VALUES (1000, 'Oracle8i Advanced PL/SQL Programming', 'Urman, Scott');

INSERT INTO books (catalog_number, title, author1, author2, author3)
  VALUES (1001, 'Oracle8i: A Beginner''s Guide', 'Abbey, Michael', 'Corey, Michael J.', 'Abramson, Ian');

INSERT INTO books (catalog_number, title, author1, author2, author3, author4)
  VALUES (1002, 'Oracle8 Tuning', 'Corey, Michael J.', 'Abbey, Michael', 'Dechichio, Daniel J.', 'Abramson, Ian');

INSERT INTO books (catalog_number, title, author1, author2)
  VALUES (2001, 'A History of the World', 'Arlington, Arlene', 'Verity, Victor');

INSERT INTO books (catalog_number, title, author1)
  VALUES (3001, 'Bach and the Modern World', 'Foo, Fred');

INSERT INTO books (catalog_number, title, author1)
  VALUES (3002, 'Introduction to the Piano', 'Morenson, Mary');

DROP TYPE BookList FORCE;

CREATE OR REPLACE TYPE BookList AS VARRAY(10) OF NUMBER(4);
/

DROP TABLE class_material CASCADE CONSTRAINTS;

CREATE TABLE class_material (
  department       CHAR(3),
  course           NUMBER(3),
  required_reading BookList
);

DROP TYPE StudentList FORCE;

CREATE OR REPLACE TYPE StudentList AS TABLE OF NUMBER(5);
/

DROP TABLE library_catalog CASCADE CONSTRAINTS;

CREATE TABLE library_catalog (
  catalog_number NUMBER(4),
    FOREIGN KEY (catalog_number) REFERENCES books(catalog_number),
  num_copies     NUMBER,
  num_out        NUMBER,
  checked_out    StudentList)
  NESTED TABLE checked_out STORE AS co_tab;

