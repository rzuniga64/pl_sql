REM LogRSChanges.sql
REM Chapter 11, Oracle9i PL/SQL Programming by Scott Urman
REM This trigger uses predicates to log changes to the
REM registered_students table.

CREATE OR REPLACE TRIGGER LogRSChanges
  BEFORE INSERT OR DELETE OR UPDATE ON registered_students
  FOR EACH ROW
DECLARE
  v_ChangeType CHAR(1);
BEGIN
  /* Use 'I' for an INSERT, 'D' for DELETE, and 'U' for UPDATE. */
  IF INSERTING THEN
    v_ChangeType := 'I';
  ELSIF UPDATING THEN
    v_ChangeType := 'U';
  ELSE
    v_ChangeType := 'D';
  END IF;

  /* Record all the changes made to registered_students in
     RS_audit. Use SYSDATE to generate the timestamp, and
     USER to return the userid of the current user. */
  INSERT INTO RS_audit
    (change_type, changed_by, timestamp,
     old_student_id, old_department, old_course, old_grade,
     new_student_id, new_department, new_course, new_grade)
  VALUES
    (v_ChangeType, USER, SYSDATE,
     :old.student_id, :old.department, :old.course, :old.grade,
     :new.student_id, :new.department, :new.course, :new.grade);
END LogRSChanges;
/
