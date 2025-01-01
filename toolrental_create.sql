

-- Create STORAGE
CREATE TABLESPACE toolrental
  DATAFILE 'toolrental.dat' SIZE 40M 
  ONLINE; 
  
-- Create Users
CREATE USER userAdmin IDENTIFIED BY userAdminPassword ACCOUNT UNLOCK
	DEFAULT TABLESPACE toolrental
	QUOTA 20M ON toolrental;
	
CREATE USER guestUser IDENTIFIED BY guestPassword ACCOUNT UNLOCK
	DEFAULT TABLESPACE toolrental
	QUOTA 5M ON toolrental;
	
-- Grant PRIVILEGES
GRANT CONNECT, RESOURCE, CREATE VIEW, CREATE TRIGGER, CREATE PROCEDURE TO applicationAdmin;
GRANT CONNECT, RESOURCE TO applicationUser;

GRANT applicationAdmin TO userAdmin;
GRANT applicationUser TO guestUser;

CONNECT userAdmin/userAdminPassword;

CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,         
    date_of_birth TIMESTAMP,              
    phone VARCHAR2(15),                        
    email_address VARCHAR2(255) UNIQUE,
    street VARCHAR2(100),                       
    city VARCHAR2(50),                          
    province VARCHAR2(50),                     
    postal_code VARCHAR2(10)                    
);

CREATE TABLE names (
    name_id NUMBER PRIMARY KEY,  
    first_name VARCHAR2(50) NOT NULL,            
    last_name VARCHAR2(50) NOT NULL  
);

CREATE TABLE customer_name (
    customername_id NUMBER PRIMARY KEY,
    customers_customerid NUMBER,
    names_nameid NUMBER,
    startdate TIMESTAMP NOT NULL, 
    enddate TIMESTAMP DEFAULT NULL, 
    FOREIGN KEY (customers_customerid) REFERENCES customers(customer_id),
    FOREIGN KEY (names_nameid) REFERENCES names(name_id)
);

