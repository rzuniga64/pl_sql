--FIGURE 3-26 Using a table of records variable
  
/* 
  As a shopper is perusing the Brewbean site and selecting items to 
  purchase, the Brewbean's application needs a variable to hold 
  information on all items selected so far in the basket until the 
  shopper indicates saving the basket for completion later or 
  finishing the purchase (at which time data is inserted into the database.
  
  You need a variable that holds data similar to a row of the BB_BASKETITEM
  table.  In addition the shopper might select more than one item, so the
  variable must be able to handle more than on row of data.
*/
DECLARE
  --Table of records data type declaration
  TYPE type_basketitems IS TABLE OF bb_basketitem%ROWTYPE
  INDEX BY BINARY_INTEGER;
  --Table of records variable declaration
  tbl_items type_basketitems;
  --Adding application data to the table of records variable
  lv_ind_num NUMBER(3) :=1;
  lv_id_num bb_basketitem.idproduct%TYPE := 7;
  lv_price_num bb_basketitem.price%TYPE := 10.80;
  lv_qty_num bb_basketitem.quantity%TYPE := 2;
  lv_opt1_num bb_basketitem.option1%TYPE := 2;
  lv_opt2_num bb_basketitem.option2%TYPE := 3;
BEGIN
  tbl_items(lv_ind_num).idproduct := lv_id_num;
  tbl_items(lv_ind_num).price := lv_price_num;
  tbl_items(lv_ind_num).quantity := lv_qty_num;  
  tbl_items(lv_ind_num).option1 := lv_opt1_num;
  tbl_items(lv_ind_num).option2 := lv_opt2_num;
  --Display values to determine whether code is processing correctly
  DBMS_OUTPUT.PUT_LINE(lv_ind_num); 
  DBMS_OUTPUT.PUT_LINE(tbl_items(lv_ind_num).idproduct);
  DBMS_OUTPUT.PUT_LINE(tbl_items(lv_ind_num).price);
  DBMS_OUTPUT.PUT_LINE(tbl_items(lv_ind_num).quantity);
  DBMS_OUTPUT.PUT_LINE(tbl_items(lv_ind_num).option1);
  DBMS_OUTPUT.PUT_LINE(tbl_items(lv_ind_num).option2);  
END;