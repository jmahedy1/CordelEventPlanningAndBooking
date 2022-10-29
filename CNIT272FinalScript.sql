DROP TABLE BUSINESS CASCADE CONSTRAINTS;
DROP TABLE CATERER CASCADE CONSTRAINTS;
DROP TABLE CUSTOMER CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE CASCADE CONSTRAINTS;
DROP TABLE ENTERTAINER CASCADE CONSTRAINTS;
DROP TABLE MARKETINGOFFICE CASCADE CONSTRAINTS;
DROP TABLE "ORDER" CASCADE CONSTRAINTS;
DROP TABLE PAYMENT CASCADE CONSTRAINTS;
DROP TABLE PERFORMANCE CASCADE CONSTRAINTS;
DROP TABLE RESERVATION CASCADE CONSTRAINTS;
DROP TABLE RESERVEDCATERING CASCADE CONSTRAINTS;
DROP TABLE SECURITYGUARD CASCADE CONSTRAINTS;
DROP TABLE SUPPLIER CASCADE CONSTRAINTS;
DROP TABLE VENUE CASCADE CONSTRAINTS;

CREATE TABLE business (
    businessid  CHAR(10) NOT NULL,
    name        VARCHAR2(30),
    description VARCHAR2(200),
    address     VARCHAR2(40),
    city        VARCHAR2(50),
    state       CHAR(2),
    country     VARCHAR2(50),
    zipcode     CHAR(5)
);

ALTER TABLE business ADD CONSTRAINT business_pk PRIMARY KEY ( businessid );

CREATE TABLE caterer (
    catererid   CHAR(10) NOT NULL,
    menu        VARCHAR2(1000),
    staffsize   CHAR(3),
    foodinstock INTEGER
);

ALTER TABLE caterer ADD CONSTRAINT caterer_pk PRIMARY KEY ( catererid );

CREATE TABLE customer (
    customerid          CHAR(10) NOT NULL,
    address             VARCHAR2(40),
    phonenum            CHAR(10),
    emailaddress        VARCHAR2(30) CONSTRAINT emailaddress_UQ UNIQUE,
    firstname           VARCHAR2(20) NOT NULL,
    lastname            VARCHAR2(20) NOT NULL,
    business_businessid CHAR(10)
);

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( customerid );

CREATE TABLE employee (
    employeeid CHAR(10) NOT NULL,
    firstname  VARCHAR2(20) NOT NULL,
    lastname   VARCHAR2(20) NOT NULL,
    hiredate   DATE,
    salary     NUMBER(8, 2) NOT NULL
);

ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY ( employeeid );

CREATE TABLE entertainer (
    entertainerid CHAR(10) NOT NULL,
    name          VARCHAR2(50),
    genre         VARCHAR2(20),
    billingrate   NUMBER(6, 2) NOT NULL
);

ALTER TABLE entertainer ADD CONSTRAINT entertainer_pk PRIMARY KEY ( entertainerid );

CREATE TABLE marketingoffice (
    marketofficeid CHAR(10) NOT NULL,
    companyname    VARCHAR2(50),
    description    VARCHAR2(200),
    address        VARCHAR2(80),
    city           VARCHAR2(50),
    state          CHAR(2),
    country        VARCHAR2(50),
    zipcode        CHAR(5)
);

ALTER TABLE marketingoffice ADD CONSTRAINT marketingoffice_pk PRIMARY KEY ( marketofficeid );

CREATE TABLE "ORDER" (
    caterer_catererid   CHAR(10) NOT NULL,
    supplier_supplierid CHAR(10) NOT NULL,
    orderdate           DATE NOT NULL,
    purchasedamount     CHAR(3),
    cost                NUMBER(7, 2),
    shippingdate        DATE
);

ALTER TABLE "ORDER"
    ADD CONSTRAINT order_pk PRIMARY KEY ( supplier_supplierid,
                                          caterer_catererid,
                                          orderdate );

CREATE TABLE payment (
    paymentid                 CHAR(10) NOT NULL,
    reservation_reservationid CHAR(10) NOT NULL,
    paymentmethod             VARCHAR2(20),
    price                     NUMBER(6, 2),
    receipt                   VARCHAR2(100)
);

ALTER TABLE payment ADD CONSTRAINT payment_pk PRIMARY KEY ( paymentid );

CREATE TABLE performance (
    entertainer_entertainerid CHAR(10) NOT NULL,
    reservation_reservationid CHAR(10) NOT NULL,
    "Date/Time"               DATE,
    description               VARCHAR2(200),
    length                    INTEGER
);

ALTER TABLE performance ADD CONSTRAINT performance_pk PRIMARY KEY ( entertainer_entertainerid,
                                                                    reservation_reservationid );

CREATE TABLE reservation (
    reservationid                  CHAR(10) NOT NULL,
    customer_customerid            CHAR(10) NOT NULL,
    venue_venueid                  CHAR(10) NOT NULL,
    employee_employeeid            CHAR(10) NOT NULL,
    roomnum                        CHAR(3),
    "Date/Time"                    DATE,
    confirmationemail              VARCHAR2(200),
    marketingoffice_marketofficeid CHAR(10) NOT NULL
);

ALTER TABLE reservation ADD CONSTRAINT reservation_pk PRIMARY KEY ( reservationid );

CREATE TABLE reservedcatering (
    reservation_reservationid CHAR(10) NOT NULL,
    caterer_catererid         CHAR(10) NOT NULL,
    "Date"                    DATE,
    cost                      NUMBER(6, 2),
    servicedescription        VARCHAR2(200)
);

ALTER TABLE reservedcatering ADD CONSTRAINT reservedcatering_pk PRIMARY KEY ( reservation_reservationid,
                                                                              caterer_catererid );

CREATE TABLE securityguard (
    securityid     CHAR(10) NOT NULL,
    firstname      VARCHAR2(20),
    lastname       VARCHAR2(20),
    clearancelevel CHAR(1),
    venue_venueid  CHAR(10)
);

ALTER TABLE securityguard ADD CONSTRAINT securityguard_pk PRIMARY KEY ( securityid );

CREATE TABLE supplier (
    supplierid   CHAR(10) NOT NULL,
    companyname  VARCHAR2(50),
    description  VARCHAR2(200),
    unitsinstock INTEGER,
    costperunit  NUMBER(6, 2),
    address      VARCHAR2(80),
    city         VARCHAR2(50),
    state        CHAR(2),
    country      VARCHAR2(50),
    zipcode      CHAR(5)
);

ALTER TABLE supplier ADD CONSTRAINT supplier_pk PRIMARY KEY ( supplierid );

CREATE TABLE venue (
    venueid CHAR(10) NOT NULL,
    name    VARCHAR2(20),
    city    VARCHAR2(20),
    state   CHAR(2)
);

ALTER TABLE venue ADD CONSTRAINT venue_pk PRIMARY KEY ( venueid );

ALTER TABLE customer
    ADD CONSTRAINT customer_business_fk FOREIGN KEY ( business_businessid )
        REFERENCES business ( businessid );

ALTER TABLE "ORDER"
    ADD CONSTRAINT order_caterer_fk FOREIGN KEY ( caterer_catererid )
        REFERENCES caterer ( catererid );

ALTER TABLE "ORDER"
    ADD CONSTRAINT order_supplier_fk FOREIGN KEY ( supplier_supplierid )
        REFERENCES supplier ( supplierid );

ALTER TABLE payment
    ADD CONSTRAINT payment_reservation_fk FOREIGN KEY ( reservation_reservationid )
        REFERENCES reservation ( reservationid );

ALTER TABLE performance
    ADD CONSTRAINT performance_entertainer_fk FOREIGN KEY ( entertainer_entertainerid )
        REFERENCES entertainer ( entertainerid );

ALTER TABLE performance
    ADD CONSTRAINT performance_reservation_fk FOREIGN KEY ( reservation_reservationid )
        REFERENCES reservation ( reservationid );

