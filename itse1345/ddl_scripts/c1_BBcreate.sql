DROP TABLE BB_AUDIT_LOGON CASCADE CONSTRAINTS;
DROP TABLE BB_BASKETITEM CASCADE CONSTRAINTS;
DROP TABLE BB_BASKETSTATUS CASCADE CONSTRAINTS;
DROP TABLE BB_BASKET CASCADE CONSTRAINTS;
DROP TABLE BB_BLOCKTEST CASCADE CONSTRAINTS;
DROP TABLE BB_PROD_SALES CASCADE CONSTRAINTS;;
DROP TABLE BB_PRODUCT_REQUEST CASCADE CONSTRAINTS;
DROP TABLE BB_PRODUCTOPTION CASCADE CONSTRAINTS;
DROP TABLE BB_PRODUCTOPTIONDETAIL CASCADE CONSTRAINTS;
DROP TABLE BB_PRODUCTOPTIONCATEGORY CASCADE CONSTRAINTS;
DROP TABLE BB_PRODUCT CASCADE CONSTRAINTS;
DROP TABLE BB_DEPARTMENT CASCADE CONSTRAINTS;
DROP TABLE BB_PROMO CASCADE CONSTRAINTS;
DROP TABLE BB_PROMOLIST CASCADE CONSTRAINTS;
DROP TABLE BB_SHIPPING CASCADE CONSTRAINTS;
DROP TABLE BB_SHOP_SALES CASCADE CONSTRAINTS;
DROP TABLE BB_SHOPPER CASCADE CONSTRAINTS;
DROP TABLE BB_TAX CASCADE CONSTRAINTS;
DROP TABLE BB_TEST1 CASCADE CONSTRAINTS;
DROP TABLE BB_TEST2 CASCADE CONSTRAINTS;
DROP VIEW BB_BASKETITEM_VU;
DROP VIEW BB_SHIP_VU;
DROP SEQUENCE BB_IDBASKETITEM_SEQ;
DROP SEQUENCE BB_IDBASKET_SEQ;
DROP SEQUENCE BB_POPTION_SEQ;
DROP SEQUENCE BB_PRODID_SEQ;
DROP SEQUENCE BB_PRODREQ_SEQ;
DROP SEQUENCE BB_SHOPPER_SEQ;
DROP SEQUENCE BB_STATUS_SEQ;

CREATE TABLE BB_Department (
	idDepartment number(2)  ,
	DeptName varchar2(25) ,
	DeptDesc varchar2(100) ,
	DeptImage varchar2(25) ,
	CONSTRAINT dept_id_pk PRIMARY KEY(idDepartment) );
insert into bb_department 
   values(1,'Coffee','Many types of coffee beans','coffee.gif');
insert into bb_department 
   values(2,'Equipment and Supplies','Coffee makers to coffee filters available','machines.gif');
insert into bb_department 
   values(3,'Coffee Club','Benefits of our club membership?','club.gif');
CREATE TABLE BB_Product (
	idProduct number(2) ,
	ProductName varchar2(25) ,
	Description varchar2(100) ,
	ProductImage varchar2(25),
	Price number(6,2),
	SaleStart date,
	SaleEnd date,
	SalePrice number(6,2),
	Active number(1),
	Featured number(1),
	FeatureStart date,
	FeatureEnd date,
        Type char(1),
        idDepartment number(2),
	 CONSTRAINT prod_id_pk PRIMARY KEY(idProduct),
         CONSTRAINT prod_idDept_fk FOREIGN KEY (idDepartment)
           REFERENCES BB_Department (idDepartment) );
insert into bb_product(idProduct, type, ProductName, Description, ProductImage, Price, Active, idDepartment) 
  values(1,'E','CapressoBar Model #351', 'A fully programmable pump espresso machine and 10-cup coffee maker complete with GoldTone filter', 'capresso.gif', 99.99, 1, 2);

insert into bb_product(idProduct, type, ProductName, Description, ProductImage, Price, Active, idDepartment) 
  values(2,'E','Capresso Ultima', 'Coffee and Espresso and Cappuccino Machine. Brews from one espresso to two six ounce cups of coffee', 'capresso2.gif', 129.99, 1, 2);

