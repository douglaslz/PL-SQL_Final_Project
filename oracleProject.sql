--DROP
DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE customer CASCADE CONSTRAINTS;
DROP TABLE card_payment CASCADE CONSTRAINTS;
DROP TABLE "order" CASCADE CONSTRAINTS;
DROP TABLE order_item CASCADE CONSTRAINTS;
DROP TABLE shipping CASCADE CONSTRAINTS;
--CREATE TABLES
CREATE TABLE product (
  product# NUMBER(4) NOT NULL,
  productName VARCHAR2(20) NOT NULL,
  color VARCHAR2(10) NOT NULL,
  productquantity NUMBER(5) NOT NULL,
  price DECIMAL(8, 2) NOT NULL,
  productsize CHAR(3) NOT NULL,
  category VARCHAR2(30) NOT NULL,
  CONSTRAINT product_product#_pk PRIMARY KEY (product#),
  CONSTRAINT product_price_ck check(price >= 0)
);

CREATE TABLE customer (
  cust# NUMBER(3) NOT NULL,
  first_name VARCHAR2(30) NOT NULL,
  last_name VARCHAR2(30) NOT NULL,
  email VARCHAR2(30) NOT NULL,
  phone VARCHAR2(20) NOT NULL,
  addrees VARCHAR2(30) NOT NULL,
  city VARCHAR2(30) NOT NULL,
  state VARCHAR2(30) NOT NULL,
  zip VARCHAR2(6) NOT NULL,
  PRIMARY KEY (cust#)
);

CREATE TABLE "order" (
  order# NUMBER(4) NOT NULL,
  cust# NUMBER(3) NOT NULL,
  order_date DATE,
  CONSTRAINT order_order#_pk PRIMARY KEY (order#),
  CONSTRAINT fk_order_cust# FOREIGN KEY (cust#) REFERENCES customer (cust#)
);

CREATE TABLE card_payment (
  card# VARCHAR2(20) NOT NULL,
  order# NUMBER(4) NOT NULL,
  holder_name VARCHAR2(40) NOT NULL,
  month_expire NUMBER(2),
  year_expire NUMBER(2),
  CONSTRAINT cardPayment_card#_pk PRIMARY KEY (card#),
  CONSTRAINT fk_order_cardPayment_order# FOREIGN KEY (order#) REFERENCES "order" (order#),
  CONSTRAINT card_payment_month_ck check(month_expire >= 0 AND month_expire <= 12),
  CONSTRAINT card_payment_year_ck check(year_expire >= 0 AND year_expire <= 99)
);

CREATE TABLE order_item (
  order# NUMBER(4) NOT NULL,
  product# NUMBER(4) NOT NULL,
  quantity NUMBER(2) NOT NULL,
  total NUMBER(8, 2) NOT NULL,
  CONSTRAINT orderItem_order#_product#_pk PRIMARY KEY (order#, product#),
  CONSTRAINT fk_order_order# FOREIGN KEY (order#) REFERENCES "order" (order#),
  CONSTRAINT fk_order_product# FOREIGN KEY (product#) REFERENCES product (product#)
);

CREATE TABLE shipping (
  shipping# NUMBER(5) NOT NULL,
  order# NUMBER(4) NOT NULL,
  ship_date DATE,
  ship_status VARCHAR2(20) NOT NULL,
  CONSTRAINT shipping_shipping#_pk PRIMARY KEY (shipping#),
  CONSTRAINT fk_order_orderItem_order# FOREIGN KEY (order#) REFERENCES "order" (order#)
);
--SEQUENCES
DROP SEQUENCE order#_seq;
CREATE SEQUENCE  order#_seq
  MINVALUE 1
  INCREMENT BY 1
  START WITH 1
  NOCACHE
  NOORDER
  NOCYCLE;

DROP SEQUENCE shipping#_seq;
CREATE SEQUENCE  shipping#_seq
  MINVALUE 1
  INCREMENT BY 1
  START WITH 1
  NOCACHE
  NOORDER
  NOCYCLE;

DROP SEQUENCE cust#_seq;
CREATE SEQUENCE  cust#_seq
  MINVALUE 1
  INCREMENT BY 1
  START WITH 1
  NOCACHE
  NOORDER
  NOCYCLE;

DROP SEQUENCE product#_seq;
CREATE SEQUENCE  product#_seq
  MINVALUE 1
  INCREMENT BY 1
  START WITH 1
  NOCACHE
  NOORDER
  NOCYCLE;
--INSERT
INSERT INTO product VALUES (product#_seq.nextval, 'PinkFloyd T-Shirt', 'Black', 15, 25.00, 'M', 'T-Shirt');
INSERT INTO product VALUES (product#_seq.nextval, 'Slim Jeans', 'Dark Blue', 20, 30.00, '32', 'Jeans');
INSERT INTO product VALUES (product#_seq.nextval, 'Vine T-Shirt', 'Gray', 10, 20.00, 'L', 'T-Shirt');
INSERT INTO product VALUES (product#_seq.nextval, 'Running Shoes', 'White/Red', 12, 120.00, '8.5', 'Running Shoes');
INSERT INTO product VALUES (product#_seq.nextval, 'Training Pants', 'Black', 9, 35.00, 'L', 'Sports Pants');
INSERT INTO product VALUES (product#_seq.nextval, 'White Hoodie', 'White', 22, 29.00, 'S', 'Hoodies');
INSERT INTO product VALUES (product#_seq.nextval, 'Yoga Pants', 'Green', 14, 25.00, 'XS', 'Sports Pants');
INSERT INTO product VALUES (product#_seq.nextval, 'Black T-Shirt', 'Black', 18, 20.00, 'L', 'T-Shirt');
INSERT INTO product VALUES (product#_seq.nextval, 'Winter Boots', 'Dark Gray', 6, 189.00, '9.0', 'Boots');
INSERT INTO product VALUES (product#_seq.nextval, 'Heat-Tech', 'Dark Blue', 16, 30.00, 'XL', 'Heat-Tech');

SELECT * FROM product;

INSERT INTO customer VALUES (cust#_seq.nextval, 'Luiz', 'Sato', 'luiz.sato@test.com', '416-555-0162', '1244  Islington Ave', 'Toronto', 'Ontario', 'M8V3B6');
INSERT INTO customer VALUES (cust#_seq.nextval, 'Zawar', 'Mehmood', 'zawar@test.com', '416-555-0161','2813  Ste. Catherine Ouest', 'Montreal', 'Quebec', 'H3K2C3');
INSERT INTO customer VALUES (cust#_seq.nextval, 'Mary', 'Romeral', 'maryromeral@test.com', '416-555-0199', '3285  th Street', 'Edmonton', 'Alberta', 'T5J2R4');
INSERT INTO customer VALUES (cust#_seq.nextval, 'Neeti', 'Parekh', 'neetip@test.com', '416-555-0137', '3890  Charing Cross Rd', 'Chatham', 'Ontario', 'N7M2G9');
INSERT INTO customer VALUES (cust#_seq.nextval, 'Giovanna', 'Nieto', 'gnieto@test.com', '416-555-0145', '1912  St. John Street', 'Viscount', 'Saskatchewan', 'S4P3Y2');
INSERT INTO customer VALUES (cust#_seq.nextval, 'Artur', 'Fundukyan', 'artur@test.com', '416-555-0114', '970  Richmond Road', 'Calgary', 'Alberta', 'T2T0C6');
INSERT INTO customer VALUES (cust#_seq.nextval, 'Sharang', 'Verma', 'sharang@test.com', '416-555-0186', '3617  Bloor Street', 'Lougheed', 'Alberta', 'T0B2V0');
INSERT INTO customer VALUES (cust#_seq.nextval, 'Janelle', 'Baetiong', 'beationg@test.com', '416-555-0105', '2638  Exmouth Street', 'Sarnia', 'Ontario', 'N7T4C8');
INSERT INTO customer VALUES (cust#_seq.nextval, 'Akio', 'Kozuka', 'kozukaakio@test.com', '416-555-0146', '545  Robson St', 'Vancouver', 'British Columbia', 'V6B3K9');
INSERT INTO customer VALUES (cust#_seq.nextval, 'Connie', 'Chang', 'cchang@test.com', '416-555-0188', '1585  Scotchmere Dr', 'Sarnia', 'Ontario', 'N7T7X5');

SELECT * FROM customer;

INSERT INTO "order" VALUES (order#_seq.nextval, 1, '12-Dec-2018');
INSERT INTO "order" VALUES (order#_seq.nextval, 2, '11-Mar-2018');
INSERT INTO "order" VALUES (order#_seq.nextval, 3, '05-May-2018');
INSERT INTO "order" VALUES (order#_seq.nextval, 4, '23-Feb-2018');
INSERT INTO "order" VALUES (order#_seq.nextval, 5, '11-Nov-2018');
INSERT INTO "order" VALUES (order#_seq.nextval, 6, '22-Oct-2018');
INSERT INTO "order" VALUES (order#_seq.nextval, 7, '14-Jan-2018');
INSERT INTO "order" VALUES (order#_seq.nextval, 8, '04-May-2018');
INSERT INTO "order" VALUES (order#_seq.nextval, 9, '11-May-2018');
INSERT INTO "order" VALUES (order#_seq.nextval, 10, '25-Dec-2018');


SELECT * FROM "order";

INSERT INTO card_payment VALUES ('5407-8107-3575-4590', 1 , 'Luiz Gustavo Sato', 11, 23);
INSERT INTO card_payment VALUES ('5518-7685-0207-7114', 2, 'Zawar Mehmood', 01, 22);
INSERT INTO card_payment VALUES ('4532-3399-7199-1261', 3, 'Mary Joy Romeral', 05, 23);
INSERT INTO card_payment VALUES ('5144-5346-5119-4197', 4, 'Neeti P Parekh', 11, 21);
INSERT INTO card_payment VALUES ('5207-1667-9468-5502', 5, 'Giovanna F Nieto', 11, 19);
INSERT INTO card_payment VALUES ('3798-172934-08811', 6, 'Artur Fundukyan', 09, 20);
INSERT INTO card_payment VALUES ('4916-1280-4874-4605', 7, 'Sharang Verma', 12, 25);
INSERT INTO card_payment VALUES ('3773-327359-85261', 8, 'Janelle Beation', 04, 22);
INSERT INTO card_payment VALUES ('5356-6382-2082-7014', 9, 'Akio Kozuka', 08, 26);
INSERT INTO card_payment VALUES ('4024-0071-7531-0399', 10, 'Connie Chang', 11, 24);

SELECT * FROM card_payment;

INSERT INTO order_item VALUES (1, 2, 1, 30.00);
INSERT INTO order_item VALUES (2, 5, 2, 70.00);
INSERT INTO order_item VALUES (3, 2, 1, 60.00);
INSERT INTO order_item VALUES (4, 3, 2, 40.00);
INSERT INTO order_item VALUES (5, 7, 3, 75.00);
INSERT INTO order_item VALUES (6, 1, 1, 25.00);
INSERT INTO order_item VALUES (7, 7, 2, 50.00);
INSERT INTO order_item VALUES (8, 9, 1, 189.00);
INSERT INTO order_item VALUES (9, 10, 2, 60.00);
INSERT INTO order_item VALUES (10, 2, 3, 60.00);

SELECT * FROM order_item;

INSERT INTO shipping VALUES (shipping#_seq.nextval, 1, '20-Dec-2018', 'Preparing');
INSERT INTO shipping VALUES (shipping#_seq.nextval, 2, '15-Mar-2018', 'Delivered');
INSERT INTO shipping VALUES (shipping#_seq.nextval, 3, '07-May-2018', 'Delivered');
INSERT INTO shipping VALUES (shipping#_seq.nextval, 4, '27-Feb-2018', 'Delivered');
INSERT INTO shipping VALUES (shipping#_seq.nextval, 5, '15-Nov-2018', 'Transit');
INSERT INTO shipping VALUES (shipping#_seq.nextval, 6, '25-Oct-2018', 'Delivered');
INSERT INTO shipping VALUES (shipping#_seq.nextval, 7, '20-Jan-2018', 'Delivered');
INSERT INTO shipping VALUES (shipping#_seq.nextval, 8, '11-May-2018', 'Delivered');
INSERT INTO shipping VALUES (shipping#_seq.nextval, 9, '11-May-2018', 'Delivered');
INSERT INTO shipping VALUES (shipping#_seq.nextval, 10, '01-Jan-2019', 'Preparing');





--INDEXES
CREATE BITMAP INDEX customer_state_idx ON CUSTOMER(state);

CREATE INDEX shipping_status_idx ON SHIPPING(SHIP_STATUS);

CREATE INDEX product_category_idx ON PRODUCT(CATEGORY);

--FUNCTIONS
CREATE OR REPLACE FUNCTION qua_calc_pf (p_id NUMBER)
RETURN NUMBER
IS
  lv_qua_num NUMBER(5,2) :=0;
  BEGIN
    SELECT PRODUCTQUANTITY INTO lv_qua_num FROM PRODUCT WHERE PRODUCT# = p_id;
  RETURN lv_qua_num;
  END;
/

CREATE OR REPLACE FUNCTION ship_calc_pf (p_id IN NUMBER)
RETURN NUMBER
IS
  lv_tax_num NUMBER(5,3);
  lv_state VARCHAR2(50);

  BEGIN
    SELECT STATE
      INTO lv_state
      FROM CUSTOMER
      WHERE CUST# = p_id;
        CASE lv_state
        WHEN 'Alberta' THEN lv_tax_num :=  .06;
        WHEN 'Ontario' THEN lv_tax_num :=  .05;
        WHEN 'Saskatchewan' THEN lv_tax_num :=  .08;
        WHEN 'British Columbia' THEN lv_tax_num := .09;
        WHEN 'Quebec' THEN lv_tax_num :=  .1;
        ELSE lv_tax_num := .04;
        END CASE;
    RETURN lv_tax_num;
  END;
/

CREATE OR REPLACE FUNCTION PRICE_CALC_PF(p_ORDERID NUMBER)
RETURN NUMBER
IS
  LV_PRODUCTID NUMBER (5,2);
  LV_QUANTITY  NUMBER (4);
  LV_PRICE     NUMBER (5,2);

  BEGIN
    SELECT PRODUCT#, QUANTITY
    INTO LV_PRODUCTID, LV_QUANTITY
    FROM ORDER_ITEM
    WHERE ORDER# = P_ORDERID;
    SELECT PRICE INTO LV_PRICE FROM PRODUCT WHERE PRODUCT# = LV_PRODUCTID;
      LV_PRICE := LV_PRICE *LV_QUANTITY;
    RETURN LV_PRICE;
  END;
/

--PROCEDURES
CREATE OR REPLACE PROCEDURE reduce_QUANTITY_SP (PRODUCTNUMBER NUMBER,QUANTITY_RD NUMBER)
IS
  QUANTITY NUMBER;

    BEGIN
      QUANTITY := qua_calc_pf(PRODUCTNUMBER);
      QUANTITY := QUANTITY - QUANTITY_RD;
      UPDATE PRODUCT SET PRODUCTQUANTITY = QUANTITY WHERE PRODUCT# = PRODUCTNUMBER;
        DBMS_OUTPUT.PUT_LINE(QUANTITY);
      COMMIT;
    END;
/

CREATE OR REPLACE PROCEDURE CHANGE_PRICE_SP (P_ID NUMBER,P_PRICE NUMBER)
IS
  BEGIN
    UPDATE PRODUCT SET PRICE = P_PRICE WHERE PRODUCT# = P_ID;
    COMMIT;
  END;
/

CREATE OR REPLACE PROCEDURE TOTAL_CALC_SP (P_ORDERID NUMBER)
IS
  p_CUSTID NUMBER (5);
  P_TAX NUMBER (5,2);
  P_PRICE NUMBER (5,2);
  P_TOTAL NUMBER(5,2);
  BEGIN
    SELECT CUST# INTO P_CUSTID FROM "order" WHERE ORDER# = P_ORDERID;
      P_PRICE := PRICE_CALC_PF(P_ORDERID);
      P_TAX := SHIP_CALC_PF(P_CUSTID);
      P_TOTAL := P_PRICE + (P_PRICE* P_TAX);
    UPDATE ORDER_ITEM SET TOTAL = P_TOTAL WHERE ORDER# =P_ORDERID;
    DBMS_OUTPUT.PUT_LINE('The total amount for the order# '|| P_ORDERID || ' is '|| P_TOTAL );
    COMMIT;
  END;
/

CREATE OR REPLACE PROCEDURE TOTAL_BOUGHT_USER (p_id number)
IS
  total NUMBER ;
  First_n VARCHAR2(20);
  Last_n VARCHAR2(20);
    BEGIN
      SELECT SUM(TOTAL) INTO total FROM ORDER_ITEM WHERE ORDER# = p_id;
      SELECT FIRST_NAME,LAST_NAME INTO First_n,Last_n FROM CUSTOMER WHERE CUST# = (SELECT CUST# FROM "order" WHERE ORDER# = p_id);

        DBMS_OUTPUT.PUT_LINE('The total of the order of the client '||First_n || ' '||Last_n|| ' is '||total );
    END;
/

--TRIGGERS
CREATE OR REPLACE TRIGGER PRICE_CHANGE_TRG AFTER
  UPDATE ON PRODUCT FOR EACH ROW
  DECLARE
    p_diff number(5,2);
  BEGIN
    P_DIFF := :NEW.PRICE - :OLD.PRICE;

    DBMS_OUTPUT.PUT_LINE(:OLD.PRODUCTNAME
      || ' old price: $'
      || :OLD.PRICE);
    DBMS_OUTPUT.PUT_LINE(:OLD.PRODUCTNAME || ' new price: $' || :NEW.PRICE);
      IF P_DIFF > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Price increased by: $' || P_DIFF);
      ELSIF P_DIFF < 0 THEN
        P_DIFF := -P_DIFF;
        DBMS_OUTPUT.PUT_LINE('Price decreased by: $' || P_DIFF);
      END IF;
  END;
/

CREATE OR REPLACE TRIGGER ORDER_DELETE_TRG
BEFORE DELETE ON "order"
FOR EACH ROW
BEGIN
  DELETE FROM SHIPPING WHERE SHIPPING.ORDER# = :old.order#;
  DELETE FROM ORDER_ITEM WHERE ORDER_ITEM.ORDER# = :OLD.ORDER#;
  DELETE FROM CARD_PAYMENT WHERE CARD_PAYMENT.ORDER# = :OLD.ORDER#;
END;
/

--VIEWS
CREATE OR REPLACE VIEW ORDER_CATEGORY AS
  SELECT CATEGORY, ORDER#, PRODUCTNAME, QUANTITY, TOTAL
    FROM ORDER_ITEM
      LEFT JOIN PRODUCT USING (PRODUCT#)
    ORDER BY CATEGORY;
  CREATE OR REPLACE VIEW SHIPPED_ORDER
AS
  SELECT FIRST_NAME, LAST_NAME, STATE, TOTAL, SHIP_DATE
    FROM CUSTOMER
      INNER JOIN "order" USING(CUST#)
      INNER JOIN ORDER_ITEM USING(ORDER#)
      INNER JOIN SHIPPING USING (ORDER#)
    WHERE SHIP_STATUS = 'Delivered';

COMMIT;


SET SERVEROUTPUT ON;

--Will change the price of products
BEGIN
  CHANGE_PRICE_SP(1, 30);
  CHANGE_PRICE_SP(4, 100);
END;

--This will display how much 
BEGIN
    TOTAL_CALC_SP(2);
END;

--This will display 
BEGIN
    TOTAL_BOUGHT_USER(3);
END;

--This will display all the users that have shipping already delivered
SELECT * FROm ORDER_CATEGORY;



BEGIN
reduce_QUANTITY_SP(2, 3);
END;