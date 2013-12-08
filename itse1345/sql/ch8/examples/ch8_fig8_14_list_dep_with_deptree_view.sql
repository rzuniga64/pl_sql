REM using the seq# in the ORDER BY clause ensures that
REM dependencies are listed in a logical order so that you
REM can identify the path of direct and indirect dependencies
REM
REM A 0 represents the object being analyzed, a 1 represents a 
REM direct dependency on the object and a 2 represents an indirect
REM dependency on the object

SELECT nested_level, name, type, seq#
FROM deptree
ORDER BY seq#