ALTER TABLE reservation
    ADD CONSTRAINT reservation_customer_fk FOREIGN KEY ( customer_customerid )
        REFERENCES customer ( customerid );

ALTER TABLE reservation
    ADD CONSTRAINT reservation_employee_fk FOREIGN KEY ( employee_employeeid )
        REFERENCES employee ( employeeid );

ALTER TABLE reservation
    ADD CONSTRAINT reservation_marketingoffice_fk FOREIGN KEY ( marketingoffice_marketofficeid )
        REFERENCES marketingoffice ( marketofficeid );

ALTER TABLE reservation
    ADD CONSTRAINT reservation_venue_fk FOREIGN KEY ( venue_venueid )
        REFERENCES venue ( venueid );

ALTER TABLE reservedcatering
    ADD CONSTRAINT reservedcatering_caterer_fk FOREIGN KEY ( caterer_catererid )
        REFERENCES caterer ( catererid );

ALTER TABLE reservedcatering
    ADD CONSTRAINT resCat_reservation_fk FOREIGN KEY ( reservation_reservationid )
        REFERENCES reservation ( reservationid );

ALTER TABLE securityguard
    ADD CONSTRAINT securityguard_venue_fk FOREIGN KEY ( venue_venueid )
        REFERENCES venue ( venueid );

        
--- ALL RECORDS ----------------------------------------------------------------

-- Employee records
INSERT INTO employee
    VALUES  ('1000000002', 'Joe', 'Schmoe', '21-SEP-2020', '120000');
INSERT INTO employee
    VALUES  ('1000000023', 'Bob', 'Moss', '29-OCT-1982', '183240.23');
INSERT INTO employee
    VALUES  ('1000000047', 'Elvis', 'Parsley', '06-FEB-1977', '70042.05');
INSERT INTO employee
    VALUES  ('1000000016', 'Kobe', 'Pryant', '26-JAN-2020', '240000.08');
INSERT INTO employee
    VALUES  ('1000000091', 'Freddie', 'Ammonium', '24-NOV-1991', '419300');
INSERT INTO employee
    VALUES  ('1000000105', 'Marilyn', 'Jacksonville', '09-MAR-2001', '100243.76');
INSERT INTO employee
    VALUES  ('1000000086', 'John', 'Lenin', '08-JUN-1998', '48631.36');
INSERT INTO employee
    VALUES  ('1000000117', 'Muhammad', 'Balli', '03-NOV-2016', '83542.78');
INSERT INTO employee
    VALUES  ('1000000009', 'Albert', 'Einstein', '13-AUG-1982', '173004.20');
INSERT INTO employee
    VALUES  ('1000000056', 'Andy', 'Anderson', '01-SEP-2006', '47520.42');


-- BUSINESS records
INSERT INTO BUSINESS
    VALUES('0000000001', 'Apple Inc.', 'Tech company that specializes in manufacturing electronics.', '1 Infinite Loop', 'Cupertino', 'CA', 'United States', '95014');  
INSERT INTO BUSINESS
    VALUES('0000000002', 'Netflix', 'Entertaintment technology company that specializes in streaming', '2 Infinite Loop', 'Freemont', 'CA', 'United States', '95234');
INSERT INTO BUSINESS
    VALUES('0000000003', 'The Walt Disney Company', 'Animation and Entertaintment conglomerate.', '3 Infinite Loop', 'Burbank', 'CA', 'United States', '12314');
INSERT INTO BUSINESS
    VALUES('0000000004', 'Monsters Inc.', 'Scary monsters scare children for the scare juice.', '4 Infinite Loop', 'West Lafayette', 'IN', 'United States', '42314');
INSERT INTO BUSINESS
    VALUES('0000000005', 'Dunder Mifflin', 'Paper company that specializes in paper and all thing paper. Paper.', '500 N. NBC Dr.', 'Scranton', 'PA', 'United States', '23414');
INSERT INTO BUSINESS
    VALUES('0000000006', 'Caterpillar', 'Construction equipment and manufacturing company.', '342 Finitte Loop', 'Chicago', 'IL', 'United States', '95414');
INSERT INTO BUSINESS
    VALUES('0000000007', 'Boeing', 'Aviation and Manufacturing company', '123 Lakeshore Dr.', 'Seattle', 'WA', 'United States', '95325');
INSERT INTO BUSINESS
    VALUES('0000000008', 'University of Illinois', 'University in Champaign Illinois', '234 Corfield Blvd.', 'Champaign', 'IL', 'United States', '95344');
INSERT INTO BUSINESS
    VALUES('0000000009', 'Commvault', 'Databse cybersecurity company', '1 Commvault Way', 'Tinton Falls', 'NJ', 'United States', '07724');    
INSERT INTO BUSINESS
    VALUES('0000000010', 'Oscorp Industries', 'Research and Development company', '4 road st.', 'Newark', 'NJ', 'United States', '25419');
    
-- CUSTOMER records
INSERT INTO CUSTOMER
    VALUES('0000000001', '1 Infinite Loop', '1234567891', 'tcook@apple.com', 'Tim', 'Cook', '0000000001');
INSERT INTO CUSTOMER
    VALUES('0000000002', '2 Infinite Loop', '1594237461', 'nchorris@apple.com', 'Nuck', 'Chorris', '0000000002');
INSERT INTO CUSTOMER
    VALUES('0000000003', '500 N. Martin Jischke Dr.', '2344523491', 'rboss@gmail.com', 'Ross', 'Bob', Null);    
INSERT INTO CUSTOMER
    VALUES('0000000004', '4 Infinite Loop', '4206696238', 'mwazowski@roar.com', 'Mike', 'Wazowski', '0000000004');    
INSERT INTO CUSTOMER
    VALUES('0000000005', '244 Salisbury Ave.', '9876543219', 'kdhuper@purdue.edu', 'Karty', 'Dhuper', Null);    
INSERT INTO CUSTOMER
    VALUES('0000000006', '342 Finitte Loop', '6546547891', 'jmahedy@caterpillar.com', 'Jack', 'Mahedy', '0000000006');
INSERT INTO CUSTOMER
    VALUES('0000000007', '123 Lakeshore Dr.', '3534525434', 'rmelen@boeing.com', 'Ryan', 'Melenchuk', '0000000007');
INSERT INTO CUSTOMER
    VALUES('0000000008', '500 N. Martin Jischke Dr.', '2344523491', 'rboss8@gmail.com', 'Ross', 'Bob', Null);    
INSERT INTO CUSTOMER
    VALUES('0000000009', '1 Commvault Dr.', '9876123459', 'asmith@roar.com', 'Amel', 'Smith', '0000000009');    
INSERT INTO CUSTOMER
    VALUES('0000000010', '244 Aspire Blvd.', '6767672342', 'sclause@purdue.edu', 'Santa', 'Clause', Null);  
    
-- MARKETINGOFFICE records
INSERT INTO MARKETINGOFFICE
    VALUES('0000000001','Melenchuk Marketing Firm', 'Marketing Firm owned by Ryan Melenchuk', '500 N. Martin Jischke Dr.', 'West Lafayette', 'IN', 'United States', '45907' );
INSERT INTO MARKETINGOFFICE
    VALUES('0000000002','Dhuper Marketing Firm', 'Marketing Firm owned by Ryan Melenchuk', '500 N. Martin Jischke Dr.', 'West Lafayette', 'IN', 'United States', '45907' );    
INSERT INTO MARKETINGOFFICE
    VALUES('0000000003','Mahedy Marketing Firm', 'Marketing Firm owned by Jack Mahedy', '500 N. Martin Jischke Dr.', 'West Lafayette', 'IN', 'United States', '45907' );
INSERT INTO MARKETINGOFFICE
    VALUES('0000000004','Smith Marketing Firm', 'Marketing Firm owned by John Smith', '500 N. Martin Jischke Dr.', 'West Lafayette', 'IN', 'United States', '45907' );   