insert into bb_product(idProduct, Type, ProductName, Description, ProductImage, Price, Active, idDepartment) 
  values(3,'E','Eileen 4-cup French Press', 'A unique coffeemaker from those proud craftsmen in windy Normandy.', 'frepress.gif', 32.50, 1, 2);

insert into bb_product(idProduct, Type, ProductName, Description, ProductImage, Price, Active, idDepartment) 
  values(4,'E','Coffee Grinder', 'Avoid blade grinders! This mill grinder allows you to choose a fine grind to a coarse grind.', 'grind.gif', 28.50, 1, 2);

insert into bb_product(idProduct, Type, ProductName, Description, ProductImage, Price, Active, idDepartment) 
  values(5,'C','Sumatra', 'Spicy and intense with herbal aroma. ', 'sumatra.jpg', 10.50, 1, 1);

insert into bb_product(idProduct, Type, ProductName, Description, ProductImage, Price, Active, idDepartment) 
  values(6,'C','Guatamala', 'heavy body, spicy twist, aromatic and smokey flavor.', 'Guatamala.jpg', 10.00, 1, 1);

insert into bb_product(idProduct, Type, ProductName, Description, ProductImage, Price, Active, idDepartment) 
  values(7,'C','Columbia', 'dry, nutty flavor and smoothness', 'columbia.jpg', 10.80, 1, 1);

insert into bb_product(idProduct, Type, ProductName, Description, ProductImage, Price, Active, idDepartment) 
  values(8,'C','Brazil', 'well-balanced mellow flavor, a medium body with hints of cocoa and a mild, nut-like aftertaste', 'brazil.jpg', 10.80, 1, 1);

insert into bb_product(idProduct, Type, ProductName, Description, ProductImage, Price, Active, idDepartment) 
  values(9,'C','Ethiopia', 'distinctive berry-like flavor and aroma, reminds many of a fruity, memorable wine. ', 'ethiopia.jpg', 10.00, 1, 1);

insert into bb_product(idProduct, Type, ProductName, Description, ProductImage, Price, Active, idDepartment) 
  values(10,'C','Espresso', 'dense, caramel-like sweetness with a soft acidity. Roasted somewhat darker than traditional Italian.', 'espresso.jpg', 10.00, 1, 1);
CREATE SEQUENCE bb_prodid_seq start with 15;
Alter table bb_product
 ADD (stock number(5,1),
      ordered number(3),
      reorder number(3) );
UPDATE bb_product 
  SET stock = 23, ordered = 0, reorder = 12
  WHERE idproduct = 1;
UPDATE bb_product 
  SET stock = 15, ordered = 0, reorder = 9
  WHERE idproduct = 2  ;
UPDATE bb_product 
  SET stock = 30, ordered = 0, reorder = 15
  WHERE idproduct =  3 ;
UPDATE bb_product 
  SET stock = 26, ordered = 0, reorder = 25
  WHERE idproduct =  4 ;
UPDATE bb_product 
  SET stock = 41, ordered = 0, reorder = 45
  WHERE idproduct =  5 ;
UPDATE bb_product 
  SET stock = 42, ordered = 0, reorder = 35
  WHERE idproduct =  6 ;
UPDATE bb_product 
  SET stock = 61, ordered = 0, reorder = 35
  WHERE idproduct =  7 ;
UPDATE bb_product 
  SET stock = 53, ordered = 0, reorder = 35
  WHERE idproduct =  8 ;
UPDATE bb_product 
  SET stock = 54 , ordered = 0, reorder = 35
  WHERE idproduct =  9 ;
UPDATE bb_product 
  SET stock = 50, ordered = 50, reorder = 50
  WHERE idproduct =  10 ;
UPDATE bb_product
  set salestart = '01-JUN-2012', saleend = '15-JUN-2012', SalePrice = 8.00
  WHERE idProduct = 6;
