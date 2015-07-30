SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE account;
TRUNCATE account_type;
TRUNCATE bank;
TRUNCATE bank_contact;
TRUNCATE bond;
TRUNCATE budget;
TRUNCATE budget_transaction;
TRUNCATE credential;
TRUNCATE currency;
TRUNCATE finances_user;
TRUNCATE ifinances_keys;
TRUNCATE investment;
TRUNCATE market;
TRUNCATE portfolio;
TRUNCATE stock;
TRUNCATE time_test;
TRUNCATE transaction;
TRUNCATE user_account;
TRUNCATE user_address;

SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO `ifinances`.`bank`
(`BANK_ID`,
`NAME`,
`ADDRESS_LINE_1`,
`ADDRESS_LINE_2`,
`CITY`,
`STATE`,
`ZIP_CODE`,
`IS_INTERNATIONAL`,
`LAST_UPDATED_BY`,
`LAST_UPDATED_DATE`,
`CREATED_BY`,
`CREATED_DATE`,
`ADDRESS_TYPE`)
VALUES
(null,
'Second National Trust',
'301 Snowy Lane',
'Suite 2',
'Adams',
'PA',
'10003',
0,
'system',
'2014-11-1',
'system',
'2014-11-1',
'PRIMARY');

INSERT INTO `ifinances`.`bank`
(`BANK_ID`,
`NAME`,
`ADDRESS_LINE_1`,
`ADDRESS_LINE_2`,
`CITY`,
`STATE`,
`ZIP_CODE`,
`IS_INTERNATIONAL`,
`LAST_UPDATED_BY`,
`LAST_UPDATED_DATE`,
`CREATED_BY`,
`CREATED_DATE`,
`ADDRESS_TYPE`)
VALUES
(null,
'Third National Trust',
'Sunrise Drive',
'Suite 22',
'Jonestown',
'MI',
'12303',
0,
'system',
'2014-11-1',
'system',
'2014-11-1',
'PRIMARY');

INSERT INTO `ifinances`.`bank`
(`BANK_ID`,
`NAME`,
`ADDRESS_LINE_1`,
`ADDRESS_LINE_2`,
`CITY`,
`STATE`,
`ZIP_CODE`,
`IS_INTERNATIONAL`,
`LAST_UPDATED_BY`,
`LAST_UPDATED_DATE`,
`CREATED_BY`,
`CREATED_DATE`,
`ADDRESS_TYPE`)
VALUES
(null,
'Third National Trust',
'Bellvue',
'Suite 2',
'Newport',
'RI',
'18943',
0,
'system',
'2014-11-1',
'system',
'2014-11-1',
'PRIMARY');

INSERT INTO `ifinances`.`bank`
(`BANK_ID`,
`NAME`,
`ADDRESS_LINE_1`,
`ADDRESS_LINE_2`,
`CITY`,
`STATE`,
`ZIP_CODE`,
`IS_INTERNATIONAL`,
`LAST_UPDATED_BY`,
`LAST_UPDATED_DATE`,
`CREATED_BY`,
`CREATED_DATE`,
`ADDRESS_TYPE`)
VALUES
(null,
'Forth National Trust',
'403 Park Ave',
'Suite 221',
'Madison',
'WI',
'10003',
0,
'system',
'2014-11-1',
'system',
'2014-11-1',
'PRIMARY');