INSERT INTO MARKETINGOFFICE
    VALUES('0000000005','Deloitte Digital', 'Deloitte Digital is a digital advertising agency within the Deloitte Consulting umbrella.', '32 N. Jartin Mischke Dr.', 'San Francisco', 'CA', 'United States', '35304' );    
INSERT INTO MARKETINGOFFICE
    VALUES('0000000006','Epsilon', 'Epsilon specializes in data, customer insights, loyalty, email, CRM and digital strategy', '435 S. Kartin Fischke St.', 'El Paso', 'TX', 'United States', '23568' );  
INSERT INTO MARKETINGOFFICE
    VALUES('0000000007','Dentsu', 'Dentsu is the largest advertising agency in Japan', '32 Tokyo Dr.', 'Tokyo', 'TK', 'Japan', '23565' );   
INSERT INTO MARKETINGOFFICE
    VALUES('0000000008','Ogilvy', 'Ogilvy is one of the largest advertising agencies around the world. ', '235 N. Lakeshore Dr.', 'New York City', 'NY', 'United States', '34213');       
INSERT INTO MARKETINGOFFICE
    VALUES('0000000009','Havas', 'The agency�s client list is extensive with partners such as Air France, Pernod Ricard, Lacoste, Jack Daniel�s, Ubisoft, IBM and more.', '23 S. Shaftsbury Ave.', 'New York City', 'NY', 'United States', '32412' );    
INSERT INTO MARKETINGOFFICE
    VALUES('0000000010','Leo Burnett', 'Leo Burnett is one of the most recognized and well-known advertising agencies in the world for their long history advertising excellence. ', '356 E. Arlington St.', 'Chicago', 'IL', 'United States', '31243' );
    
    
--CATERER records
INSERT INTO CATERER
    VALUES ('5839234435', 'Tuna Tar Tar, NY Strip Steak, Vanilla Ice cream', '17', 82);
    
INSERT INTO CATERER
    VALUES ('2321256777', 'Caesar Salad, Grilled Chicken, Chocolate Ice Cream', '15', 70);
    
INSERT INTO CATERER
    VALUES ('0969945677', 'House Salad, Pork Chop, Cannolis', '5', 20);

INSERT INTO CATERER
    VALUES ('3996970894', 'Dumplings, Lamb Chop, Churros', '3', 17);
   
INSERT INTO CATERER
    VALUES ('5665434500', 'Sliders, Hamburger, Gelato', '20', 93);

INSERT INTO CATERER
    VALUES ('1211186790', 'Nachos, Bacon Burgers, Cheese Cake', '24', 100);
    
INSERT INTO CATERER
    VALUES ('6766834456', 'Onion Rings, Spicy Chicken Wrap, Key Lime Pie', '25', 115);
    
INSERT INTO CATERER
    VALUES ('0989007658', 'Truffel Fries, Filet Mignon, Profiterole', '7', 50);
    
INSERT INTO CATERER
    VALUES ('3275968473', 'Tacos, Spaghetti Bolognese, Tiramisu', '35', 200);
    
INSERT INTO CATERER
    VALUES ('9996754597', 'Cheese Platter, Lobster, Sorbet', '18', 68);
    

--Supplier records
INSERT INTO SUPPLIER
    VALUES ('2939493295', 'Chicken Natural', 'Supplies chicken to the caterers', 50, 10.00, '12 Maple Road', 'Rumson', 'NJ', 'USA', '09987');
    
INSERT INTO SUPPLIER
    VALUES ('4596670948', 'Deans', 'Supplies utensil sets to the caterers', 75, 5.00, '6 Warner Drive', 'Newark', 'CA', 'USA', '94838');
    
INSERT INTO SUPPLIER
    VALUES ('2122968342', 'Brennans', 'Supplies fish to the caterers', 30, 11.00, '720 Northwestern Ave', 'West Lafayette', 'IN', 'USA', '47906');
    
INSERT INTO SUPPLIER
    VALUES ('4566778990', 'Beef Mart', 'Supplies the Beef to the caterers', 25, 30.00, '18 Chester Lane', 'Omaha', 'NE', 'USA', '44562');
    
INSERT INTO SUPPLIER
    VALUES ('8776545654', 'Cold Stone', 'Supplies the ice cream to the caterers', 23, 9.00, 'Main Street', 'Hilton', 'AK', 'USA', '55532');
    
INSERT INTO SUPPLIER
    VALUES ('9960543454', 'Rays Sea Food', 'Supplies the lobster to the caterers', 35, 40.00, '2 River Road', 'Waters Edge', 'ME', 'USA', '11125');
    
INSERT INTO SUPPLIER
    VALUES ('5554987656', 'Bread Basket', 'Supplies the bread to the caterers', 100, 4.00, '8 Ospray Lane', 'Dayton', 'MD', 'USA', '77654');
    
INSERT INTO SUPPLIER
    VALUES ('6578100922', 'Vs Vegtables', 'Supplies the vegtables to the caterers', 105, 8.00, 'State Street', 'Blue Sky', 'MT', 'USA', '22234');
    
INSERT INTO SUPPLIER
    VALUES ('3434868568', 'Furniture Land', 'Supplies the Table and chair sets to the caterers', 50, 20.00, 'Crossing Ave', 'Fair Haven', 'VA', 'USA', '89765');
    
INSERT INTO SUPPLIER
    VALUES ('8785868568', 'Sallys Silverware', 'Supplies the plates and glasses sets to the caterers', 73, 6.00, '52 Little Street', 'Orlando', 'FL', 'USA', '48457');
    
    
--ORDER records
INSERT INTO "ORDER"
    VALUES ('5839234435', '2939493295', '10-JAN-2021', '223', 1435.23, '15-JAN-2021');
    
INSERT INTO "ORDER"
    VALUES ('5839234435', '4596670948', '14-JAN-2021', '300', 1505.23, '19-JAN-2021');
    
INSERT INTO "ORDER"
    VALUES ('0969945677', '4596670948', '20-JAN-2021', '150', 2000.00, '29-JAN-2021');
    
INSERT INTO "ORDER"
    VALUES ('5665434500', '4566778990', '1-FEB-2021', '75', 2300.00, '25-FEB-2021');
    
INSERT INTO "ORDER"
    VALUES ('5665434500', '8776545654', '15-FEB-2021', '130', 799.59, '19-FEB-2021');
    
INSERT INTO "ORDER"
    VALUES ('6766834456', '5554987656', '7-MAR-2021', '390', 1756.00, '15-MAR-2021');
    
INSERT INTO "ORDER"
    VALUES ('6766834456', '6578100922', '13-APR-2021', '400', 2800.23, '23-APR-2021');
    
INSERT INTO "ORDER"
    VALUES ('3275968473', '3434868568', '25-MAY-2021', '530', 3100.23, '29-MAY-2021');
    
INSERT INTO "ORDER"
    VALUES ('3275968473', '2939493295', '3-JUN-2021', '600', 3900.32, '13-JUN-2021');
    
INSERT INTO "ORDER"
    VALUES ('9996754597', '3434868568', '14-JUL-2021', '780', 4400.23, '16-JUL-2021');
    

-- Venue records
INSERT into venue
    values('1111111111', 'Laux Hall', 'West Lafayette', 'IN');
INSERT into venue
    values('1111111112', 'Ryan Hall', 'Indianapolis', 'IN');
INSERT into venue
    values('1111111113', 'Amel Center', 'Fishers', 'IN');
INSERT into venue
    values('1111111114', 'Jack Room', 'Bloomington', 'IN');
INSERT into venue
    values('1111111115', 'Karty Hall', 'South Bend', 'IN');
INSERT into venue
    values('1111111116', 'Elliot Hall', 'West Lafayette', 'IN');
INSERT into venue
    values('1111111117', 'Chauncey Center', 'West Lafayette', 'IN');
