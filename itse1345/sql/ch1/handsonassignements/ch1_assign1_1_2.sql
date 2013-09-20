/*
	Show the basket ID, product ID, product name, and description 
	for all items ordered. (Do it two ways-one with an ANSI join 
	and one with a traditional join).

	  IDBASKET  IDPRODUCT PRODUCTNAME               DESCRIPTION                                                                                        
	---------- ---------- ------------------------- ----------------------------------------------------------------------------------------------------
			 3          6 Guatamala                 heavy body, spicy twist, aromatic and smokey flavor.                                                 
			 3          8 Brazil                    well-balanced mellow flavor, a medium body with hints of cocoa and a mild, nut-like aftertaste       
			 4          4 Coffee Grinder            Avoid blade grinders! This mill grinder allows you to choose a fine grind to a coarse grind.         
			 5          7 Columbia                  dry, nutty flavor and smoothness                                                                     
			 5          8 Brazil                    well-balanced mellow flavor, a medium body with hints of cocoa and a mild, nut-like aftertaste       
			 5          9 Ethiopia                  distinctive berry-like flavor and aroma, reminds many of a fruity, memorable wine.                   
			 5         10 Espresso                  dense, caramel-like sweetness with a soft acidity. Roasted somewhat darker than traditional Italian. 
			 6         10 Espresso                  dense, caramel-like sweetness with a soft acidity. Roasted somewhat darker than traditional Italian. 
			 6          2 Capresso Ultima           Coffee and Espresso and Cappuccino Machine. Brews from one espresso to two six ounce cups of coffee  
			 7          7 Columbia                  dry, nutty flavor and smoothness                                                                     
			 7          8 Brazil                    well-balanced mellow flavor, a medium body with hints of cocoa and a mild, nut-like aftertaste       
			 8          7 Columbia                  dry, nutty flavor and smoothness                                                                     
			 8          8 Brazil                    well-balanced mellow flavor, a medium body with hints of cocoa and a mild, nut-like aftertaste       
			 9          7 Columbia                  dry, nutty flavor and smoothness                                                                     
			 9          8 Brazil                    well-balanced mellow flavor, a medium body with hints of cocoa and a mild, nut-like aftertaste       
			10          6 Guatamala                 heavy body, spicy twist, aromatic and smokey flavor.                                                 
			10          8 Brazil                    well-balanced mellow flavor, a medium body with hints of cocoa and a mild, nut-like aftertaste       
			10          4 Coffee Grinder            Avoid blade grinders! This mill grinder allows you to choose a fine grind to a coarse grind.         
			11          9 Ethiopia                  distinctive berry-like flavor and aroma, reminds many of a fruity, memorable wine.                   
			12          8 Brazil                    well-balanced mellow flavor, a medium body with hints of cocoa and a mild, nut-like aftertaste       
			12          9 Ethiopia                  distinctive berry-like flavor and aroma, reminds many of a fruity, memorable wine.                   
			12          6 Guatamala                 heavy body, spicy twist, aromatic and smokey flavor.                                                 
			12          7 Columbia                  dry, nutty flavor and smoothness                                                                     
			13          9 Ethiopia                  distinctive berry-like flavor and aroma, reminds many of a fruity, memorable wine.                   
			15          8 Brazil                    well-balanced mellow flavor, a medium body with hints of cocoa and a mild, nut-like aftertaste       
			15          7 Columbia                  dry, nutty flavor and smoothness                                                                     
			16          8 Brazil                    well-balanced mellow flavor, a medium body with hints of cocoa and a mild, nut-like aftertaste       
			16          7 Columbia                  dry, nutty flavor and smoothness  
*/

-- TRADITIONAL JOIN

select b.idbasket, p.idproduct, productname, description
from bb_product p, bb_basketitem bi, bb_basket b
where p.idproduct = bi.idproduct
and bi.idbasket = b.idbasket;

-- ANSI JOIN

select idbasket, idproduct, productname, description
from bb_product p join bb_basketitem bi 
using (idproduct)
join bb_basket b 
using(idbasket);
