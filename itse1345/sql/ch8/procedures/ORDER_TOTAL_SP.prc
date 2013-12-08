CREATE OR REPLACE PROCEDURE order_total_sp (p_bsktid   IN     NUMBER,
                                            p_cnt         OUT NUMBER,
                                            p_sub         OUT NUMBER,
                                            p_ship        OUT NUMBER,
                                            p_total       OUT NUMBER)
IS
BEGIN
   SELECT SUM (quantity), SUM (quantity * price)
     INTO p_cnt, p_sub
     FROM bb_basketitem_vu
    WHERE idbasket = p_bsktid;

   ship_cost_sp@dblink1(p_cnt, p_ship);
   p_total := NVL (p_sub, 0) + NVL (p_ship, 0);
END;
/