INSERT into venue
    values('1111111118', 'Book Center', 'Muncie', 'IN');
INSERT into venue
    values('1111111119', 'Purdue Arena', 'West Lafayette', 'IN');
INSERT into venue
    values('1111111121', 'CNIT Area', 'West Lafayette', 'IN');


-- RESERVATION records
INSERT INTO RESERVATION
    VALUES ('1548235458','0000000001','1111111111','1000000105','214','30-SEP-2020','"Your reservation has been successfully booked!"','0000000005');
INSERT INTO RESERVATION
    VALUES ('1245236527','0000000006','1111111112','1000000117','004','04-NOV-2020','"Your reservation has been successfully booked!"','0000000004');
INSERT INTO RESERVATION
    VALUES ('1023479589','0000000001','1111111111','1000000009','108','18-JAN-2020','"Your reservation has been successfully booked!"','0000000005');
INSERT INTO RESERVATION
    VALUES ('1420325412','0000000010','1111111112','1000000086','351','12-JAN-2020','"Your reservation has been successfully booked!"','0000000003');
INSERT INTO RESERVATION
    VALUES ('1478451201','0000000010','1111111112','1000000023','246','19-FEB-2021','"Your reservation has been successfully booked!"','0000000001');
INSERT INTO RESERVATION
    VALUES ('1369869563','0000000003','1111111111','1000000091','412','05-MAR-2020','"Your reservation has been successfully booked!"','0000000010');
INSERT INTO RESERVATION
    VALUES ('1236985201','0000000002','1111111113','1000000002','004','02-JUN-2021','"Your reservation has been successfully booked!"','0000000009');
INSERT INTO RESERVATION
    VALUES ('1478546251','0000000008','1111111118','1000000086','105','16-AUG-2021','"Your reservation has been successfully booked!"','0000000007');
INSERT INTO RESERVATION
    VALUES ('1302358754','0000000005','1111111116','1000000091','365','31-DEC-2020','"Your reservation has been successfully booked!"','0000000010');
INSERT INTO RESERVATION
    VALUES ('1478546528','0000000009','1111111112','1000000002','283','01-JAN-2021','"Your reservation has been successfully booked!"','0000000005');


-- PAYMENT records
INSERT INTO PAYMENT
    VALUES ('1014523648','1548235458','Credit','1241.03','Payment Confirmed!');
INSERT INTO PAYMENT
    VALUES ('1014754316','1245236527','Credit','949.78','Payment Confirmed!');
INSERT INTO PAYMENT
    VALUES ('1032563214','1023479589','Cash','491.35','Payment Confirmed!');
INSERT INTO PAYMENT
    VALUES ('1014785412','1420325412','Credit','3081.20','Payment Confirmed!');
INSERT INTO PAYMENT
    VALUES ('1023985245','1478451201','Debit','4862.87',NULL);
INSERT INTO PAYMENT
    VALUES ('1097536356','1369869563','Credit','3152.04','Payment Confirmed!');
INSERT INTO PAYMENT
    VALUES ('1034568535','1236985201','Cash','2048.57','Payment Confirmed!');
INSERT INTO PAYMENT
    VALUES ('1089746437','1478546251','Bitcoin','795.69',NULL);
INSERT INTO PAYMENT
    VALUES ('1036852840','1302358754','Credit','892.47',NULL);
INSERT INTO PAYMENT
    VALUES ('1039718563','1478546528','PayPal','215.72','Payment Confirmed!');

    
--RESERVEDCATEREING records
INSERT INTO RESERVEDCATERING
    VALUES ('1548235458', '5839234435', '12-MAR-2021', 1200.00, 'Provides the Tuna Tar Tar, NY Strip Steak, and Vanilla Ice cream for the reservation.');
    
INSERT INTO RESERVEDCATERING
    VALUES ('1420325412', '2321256777', '25-MAR-2021', 1450.00, 'Provides the Caesar Salad, Grilled Chicken, and Chocolate Ice Cream for the reservation.');
    
INSERT INTO RESERVEDCATERING
    VALUES ('1548235458', '2321256777', '1-APR-2021', 800.00, 'Provides the Caesar Salad, Grilled Chicken, and Chocolate Ice Cream for the reservation.');

INSERT INTO RESERVEDCATERING
    VALUES ('1369869563', '3996970894', '8-APR-2021', 750.00, 'Provides the Dumplings, Lamb Chop, and Churros for the reservation.');
    
INSERT INTO RESERVEDCATERING
    VALUES ('1478546528', '3996970894', '15-MAY-2021', 900.00, 'Provides the Dumplings, Lamb Chop, and Churros for the reservation.');
    
INSERT INTO RESERVEDCATERING
    VALUES ('1302358754', '1211186790', '17-MAY-2021', 1700.00, 'Provides the Nachos, Bacon Burgers, and Cheese Cake for the reservation.');
    
INSERT INTO RESERVEDCATERING
    VALUES ('1023479589', '1211186790', '5-JUN-2021', 1800.00, 'Provides the Nachos, Bacon Burgers, and Cheese Cake for the reservation.');
    
INSERT INTO RESERVEDCATERING
    VALUES ('1548235458', '6766834456', '27-JUN-2021', 1900.00, 'Provides the Onion Rings, Spicy Chicken Wrap, and Key Lime Pie for the reservation.');
    
INSERT INTO RESERVEDCATERING
    VALUES ('1478546528', '3275968473', '16-JUL-2021', 2300.00, 'Provides the Tacos, Spaghetti Bolognese, and Tiramisu for the reservation.');
    
INSERT INTO RESERVEDCATERING
    VALUES ('1023479589', '3275968473', '25-JUL-2021', 2500.00, 'Provides the Tacos, Spaghetti Bolognese, and Tiramisu for the reservation.');
    
    
-- SecurityGuard records
INSERT into securityguard
    values('2222222221','Amel','Vejzovic','1', '1111111113');
INSERT into securityguard
    values('2222222222','Ryan','Melenchuk','2', '1111111112');
INSERT into securityguard
    values('2222222223','Karty','Dhuper','3', '1111111115');
INSERT into securityguard
    values('2222222224','Jack','Mehedy','4', '1111111114');
INSERT into securityguard
    values('2222222225','John','Smith','2', NULL);
INSERT into securityguard
    values('2222222226','John','Doe','3', NULL);
INSERT into securityguard
    values('2222222227','Purdue','Pete','4', '1111111115');
INSERT into securityguard
    values('2222222228','Santa','Claus','5', '1111111116');
INSERT into securityguard
    values('2222222229','Danny','Johnson','6', '1111111117');
INSERT into securityguard
    values('2222222230','Joey','Jackson','7', '1111111118');


-- Entertainer records
INSERT into entertainer
    values ('3333333331','Kanye West','Music','1000.00');
INSERT into entertainer
    values ('3333333332','Taylor Swift','Music','7500.00');
INSERT into entertainer
    values ('3333333333','Kevin Hart','Comedy','1000.00');
INSERT into entertainer
    values ('3333333334','Bob Ross','Artist','2500.00');
INSERT into entertainer
    values ('3333333335','Nick Vujicic','Motivation','100.00');
INSERT into entertainer
    values ('3333333336','Matt Stonie','Food','100.00');
INSERT into entertainer
    values ('3333333337','Kobe Bryant','Motivation','5000.00');
INSERT into entertainer
    values ('3333333338','The Beatles','Music','1250.00');
INSERT into entertainer
    values ('3333333339','Jim Carrey','Comedy','4500.00');
INSERT into entertainer
    values ('3333333340','Katy Perry','Music','1000.00');
    
    
-- Performance records
INSERT into performance
    values ('3333333331','1302358754','01-JAN-2021','Rap Music Concert',120);
INSERT into performance
    values ('3333333332','1302358754','01-JAN-2021','Pop Music Concert',120);
