REM DBMS_LOB.sql
REM Chapter 12, Oracle9i PL/SQL Programming by Scott Urman
REM This script illustrates the DBMS_LOB package.


/* Reverses the characters in the CLOB pointed to by p_InputLocator,
 * p_ChunkSize bytes at a time.  The result is returned in
 * p_OutputLocator.  For example, a call like
 *
 * ReverseLOB('abcdefghijklmnopqrstuvwxyz', output, 4)
 *
 * will set output to 'yzuvwxqrstmnopijklefghabcd'.  If p_ChunkSize
 * does not evenly divide the length of the input, the last chunk of
 * the input LOB, which will become the first chunk of the output
 * LOB, will be smaller than p_ChunkSize.  If p_ChunkSize is larger
 * than the length of the input LOB, then the output LOB will be
 * identical to the input LOB.
 */
CREATE OR REPLACE PROCEDURE ReverseLOB(
  p_InputLocator IN CLOB,
  p_OutputLocator IN OUT CLOB,
  p_ChunkSize IN NUMBER) AS

  v_InputOffset      BINARY_INTEGER;
  v_OutputOffset     BINARY_INTEGER;
  v_LOBLength        BINARY_INTEGER;
  v_CurrentChunkSize BINARY_INTEGER;
  e_TrimLength       EXCEPTION;
  PRAGMA EXCEPTION_INIT(e_TrimLength, -22926);
  
BEGIN
  -- First determine the input LOB length.
  v_LOBLength := DBMS_LOB.GETLENGTH(p_InputLocator);
  
  -- Trim the output LOB to the input length.  Trap and ignore the
  -- ORA-22926 error if the output LOB is less than v_LOBLength
  -- already.
  BEGIN
    DBMS_LOB.TRIM(p_OutputLocator, v_LOBLength);
  EXCEPTION
    WHEN e_TrimLength THEN
      NULL;
  END;

  -- Set up the initial offsets.  The input offset starts at the
  -- beginning, the output offset at the end.
  v_InputOffset := 1;
  v_OutputOffset := v_LOBLength + 1;
  
  -- Loop through the input LOB, and write each chunk to the output
  -- LOB.
  LOOP
    -- Exit the loop when we've done all the chunks, indicated by
    -- v_InputOffset passing v_LOBLength.
    EXIT WHEN v_InputOffset > v_LOBLength;
    
    -- If at least p_ChunkSize remains in the input LOB, copy that
    -- much.  Otherwise, copy only however much remains.
    IF (v_LOBLength - v_InputOffset + 1) > p_ChunkSize THEN
      v_CurrentChunkSize := p_ChunkSize;
    ELSE
      v_CurrentChunkSize := v_LOBLength - v_InputOffset + 1;
    END IF;
    
    -- Decrement the output offset by the current chunk size.
    v_OutputOffset := v_OutputOffset - v_CurrentChunkSize;

    -- Copy the current chunk.
    DBMS_LOB.COPY(p_OutputLocator,
                  p_InputLocator,
                  v_CurrentChunkSize,
                  v_OutputOffset,
                  v_InputOffset);
    
    -- Increment the input offset by the current chunk size.
    v_InputOffset := v_InputOffset + v_CurrentChunkSize;
  END LOOP;
END ReverseLOB;
/

DROP TABLE lobdemo;

CREATE TABLE lobdemo (
  key NUMBER,
  clob_col CLOB,
  blob_col BLOB);

INSERT INTO lobdemo (key, clob_col)
  VALUES (1, 'abcdefghijklmnopqrstuvwxyz');
INSERT INTO lobdemo (key, clob_col)
  VALUES (2, EMPTY_CLOB());
INSERT INTO lobdemo (key, clob_col)
  VALUES (3, EMPTY_CLOB());
INSERT INTO lobdemo (key, clob_col)
  VALUES (4, EMPTY_CLOB());
INSERT INTO lobdemo (key, clob_col)
  VALUES (5, EMPTY_CLOB());
INSERT INTO lobdemo (key, clob_col)
  VALUES (6, EMPTY_CLOB());
COMMIT;

SELECT key, clob_col
  FROM lobdemo
  WHERE key BETWEEN 1 AND 6
  ORDER BY key;

DECLARE
  v_Source CLOB;
  v_Destination CLOB;
  v_Key NUMBER;
  CURSOR c_Destinations IS
    SELECT key, clob_col
    FROM lobdemo
    WHERE key BETWEEN 2 and 6
    FOR UPDATE;
BEGIN
  SELECT clob_col
    INTO v_Source
    FROM lobdemo
    WHERE key = 1;

  -- Loop through rows 2-6, and reverse row 1 into them, in
  -- varying ways.
  OPEN c_Destinations;
  LOOP
    FETCH c_Destinations INTO v_Key, v_Destination;
    EXIT WHEN c_Destinations%NOTFOUND;

    IF (v_Key = 2) THEN
      ReverseLOB(v_Source, v_Destination, 4);
    ELSIF (v_Key = 3) THEN
      ReverseLOB(v_Source, v_Destination, 2);
    ELSIF (v_Key = 4) THEN
      ReverseLOB(v_Source, v_Destination, 1);
    ELSIF (v_Key = 5) THEN
      ReverseLOB(v_Source, v_Destination, 10);
    ELSIF (v_Key = 6) THEN
      ReverseLOB(v_Source, v_Destination, 30);
    END IF;
  END LOOP;
  CLOSE c_Destinations;
  COMMIT;
END;
/

SELECT key, clob_col
  FROM lobdemo
  WHERE key BETWEEN 1 AND 6
  ORDER BY key;
