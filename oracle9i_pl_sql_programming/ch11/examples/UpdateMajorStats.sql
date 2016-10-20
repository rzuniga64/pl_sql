REM UpdateMajorStats.sql
REM Chapter 11, Oracle9i PL/SQL Programming by Scott Urman
REM This is an example of a DML trigger.

CREATE OR REPLACE TRIGGER UpdateMajorStats
  /* Keeps the major_stats table up-to-date with changes made
     to the students table. */
  AFTER INSERT OR DELETE OR UPDATE ON students
DECLARE
  CURSOR c_Statistics IS
    SELECT major, COUNT(*) total_students,
           SUM(current_credits) total_credits
      FROM students
      GROUP BY major;
BEGIN
  /* First delete from major_stats.  This will clear the
     statistics, and is necessary to account for the deletion
     of all students in a given major. */
  DELETE FROM major_stats;

  /* Now loop through each major, and insert the appropriate row into
     major_stats. */
  FOR v_StatsRecord in c_Statistics LOOP
    INSERT INTO major_stats (major, total_credits, total_students)
      VALUES (v_StatsRecord.major, v_StatsRecord.total_credits,
              v_StatsRecord.total_students);
  END LOOP;
END UpdateMajorStats;
/
