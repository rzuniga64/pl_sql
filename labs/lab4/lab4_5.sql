/*
	COURSE: ITSE 1345
	AUTHOR: Raul Zuniga
	ASSIGNMENT: Lab 4 part 5
	A simple driver to test the trigger TREATMENT_DATE_TRG
	Test the trigger by
	1. Update a row with date later than today
	2. Insert a row with date later than today
	3. Update row with date earlier than 3 months ago
	4. Insert row with date earler than 3 months ago
	5. Update a row with a valid date
	6. Insert a row with a valide date 
*/
	
	-- try update with date later than today
UPDATE treatment
set trt_date='21-DEC-2013'
WHERE pat_nbr = 1379;

-- try insert with date later than today
INSERT INTO treatment(pat_nbr, phys_id, trt_procedure, trt_date)
  VALUES(3249, 101, '13-08', '21-DEC-2013');

-- try update with date earlier than 3 months ago
UPDATE treatment
set trt_date='21-JUL-2013'
WHERE pat_nbr = 1379;

-- try insert with date earlier than 3 months ago
INSERT INTO treatment(pat_nbr, phys_id, trt_procedure, trt_date)
  VALUES(3249, 101, '13-08', '21-JUL-2013');
  
-- Update a row with a valid date
UPDATE treatment
set trt_date ='11-OCT-2013'
WHERE pat_nbr = 3249
AND phys_id = 101
AND trt_procedure = '13-08'
AND trt_date = '12-FEB-99';

-- Insert a row with a valid date
INSERT INTO TREATMENT
  VALUES(3249, 101, '13-08', '12-OCT-2013');