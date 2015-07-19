insert into state_lookup values ('NJ', 'New Jersey');
insert into state_lookup values ('MD', 'Maryland');
insert into state_lookup values ('NY', 'New York');
insert into state_lookup values ('HA', 'Hawaii');
insert into state_lookup values ('AK', 'Alaska');
insert into dept values (10, 'ACCOUNTING', 'NEW YORK');
insert into dept values (20, 'RESEARCH', 'DALLAS');
insert into dept values (30, 'SALES', 'CHICAGO');
insert into dept values (40, 'OPERATIONS', 'BOSTON');
insert into salgrade values (1,700,1200);
insert into salgrade values (2, 1201, 1400);
insert into salgrade values (3, 1401, 2000);
insert into salgrade values (4, 2001, 3000);
insert into salgrade values (5, 3001, 9999);
insert into emp values 
(7839,'KING','PRESIDENT',null,'17-NOV-1995',5000,null,10);
insert into emp values 
(7566,'JONES','MANAGER',7839,'02-APR-1995',2975,null,20);
insert into emp values
(7698,'BLAKE','MANAGER',7839,'01-MAY-1995',2850,null,30);
insert into emp values
(7782,'CLARK','MANAGER',7839,'09-JUN-1995',2450,null,10);
insert into emp values
(7902,'FORD','ANALYST',7566,'03-DEC-1995',3000,null,20);
insert into emp values
(7369,'SMITH','CLERK',7902,'17-DEC-1998',800,null,20);
insert into emp values
(7499,'ALLEN','SALESMAN',7698,'20-FEB-1999',1600,300,30);
insert into emp values
(7521,'WARD','SALESMAN',7698,'22-FEB-1998',1250,500,30);
insert into emp values 
(7654,'MARTIN','SALESMAN',7698,'28-SEP-1999',1250,1400,30);
insert into emp values 
(7788,'SCOTT','ANALYST',7566,'09-DEC-1996',3000,null,20);
insert into emp values
(7844,'TURNER','SALESMAN',7698,'08-SEP-1995',1500,0,30);
insert into emp values
(7876,'ADAMS','CLERK',7788,'12-JAN-2000',1100,null,20);
insert into emp values
(7900,'JAMES','CLERK',7698,'03-DEC-1995',950,null,30);
insert into emp values
(7934,'MILLER','CLERK',7782,'23-JAN-1996',1300,null,10);
insert into customer values (90001, 'B and B', 'A-11101', 'PR', 'AK');
insert into customer values (90002, 'XYZ', 'A-11102', 'CM', 'NJ');
insert into customer values (90003, 'JJ Sons', 'A-11103', 'CM', 'NJ');
insert into customer values (90004, 'Exxon', 'A-11104', 'PR', 'NY');
insert into customer values (90005, 'ABC', 'A-11105', 'CM', 'NY');
insert into customer values (90006, 'Smith Co.', 'A-11106', 'CM', 'MD');
insert into customer values (90007, 'Brown Co.', 'A-11107', 'CM', 'MD');
insert into customer values (90008, 'Cooper Inc.', 'A-11108', 'PR', 'MD');
insert into emp_service values (7521, 90001, 100);
insert into emp_service values (7521, 90006, 100);
insert into emp_service values (7698, 90004, 100);
insert into emp_service values (7369, 90002, 100);
insert into emp_service values (7788, 90003, 300);
insert into emp_service values (7788, 90005, 300);
insert into emp_service values (7902, 90007, 300);
insert into emp_service values (7902, 90008, 5001);
insert into widgets values (61, 'off',  'yes', 15, 20, 20);
insert into widgets values (62, 'on',  'yes',  17, 21, 21);
insert into widgets values (63, 'off',  'yes', 16, 20, 20);
insert into widgets values (64, 'off',  'yes', 14, 20, 20);
insert into widgets values (65, 'off',  'yes', 17, 20, 21);
insert into purchase_order values (31, 61, 90001, 10, '21-JAN-2000',100,'N');
insert into purchase_order values (32, 63, 90004, 10, '11-FEB-1998',100,'N');
insert into purchase_order values (33, 64, 90008, 8,  '20-MAR-1999',80,'N');
insert into purchase_order values (34, 65, 90007, 7,  '10-JUN-1999',90,'N');
insert into purchase_order values (35, 62, 90004, 12, '25-JUN-1998', 75, 'Y');
insert into purchase_order values (36, 65, 90001, 9, '05-JAN-2000', 90, 'Y');
insert into purchase_order values (37, 61, 90005, 8, '15-JUL-1999', 100, 'N');
insert into purchase_order values (38, 63, 90001, 5, '22-JUL-1998', 100, 'Y');
insert into purchase_order values (39, 62, 90005, 7, '01-AUG-1998', 75, 'N');
insert into purchase_order values (40, 64, 90008, 10, '20-AUG-1999', 80, 'Y');
insert into emp_service_log values (7521, 90001, 'pur order sent');
insert into emp_service_log values (7521, 90006, 'waiting on invoice');
insert into emp_service_log values (7698, 90004, 'waiting parts');
commit;


