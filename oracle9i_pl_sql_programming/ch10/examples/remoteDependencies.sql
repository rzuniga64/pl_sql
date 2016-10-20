REM remoteDependencies.sql
REM Chapter 10, Oracle9i PL/SQL Programming by Scott Urman
REM This script illustrates the dependencies between objects in
REM different databases.

set serveroutput on

-- Create two procedures.  P1 depends on P2.
CREATE OR REPLACE PROCEDURE P2 AS
BEGIN
  DBMS_OUTPUT.PUT_LINE('Inside P2!');
END P2;
/

CREATE OR REPLACE PROCEDURE P1 AS
BEGIN
  DBMS_OUTPUT.PUT_LINE('Inside P1!');
  P2;
END P1;
/

-- Verify that both procedures are valid.
SELECT object_name, object_type, status
  FROM user_objects
  WHERE object_name IN ('P1', 'P2');

-- Recompile P2, which invalidates P1 immediately.
ALTER PROCEDURE P2 COMPILE;

-- Query again to see this.
SELECT object_name, object_type, status
  FROM user_objects
  WHERE object_name IN ('P1', 'P2');

-- Create a database link which points back to the current
-- instance.  You will have to modify connect_string and set
-- up SQL*Net appropriately for your system.
CREATE DATABASE LINK loopback
  USING 'connect_string';

-- Change P1 to call P2 over the link.
CREATE OR REPLACE PROCEDURE P1 AS
BEGIN
  DBMS_OUTPUT.PUT_LINE('Inside P1!');
  P2@loopback;
END P1;
/

-- Verify that both are valid.
SELECT object_name, object_type, status
  FROM user_objects
  WHERE object_name IN ('P1', 'P2');

-- Now when we recompile P2, P1 is not invalidated immediately.
ALTER PROCEDURE P2 COMPILE;
SELECT object_name, object_type, status
  FROM user_objects
  WHERE object_name IN ('P1', 'P2');