INSERT into performance
    values ('3333333333','1023479589','10-JAN-2021','Stand-Up Comedy',60);
INSERT into performance
    values ('3333333334','1548235458','15-JAN-2021','Painting Walkthrough',60);
INSERT into performance
    values ('3333333335','1245236527','20-JAN-2021','Motivational Speech',60);
INSERT into performance
    values ('3333333336','1420325412','25-JAN-2021','Food Eating',30);
INSERT into performance
    values ('3333333337','1478451201','01-FEB-2021','Motivational Speech',90);
INSERT into performance
    values ('3333333338','1369869563','05-FEB-2021','Oldschool Music Concert',120);
INSERT into performance
    values ('3333333339','1478546528','15-FEB-2021','Stand-Up Comedy',120);
INSERT into performance
    values ('3333333340','1478546528','15-FEB-2021','Pop Music Concert',120);

-- DESCRIBE statements
DESCRIBE EMPLOYEE;
DESCRIBE RESERVATION;
DESCRIBE PAYMENT;
DESCRIBE BUSINESS;
DESCRIBE CUSTOMER;
DESCRIBE MARKETINGOFFICE;
DESCRIBE CATERER;
DESCRIBE SUPPLIER;
DESCRIBE ORDER;
DESCRIBE RESERVEDCATERING;
DESCRIBE VENUE;
DESCRIBE SECURITYGUARD;
DESCRIBE ENTERTAINER;
DESCRIBE PERFORMANCE;

-- SELECT * statements
SELECT * FROM EMPLOYEE;
SELECT * FROM RESERVATION;
SELECT * FROM PAYMENT;
SELECT * FROM BUSINESS;
SELECT * FROM CUSTOMER;
SELECT * FROM MARKETINGOFFICE;
SELECT * FROM CATERER;
SELECT * FROM SUPPLIER;
SELECT * FROM "ORDER";
SELECT * FROM RESERVEDCATERING;
SELECT * FROM VENUE;
SELECT * FROM SECURITYGUARD;
SELECT * FROM ENTERTAINER;
SELECT * FROM PERFORMANCE;


-- FINAL PHASE SQL Statements --------------------------------------------------

/* Question 1
Team member: Ryan Melenchuk             Quality Checker: Entire group
*/

SELECT employeeid, firstname ||' '|| lastname AS FULL_NAME, salary, hiredate
FROM employee
WHERE salary >= 100000;

/* Results:

EMPLOYEEID FULL_NAME                                     SALARY HIREDATE 
---------- ----------------------------------------- ---------- ---------
1000000002 Joe Schmoe                                    120000 21-SEP-20
1000000023 Bob Moss                                   183240.23 29-OCT-82
1000000016 Kobe Pryant                                240000.08 26-JAN-20
1000000091 Freddie Ammonium                              419300 24-NOV-91
1000000105 Marilyn Jacksonville                       100243.76 09-MAR-01
1000000009 Albert Einstein                             173004.2 13-AUG-82

6 rows selected. 

*/
/* Question 2
Team member: Ryan Melenchuk             Quality Checker: Entire group
*/

SELECT employeeid, firstname ||' '|| lastname AS FULL_NAME, hiredate
FROM employee
WHERE hiredate BETWEEN '01-JAN-2010' AND '31-DEC-2020';

/* Results:

EMPLOYEEID FULL_NAME                                 HIREDATE 
---------- ----------------------------------------- ---------
1000000002 Joe Schmoe                                21-SEP-20
1000000016 Kobe Pryant                               26-JAN-20
1000000117 Muhammad Balli                            03-NOV-16

*/
/* Question 3
Team member: Ryan Melenchuk             Quality Checker Entire group
*/

SELECT marketofficeid, companyname, city, state
FROM marketingoffice
WHERE companyname LIKE '%Marketing Firm';

/* Results:

MARKETOFFI COMPANYNAME                                        CITY                                               ST
---------- -------------------------------------------------- -------------------------------------------------- --
0000000001 Melenchuk Marketing Firm                           West Lafayette                                     IN
0000000002 Dhuper Marketing Firm                              West Lafayette                                     IN
0000000003 Mahedy Marketing Firm                              West Lafayette                                     IN
0000000004 Smith Marketing Firm                               West Lafayette                                     IN

*/
/* Question 4
Team member: Ryan Melenchuk             Quality Checker: Entire group
*/

SELECT supplierid, companyname, unitsinstock, costperunit, (unitsinstock*costperunit) AS SUBTOTAL
FROM supplier
GROUP BY supplierid, companyname, unitsinstock, costperunit;

/* Results:

SUPPLIERID COMPANYNAME                                        UNITSINSTOCK COSTPERUNIT   SUBTOTAL
---------- -------------------------------------------------- ------------ ----------- ----------
2939493295 Chicken Natural                                              50          10        500
4596670948 Deans                                                        75           5        375
2122968342 Brennans                                                     30          11        330
4566778990 Beef Mart                                                    25          30        750
8776545654 Cold Stone                                                   23           9        207
9960543454 Rays Sea Food                                                35          40       1400
5554987656 Bread Basket                                                100           4        400
6578100922 Vs Vegtables                                                105           8        840
3434868568 Furniture Land                                               50          20       1000
8785868568 Sallys Silverware                                            73           6        438

10 rows selected. 

*/
/* Question 5
Team member: Ryan Melenchuk             Quality Checker: Entire group
*/

SELECT businessid, name, address, city, state, country, zipcode
FROM business
WHERE state NOT IN 'CA';

/* Results:

BUSINESSID NAME                           ADDRESS                                  CITY                                               ST COUNTRY                                            ZIPCO
---------- ------------------------------ ---------------------------------------- -------------------------------------------------- -- -------------------------------------------------- -----
0000000004 Monsters Inc.                  4 Infinite Loop                          West Lafayette                                     IN United States                                      42314
0000000005 Dunder Mifflin                 500 N. NBC Dr.                           Scranton                                           PA United States                                      23414
0000000006 Caterpillar                    342 Finitte Loop                         Chicago                                            IL United States                                      95414
0000000007 Boeing                         123 Lakeshore Dr.                        Seattle                                            WA United States                                      95325
0000000008 University of Illinois         234 Corfield Blvd.                       Champaign                                          IL United States                                      95344
0000000009 Commvault                      1 Commvault Way                          Tinton Falls                                       NJ United States                                      07724
0000000010 Oscorp Industries              4 road st.                               Newark                                             NJ United States                                      25419

7 rows selected. 

*/
/* Question 6
Team member: Ryan Melenchuk             Quality Checker: Entire group
*/

SELECT securityid, rpad(lastname, 20, '#') AS LASTNAME, clearancelevel, NVL(venue_venueid, 'None') AS VENUEID
FROM securityguard;

/* Results:

SECURITYID LASTNAME             C VENUEID   
---------- -------------------- - ----------
2222222221 Vejzovic############ 1 1111111113
2222222222 Melenchuk########### 2 1111111112
2222222223 Dhuper############## 3 1111111115
2222222224 Mehedy############## 4 1111111114
2222222225 Smith############### 2 None      
2222222226 Doe################# 3 None      
2222222227 Pete################ 4 1111111115
2222222228 Claus############### 5 1111111116
2222222229 Johnson############# 6 1111111117
2222222230 Jackson############# 7 1111111118

10 rows selected. 

*/
/* Question 7
Team member: Ryan Melenchuk             Quality Checker: Entire group
*/

SELECT employeeid, (lastname ||', '|| firstname) AS FULL_NAME, min(hiredate), salary
FROM employee
WHERE hiredate IN (SELECT min(hiredate) FROM employee)
GROUP BY employeeid, lastname, firstname, salary;

/* Results:

EMPLOYEEID FULL_NAME                                  MIN(HIRED     SALARY
---------- ------------------------------------------ --------- ----------
1000000047 Parsley, Elvis                             06-FEB-77   70042.05

*/
/* Question 8
Team member: Ryan Melenchuk             Quality Checker: Entire group
*/

