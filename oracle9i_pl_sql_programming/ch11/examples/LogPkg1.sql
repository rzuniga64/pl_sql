REM LogPkg1.sql
REM Chapter 11, Oracle9i PL/SQL Programming by Scott Urman
REM This package is used to log connects and disconnects to the
REM database.

CREATE OR REPLACE PACKAGE LogPkg AS
  PROCEDURE LogConnect(p_UserID IN VARCHAR2);
  PROCEDURE LogDisconnect(p_UserID IN VARCHAR2);
END LogPkg;
/

CREATE OR REPLACE PACKAGE BODY LogPkg AS
  PROCEDURE LogConnect(p_UserID IN VARCHAR2) IS
  BEGIN
    INSERT INTO connect_audit (user_name, operation, timestamp)
      VALUES (p_USerID, 'CONNECT', SYSDATE);
  END LogConnect;

  PROCEDURE LogDisconnect(p_UserID IN VARCHAR2) IS
  BEGIN
    INSERT INTO connect_audit (user_name, operation, timestamp)
      VALUES (p_USerID, 'DISCONNECT', SYSDATE);
  END LogDisconnect;
END LogPkg;
/
