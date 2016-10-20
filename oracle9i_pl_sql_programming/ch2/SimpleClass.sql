REM SimpleClass.sql
REM Chapter 2, Oracle9i PL/SQL Programming by Scott Urman
REM This script will create a simple Java class.  It requires
REM Oracle8i or higher to run.

CREATE OR REPLACE AND RESOLVE JAVA SOURCE NAMED "SimpleClass" AS
  class SimpleClass
  {
    static public void Hello()
    {
      System.out.println("Hello from Simple!");
    }
  }
/

CREATE OR REPLACE PROCEDURE SimpleWrapper AS
  LANGUAGE Java
  NAME 'SimpleClass.Hello()';
/