CREATE TABLE bb_Product_request 
  (idRequest NUMBER(4),
   idproduct number(2),
   dtrequest DATE DEFAULT SYSDATE,
   dtrecd DATE,
   cost number(6,2),
   qty number(3),
   idvender number(3),
     CONSTRAINT prodreq_id_pk PRIMARY KEY (idrequest),
     CONSTRAINT prodreq_idprod_fk FOREIGN KEY (idProduct)
                     REFERENCES bb_product (idproduct) );
CREATE TABLE BB_Shopper (
	idShopper number(4),
	FirstName varchar2(15),
	LastName varchar2(20),
	Address varchar2(40),
	City varchar2(20),
	State char(2),
	ZipCode varchar2(15),
	Phone varchar2(10),
	Fax varchar2(10),
	Email varchar2(25),
	UserName varchar2(8),
	Password varchar2(8),
	Cookie number(4) DEFAULT 0,
	dtEntered date DEFAULT SYSDATE,
	Province varchar2(15),
	Country varchar2(15),
	CONSTRAINT shopper_id_pk PRIMARY KEY(idShopper) );
create sequence bb_shopper_seq
  start with 30;
insert into bb_shopper
    values (21, 'John', 'Carter', '21 Front St.', 'Raleigh',
            'NC','54822', '9014317701', NULL, 'Crackjack@aol.com', 'Crackj',
            'flyby', 1, '13-JAN-2012', NULL, 'USA');
insert into bb_shopper
    values (22, 'Margaret', 'Somner', '287 Walnut Drive', 'Cheasapeake',
            'VA','23321', '7574216559', NULL, 'MargS@infi.net', 'MaryS',
            'pupper', 1, '03-FEB-2012', NULL, 'USA');
insert into bb_shopper
    values (23, 'Kenny', 'Ratman', '1 Fun Lane', 'South Park',
            'NC','54674', '9015680902', NULL, 'ratboy@msn.net', 'rat55',
            'kile', 0, '26-JAN-2012', NULL, 'USA');
insert into bb_shopper
    values (24, 'Camryn', 'Sonnie', '40162 Talamore', 'South Riding',
            'VA','20152', '7035556868', NULL, 'kids2@xis.net', 'kids2',
            'steel', 1, '19-MAR-2012', NULL, 'USA');
insert into bb_shopper
    values (25, 'Scott', 'Savid', '11 Pine Grove', 'Hickory',
            'VA','22954', '7578221010', NULL, 'scott1@odu.edu', 'fdwell',
            'tweak', 1, '19-FEB-2012', NULL, 'USA');
insert into bb_shopper
    values (26, 'Monica', 'Cast', '112 W. 4th', 'Greensburg',
            'VA','27754', '7573217384', NULL, 'gma@earth.net', 'gma1',
            'goofy', 1, '09-FEB-2012', NULL, 'USA');
insert into bb_shopper
    values (27, 'Pete', 'Parker', '1 Queens', 'New York',
            'NY','67233', '1013217384', NULL, 'spider@web.net', '',
            '', 0, '14-FEB-2012', NULL, 'USA');
ALter table bb_shopper
  ADD (promo CHAR(1));
  CREATE TABLE bb_ProductOptionCategory (
	idOptionCategory number(2),
	CategoryName varchar2(25),
	CONSTRAINT prodoptcat_id_pk PRIMARY KEY(idOptionCategory) );
CREATE TABLE bb_ProductOptionDetail (
	idoption number(2),
	OptionName varchar2(25),
	idOptionCategory number(2),
	CONSTRAINT prodoptdet_id_pk PRIMARY KEY (idOption),
        CONSTRAINT prodoptdet_idoptcat_fk FOREIGN KEY(idOptionCategory) REFERENCES bb_ProductOptionCategory(idOptionCategory) );
CREATE TABLE bb_ProductOption (
	idProductoption number(3),
	idoption number(2),
	idProduct number(2),
	CONSTRAINT prodattr_id_pk PRIMARY KEY (idProductoption),
        CONSTRAINT prodopt_optid_fk FOREIGN KEY(idoption) REFERENCES bb_ProductOptionDetail(idoption),
        CONSTRAINT prodopt_prodid_fk FOREIGN KEY(idProduct) REFERENCES BB_Product(idProduct) );                   
