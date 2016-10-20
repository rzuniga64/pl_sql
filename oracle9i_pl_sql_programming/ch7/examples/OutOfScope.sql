REM OutOfScope.sql
REM Chapter 7, Oracle9i PL/SQL Programming by Scott Urman
REM This example illustrates the scope of exceptions.

BEGIN
  DECLARE
    e_UserDefinedException EXCEPTION;
  BEGIN
    RAISE e_UserDefinedException;
  END;
EXCEPTION
  /* e_UserDefinedException is out of scope here - can only be
     handled by an OTHERS handler */
  WHEN OTHERS THEN
    /* Just re-raise the exception, which will be propagated to the
       calling environment */
    RAISE;
END;
/

CREATE OR REPLACE PACKAGE Globals AS
/* This package contains global declarations. Objects declared here will 
   be visible via qualified references for any other blocks or procedures.
   Note that this package does not have a package body. */

  /* A user-defined exception. */
  e_UserDefinedException EXCEPTION;
END Globals;
/

BEGIN
  BEGIN
    RAISE Globals.e_UserDefinedException;
  END;
EXCEPTION
  /* Since e_UserDefinedException is still visible, we can handle it 
     explicitly */
  WHEN Globals.e_UserDefinedException THEN
    /* Just re-raise the exception, which will be propagated to the
       calling environment */
    RAISE;
END;
/
