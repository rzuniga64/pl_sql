REM DefaultPragma.sql
REM Chapter 10, Oracle9i PL/SQL Programming by Scott Urman
REM This package uses the DEFAULT keyword in the RESTRICT_REFERENCES
REM pragma.

CREATE OR REPLACE PACKAGE DefaultPragma AS
  FUNCTION F1 RETURN NUMBER;
  PRAGMA RESTRICT_REFERENCES(F1, RNDS, RNPS);

  PRAGMA RESTRICT_REFERENCES(DEFAULT, WNDS, WNPS, RNDS, RNPS);
  FUNCTION F2 RETURN NUMBER;

  FUNCTION F3 RETURN NUMBER;
END DefaultPragma;
/

CREATE OR REPLACE PACKAGE BODY DefaultPragma AS
  FUNCTION F1 RETURN NUMBER IS
  BEGIN
    INSERT INTO temp_table (num_col, char_col)
      VALUES (1, 'F1!');
    RETURN 1;
  END F1;

  FUNCTION F2 RETURN NUMBER IS
  BEGIN
    RETURN 2;
  END F2;

  -- This function violates the default pragma.
  FUNCTION f3 RETURN NUMBER IS
  BEGIN
    INSERT INTO temp_table (num_col, char_col)
      VALUES (1, 'F3!');
    RETURN 3;
  END F3;
END DefaultPragma;
/

show errors
