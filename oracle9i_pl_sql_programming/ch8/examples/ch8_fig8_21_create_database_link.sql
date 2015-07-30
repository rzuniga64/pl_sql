REM a database link is simply a pointer that instructs Oracle
REM to look for the referenced object in a database instance
REM other than the current connection.

CREATE DATABASE LINK dblink1
USING 'coisorcl2';