create sequence bb_poption_seq
  start with 30;
insert into bb_ProductOptionCategory(idOptionCategory, CategoryName) values(1,'Size');
insert into bb_ProductOptionCategory(idOptionCategory, CategoryName) values(2,'Form');

insert into bb_ProductOptionDetail(idOption, OptionName, idOptionCategory) values(1,'1/2 LB.', 1);
insert into bb_ProductOptionDetail(idOption, OptionName, idOptionCategory) values(2,'1 LB.', 1);
insert into bb_ProductOptionDetail(idOption, OptionName, idOptionCategory) values(3,'Whole Bean', 2);
insert into bb_ProductOptionDetail(idOption, OptionName, idOptionCategory) values(4,'Regular Grind', 2);

insert into bb_ProductOption(idProductOption, idOption, idProduct) values(1, 1, 5);
insert into bb_ProductOption(idProductOption, idOption, idProduct) values(2, 2, 5);
insert into bb_ProductOption(idProductOption, idOption, idProduct) values(3, 3, 5);
insert into bb_ProductOption(idProductOption, idOption, idProduct) values(4, 4, 5);
insert into bb_ProductOption(idProductOption, idOption, idProduct) values(5, 1, 6);
insert into bb_ProductOption(idProductOption, idOption, idProduct) values(6, 2, 6);
insert into bb_ProductOption(idProductOption, idOption, idProduct) values(7, 3, 6);
insert into bb_ProductOption(idProductOption, idOption, idProduct) values(8, 4, 6);
insert into bb_ProductOption(idProductOption, idOption, idProduct) values(9, 1, 7);
insert into bb_ProductOption(idProductOption, idOption, idProduct) values(10, 2,7);
insert into bb_ProductOption(idProductOption, idOption, idProduct) values(11, 3, 7);
insert into bb_ProductOption(idProductOption, idOption, idProduct) values(12, 4, 7);
insert into bb_ProductOption(idProductOption, idOption, idProduct) values(13, 1, 8);
insert into bb_ProductOption(idProductOption, idOption, idProduct) values(14, 2, 8);
insert into bb_ProductOption(idProductOption, idOption, idProduct) values(15, 3, 8);
insert into bb_ProductOption(idProductOption, idOption, idProduct) values(16, 4, 8);
insert into bb_ProductOption(idProductOption, idOption, idProduct) values(17, 1, 9);
insert into bb_ProductOption(idProductOption, idOption, idProduct) values(18, 2, 9);
insert into bb_ProductOption(idProductOption, idOption, idProduct) values(19, 3, 9);
insert into bb_ProductOption(idProductOption, idOption, idProduct) values(20, 4, 9);
insert into bb_ProductOption(idProductOption, idOption, idProduct) values(21, 1, 10);
insert into bb_ProductOption(idProductOption, idOption, idProduct) values(22, 2, 10);
insert into bb_ProductOption(idProductOption, idOption, idProduct) values(23, 3, 10);
insert into bb_ProductOption(idProductOption, idOption, idProduct) values(24, 4, 10);
CREATE TABLE bb_Basket (
	idBasket number(5),
	Quantity number(2),
	idShopper number(4),
	OrderPlaced number(1),
	SubTotal number(7,2),
	Total number(7,2),
	Shipping number(5,2),
	Tax number(5,2),
	dtCreated date DEFAULT SYSDATE,
	Promo number(2),
	ShipFirstName varchar2(10),
	ShipLastName varchar2(20),
	ShipAddress varchar2(40),
	ShipCity varchar2(20),
	ShipState varchar2(2),
	ShipZipCode varchar2(15),
	ShipPhone varchar2(10),
	ShipFax varchar2(10),
	ShipEmail varchar2(25),
	BillFirstName varchar2(10),
	BillLastName varchar2(20),
	BillAddress varchar2(40),
	BillCity varchar2(20),
	BillState varchar2(2),
	BillZipCode varchar2(15),
	BillPhone varchar2(10),
	BillFax varchar2(10),
	BillEmail varchar2(25),
	dtOrdered date DEFAULT SYSDATE,
	ShipProvince varchar2(20),
	ShipCountry varchar2(20),
	BillProvince varchar2(20),
	BillCountry varchar2(20),
	CardType char(1) ,
	CardNumber varchar2(20) ,
	ExpMonth char(2),
        ExpYear char(4),
	CardName varchar2(25),
        shipbill char(1) default 'N',
        ShipFlag char(1) default 'N',
        CONSTRAINT bskt_id_pk PRIMARY KEY(idBasket),
         CONSTRAINT bskt_idshopper_fk FOREIGN KEY (idShopper)
           REFERENCES bb_Shopper(idShopper) );
