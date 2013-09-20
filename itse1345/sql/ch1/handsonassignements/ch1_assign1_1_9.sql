/*
	Add two rows of data to the table, using data values you create.  
	Make sure the default option on the LAST_DATE column is used in 
	the second row added.  Also, issuea command to save the data in 
	the table permanently.

		CON_ID COMPANY_NAME                   EMAIL                          LAST_DATE    CON_CNT
	---------- ------------------------------ ------------------------------ --------- ----------
			 1 Nokia                          nokia@nokia.com                01-JAN-12          1 
			 2 HP                             hp@hp.com                      02-SEP-13 
*/

insert into contacts
  values(1, 'Nokia', 'nokia@nokia.com', '01-JAN-12', 1);
insert into contacts
  values(2, 'HP', 'hp@hp.com', sysdate, 2);
commit;