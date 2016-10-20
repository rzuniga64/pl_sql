REM LogConnects.sql
REM Chapter 11, Oracle9i  PL/SQL Programming by Scott Urman
REM These triggers will record all connects and disconnects to/from
REM the database.

CREATE OR REPLACE TRIGGER LogConnects
  AFTER LOGON ON DATABASE
  CALL LogPkg.LogConnect(SYS.LOGIN_USER)
/

CREATE OR REPLACE TRIGGER LogDisconnects
  BEFORE LOGOFF ON DATABASE
  CALL LogPkg.LogDisconnect(SYS.LOGIN_USER)
/