Create sequence bb_idBasket_seq
   start with 25;
insert into bb_basket (idbasket, quantity, idshopper,orderplaced, subtotal, total, shipping, tax, dtcreated, promo)
    values (3, 3, 21, 1, 26.60, 32.40, 5.00, .80, '23-JAN-2012',0);
insert into bb_basket (idbasket, quantity, idshopper,orderplaced, subtotal, total, shipping, tax, dtcreated, promo)
    values (4, 1, 21, 1, 28.50, 34.36, 5.00, .86, '12-FEB-2012',0);
insert into bb_basket (idbasket, quantity, idshopper,orderplaced, subtotal, total, shipping, tax, dtcreated, promo)
    values (5, 4, 22, 1, 41.60, 48.47, 5.00, 1.87, '19-FEB-2012',0);
insert into bb_basket (idbasket, quantity, idshopper,orderplaced, subtotal, total, shipping, tax, dtcreated, promo)
    values (6, 3, 22, 1, 149.99, 161.74, 5.00, 6.75, '01-MAR-2012',0);
insert into bb_basket (idbasket, quantity, idshopper,orderplaced, subtotal, total, shipping, tax, dtcreated, promo)
    values (7, 2, 23, 1, 21.60, 27.25, 5.00, .65, '26-JAN-2012',0);
insert into bb_basket (idbasket, quantity, idshopper,orderplaced, subtotal, total, shipping, tax, dtcreated, promo)
    values (8, 2, 23, 1, 21.60, 27.25, 5.00, .65, '16-FEB-2012',0);
insert into bb_basket (idbasket, quantity, idshopper,orderplaced, subtotal, total, shipping, tax, dtcreated, promo)
    values (9, 2, 23, 1, 21.60, 27.25, 5.00, .65, '02-MAR-2012',0);
insert into bb_basket (idbasket, quantity, idshopper,orderplaced, subtotal, total, shipping, tax, dtcreated, promo)
    values (10, 3, 24, 1, 38.90, 45.65, 5.00, 1.75, '07-FEB-2012',0);
insert into bb_basket (idbasket, quantity, idshopper,orderplaced, subtotal, total, shipping, tax, dtcreated, promo)
    values (11, 1, 24, 1, 10.00, 15.45, 5.00, .45, '27-FEB-2012',0);
insert into bb_basket (idbasket, quantity, idshopper,orderplaced, subtotal, total, shipping, tax, dtcreated, promo)
    values (12, 7, 25, 1, 72.40, 83.66, 8.00, 3.26, '19-FEB-2012',0);
insert into bb_basket (idbasket, quantity, idshopper,orderplaced, subtotal, total, shipping, tax, dtcreated, promo)
    values (13, 2, 26, 0, 20.00, 0, 0, 0, '09-FEB-2012',0);
insert into bb_basket (idbasket, quantity, idshopper,orderplaced, subtotal, total, shipping, tax, dtcreated, promo)
    values (14, 0, 26, 0, 0, 0, 0, 0, '10-FEB-2012',0);
insert into bb_basket (idbasket, quantity, idshopper,orderplaced, subtotal, total, shipping, tax, dtcreated, promo)
    values (15, 2, 27, 0, 16.20, 21.69, 5.00, .49, '14-FEB-2012',0);