SELECT genre, count(genre) AS COUNT
FROM entertainer
GROUP BY genre;

/* Results:

GENRE                     COUNT
-------------------- ----------
Food                          1
Artist                        1
Motivation                    2
Comedy                        2
Music                         4

*/
/*******************************************
Question 9

Creator: Jack Mahedy
Quality Check: Entire group
*/

SELECT SUM(purchasedamount*cost) AS Total_Order
FROM "ORDER";

--Results
/*
TOTAL_ORDER
-----------
 10568497.3
*/

/********************************************
Question 10

Creator: Jack Mahedy
Quality Check: Entire group
*/

SELECT genre, AVG(billingrate)
FROM entertainer
GROUP BY genre;

--Results
/*
GENRE                AVG(BILLINGRATE)
-------------------- ----------------
Food                              100
Artist                           2500
Motivation                       2550
Comedy                           2750
Music                          2687.5
*/

/********************************************
Question 11

Creator: Jack Mahedy
Quality Check: Entire group
*/

SELECT paymentmethod, AVG(price)
FROM payment
GROUP BY paymentmethod
HAVING AVG(price) > 1000;

--Results
/*
PAYMENTMETHOD        AVG(PRICE)
-------------------- ----------
Debit                   4862.87
Cash                    1269.96
Credit                 1863.304
*/
/********************************************
Question 12

Creator: Jack Mahedy
Quality Check: Entire group
*/

SELECT paymentmethod, AVG(price)
FROM payment
WHERE paymentmethod = 'Credit'
GROUP BY paymentmethod
HAVING AVG(price) > 500;

--Results
/*
PAYMEN AVG(PRICE)
------ ----------
Credit   1863.304
*/

/********************************************
Question 13

Creator: Jack Mahedy
Quality Check: Entire group
*/

SELECT c.catererid, c.staffsize, r.cost
FROM caterer c INNER JOIN reservedcatering r
ON c.catererid = r.caterer_catererid
WHERE c.staffsize > 10 AND r.cost > 1000;

--Results
/*
CATERERID  STA       COST
---------- --- ----------
5839234435 17        1200
2321256777 15        1450
1211186790 24        1700
1211186790 24        1800
6766834456 25        1900
3275968473 35        2300
3275968473 35        2500

7 rows selected.
*/
/********************************************
Question 14

Creator: Jack Mahedy
Quality Check: Entire group
*/

SELECT r.reservation_reservationid, c.catererid, TO_CHAR(orderdate, 'FMday, Month DD,YYYY')
FROM supplier s INNER JOIN "ORDER" 
ON s.supplierid = "ORDER".supplier_supplierid
INNER JOIN caterer c
ON c.catererid = "ORDER".caterer_catererid
INNER JOIN reservedcatering r
ON c.catererid = r.caterer_catererid;

--Results
/*
RESERVATIO CATERERID  TO_CHAR(ORDERDATE,'FMDAY,MON
---------- ---------- ----------------------------
1023479589 3275968473 thursday, June 3,2021       
1023479589 3275968473 tuesday, May 25,2021        
1478546528 3275968473 thursday, June 3,2021       
1478546528 3275968473 tuesday, May 25,2021        
1548235458 5839234435 sunday, January 10,2021     
1548235458 5839234435 thursday, January 14,2021   
1548235458 6766834456 sunday, March 7,2021        
1548235458 6766834456 tuesday, April 13,2021      

8 rows selected.
*/
/********************************************
Question 15

Creator: Jack Mahedy
Quality Check: Entire group
*/

SELECT name, address
FROM business
WHERE address NOT IN (SELECT address
                      FROM customer);
--Results
/*
NAME                           ADDRESS                                 
------------------------------ ----------------------------------------
The Walt Disney Company        3 Infinite Loop                         
Dunder Mifflin                 500 N. NBC Dr.                          
Commvault                      1 Commvault Way                         
University of Illinois         234 Corfield Blvd.                      
Oscorp Industries              4 road st.
*/
/********************************************
Question 16

Creator: Jack Mahedy
Quality Check: Entire group
*/

SELECT orderdate, cost
FROM "ORDER"
WHERE cost > (SELECT AVG(cost)
              FROM "ORDER");

--Results
/*
ORDERDATE       COST
--------- ----------
13-APR-21    2800.23
25-MAY-21    3100.23
03-JUN-21    3900.32
14-JUL-21    4400.23
*/
/*
17.
Creator: Amel Vejzovic
Quality Checker: Entire group
*/

select r.reservation_reservationid, sum(r.cost) AS TotalCost, c.menu
from caterer c INNER JOIN reservedcatering r
ON c.catererid = r.caterer_catererid
Group by r.reservation_reservationid, c.menu;

/* Results:

    RESERVATIO  TOTALCOST MENU                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
    ---------- ---------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    1302358754       1700 Nachos, Bacon Burgers, Cheese Cake                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
    1548235458       1200 Tuna Tar Tar, NY Strip Steak, Vanilla Ice cream                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
    1420325412       1450 Caesar Salad, Grilled Chicken, Chocolate Ice Cream                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
    1369869563        750 Dumplings, Lamb Chop, Churros                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
    1023479589       2500 Tacos, Spaghetti Bolognese, Tiramisu                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
    1478546528        900 Dumplings, Lamb Chop, Churros                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
    1478546528       2300 Tacos, Spaghetti Bolognese, Tiramisu                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
    1023479589       1800 Nachos, Bacon Burgers, Cheese Cake                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
    1548235458        800 Caesar Salad, Grilled Chicken, Chocolate Ice Cream                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
    1548235458       1900 Onion Rings, Spicy Chicken Wrap, Key Lime Pie                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
    
    10 rows selected. 

*/
/*
18.
Creator: Amel Vejzovic
Quality Checker: Entire group
*/

select venueid, v.name, s.securityid
from venue v LEFT JOIN securityguard s
ON v.venueid = s.venue_venueid
where s.securityid IS NOT NULL;

/* Results:

VENUEID    NAME                 SECURITYID
---------- -------------------- ----------
1111111113 Amel Center          2222222221
1111111112 Ryan Hall            2222222222
1111111115 Karty Hall           2222222223
1111111114 Jack Room            2222222224
1111111115 Karty Hall           2222222227
1111111116 Elliot Hall          2222222228
1111111117 Chauncey Center      2222222229
1111111118 Book Center          2222222230

8 rows selected. 

*/
/*
19. 
Creator: Amel Vejzovic
Quality Checker: Entire group
*/

select customerid, c.emailaddress, businessid
from business b RIGHT JOIN customer c
ON b.businessid = c.business_businessid
where businessid IS NOT NULL;

/* Results:

CUSTOMERID EMAILADDRESS                   BUSINESSID
---------- ------------------------------ ----------
0000000012 joshb@dundermifflin.com        0000000005
0000000001 tcook@apple.com                0000000001
0000000002 nchorris@apple.com             0000000002
0000000004 mwazowski@roar.com             0000000004
0000000006 jmahedy@caterpillar.com        0000000006
0000000007 rmelen@boeing.com              0000000007
0000000009 asmith@roar.com                0000000009

7 rows selected. 

*/
/*
20. 
Creator: Amel Vejzovic
Quality Checker: Entire group
*/

select name
from ENTERTAINER
UNION
select companyname
from marketingoffice;

/* Results:

NAME                                              
--------------------------------------------------
Bob Ross
Deloitte Digital
Dentsu
Dhuper Marketing Firm
Epsilon
Havas
Jim Carrey
Kanye West
Katy Perry
Kevin Hart
Kobe Bryant

NAME                                              
--------------------------------------------------
Leo Burnett
Mahedy Marketing Firm
Matt Stonie
Melenchuk Marketing Firm
Nick Vujicic
Ogilvy
Smith Marketing Firm
Taylor Swift
The Beatles

20 rows selected. 

*/
/*
21.
Creator: Amel Vejzovic
Quality Checker: Entire group
*/

