REM UTL_FILE.sql
REM Chapter 12, Oracle9i PL/SQL Programming by Scott Urman
REM This block demonstrates the use of the UTL_FILE package. 

DECLARE
  v_FileHandle UTL_FILE.FILE_TYPE;
BEGIN
  -- Open the file /tmp/utl_file.txt for writing.  If the
  -- file does not exist, this will create it.  If the file
  -- does exist, this will overwrite it.
  v_FileHandle := UTL_FILE.FOPEN('/tmp/', 'utl_file.txt', 'w');
  
  -- Write some lines to the file.
  UTL_FILE.PUT_LINE(v_FileHandle, 'This is line 1!');
  FOR v_Counter IN 2..11 LOOP
    UTL_FILE.PUTF(v_FileHandle, 'This is line %s!\n', v_Counter);
  END LOOP;
  
  -- And close the file.
  UTL_FILE.FCLOSE(v_FileHandle);
END;
/

