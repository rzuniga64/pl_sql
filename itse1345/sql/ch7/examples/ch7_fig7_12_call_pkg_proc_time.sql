SET TIMNG ON;
DECLARE
  lv_pcte_num NUMBER(3,2) := 0.05;
  lv_pctc_num NUMBER(3,2) := 0.10;
  lv_incr_num NUMBER(6,2);
BEGIN
  budget_pkg.project_sales_pp(lv_pcte_num, lv_pctc_num, lv_incr_num);
  DBMS_OUTPUT.PUT_LINE(lv_incr_num);
END;
/