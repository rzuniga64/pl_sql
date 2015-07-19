/*
	Issue a command to change the e-mail value for the first row added to the table.
	show a query on the table to confirm that the change was completed.  then issue a 
	command to undo the change. 
	
			CON_ID COMPANY_NAME                   EMAIL                          LAST_DATE    CON_CNT
	---------- ------------------------------ ------------------------------ --------- ----------
			 1 Nokia                          acc@austincc.edu               01-JAN-12          1 
			 2 HP                             hp@hp.com                      02-SEP-13          2 
*/

update contacts
  set email = 'acc@austincc.edu'
  where con_id = 1;