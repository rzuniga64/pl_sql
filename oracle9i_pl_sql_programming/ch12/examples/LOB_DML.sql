REM LOB_DML.sql
REM Chapter 12, Oracle9i PL/SQL Programming by Scott Urman
REM This script illustrates some LOB manipulations using DML
REM statements.

set serveroutput on

DROP TABLE lobdemo;

CREATE TABLE lobdemo (
  key NUMBER PRIMARY KEY,
  clob_col  CLOB,
  blob_col  BLOB,
  bfile_col BFILE
);

DELETE FROM lobdemo
  WHERE key IN (50, 51, 60, 61);

-- The following two INSERTs will add twp rows to the table.
INSERT INTO lobdemo (key, clob_col, blob_col, bfile_col)
  VALUES (50, 'This is a character literal',
               HEXTORAW('FEFEFEFEFEFEFEFEFEFE'),
               NULL);

INSERT INTO lobdemo (key, clob_col, blob_col, bfile_col)
  VALUES (51, 'This is another character literal',
               HEXTORAW('ABABABABABABABABABAB'),
               NULL);

-- We can also do INSERTs with the results of a query.  The
-- following will copy rows 50 and 51 to 60 and 61.
INSERT INTO lobdemo
  SELECT key + 10, clob_col, blob_col, NULL
    FROM lobdemo
    WHERE key IN (50, 51);

-- This statement will update blob_col to a new value.
UPDATE lobdemo
  SET blob_col = HEXTORAW('CDCDCDCDCDCDCDCDCDCDCDCD')
  WHERE key IN (60, 61);

-- And finally, we can delete row 61.
DELETE FROM lobdemo
  WHERE key = 61;

COMMIT;


