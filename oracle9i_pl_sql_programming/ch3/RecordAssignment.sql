REM RecordAssignment.sql
REM Chapter 3, Oracle9i PL/SQL Programming by Scott Urman
REM This block shows legal and illegal record assignments.

DECLARE
  TYPE t_Rec1Type IS RECORD (
    Field1 NUMBER,
    Field2 VARCHAR2(5));
  TYPE t_Rec2Type IS RECORD (
    Field1 NUMBER,
    Field2 VARCHAR2(5));
  v_Rec1 t_Rec1Type;
  v_Rec2 t_Rec2Type;
BEGIN
  /* Even though v_Rec1 and v_Rec2 have the same field names
     and field types, the record types themselves are different.
     This is an illegal assignment which raises PLS-382. */
  v_Rec1 := v_Rec2;

  /* However, the fields are the same type, so the following
     are legal assignments. */
  v_Rec1.Field1 := v_Rec2.Field1;
  v_Rec2.Field2 := v_Rec2.Field2;
END;
/
