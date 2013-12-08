REM run the DEPTREE_FILL procedure to populate the DEPTREE_TEMPTAB table
REM with the dependency data for the BB_BASKETITEM table.  The DEPTREE_FILL
REM procedure has three parameters: object_type (type of object being analyzed),
REM object schema (name of schema in which the object exists), and object name
REM (name of object being analyzed).
EXECUTE deptree_fill('TABLE', 'SYSTEM', 'BB_BASKETITEM');