select city
from business
INTERSECT
select city
from venue;

/* Results:

CITY                                              
--------------------------------------------------
West Lafayette

*/
/*
22. 
Creator: Amel Vejzovic
Quality Checker: Entire group
*/

select clearancelevel
from securityguard
where firstname = 'Amel';

UPDATE SecurityGuard
set clearancelevel = '2'
where firstname = 'Amel';

/* Results:

C
-
1


1 row updated.


C
-
2

I updated a security guard's clearance level from 1 to 2.
*/
/*
23.
Creator: Amel Vejzovic
Quality Checker: Entire group
*/

select *
from securityguard;

UPDATE SecurityGuard
set clearancelevel = '2';

/* Results:

SECURITYID FIRSTNAME            LASTNAME             C VENUE_VENU
---------- -------------------- -------------------- - ----------
2222222221 Amel                 Vejzovic             2 1111111113
2222222222 Ryan                 Melenchuk            2 1111111112
2222222223 Karty                Dhuper               3 1111111115
2222222224 Jack                 Mehedy               4 1111111114
2222222225 John                 Smith                2           
2222222226 John                 Doe                  3           
2222222227 Purdue               Pete                 4 1111111115
2222222228 Santa                Claus                5 1111111116
2222222229 Danny                Johnson              6 1111111117
2222222230 Joey                 Jackson              7 1111111118

10 rows selected. 


10 rows updated.


SECURITYID FIRSTNAME            LASTNAME             C VENUE_VENU
---------- -------------------- -------------------- - ----------
2222222221 Amel                 Vejzovic             2 1111111113
2222222222 Ryan                 Melenchuk            2 1111111112
2222222223 Karty                Dhuper               2 1111111115
2222222224 Jack                 Mehedy               2 1111111114
2222222225 John                 Smith                2           
2222222226 John                 Doe                  2           
2222222227 Purdue               Pete                 2 1111111115
2222222228 Santa                Claus                2 1111111116
2222222229 Danny                Johnson              2 1111111117
2222222230 Joey                 Jackson              2 1111111118

10 rows selected. 

I changed all the security guard's clearance levels to 2.
*/
/*
********************************************************************************
Query 24
Creator: Karty Dhuper
Quality Checker: Entire group
*/

SELECT * FROM CUSTOMER; 

INSERT INTO CUSTOMER(customerid, address, phonenum, emailaddress, firstname, lastname, business_businessid)
    VALUES('0000000011', '32 S. Golden Loop', '3256212356', 'kdhuper@disney.com', 'Karty2', 'Dhuper2', '0000000003');
INSERT INTO CUSTOMER(customerid, address, phonenum, emailaddress, firstname, lastname, business_businessid)
    VALUES('0000000012', '56 N. Garden Loop', '1454623421', 'joshb@dundermifflin.com', 'Josh', 'Brolin', '0000000005');

/* Results:

This query adds 2 new customers to the customer table. One of which is 
from the Walt Disney Company and the other is from Dunder Mifflin. 
 
--> Before:

    CUSTOMERID ADDRESS                                  PHONENUM   EMAILADDRESS                   FIRSTNAME            LASTNAME             BUSINESS_B
    ---------- ---------------------------------------- ---------- ------------------------------ -------------------- -------------------- ----------
    0000000001 1 Infinite Loop                          1234567891 tcook@apple.com                Tim                  Cook                 0000000001
    0000000002 2 Infinite Loop                          1594237461 nchorris@apple.com             Nuck                 Chorris              0000000002
    0000000003 500 N. Martin Jischke Dr.                2344523491 rboss@gmail.com                Ross                 Bob                            
    0000000004 4 Infinite Loop                          4206696238 mwazowski@roar.com             Mike                 Wazowski             0000000004
    0000000005 244 Salisbury Ave.                       9876543219 kdhuper@purdue.edu             Karty                Dhuper                         
    0000000006 342 Finitte Loop                         6546547891 jmahedy@caterpillar.com        Jack                 Mahedy               0000000006
    0000000007 123 Lakeshore Dr.                        3534525434 rmelen@boeing.com              Ryan                 Melenchuk            0000000007
    0000000008 500 N. Martin Jischke Dr.                2344523491 rboss8@gmail.com               Ross                 Bob                            
    0000000009 1 Commvault Dr.                          9876123459 asmith@roar.com                Amel                 Smith                0000000009
    0000000010 244 Aspire Blvd.                         6767672342 sclause@purdue.edu             Santa                Clause                         

    10 rows selected. 

--> RESULT:
    1 row inserted.
    1 row inserted.
    
--> After:

    CUSTOMERID ADDRESS                                  PHONENUM   EMAILADDRESS                   FIRSTNAME            LASTNAME             BUSINESS_B
    ---------- ---------------------------------------- ---------- ------------------------------ -------------------- -------------------- ----------
    0000000011 32 S. Golden Loop                        3256212356 kdhuper@disney.com             Karty2               Dhuper2              0000000003
    0000000012 56 N. Garden Loop                        1454623421 joshb@dundermifflin.com        Josh                 Brolin               0000000005
    0000000001 1 Infinite Loop                          1234567891 tcook@apple.com                Tim                  Cook                 0000000001
    0000000002 2 Infinite Loop                          1594237461 nchorris@apple.com             Nuck                 Chorris              0000000002
    0000000003 500 N. Martin Jischke Dr.                2344523491 rboss@gmail.com                Ross                 Bob                            
    0000000004 4 Infinite Loop                          4206696238 mwazowski@roar.com             Mike                 Wazowski             0000000004
    0000000005 244 Salisbury Ave.                       9876543219 kdhuper@purdue.edu             Karty                Dhuper                         
    0000000006 342 Finitte Loop                         6546547891 jmahedy@caterpillar.com        Jack                 Mahedy               0000000006
    0000000007 123 Lakeshore Dr.                        3534525434 rmelen@boeing.com              Ryan                 Melenchuk            0000000007
    0000000008 500 N. Martin Jischke Dr.                2344523491 rboss8@gmail.com               Ross                 Bob                            
    0000000009 1 Commvault Dr.                          9876123459 asmith@roar.com                Amel                 Smith                0000000009
    
    CUSTOMERID ADDRESS                                  PHONENUM   EMAILADDRESS                   FIRSTNAME            LASTNAME             BUSINESS_B
    ---------- ---------------------------------------- ---------- ------------------------------ -------------------- -------------------- ----------
    0000000010 244 Aspire Blvd.                         6767672342 sclause@purdue.edu             Santa                Clause                         
    
    12 rows selected. 

*/
/*
********************************************************************************
Query 25:
Creator: Karty Dhuper
Quality Checker: Entire group
*/

SELECT * FROM CUSTOMER;

DELETE FROM CUSTOMER
    WHERE customerid = '0000000011';