insert into bb_basket (idbasket, quantity, idshopper,orderplaced, subtotal, total, shipping, tax, dtcreated, promo)
    values (16, 2, 27, 0, 16.20, 21.69, 5.00, .49, '24-FEB-2012',0);
update bb_basket
 set dtordered = dtcreated;
update bb_basket
  set dtordered = NULL
  where orderplaced = 0;
UPDATE bb_basket
  set shipflag = 'N';
update bb_basket
 SET orderplaced = 0
where idbasket = 12;
CREATE TABLE bb_basketItem (
	idBasketItem number(2),
	idProduct number(2),
	Price number(6,2),
	Quantity number(2),
	idBasket number(5) ,
	option1 number(2),
	option2 number(2),
	CONSTRAINT bsktitem_id_pk PRIMARY KEY (idBasketItem),
        CONSTRAINT bsktitem_bsktid_fk FOREIGN KEY (idBasket) 
          REFERENCES bb_Basket(idBasket),
        CONSTRAINT bsktitem_idprod_fk FOREIGN KEY (idproduct) 
          REFERENCES bb_Product(idproduct) );
Create sequence bb_idBasketitem_seq
  start with 50;
insert into bb_basketItem
      values (15, 6, 5.00, 1, 3, 1, 4);
insert into bb_basketItem
      values (16, 8, 10.80, 2, 3, 2, 4);
insert into bb_basketItem
      values (17, 4, 28.50, 1, 4, NULL, NULL);
insert into bb_basketItem
      values (18, 7, 10.80, 1, 5, 2, 3);
insert into bb_basketItem
      values (19, 8, 10.80, 1, 5, 2, 3);
insert into bb_basketItem
      values (20, 9, 10.00, 1, 5, 2, 3);
insert into bb_basketItem
      values (21, 10, 10.00, 1, 5, 2, 3);
insert into bb_basketItem
      values (22, 10, 10.00, 2, 6, 2, 4);
insert into bb_basketItem
      values (23, 2, 129.99, 1, 6, NULL, NULL);
insert into bb_basketItem
      values (24, 7, 10.80, 1, 7, 2, 3);
insert into bb_basketItem
      values (25, 8, 10.80, 1, 7, 2, 3);
insert into bb_basketItem
      values (26, 7, 10.80, 1, 8, 2, 3);
insert into bb_basketItem
      values (27, 8, 10.80, 1, 8, 2, 3);
insert into bb_basketItem
      values (28, 7, 10.80, 1, 9, 2, 3);
insert into bb_basketItem
      values (29, 8, 10.80, 1, 9, 2, 3);
insert into bb_basketItem
      values (30, 6, 5.00,  1, 10, 1, 3);
insert into bb_basketItem
      values (31, 8, 5.40,  1, 10, 1, 3);
insert into bb_basketItem
      values (32, 4, 28.50, 1, 10, NULL, NULL);
insert into bb_basketItem
      values (33, 9, 10.00, 1, 11, 2, 3);
insert into bb_basketItem
      values (34, 8, 10.80, 2, 12, 2, 3);
insert into bb_basketItem
      values (35, 9, 10.00, 2, 12, 2, 3);
insert into bb_basketItem
      values (36, 6, 10.00, 2, 12, 2, 3);
insert into bb_basketItem
      values (37, 7, 10.80, 1, 12, 2, 3);
insert into bb_basketItem
      values (38, 9, 10.00, 2, 13, 2, 3);
insert into bb_basketItem
      values (40, 8, 10.80, 1, 15, 2, 3);
insert into bb_basketItem
      values (41, 7, 5.40, 1, 15, 1, 3);
insert into bb_basketItem
      values (42, 8, 10.80, 1, 16, 2, 3);
insert into bb_basketItem
      values (43, 7, 5.40, 1, 16, 1, 3);
CREATE TABLE bb_Shipping (
	idRange NUMBER(2),
	Low NUMBER(3),
	High NUMBER(3),
	Fee NUMBER(6,2),
	CONSTRAINT ship_idrange_pk PRIMARY KEY (idRange) ); 
