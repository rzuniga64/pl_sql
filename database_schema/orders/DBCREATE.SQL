drop table emp_service_log;
drop table emp_service;
drop table purchase_order;
drop table emp;
drop table dept;
drop table customer;
drop table widgets;
drop table salgrade;
drop table state_lookup;
drop sequence empno;
drop sequence deptno;
drop sequence cust_id;
drop sequence account_id;


CREATE TABLE state_lookup
(state       	VARCHAR2(2) CONSTRAINT pk_state_lookup PRIMARY KEY,
 state_desc  	VARCHAR2(16));

CREATE TABLE dept 
   (deptno    number(3) CONSTRAINT pk_dept PRIMARY KEY,                      
    dname     VARCHAR2(15),
    loc       VARCHAR2(10));

CREATE TABLE emp 
   (empno      number(4)    CONSTRAINT pk_emp PRIMARY KEY,
    ename      varchar2(10) NOT NULL,
    job        varchar2(10),
    mgr        number(4) references emp ON DELETE CASCADE,
    hiredate   date,
    sal        number(6),
    comm       number(6),
    deptno     number(3),
CONSTRAINT fk_emp_deptno FOREIGN KEY (deptno) REFERENCES dept 
			  ON DELETE CASCADE);
CREATE TABLE salgrade
   (grade number(3) CONSTRAINT pk_salgrade PRIMARY KEY,
    losal number(5),
    hisal number(6));

CREATE TABLE customer
(cust_id       	NUMBER(5) CONSTRAINT pk_customer PRIMARY KEY,
 cust_name     	VARCHAR2(15),
 account_id    	VARCHAR2(10) CONSTRAINT 
			    uk_customer_account_id UNIQUE,
 account_type  	VARCHAR2(2),
 state         	VARCHAR2(2),
 CONSTRAINT    fk_customer_state FOREIGN KEY (state) 
	       REFERENCES state_lookup);

CREATE TABLE widgets  
(widget_id 	NUMBER(5) CONSTRAINT pk_widgets PRIMARY KEY,                                         
 status  	VARCHAR2(3) NOT NULL CONSTRAINT ck_widgets_status 
		     CHECK (status in ('on', 'off')),      
 sample  	VARCHAR2(3) CONSTRAINT ck_widgets_sample               
		     CHECK (sample IN ('yes', 'no')),                         
 length  	NUMBER(5)   CONSTRAINT ck_widgets_length
		     CHECK ((length != 10) 
		     AND (length != 20)),        
 width   	NUMBER(5),                                                 
 height  	NUMBER(5), 
 CONSTRAINT ck_widgets_production 
      CHECK ((length >= 0)
      AND (width <= length + 10)   	   
      AND (height <= width + 10)));

CREATE TABLE purchase_order
(order_id       NUMBER(5),
 widget_id      NUMBER (5),
 cust_id        NUMBER(5),
 quantity       NUMBER (5),
 purchase_date  DATE,
 purchase_price NUMBER(5),
 dev            VARCHAR2(1) NOT NULL 
                            CONSTRAINT ck_purchase_order_status
                            CHECK (dev IN ('Y','N')),
 CONSTRAINT     pk_ourchase_order PRIMARY KEY (order_id, widget_id),
 CONSTRAINT	fk_purchase_order_cust_id 
	        FOREIGN KEY (cust_id) 
	        REFERENCES customer ON DELETE CASCADE,
 CONSTRAINT	fk_purchase_order_widget_id 
	        FOREIGN KEY (widget_id)
	        REFERENCES widgets ON DELETE CASCADE);

CREATE TABLE emp_service
(empno    	NUMBER(5),
 cust_id   	NUMBER(5),
 sales     	NUMBER(5),
 CONSTRAINT	pk_emp_service PRIMARY KEY (empno, cust_id),
 CONSTRAINT	fk_emp_service_empno  FOREIGN KEY (empno) 
		REFERENCES emp ON DELETE CASCADE,
 CONSTRAINT 	fk_emp_service_cust_id FOREIGN KEY (cust_id) 
		REFERENCES customer ON DELETE CASCADE);

CREATE TABLE emp_service_log
(empno    	NUMBER(5),
 cust_id   	NUMBER(5),
 log       	VARCHAR2(40),
 CONSTRAINT	pk_emp_service_log PRIMARY KEY (empno, cust_id),
 CONSTRAINT	fk_emp_service_log_ce 
		FOREIGN KEY (empno, cust_id) 
		REFERENCES emp_service ON DELETE CASCADE);

CREATE SEQUENCE EMPNO
INCREMENT BY 1
START WITH 100
NOMAXVALUE
NOCYCLE
NOCACHE
ORDER;
CREATE SEQUENCE DEPTNO
INCREMENT BY 10
START WITH 100
NOMAXVALUE
NOCYCLE
NOCACHE
ORDER;
CREATE SEQUENCE ACCOUNT_ID
INCREMENT BY 1
START WITH 11109
NOMAXVALUE
NOCYCLE
NOCACHE
ORDER;
CREATE SEQUENCE CUST_ID
INCREMENT BY 1
START WITH 90009
NOMAXVALUE
NOCYCLE
NOCACHE
ORDER;


