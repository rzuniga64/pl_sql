REM samename.sql
REM Chapter 11, Oracle9i PL/SQL Programming by Scott Urman
REM This script demonstrates triggers, procedures, and tables with
REM the same name.

-- Legal, since triggers and tables are in different namespaces.
CREATE OR REPLACE TRIGGER major_stats
  BEFORE INSERT ON major_stats
BEGIN
  INSERT INTO temp_table (char_col)
    VALUES ('Trigger fired!');
END major_stats;
/

-- Illegal, since procedures and tables are in the same namespace.
CREATE OR REPLACE PROCEDURE major_stats AS
BEGIN
  INSERT INTO temp_table (char_col)
    VALUES ('Procedure called!');
END major_stats;
/

