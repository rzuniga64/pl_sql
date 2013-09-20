/*
	Modify the queries in Step 2 to include the customer's last name.
  
	IDBASKET LASTNAME              IDPRODUCT PRODUCTNAME               DESCRIPTION                                                                                        
	---------- -------------------- ---------- ------------------------- ----------------------------------------------------------------------------------------------------
			 3 Carter                        8 Brazil                    well-balanced mellow flavor, a medium body with hints of cocoa and a mild, nut-like aftertaste       
			 4 Carter                        4 Coffee Grinder            Avoid blade grinders! This mill grinder allows you to choose a fine grind to a coarse grind.         
			 3 Carter                        6 Guatamala                 heavy body, spicy twist, aromatic and smokey flavor.                                                 
			13 Cast                          9 Ethiopia                  distinctive berry-like flavor and aroma, reminds many of a fruity, memorable wine.                   
			16 Parker                        8 Brazil                    well-balanced mellow flavor, a medium body with hints of cocoa and a mild, nut-like aftertaste       
			15 Parker                        8 Brazil                    well-balanced mellow flavor, a medium body with hints of cocoa and a mild, nut-like aftertaste       
			16 Parker                        7 Columbia                  dry, nutty flavor and smoothness                                                                     
			15 Parker                        7 Columbia                  dry, nutty flavor and smoothness                                                                     
			 7 Ratman                        7 Columbia                  dry, nutty flavor and smoothness                                                                     
			 8 Ratman                        7 Columbia                  dry, nutty flavor and smoothness                                                                     
			 9 Ratman                        7 Columbia                  dry, nutty flavor and smoothness                                                                     
			 8 Ratman                        8 Brazil                    well-balanced mellow flavor, a medium body with hints of cocoa and a mild, nut-like aftertaste       
			 9 Ratman                        8 Brazil                    well-balanced mellow flavor, a medium body with hints of cocoa and a mild, nut-like aftertaste       
			 7 Ratman                        8 Brazil                    well-balanced mellow flavor, a medium body with hints of cocoa and a mild, nut-like aftertaste       
			12 Savid                         7 Columbia                  dry, nutty flavor and smoothness                                                                     
			12 Savid                         8 Brazil                    well-balanced mellow flavor, a medium body with hints of cocoa and a mild, nut-like aftertaste       
			12 Savid                         6 Guatamala                 heavy body, spicy twist, aromatic and smokey flavor.                                                 
			12 Savid                         9 Ethiopia                  distinctive berry-like flavor and aroma, reminds many of a fruity, memorable wine.                   
			 5 Somner                        8 Brazil                    well-balanced mellow flavor, a medium body with hints of cocoa and a mild, nut-like aftertaste       
			 5 Somner                        7 Columbia                  dry, nutty flavor and smoothness                                                                     
			 6 Somner                        2 Capresso Ultima           Coffee and Espresso and Cappuccino Machine. Brews from one espresso to two six ounce cups of coffee  
			 6 Somner                       10 Espresso                  dense, caramel-like sweetness with a soft acidity. Roasted somewhat darker than traditional Italian. 
			 5 Somner                       10 Espresso                  dense, caramel-like sweetness with a soft acidity. Roasted somewhat darker than traditional Italian. 
			 5 Somner                        9 Ethiopia                  distinctive berry-like flavor and aroma, reminds many of a fruity, memorable wine.                   
			11 Sonnie                        9 Ethiopia                  distinctive berry-like flavor and aroma, reminds many of a fruity, memorable wine.                   
			10 Sonnie                        4 Coffee Grinder            Avoid blade grinders! This mill grinder allows you to choose a fine grind to a coarse grind.         
			10 Sonnie                        6 Guatamala                 heavy body, spicy twist, aromatic and smokey flavor.                                                 
			10 Sonnie                        8 Brazil                    well-balanced mellow flavor, a medium body with hints of cocoa and a mild, nut-like aftertaste 
*/

-- TRADITIONAL JOIN
   
select b.idbasket, s.lastname, p.idproduct, productname, description
from bb_product p, bb_basketitem bi, bb_basket b, bb_shopper s
where p.idproduct = bi.idproduct
and bi.idbasket = b.idbasket
and b.idshopper = s.idshopper
order by s.lastname; 

-- ANSI JOIN

select idbasket,lastname, idproduct, productname, description
from bb_product join bb_basketitem using (idproduct)
join bb_basket using(idbasket)
join bb_shopper using(idshopper)
order by lastname; 