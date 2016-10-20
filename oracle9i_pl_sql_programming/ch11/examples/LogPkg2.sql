REM LogPkg2.sql
REM Chapter 11, Oracle9i PL/SQL Programming by Scott Urman
REM This package is used to log connects and disconnects to the
REM database.  The package body is implemented as Java stored
REM procedures.

CREATE OR REPLACE PACKAGE LogPkg AS
  PROCEDURE LogConnect(p_UserID IN VARCHAR2);
  PROCEDURE LogDisconnect(p_UserID IN VARCHAR2);
END LogPkg;
/

CREATE OR REPLACE PACKAGE BODY LogPkg AS
  PROCEDURE LogConnect(p_UserID IN VARCHAR2) IS
    LANGUAGE JAVA
    NAME 'Logger.LogConnect(java.lang.String)';

  PROCEDURE LogDisconnect(p_UserID IN VARCHAR2) IS
    LANGUAGE JAVA
    NAME 'Logger.LogDisconnect(java.lang.String)';
END LogPkg;
/