/* Results:

Employee 0000000011 was deleted from the Customer table because the details
provided for them had already been used for a previous customer.

--> BEFORE:

CUSTOMERID ADDRESS                                  PHONENUM   EMAILADDRESS                   FIRSTNAME            LASTNAME             BUSINESS_B
---------- ---------------------------------------- ---------- ------------------------------ -------------------- -------------------- ----------
0000000011 32 S. Golden Loop                        3256212356 kdhuper@disney.com             Karty2               Dhuper2              0000000003
0000000012 56 N. Garden Loop                        1454623421 joshb@dundermifflin.com        Josh                 Brolin               0000000005
0000000001 1 Infinite Loop                          1234567891 tcook@apple.com                Tim                  Cook                 0000000001
0000000002 2 Infinite Loop                          1594237461 nchorris@apple.com             Nuck                 Chorris              0000000002
0000000003 500 N. Martin Jischke Dr.                2344523491 rboss@gmail.com                Ross                 Bob                            
0000000004 4 Infinite Loop                          4206696238 mwazowski@roar.com             Mike                 Wazowski             0000000004
0000000005 244 Salisbury Ave.                       9876543219 kdhuper@purdue.edu             Karty                Dhuper                         
0000000006 342 Finitte Loop                         6546547891 jmahedy@caterpillar.com        Jack                 Mahedy               0000000006
0000000007 123 Lakeshore Dr.                        3534525434 rmelen@boeing.com              Ryan                 Melenchuk            0000000007
0000000008 500 N. Martin Jischke Dr.                2344523491 rboss8@gmail.com               Ross                 Bob                            
0000000009 1 Commvault Dr.                          9876123459 asmith@roar.com                Amel                 Smith                0000000009

CUSTOMERID ADDRESS                                  PHONENUM   EMAILADDRESS                   FIRSTNAME            LASTNAME             BUSINESS_B
---------- ---------------------------------------- ---------- ------------------------------ -------------------- -------------------- ----------
0000000010 244 Aspire Blvd.                         6767672342 sclause@purdue.edu             Santa                Clause                         

12 rows selected. 

--> RESULT:

1 row deleted.

--> AFTER:

CUSTOMERID ADDRESS                                  PHONENUM   EMAILADDRESS                   FIRSTNAME            LASTNAME             BUSINESS_B
---------- ---------------------------------------- ---------- ------------------------------ -------------------- -------------------- ----------
0000000012 56 N. Garden Loop                        1454623421 joshb@dundermifflin.com        Josh                 Brolin               0000000005
0000000001 1 Infinite Loop                          1234567891 tcook@apple.com                Tim                  Cook                 0000000001
0000000002 2 Infinite Loop                          1594237461 nchorris@apple.com             Nuck                 Chorris              0000000002
0000000003 500 N. Martin Jischke Dr.                2344523491 rboss@gmail.com                Ross                 Bob                            
0000000004 4 Infinite Loop                          4206696238 mwazowski@roar.com             Mike                 Wazowski             0000000004
0000000005 244 Salisbury Ave.                       9876543219 kdhuper@purdue.edu             Karty                Dhuper                         
0000000006 342 Finitte Loop                         6546547891 jmahedy@caterpillar.com        Jack                 Mahedy               0000000006
0000000007 123 Lakeshore Dr.                        3534525434 rmelen@boeing.com              Ryan                 Melenchuk            0000000007
0000000008 500 N. Martin Jischke Dr.                2344523491 rboss8@gmail.com               Ross                 Bob                            
0000000009 1 Commvault Dr.                          9876123459 asmith@roar.com                Amel                 Smith                0000000009
0000000010 244 Aspire Blvd.                         6767672342 sclause@purdue.edu             Santa                Clause                         

11 rows selected. 

*/
/*
********************************************************************************
Query 26:
Creator: Karty Dhuper
Quality Checker: Entire group
*/

DESCRIBE CUSTOMER;

ALTER TABLE CUSTOMER
    ADD Region char(25); 

/* Results:

A new attribute called Region was added to store the region the customer is from.

--> BEFORE: 

Name                Null?    Type         
------------------- -------- ------------ 
CUSTOMERID          NOT NULL CHAR(10)     
ADDRESS                      VARCHAR2(40) 
PHONENUM                     CHAR(10)     
EMAILADDRESS                 VARCHAR2(30) 
FIRSTNAME           NOT NULL VARCHAR2(20) 
LASTNAME            NOT NULL VARCHAR2(20) 
BUSINESS_BUSINESSID          CHAR(10)     

--> RESULT:

Table CUSTOMER altered.

--> AFTER:

Name                Null?    Type         
------------------- -------- ------------ 
CUSTOMERID          NOT NULL CHAR(10)     
ADDRESS                      VARCHAR2(40) 
PHONENUM                     CHAR(10)     
EMAILADDRESS                 VARCHAR2(30) 
FIRSTNAME           NOT NULL VARCHAR2(20) 
LASTNAME            NOT NULL VARCHAR2(20) 
BUSINESS_BUSINESSID          CHAR(10)     
REGION                       CHAR(25)     

*/
/*
********************************************************************************
Query 27:
Creator: Karty Dhuper
Quality Checker: Entire group
*/

SELECT Region 
FROM CUSTOMER;

UPDATE CUSTOMER
    SET Region = 'USA';

/* Results:

This query adds a region to each customer.

--> BEFORE: 
      REGION                   
    -------------------------
  
  
  
  
  
  
  
  
  
  
  
  
    11 rows selected. 

--> RESULT:

    11 rows updated.

--> AFTER: 

    REGION                   
    -------------------------
    USA                      
    USA                      
    USA                      
    USA                      
    USA                      
    USA         
    USA
    USA
    USA                      
    USA                      
    USA                      
    
    11 rows selected. 

*/
/*
********************************************************************************
Query 28:
Creator: Karty Dhuper
Quality Checker: Entire group
*/

SELECT Region 
FROM CUSTOMER;

UPDATE CUSTOMER
    SET Region = 'Ireland'
    WHERE SUBSTR(phonenum,1,3) = '353';

/* Results:

--> BEFORE: 
    
    REGION                   
    -------------------------
    USA                      
    USA                      
    USA                      
    USA                      
    USA                      
    USA                      
    USA                      
    USA                      
    USA                      
    USA                      
    USA                      
    
    11 rows selected. 

--> RESULT:

1 row updated.

--> AFTER:
    
    REGION                   
    -------------------------
    USA                      
    USA                      
    USA                      
    USA                      
    USA                      
    USA                      
    USA                      
    Ireland                  
    USA                      
    USA                      
    USA                      
    
    11 rows selected. 

*/
/*
********************************************************************************
Query 29:
Creator: Karty Dhuper
Quality Checker: Entire group
*/

CREATE VIEW american_customers AS 
SELECT FirstName, LastName, PhoneNum
FROM CUSTOMER 
WHERE Region = 'USA';

CREATE INDEX LastName_InversionEntry
    ON CUSTOMER(LastName);
    
CREATE UNIQUE INDEX Name_AlternateKey
    ON CUSTOMER(Lastname, emailaddress);

SELECT * FROM american_customers;

/* Results:

--> RESULT:
 
    View AMERICAN_CUSTOMERS created.

    Index LASTNAME_INVERSIONENTRY created.
    
    INDEX NAME_ALTERNATEKEY created.


    FIRSTNAME            LASTNAME             PHONENUM  
    -------------------- -------------------- ----------
    Josh                 Brolin               1454623421
    Tim                  Cook                 1234567891
    Nuck                 Chorris              1594237461
    Ross                 Bob                  2344523491
    Mike                 Wazowski             4206696238
    Karty                Dhuper               9876543219
    Jack                 Mahedy               6546547891
    Ross                 Bob                  2344523491
    Amel                 Smith                9876123459
    Santa                Clause               6767672342
    
    10 rows selected. 
    
*/
/*
********************************************************************************
Query 30:
Creator: Karty Dhuper
Quality Checker: Entire group
*/

SELECT Region 
FROM CUSTOMER;

UPDATE CUSTOMER
    SET Region = 'Minneapolis'
    WHERE SUBSTR(phonenum, 1, 3) = '654';

/* Results:

--> BEFORE: 
        
    REGION                   
    -------------------------
    USA                      
    USA                      
    USA                      
    USA                      
    USA                      
    USA                      
    USA                      
    Ireland                  
    USA                      
    USA                      
    USA                      
    
    11 rows selected. 
 
--> RESULT:

    1 row updated.

--> AFTER:

    REGION                   
    -------------------------
    USA                      
    USA                      
    USA                      
    USA                      
    USA                      
    USA                      
    Minneapolis              
    Ireland                  
    USA                      
    USA                      
    USA                      
    
    11 rows selected. 
*/