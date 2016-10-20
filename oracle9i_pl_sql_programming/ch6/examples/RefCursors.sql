REM RefCursors.sql
REM Chapter 6, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates several REF CURSOR declarations.

DECLARE
  -- Definition using %ROWTYPE.
  TYPE t_StudentsRef IS REF CURSOR
    RETURN students%ROWTYPE;

  -- Define a new record type,
  TYPE t_NameRecord IS RECORD (
    first_name  students.first_name%TYPE,
    last_name   students.last_name%TYPE);

  -- a variable of this type,
  v_NameRecord  t_NameRecord;

  -- And a cursor variable using the record type.
  TYPE t_NamesRef IS REF CURSOR
    RETURN t_NameRecord;

  -- We can declare another type, using %TYPE for the previously
  -- defined record.
  TYPE t_NamesRef2 IS REF CURSOR
    RETURN v_NameRecord%TYPE;

  -- Declare cursor variables using the above types.
  v_StudentCV t_StudentsRef;
  v_NameCV    t_NamesRef;
  
  -- Define an unconstrained reference type,
  TYPE t_FlexibleRef IS REF CURSOR;
  
  -- and a variable of that type.
  v_CursorVar t_FlexibleRef;

BEGIN
  NULL;
END;
/
