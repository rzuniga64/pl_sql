REM LogCreations.sql
REM Chapter 11, Oracle9i PL/SQL Programming by Scott Urman
REM This file contains a system trigger.

DROP TABLE ddl_creations;

CREATE TABLE ddl_creations (
  user_id       VARCHAR2(30),
  object_type   VARCHAR2(20),
  object_name   VARCHAR2(30),
  object_owner  VARCHAR2(30),
  creation_date DATE);

CREATE OR REPLACE TRIGGER LogCreations
  AFTER CREATE ON DATABASE
BEGIN
  INSERT INTO ddl_creations (user_id, object_type, object_name,
                             object_owner, creation_date)
    VALUES (USER, SYS.DICTIONARY_OBJ_TYPE, SYS.DICTIONARY_OBJ_NAME,
            SYS.DICTIONARY_OBJ_OWNER, SYSDATE);
END LogCreations;
/
