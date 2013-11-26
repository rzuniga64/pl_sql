/*
	COURSE: ITSE 1345
	AUTHOR: Raul Zuniga
	ASSIGNMENT: Lab 4 part 6
	A simple driver to test the trigger TRT_COUNT_TRG
	Test the trigger by
	1. Inserting a row into the TREATMENT table
	2. Insert another row into the TREATMENT table
	3. Updating a row in the TREATMENT table
	4. Updating another row in the TREATMENT table
	5. Deleting a row from the TREATMENT table
	6. Deleting another row from the TREATMENT table
*/

-- Insert a row into the TREATMENT table
INSERT INTO treatment(pat_nbr, phys_id, trt_procedure, trt_date)
  VALUES(3249, 101, '60-00', SYSDATE);
COMMIT;

-- Insert another row into the TREATMENT table  
INSERT INTO treatment(pat_nbr, phys_id, trt_procedure, trt_date)
  VALUES(3249, 101, '60-00', SYSDATE-1);
COMMIT;

-- Update a row in the TREATMENT table
UPDATE treatment
  SET trt_procedure ='88-20'
  WHERE pat_nbr = 1379
  AND phys_id = 103
  AND trt_procedure = '27-45'
  AND trt_date = '25-MAR-99';
COMMIT;

-- Update another row in the TREATMENT table
UPDATE treatment
set trt_date ='11-OCT-2013'
WHERE pat_nbr = 3249
AND phys_id = 103
AND trt_procedure = '88-20'
AND trt_date = '22-JAN-99';

-- Delete a row into the TREATMENT table
DELETE FROM treatment
WHERE PAT_NBR = 5116
AND PHYS_ID = 104
AND TRT_PROCEDURE = '52-14'
AND TRT_DATE = '03-APR-99';
COMMIT;

-- Delete another row into the TREATMENT table 
DELETE FROM treatment
WHERE PAT_NBR = 5116
AND PHYS_ID = 104
AND TRT_PROCEDURE = '52-14'
AND TRT_DATE = '05-FEB-01';
COMMIT;


 