INSERT INTO bb_shipping  VALUES(1,1,5,5.00);
INSERT INTO bb_shipping  VALUES(2,6,10,8.00);
INSERT INTO bb_shipping  VALUES(3,11,99,11.00);
CREATE TABLE bb_Tax (
	idState NUMBER(2),
	State char(2),
	TaxRate NUMBER(4,3),
	CONSTRAINT tax_idstate_pk PRIMARY KEY(idState) ); 
INSERT INTO bb_tax VALUES(1,'VA',.045);
INSERT INTO bb_tax VALUES(2,'NC',.03);
INSERT INTO bb_tax VALUES(3,'SC',.06);
CREATE TABLE bb_BasketStatus (
	idStatus number(5),
	idBasket number(5),
	idStage number(1),
	dtStage date,
	Notes varchar2(50),
        shipper varchar2(5),
	ShippingNum varchar2(20),
	CONSTRAINT  basketstatus_pk PRIMARY KEY (idStatus),
        CONSTRAINT BasketStatus_idBasket_fk FOREIGN KEY (idBasket)
          REFERENCES bb_basket(idBasket) );
CREATE SEQUENCE bb_status_seq start with 15;
INSERT INTO bb_basketstatus (idstatus, idbasket, idstage, dtstage)
     VALUES (1,3,1,'24-JAN-2012');
INSERT INTO bb_basketstatus (idstatus, idbasket, idstage, dtstage)
     VALUES (2,3,5,'25-JAN-2012');
INSERT INTO bb_basketstatus (idstatus, idbasket, idstage, dtstage)
     VALUES (3,4,1,'13-FEB-2012');
INSERT INTO bb_basketstatus (idstatus, idbasket, idstage, dtstage)
     VALUES (4,4,5,'14-FEB-2012');
INSERT INTO bb_basketstatus
   VALUES (bb_status_seq.NEXTVAL, 12, 3, NULL, NULL, NULL, NULL);
update bb_basketstatus
  SET shipper = 'UPS', shippingnum = 'ZW845584GD89H569',
                  notes = 'Customer called to confirm shipment'
 WHERE idstatus = 2;
Create table bb_promolist (
   idshopper number(4),
   month CHAR(3),
   year CHAR(4),
   promo_flag CHAR(2),
   Used CHAR(1) DEFAULT 'N',
     CONSTRAINT promo_uk UNIQUE (idshopper,month,year),
     CONSTRAINT promo_idshopper_fk FOREIGN KEY (idshopper)
        REFERENCES bb_shopper(idshopper) );
Create table bb_promo (
   idPromo char(1),
   amount number(5,2) );
insert into bb_promo values ('B', .05);
create view bb_basketitem_vu as
   select * from bb_basketitem;
create table bb_blocktest
  ( testcol varchar2(15) );
create table bb_test1
  (col1 number(2));
create table bb_test2
  (col1 number(2));
 insert into bb_test1 values (1);
 insert into bb_test2 values (1);
create table bb_prod_sales (
     idproduct NUMBER(2),
     month char(3),
     year char(4),
     qty number(5),
     total number(6,2),
     CONSTRAINT prodsales_prodid_fk FOREIGN KEY(idproduct)
                     REFERENCES BB_Product(idproduct));
create table bb_shop_sales (
     idshopper NUMBER(4),
     total number(6,2),
     CONSTRAINT shopsales_shopid_fk FOREIGN KEY(idshopper)
                     REFERENCES BB_Shopper(idshopper));
CREATE SEQUENCE bb_prodreq_seq;
CREATE OR REPLACE VIEW bb_ship_vu
 AS SELECT b.idbasket, b.shipflag, bs.idstage, bs.dtstage, bs.notes,
            bs.shipper, bs.shippingnum
      FROM bb_basket b, bb_basketstatus bs
      WHERE b.idBasket = bs.idBasket;
CREATE TABLE bb_audit_logon
  ( userid VARCHAR2(10),
    logdate DATE );
COMMIT;

