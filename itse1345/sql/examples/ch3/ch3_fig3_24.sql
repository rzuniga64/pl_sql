/*  FIGURE 3-24 Using an associative array
	An associative array is still commonly referred to as a 
	'PL/SQL table' or an 'index-by table'. It's a variable that
	can handle many rows of data but only one field. This structure
	is a set of key-value pairs in which each key uniquely identifies
	a value in the array. The index can be an integer or a string value.
*/
DECLARE
  --Associative array data type declaration
  TYPE type_roast IS TABLE OF NUMBER
  INDEX BY BINARY_INTEGER;
  
  --Associative array variable declaration
  tbl_roast type_roast; 
  
  lv_tot_num NUMBER := 0;
  lv_cnt_num NUMBER := 0;
  lv_avg_num NUMBER;
  lv_samp1_num NUMBER(5,2) := 6.22;
  lv_samp2_num NUMBER(5,2) := 6.13;
  lv_samp3_num NUMBER(5,2) := 6.27;
  lv_samp4_num NUMBER(5,2) := 6.16;
  lv_samp5_num NUMBER(5,2);
BEGIN
  --Put initialized variable values in the table variable.
  tbl_roast(1) := lv_samp1_num;
  tbl_roast(2) := lv_samp2_num;
  tbl_roast(3) := lv_samp3_num;
  tbl_roast(4) := lv_samp4_num;
  tbl_roast(5) := lv_samp5_num;
  
  /* A FOR loop adds all the sample measurements that
     have been entered in teh table variable */
  FOR i IN 1..tbl_roast.COUNT LOOP
    IF tbl_roast(i) IS NOT NULL THEN 
      lv_tot_num := lv_tot_num + tbl_roast(i);
      lv_cnt_num := lv_cnt_num + 1;
    END IF;
  END LOOP;
  
  --lv_avg_num calculates the average measurement
  lv_avg_num := lv_tot_num / lv_cnt_num;
  dbms_output.put_line(lv_tot_num);
  dbms_output.put_line(lv_cnt_num);
  dbms_output.put_line(tbl_roast.COUNT);
  dbms_output.put_line(lv_avg_num);  
END;