-- Create Rentals Table
CREATE TABLE rentals (
    rental_id NUMBER PRIMARY KEY, 
    start_date TIMESTAMP NOT NULL,                       
    due_date TIMESTAMP NOT NULL, 
    customer_id NUMBER ,         
    order_date TIMESTAMP NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Create Categories Table
CREATE TABLE categories (
    category_id NUMBER PRIMARY KEY,  
    category_name VARCHAR2(50) NOT NULL        
);

-- Create Tools Table
CREATE TABLE tools (
    tool_id NUMBER PRIMARY KEY,               
    tool_name VARCHAR2(50) NOT NULL,                   
    rental_price_per_day NUMBER(10, 2) NOT NULL,      
    dimensions VARCHAR2(30),                                     
    weight_lbs NUMBER(10, 2)
);

-- Create Tool Categories Table
CREATE TABLE tool_categories (
    categories_id NUMBER NOT NULL,      
    tool_id NUMBER NOT NULL,            
    PRIMARY KEY (categories_id, tool_id),  
    FOREIGN KEY (categories_id) REFERENCES categories(category_id),  
    FOREIGN KEY (tool_id) REFERENCES tools(tool_id)                   
);

-- Create Rental Lines Table
CREATE TABLE rental_lines (
    rental_line_id NUMBER PRIMARY KEY,       
    rental_id NUMBER NOT NULL,                            
    tool_id NUMBER NOT NULL,
    tax NUMBER(10, 2) NOT NULL,  
    FOREIGN KEY (rental_id) REFERENCES rentals(rental_id),   
    FOREIGN KEY (tool_id) REFERENCES tools(tool_id)
);

-- Create Returns Table
CREATE TABLE returns (
    rental_line_id NUMBER PRIMARY KEY, 
    returned_date TIMESTAMP NOT NULL,                    
    condition VARCHAR2(50),                            
    penalty_fee NUMBER(10, 2),                      
    FOREIGN KEY (rental_line_id) REFERENCES rental_lines(rental_line_id)
);

-- Create Power Tools Table
CREATE TABLE power_tools (
    tool_id NUMBER PRIMARY KEY,         
    battery_type VARCHAR2(30),                  
    power_rating_watts NUMBER(10, 2),          
    voltage_volts NUMBER(10, 2),                      
    FOREIGN KEY (tool_id) REFERENCES tools(tool_id)
);


/*INSERT STATEMENT*/

INSERT INTO customers (customer_id, phone, email_address, date_of_birth, street, city, province, postal_code)
VALUES (101, '1-613-483-9701', 'doe011@gmail.com', TO_TIMESTAMP('1995-09-15 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '628 George Ave', 'Ottawa', 'ON', 'K1N 1X8');

INSERT INTO customers (customer_id, phone, email_address, date_of_birth, street, city, province, postal_code)
VALUES (102, '1-264-374-7442', 'sAnne98@gmail.com', TO_TIMESTAMP('1980-07-18 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '234 Pine Dr', 'Ottawa', 'ON', 'V6M 0A2');

INSERT INTO customers (customer_id, phone, email_address, date_of_birth, street, city, province, postal_code)
VALUES (103, '1-264-374-7443', 'tran0023@gmail.com', TO_TIMESTAMP('1981-01-29 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '872 Cedar Ln', 'Ottawa', 'ON', 'K9A 0M2');

INSERT INTO customers (customer_id, phone, email_address, date_of_birth, street, city, province, postal_code)
VALUES (104, '1-264-374-7444', 'jon123@gmail.com', TO_TIMESTAMP('1987-08-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '999 Birch Way', 'Ottawa', 'ON', 'K5A 5A7');

INSERT INTO customers (customer_id, phone, email_address, date_of_birth, street, city, province, postal_code)
VALUES (105, '1-264-374-7445', 'roc345@gmail.com', TO_TIMESTAMP('1990-11-13 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '212 Ash St', 'Ottawa', 'ON', 'K6G 2R3');

INSERT INTO customers (customer_id, phone, email_address, date_of_birth, street, city, province, postal_code)
VALUES (106, '1-264-374-7446', 'Lin333@gmail.com', TO_TIMESTAMP('1991-03-18 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '345 Poplar St', 'Ottawa', 'ON', 'V3Z 2Y7');

INSERT INTO customers (customer_id, phone, email_address, date_of_birth, street, city, province, postal_code)
VALUES (107, '1-264-374-7447', 'wils27889@gmail.com', TO_TIMESTAMP('1989-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '19 Spruce Blvd', 'Ottawa', 'ON', 'M1V 0A6');

INSERT INTO customers (customer_id, phone, email_address, date_of_birth, street, city, province, postal_code)
VALUES (108, '1-264-374-7448', 'hailey23456@gmail.com', TO_TIMESTAMP('1993-03-04 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '923 Clarent St', 'Ottawa', 'ON', 'K8V 3K7');

INSERT INTO customers (customer_id, phone, email_address, date_of_birth, street, city, province, postal_code)
VALUES (109, '1-264-374-7449', 'emdon12@gmail.com', TO_TIMESTAMP('1995-08-02 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '496 St. Laurent St', 'Ottawa', 'ON', 'K3H 2Y9');

INSERT INTO customers (customer_id, phone, email_address, date_of_birth, street, city, province, postal_code)
VALUES (110, '1-264-374-7450', 'Louis009@gmail.com', TO_TIMESTAMP('1986-12-18 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '207 Walnut Rd', 'Ottawa', 'ON', 'A3B 2Y3');

-- Insert into names table
INSERT INTO names (name_id, first_name, last_name) VALUES (601, 'Donald', 'Doe');
INSERT INTO names (name_id, first_name, last_name) VALUES (602, 'Angle', 'Smith');
INSERT INTO names (name_id, first_name, last_name) VALUES (603, 'Anne', 'Tran');
INSERT INTO names (name_id, first_name, last_name) VALUES (604, 'Joe', 'Johnson');
INSERT INTO names (name_id, first_name, last_name) VALUES (605, 'Mike', 'Rockie');
INSERT INTO names (name_id, first_name, last_name) VALUES (606, 'Rosie', 'Lin');
INSERT INTO names (name_id, first_name, last_name) VALUES (607, 'John', 'Wilson');
INSERT INTO names (name_id, first_name, last_name) VALUES (608, 'Frank', 'Hailey');
INSERT INTO names (name_id, first_name, last_name) VALUES (609, 'Emily', 'Don');
INSERT INTO names (name_id, first_name, last_name) VALUES (610, 'Paris', 'Louis');
INSERT INTO names (name_id, first_name, last_name) VALUES (611, 'Henry', 'Dough');
INSERT INTO names (name_id, first_name, last_name) VALUES (612, 'Marie', 'Coke');

--Insert into customer_name
INSERT INTO customer_name (customername_id, customers_customerid, names_nameid, startdate, enddate) 
VALUES (701, 101, 601, TO_TIMESTAMP('2024-11-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL);

INSERT INTO customer_name (customername_id, customers_customerid, names_nameid, startdate, enddate) 
VALUES (702, 102, 602, TO_TIMESTAMP('2024-11-02 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL);

INSERT INTO customer_name (customername_id, customers_customerid, names_nameid, startdate, enddate) 
VALUES (703, 103, 603, TO_TIMESTAMP('2024-11-03 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-11-09 18:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO customer_name (customername_id, customers_customerid, names_nameid, startdate, enddate) 
VALUES (704, 104, 604, TO_TIMESTAMP('2024-11-04 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL);

INSERT INTO customer_name (customername_id, customers_customerid, names_nameid, startdate, enddate) 
VALUES (705, 105, 605, TO_TIMESTAMP('2024-11-05 08:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-11-11 15:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO customer_name (customername_id, customers_customerid, names_nameid, startdate, enddate) 
VALUES (706, 106, 606, TO_TIMESTAMP('2024-11-06 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL);

INSERT INTO customer_name (customername_id, customers_customerid, names_nameid, startdate, enddate) 
VALUES (707, 107, 607, TO_TIMESTAMP('2024-11-07 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL);

INSERT INTO customer_name (customername_id, customers_customerid, names_nameid, startdate, enddate) 
VALUES (708, 108, 608, TO_TIMESTAMP('2024-11-08 07:30:00', 'YYYY-MM-DD HH24:MI:SS'), NULL);

INSERT INTO customer_name (customername_id, customers_customerid, names_nameid, startdate, enddate) 
VALUES (709, 103, 609, TO_TIMESTAMP('2024-11-09 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL);

INSERT INTO customer_name (customername_id, customers_customerid, names_nameid, startdate, enddate) 
VALUES (710, 109, 610, TO_TIMESTAMP('2024-11-10 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL);

INSERT INTO customer_name (customername_id, customers_customerid, names_nameid, startdate, enddate) 
VALUES (711, 105, 611, TO_TIMESTAMP('2024-11-11 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL);

INSERT INTO customer_name (customername_id, customers_customerid, names_nameid, startdate, enddate) 
VALUES (712, 110, 612, TO_TIMESTAMP('2024-11-12 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL);

-- Insert into rentals
INSERT INTO rentals (rental_id, start_date, due_date, customer_id, order_date) 
VALUES (201, TO_TIMESTAMP('2024-09-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-09-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 104, TO_TIMESTAMP('2024-08-15 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO rentals (rental_id, start_date, due_date, customer_id, order_date) 
VALUES (202, TO_TIMESTAMP('2024-09-04 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-09-12 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 102, TO_TIMESTAMP('2024-08-16 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO rentals (rental_id, start_date, due_date, customer_id, order_date) 
VALUES (203, TO_TIMESTAMP('2024-09-12 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-09-18 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 101, TO_TIMESTAMP('2024-08-16 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO rentals (rental_id, start_date, due_date, customer_id, order_date) 
VALUES (204, TO_TIMESTAMP('2024-09-13 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-09-17 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 103, TO_TIMESTAMP('2024-08-22 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO rentals (rental_id, start_date, due_date, customer_id, order_date) 
VALUES (205, TO_TIMESTAMP('2024-09-16 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-09-20 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 107, TO_TIMESTAMP('2024-08-29 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO rentals (rental_id, start_date, due_date, customer_id, order_date) 
VALUES (206, TO_TIMESTAMP('2024-09-17 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-09-24 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 106, TO_TIMESTAMP('2024-09-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO rentals (rental_id, start_date, due_date, customer_id, order_date) 
VALUES (207, TO_TIMESTAMP('2024-09-18 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-09-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 109, TO_TIMESTAMP('2024-09-09 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO rentals (rental_id, start_date, due_date, customer_id, order_date) 
VALUES (208, TO_TIMESTAMP('2024-09-19 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-09-22 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 108, TO_TIMESTAMP('2024-09-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO rentals (rental_id, start_date, due_date, customer_id, order_date) 
VALUES (209, TO_TIMESTAMP('2024-09-20 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-09-28 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 105, TO_TIMESTAMP('2024-09-11 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO rentals (rental_id, start_date, due_date, customer_id, order_date) 
VALUES (210, TO_TIMESTAMP('2024-09-21 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-09-29 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 110, TO_TIMESTAMP('2024-09-16 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));


--Insert into tools table 
INSERT INTO tools (tool_id, tool_name, rental_price_per_day, dimensions, weight_lbs) VALUES (401, 'Circular Saw S1', 30, '15x9x10 in', 9.5);
INSERT INTO tools (tool_id, tool_name, rental_price_per_day, dimensions, weight_lbs) VALUES (402, 'Electric Screwdriver E1', 15, '8x2x2 in', 1.8);
INSERT INTO tools (tool_id, tool_name, rental_price_per_day, dimensions, weight_lbs) VALUES (403, 'Jigsaw J1', 20, '10x3x7 in', 5);
INSERT INTO tools (tool_id, tool_name, rental_price_per_day, dimensions, weight_lbs) VALUES (404, 'Angle Grinder A1', 25, '16x4x5 in', 6.5);
INSERT INTO tools (tool_id, tool_name, rental_price_per_day, dimensions, weight_lbs) VALUES (405, 'Circular Saw S2', 30, '19x10x9 in', 4.2);
INSERT INTO tools (tool_id, tool_name, rental_price_per_day, dimensions, weight_lbs) VALUES (406, 'Cordless Drill C2', 25, '9x3x8 in', 4.8);
INSERT INTO tools (tool_id, tool_name, rental_price_per_day, dimensions, weight_lbs) VALUES (407, 'Jigsaw J2', 20, '12x6x8 in', 2.5);
INSERT INTO tools (tool_id, tool_name, rental_price_per_day, dimensions, weight_lbs) VALUES (408, 'Hand Saw V1', 5, '26x5x1 in', 1.2);
INSERT INTO tools (tool_id, tool_name, rental_price_per_day, dimensions, weight_lbs) VALUES (409, 'Adjustable Wrench A2', 4, '10x3x1 in', 1);
INSERT INTO tools (tool_id, tool_name, rental_price_per_day, dimensions, weight_lbs) VALUES (410, 'Hammer', 4, '13x5x1.5 in', 1.5);
INSERT INTO tools (tool_id, tool_name, rental_price_per_day, dimensions, weight_lbs) VALUES (411, 'Ball Grip Electric Screwdriver', 7, '8.5x3x3 in', 2.2);
INSERT INTO tools (tool_id, tool_name, rental_price_per_day, dimensions, weight_lbs) VALUES (412, 'Cordless Ratchet Wrenches', 15, '10x3x3 in', 2.8);
INSERT INTO tools (tool_id, tool_name, rental_price_per_day, dimensions, weight_lbs) VALUES (413, 'Rotary Tools R1', 20, '9.5x2x2 in', 1.4);

-- Insert into rental_lines
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (1, 201, 401, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (2, 201, 402, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (3, 201, 403, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (4, 202, 404, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (5, 202, 405, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (6, 202, 406, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (7, 202, 407, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (8, 203, 408, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (9, 203, 409, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (10, 203, 410, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (11, 204, 411, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (12, 204, 412, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (13, 205, 413, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (14, 205, 401, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (15, 206, 402, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (16, 206, 403, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (17, 206, 404, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (18, 207, 405, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (19, 207, 406, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (20, 208, 407, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (21, 208, 408, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (22, 209, 409, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (23, 209, 410, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (24, 209, 411, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (25, 210, 412, 0.13);
INSERT INTO rental_lines (rental_line_id, rental_ID, tool_ID, tax) VALUES (26, 210, 413, 0.13);

-- Insert in returns table
INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (1, TO_TIMESTAMP('2024-09-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 250.00, 'Severely Damage');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (2, TO_TIMESTAMP('2024-09-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0.00, 'Good');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (3, TO_TIMESTAMP('2024-09-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0.00, 'Good');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (4, TO_TIMESTAMP('2024-09-12 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0.00, 'Good');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (5, TO_TIMESTAMP('2024-09-12 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 100.00, 'Partially Damage');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (6, TO_TIMESTAMP('2024-09-12 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0.00, 'Good');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (7, TO_TIMESTAMP('2024-09-12 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 50.00, 'Slightly Damage');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (8, TO_TIMESTAMP('2024-09-18 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0.00, 'Good');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (9, TO_TIMESTAMP('2024-09-18 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0.00, 'Good');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (10, TO_TIMESTAMP('2024-09-18 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0.00, 'Good');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (11, TO_TIMESTAMP('2024-09-17 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 250.00, 'Severely Damage');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (12, TO_TIMESTAMP('2024-09-17 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 250.00, 'Severely Damage');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (13, TO_TIMESTAMP('2024-09-20 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0.00, 'Good');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (14, TO_TIMESTAMP('2024-09-20 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0.00, 'Good');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (15, TO_TIMESTAMP('2024-09-24 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0.00, 'Good');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (16, TO_TIMESTAMP('2024-09-24 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 100.00, 'Partially Damage');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (17, TO_TIMESTAMP('2024-09-24 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0.00, 'Good');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (18, TO_TIMESTAMP('2024-09-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0.00, 'Good');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (19, TO_TIMESTAMP('2024-09-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 100.00, 'Partially Damage');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (20, TO_TIMESTAMP('2024-09-22 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0.00, 'Good');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (21, TO_TIMESTAMP('2024-09-22 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 50.00, 'Slightly Damage');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (22, TO_TIMESTAMP('2024-09-28 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0.00, 'Good');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (23, TO_TIMESTAMP('2024-09-28 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0.00, 'Good');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (24, TO_TIMESTAMP('2024-09-28 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 50.00, 'Slightly Damage');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (25, TO_TIMESTAMP('2024-09-29 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 0.00, 'Good');

INSERT INTO returns (rental_line_id, returned_date, penalty_fee, condition) 
VALUES (26, TO_TIMESTAMP('2024-09-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 100.00, 'Partially Damage');

-- Insert into categories table
INSERT INTO categories (category_id, category_name) VALUES (501, 'Hand_Tools');
INSERT INTO categories (category_id, category_name) VALUES (502, 'Power_Tools');

-- Insert in to tool_categories table
INSERT INTO tool_categories (tool_id, categories_id) VALUES (401, 501);
INSERT INTO tool_categories (tool_id, categories_id) VALUES (402, 501);
INSERT INTO tool_categories (tool_id, categories_id) VALUES (403, 501);
INSERT INTO tool_categories (tool_id, categories_id) VALUES (404, 501);
INSERT INTO tool_categories (tool_id, categories_id) VALUES (405, 501);
INSERT INTO tool_categories (tool_id, categories_id) VALUES (406, 501);
INSERT INTO tool_categories (tool_id, categories_id) VALUES (407, 501);
INSERT INTO tool_categories (tool_id, categories_id) VALUES (408, 502);
INSERT INTO tool_categories (tool_id, categories_id) VALUES (409, 502);
INSERT INTO tool_categories (tool_id, categories_id) VALUES (410, 502);
INSERT INTO tool_categories (tool_id, categories_id) VALUES (411, 501);
INSERT INTO tool_categories (tool_id, categories_id) VALUES (412, 501);
INSERT INTO tool_categories (tool_id, categories_id) VALUES (413, 501);
INSERT INTO tool_categories (tool_id, categories_id) VALUES (411, 502);
INSERT INTO tool_categories (tool_id, categories_id) VALUES (412, 502);
INSERT INTO tool_categories (tool_id, categories_id) VALUES (413, 502);

-- Insert into powertool
INSERT INTO power_tools (tool_id, battery_type, power_rating_watts, voltage_volts) VALUES (401, 'Lithium-Ion', 1200, 120);
INSERT INTO power_tools (tool_id, battery_type, power_rating_watts, voltage_volts) VALUES (402, 'Lithium-Ion', 400, 12);
INSERT INTO power_tools (tool_id, battery_type, power_rating_watts, voltage_volts) VALUES (403, 'Nickel-Cadmium', 500, 120);
INSERT INTO power_tools (tool_id, battery_type, power_rating_watts, voltage_volts) VALUES (404, 'Lithium-Ion', 800, 120);
INSERT INTO power_tools (tool_id, battery_type, power_rating_watts, voltage_volts) VALUES (405, 'Nickel-Cadmium', 1500, 120);
INSERT INTO power_tools (tool_id, battery_type, power_rating_watts, voltage_volts) VALUES (406, 'Lithium-Ion', 600, 18);
INSERT INTO power_tools (tool_id, battery_type, power_rating_watts, voltage_volts) VALUES (407, 'Nickel-Cadmium', 600, 120);
INSERT INTO power_tools (tool_id, battery_type, power_rating_watts, voltage_volts) VALUES (411, 'Lithium-Ion', 200, 6);
INSERT INTO power_tools (tool_id, battery_type, power_rating_watts, voltage_volts) VALUES (412, 'Lithium-Ion', 180, 20);
INSERT INTO power_tools (tool_id, battery_type, power_rating_watts, voltage_volts) VALUES (413, 'Nickel-Cadmium', 150, 12);


-- Create Sequences for Primary Keys starting from 1000

-- Sequence for customers table
CREATE SEQUENCE CUSTOMER_SEQ
    START WITH 1000
    INCREMENT BY 1;

-- Sequence for names table
CREATE SEQUENCE NAMES_SEQ
    START WITH 1000
    INCREMENT BY 1;

-- Sequence for customer_name table
CREATE SEQUENCE CUSTOMER_NAME_SEQ
    START WITH 1000
    INCREMENT BY 1;

-- Sequence for rentals table
CREATE SEQUENCE RENTAL_SEQ
    START WITH 1000
    INCREMENT BY 1;

-- Sequence for tools table
CREATE SEQUENCE TOOL_SEQ
    START WITH 1000
    INCREMENT BY 1;

-- Sequence for categories table
CREATE SEQUENCE CATEGORY_SEQ
    START WITH 1000
    INCREMENT BY 1;

-- Sequence for tool_categories table 
CREATE SEQUENCE TOOL_CATEGORIES_SEQ
    START WITH 1000
    INCREMENT BY 1;

-- Sequence for returns table 
CREATE SEQUENCE RETURN_SEQ
    START WITH 1000
    INCREMENT BY 1;

-- Sequence for power_tools table
CREATE SEQUENCE POWER_TOOL_SEQ
    START WITH 1000
    INCREMENT BY 1;

-- Sequence for rental_lines table 
CREATE SEQUENCE RENTAL_LINES_SEQ
    START WITH 1000
    INCREMENT BY 1;

-- Trigger to auto-increment rental_line_id
CREATE OR REPLACE TRIGGER rental_lines_trigger
BEFORE INSERT ON rental_lines 
FOR EACH ROW
BEGIN
  SELECT rental_lines_seq.NEXTVAL
  INTO   :new.rental_line_id
  FROM   dual;
END;
/

-- Create the customer_view to join customers, customer_name, and names tables
CREATE OR REPLACE VIEW CUSTOMER_VIEW AS
SELECT 
    c.customer_id, 
    c.date_of_birth, 
    c.phone, 
    c.email_address, 
    c.street, 
    c.city, 
    c.province, 
    c.postal_code,
    n.first_name, 
    n.last_name
FROM 
    customers c
JOIN 
    customer_name cn ON c.customer_id = cn.customers_customerid
JOIN 
    names n ON cn.names_nameid = n.name_id
WHERE cn.enddate IS NULL;


CREATE OR REPLACE TRIGGER Customer_View_Trigger
INSTEAD OF INSERT OR UPDATE ON Customer_View
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO customers (customer_id, date_of_birth, phone, email_address, street, city, province, postal_code)
        VALUES (:NEW.customer_id, :NEW.date_of_birth, :NEW.phone, :NEW.email_address, :NEW.street, :NEW.city, :NEW.province, :NEW.postal_code);

        INSERT INTO names (name_id, first_name, last_name)
        VALUES (names_seq.NEXTVAL, :NEW.first_name, :NEW.last_name);

        INSERT INTO customer_name (customername_id, startdate, enddate, customers_customerid, names_nameid)
        VALUES (customer_name_seq.NEXTVAL, SYSDATE, NULL, :NEW.customer_id, names_seq.CURRVAL);
    END IF;

    IF UPDATING THEN
	UPDATE customer_name
	SET enddate = SYSDATE
	WHERE customers_customerid = :OLD.customer_id
  	AND enddate IS NULL;

	INSERT INTO names (name_id, first_name, last_name)
	VALUES (names_seq.NEXTVAL, :NEW.first_name, :NEW.last_name);

        INSERT INTO customer_name (customername_id, startdate, enddate, customers_customerid, names_nameid)
        VALUES (customer_name_seq.NEXTVAL, SYSDATE, NULL, :NEW.customer_id, names_seq.CURRVAL);
    END IF;
END;
/

ALTER TABLE customers
ADD (mark_delete CHAR(1) DEFAULT 'N');

CREATE OR REPLACE TRIGGER instead_of_delete_customer_view
INSTEAD OF DELETE ON CUSTOMER_VIEW
FOR EACH ROW
DECLARE
BEGIN
   UPDATE customer_name
SET enddate = sysdate
WHERE customers_customerid = :old.customer_id
AND enddate IS NULL;

UPDATE customers
SET Mark_delete = 'Y'
WHERE customer_id = :old.customer_id;
END;
/

COMMIT;

-- End of File
