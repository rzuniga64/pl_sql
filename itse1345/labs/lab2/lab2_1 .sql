DROP TABLE theater;
DROP SEQUENCE theater_seq;
CREATE TABLE THEATER (
  list#  NUMBER(5),
  v_row_number NUMBER,
  c_xyz NUMBER(10),
  v_counter1 INTEGER,
  stringa VARCHAR2(50),
  CONSTRAINT theater_list_pk PRIMARY KEY(list#));
CREATE SEQUENCE theater_seq start with 9 INCREMENT BY 1;
INSERT INTO theater
  VALUES(theater_seq.NEXTVAL, 0 , 50, 1, 'Paramount');
INSERT INTO theater
  VALUES(theater_seq.NEXTVAL, 1 , 60, 2, 'Bob Bullock Theater');