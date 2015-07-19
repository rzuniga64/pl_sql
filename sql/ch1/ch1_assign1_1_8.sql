/*
	Create a table named CONTACTS that includes the following columns:

	DESC CONTACTS;
	
	Name         Null     Type         
	------------ -------- ------------ 
	CON_ID       NOT NULL NUMBER(4)    
	COMPANY_NAME          VARCHAR2(30) 
	EMAIL                 VARCHAR2(30) 
	LAST_DATE             DATE         
	CON_CNT               NUMBER(3)  
*/

create table contacts (
  Con_id        NUMBER(4),
  Company_name  VARCHAR2(30),
  Email        VARCHAR2(30),
  Last_date     DATE,
  Con_cnt       NUMBER(3),
  CONSTRAINT con_id_pk PRIMARY KEY(Con_id)
  );