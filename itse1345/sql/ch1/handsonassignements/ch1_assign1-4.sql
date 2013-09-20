/*  Enter the query shown in Figure 1-24 and check your datat for 
  	idProduct 6 against the listing shown.  The full results shold 
	contain 24 rows of output.
	
	IDPRODUCT PRODUCTNAME               CATEGORYNAME              OPTIONNAME              
	---------- ------------------------- ------------------------- -------------------------
			 5 Sumatra                   Size                      1/2 LB.                   
			 5 Sumatra                   Size                      1 LB.                     
			 5 Sumatra                   Form                      Whole Bean                
			 5 Sumatra                   Form                      Regular Grind             
			 6 Guatamala                 Size                      1/2 LB.                   
			 6 Guatamala                 Size                      1 LB.                     
			 6 Guatamala                 Form                      Whole Bean                
			 6 Guatamala                 Form                      Regular Grind             
			 7 Columbia                  Size                      1/2 LB.                   
			 7 Columbia                  Size                      1 LB.                     
			 7 Columbia                  Form                      Whole Bean                
			 7 Columbia                  Form                      Regular Grind             
			 8 Brazil                    Size                      1/2 LB.                   
			 8 Brazil                    Size                      1 LB.                     
			 8 Brazil                    Form                      Whole Bean                
			 8 Brazil                    Form                      Regular Grind             
			 9 Ethiopia                  Size                      1/2 LB.                   
			 9 Ethiopia                  Size                      1 LB.                     
			 9 Ethiopia                  Form                      Whole Bean                
			 9 Ethiopia                  Form                      Regular Grind             
			10 Espresso                  Size                      1/2 LB.                   
			10 Espresso                  Size                      1 LB.                     
			10 Espresso                  Form                      Whole Bean                
			10 Espresso                  Form                      Regular Grind 
*/

select idproduct, p.productname, pc.categoryname, pd.optionname
	from bb_product p join bb_productoption using(idproduct)
	join bb_productoptiondetail pd using(idoption)
	join bb_productoptioncategory pc using(idoptioncategory);