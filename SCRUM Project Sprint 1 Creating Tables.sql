DROP TABLE employee CASCADE CONSTRAINTS PURGE;
DROP TABLE customer CASCADE CONSTRAINTS PURGE;
DROP TABLE item CASCADE CONSTRAINTS PURGE;
DROP TABLE cost_to_make CASCADE CONSTRAINTS PURGE;
DROP TABLE orders CASCADE CONSTRAINTS PURGE ;


CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  emp_name VARCHAR(255) NOT NULL,
  emp_pos VARCHAR(255) NOT NULL,
  emp_phonenum VARCHAR(20),
  monthly_wage INT NOT NULL
);

CREATE TABLE customer (
  cust_id INT PRIMARY KEY,
  cust_firstname VARCHAR2(50) NOT NULL,
  cust_lastname VARCHAR2(50) NOT NULL,
  cust_phonenum VARCHAR2(20),
  payment_method VARCHAR2(10) CHECK (payment_method IN ('Cash', 'Debit','Credit'))
);

CREATE TABLE item (
  item_id INT PRIMARY KEY,
  item_name VARCHAR2(50) NOT NULL,
  item_cat VARCHAR2(50) NOT NULL,
  item_size VARCHAR2(20),
  item_price NUMBER(8,2) NOT NULL
);

CREATE TABLE cost_to_make (
  cost_id INT PRIMARY KEY,
  item_id INT NOT NULL,
  total_cost_to_make NUMBER(8,2) NOT NULL,
  purchase_date DATE,
  CONSTRAINT fk_cost_to_make FOREIGN KEY (item_id) REFERENCES item(item_id)
);

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  emp_id INT,
  order_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  cust_id INT NOT NULL,
  item_id INT NOT NULL,
  quantity INT NOT NULL,
  subtotal_price NUMBER(10,2) NOT NULL,  -- Subtotal before tax
  tax_amount NUMBER(8,2) DEFAULT 0,      -- Tax amount
  total_price NUMBER(10,2) NOT NULL,     -- Total including tax
  delivery VARCHAR2(10) CHECK (delivery IN ('Dine-in', 'Takeout', 'Delivery')),
  CONSTRAINT fk_emp FOREIGN KEY (emp_id) REFERENCES employee(emp_id),
  CONSTRAINT fk_cust FOREIGN KEY (cust_id) REFERENCES customer(cust_id),
  CONSTRAINT fk_item FOREIGN KEY (item_id) REFERENCES item(item_id)
);

--Food items
INSERT INTO item VALUES (3001, 'LOLAS PASTRY BASKET', 'Pastry', 'N/A', 12.99);
INSERT INTO item VALUES(3002, 'ACAI BOWL', 'Breakfast', 'Regular', 9.99);
INSERT INTO item VALUES(3003, 'GRANNYS BREAKFAST SAMMY', 'Breakfast', 'Regular', 8.99);
INSERT INTO item VALUES(3004, 'EGG & TURKEY CROISSANT', 'Breakfast', 'Regular', 7.99);
INSERT INTO item VALUES(3005, 'CLASSIC BREAKFAST', 'Breakfast', 'Regular', 6.99);
INSERT INTO item VALUES(3006, 'VEGGIE SCRAMBLE', 'Breakfast', 'Regular', 8.99);
INSERT INTO item VALUES(3007, 'HOUSE MADE QUICHE', 'Breakfast', 'Slice', 5.99);
INSERT INTO item VALUES(3008, 'CRÈME BRÛLÉE FRENCH TOAST', 'Breakfast', 'Regular', 10.99);
INSERT INTO item VALUES(3009, 'STRAWBERRY SHORTCAKE WAFFLE', 'Breakfast', 'Regular', 11.99);
INSERT INTO item VALUES(3010, 'LETS AVOCUDDLE TOAST', 'Breakfast', 'Regular', 9.99);
INSERT INTO item VALUES(3011, 'BARNEYS UPPER EAST', 'Lunch', 'Regular', 13.99);
INSERT INTO item VALUES(3012, 'BURRATA & PROSCIUTTO', 'Lunch', 'Regular', 14.99);
INSERT INTO item VALUES(3013, 'HAIL CHICKEN CAESAR SALAD', 'Salad', 'Regular', 10.99);
INSERT INTO item VALUES(3014, 'ROASTED CHICKEN MARKET SALAD', 'Salad', 'Regular', 11.99);
INSERT INTO item VALUES(3015, 'AVOCADO & EGG SALAD SAMMY', 'Lunch', 'Regular', 9.99);
INSERT INTO item VALUES(3016, 'TURKEY & CHEDDAR', 'Lunch', 'Regular', 8.99);
INSERT INTO item VALUES(3017, 'BUTTERMILK RANCH CHICKEN CLUB', 'Lunch', 'Regular', 12.99);
INSERT INTO item VALUES(3018, 'SPICY CHICKEN CAESAR SAMMY', 'Lunch', 'Regular', 10.99);
INSERT INTO item VALUES(3019, 'LOLAS CLASSIC SOUP & SAMMY', 'Lunch', 'Regular', 9.99);
INSERT INTO item VALUES(3020, 'SIGNATURE TURKEY BURGER', 'Burger', 'Regular', 11.99);
INSERT INTO item VALUES(3021, 'BISTRO BURGER', 'Burger', 'Regular', 13.99);


--dessert options
INSERT INTO item VALUES (3030, 'YOGIS HOUSEMADE ITALIAN ICE', 'Dessert', 'Regular', 5.99);
INSERT INTO item VALUES (3031, 'LOLAS SIGNATURE DOUGHNUT', 'Dessert', 'Regular', 3.99);
INSERT INTO item VALUES (3032, 'MINI UNICORN SUGAR COOKIE', 'Dessert', 'Mini', 1.99);
INSERT INTO item VALUES(3033, 'CAFÉ LOLA SUGAR COOKIE', 'Dessert', 'Regular', 2.99);
INSERT INTO item VALUES(3034, 'FRESH BAKED COOKIES', 'Dessert', 'Regular', 4.99);
INSERT INTO item VALUES(3035, 'MACARON', 'Dessert', 'Regular', 2.50);
INSERT INTO item VALUES(3036, 'FRENCH PASTRIES', 'Dessert', 'Regular', 6.99);
INSERT INTO item VALUES(3037, 'CINNAMON ROLL', 'Dessert', 'Regular', 3.99);
INSERT INTO item VALUES(3038, 'MINI CUPCAKE', 'Dessert', 'Mini', 1.50);
INSERT INTO item VALUES(3039, 'GOURMET CHOCOLATES', 'Dessert', 'Regular', 9.99);

--coffee options
INSERT INTO item VALUES(3050, 'ALEXS COFFEE', 'Coffee', 'Regular', 3.99);
INSERT INTO item VALUES(3051, 'CUPCAKE LATTE', 'Latte', 'Regular', 5.99);
INSERT INTO item VALUES(3052, '24K GOLD CRÈME BRÛLÉE', 'Latte', 'Regular', 6.99);
INSERT INTO item VALUES(3053, 'HONEY LAVENDER LATTE', 'Latte', 'Regular', 5.99);
INSERT INTO item VALUES(3054, 'SALTED CARAMEL ICED MOCHA', 'Mocha', 'Regular', 6.99);
INSERT INTO item VALUES(3055, 'PISTACHIO LATTE', 'Latte', 'Regular', 5.99);
INSERT INTO item VALUES(3056, 'LINS MATCHA', 'Matcha', 'Regular', 4.99);
INSERT INTO item VALUES(3057, 'CEREMONIAL GRADE MATCHA', 'Matcha', 'Regular', 7.99);
INSERT INTO item VALUES(3058, 'LOLAS SIGNATURE VANILLA ROSE LATTE', 'Latte', 'Regular', 6.99);
INSERT INTO item VALUES(3059, 'LONDON FOG', 'Tea', 'Regular', 4.99);
INSERT INTO item VALUES(3060, 'BLUE MOON', 'Tea', 'Regular', 4.99);
INSERT INTO item VALUES(3061, 'GOLDEN MILK LATTE', 'Latte', 'Regular', 5.99);
INSERT INTO item VALUES(3062, 'LOLAS FROZEN LEMONADE passion fruit or strawberry', 'Beverage', 'Regular', 3.99);
INSERT INTO item VALUES(3063, 'STRAWBERRIES & CREAM', 'Beverage', 'Regular', 4.99);
INSERT INTO item VALUES(3064, 'STRAWBERRY ROSE LEMONADE', 'Beverage', 'Regular', 4.99);
INSERT INTO item VALUES(3065, 'UNICORN LEMONADE', 'Beverage', 'Regular', 5.99);

-- Bottled Beverages
INSERT INTO item VALUES(3070, 'AQUA PANNA', 'Beverage', 'Bottle', 2.99);
INSERT INTO item VALUES(3071, 'PELLEGRINO', 'Beverage', 'Bottle', 2.99);

--Adding employees
INSERT INTO employee VALUES (1000, 'John Deer', 'Manager',  '578-1234', 5000);
INSERT INTO employee VALUES (1001, 'Jane Smith', 'Waiter', '583-5678', 3000);
INSERT INTO employee VALUES (1002, 'Bofa Johnson', 'Chef', '590-9876', 6000);

-- Customers
INSERT INTO customer VALUES (2000, 'Alice', 'Smith', '555-1111', 'Credit');
INSERT INTO customer VALUES (2001, 'Bob', 'Skofield', '555-2222', 'Debit');
INSERT INTO customer VALUES (2002, 'Charlie', 'Davis', '555-3333', 'Cash');
INSERT INTO customer VALUES (2003, 'David', 'Miller', '555-4444', 'Credit');
INSERT INTO customer VALUES (2004, 'Eva', 'Johnson', '555-5555', 'Debit');
INSERT INTO customer VALUES (2005, 'Frank', 'Brown', '555-6666', 'Cash');
INSERT INTO customer VALUES (2006, 'Grace', 'White', '555-7777', 'Credit');
INSERT INTO customer VALUES (2007, 'Henry', 'Young', '555-8888', 'Debit');
INSERT INTO customer VALUES (2008, 'Ivy', 'Walker', '555-9999', 'Cash');
INSERT INTO customer VALUES (2009, 'Jack', 'Davis', '555-0000', 'Credit');


--adding item costs
INSERT INTO cost_to_make VALUES (1, 3001, 3.50, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (2, 3002, 6.00, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (3, 3003, 3.75, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (4, 3004, 5.00, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (5, 3005, 4.50, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (6, 3006, 4.50, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (7, 3007, 5.25, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (8, 3008, 6.75, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (9, 3009, 7.50, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (10, 3010, 5.00, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (11, 3011, 8.25, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (12, 3012, 9.00, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (13, 3013, 6.50, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (14, 3014, 7.25, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (15, 3015, 5.75, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (16, 3016, 6.00, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (17, 3017, 8.75, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (18, 3018, 6.75, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (19, 3019, 5.50, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (20, 3020, 7.25, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (21, 3021, 8.00, TO_DATE('2023-01-15', 'YYYY-MM-DD'));

INSERT INTO cost_to_make VALUES (30, 3030, 3.50, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (31, 3031, 1.75, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (32, 3032, 0.75, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (33, 3033, 1.00, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (34, 3034, 2.25, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (35, 3035, 1.25, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (36, 3036, 4.00, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (37, 3037, 1.50, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (38, 3038, 0.50, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (39, 3039, 3.75, TO_DATE('2023-01-15', 'YYYY-MM-DD'));

INSERT INTO cost_to_make VALUES (50, 3050, 2.00, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (51, 3051, 2.50, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (52, 3052, 3.00, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (53, 3053, 2.50, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (54, 3054, 3.00, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (55, 3055, 2.50, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (56, 3056, 2.00, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (57, 3057, 3.00, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (58, 3058, 2.50, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (59, 3059, 2.00, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (60, 3060, 2.00, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (61, 3061, 2.50, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (62, 3062, 1.50, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (63, 3063, 2.00, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (64, 3064, 2.00, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (65, 3065, 2.50, TO_DATE('2023-01-15', 'YYYY-MM-DD'));

INSERT INTO cost_to_make VALUES (70, 3070, 1.00, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO cost_to_make VALUES (71, 3071, 1.00, TO_DATE('2023-01-15', 'YYYY-MM-DD'));



--orders
INSERT INTO orders VALUES (5001, 1000, NULL, 2000, 3001, 2, 25.98, 1.56, 27.54, 'Takeout');
INSERT INTO orders VALUES (5002, 1001, NULL, 2001, 3005, 1, 6.99, 0.42, 7.41, 'Dine-in');
INSERT INTO orders VALUES (5003, 1002, NULL, 2002, 3012, 3, 44.97, 2.70, 47.67, 'Delivery');
INSERT INTO orders VALUES (5004, 1000, NULL, 2000, 3008, 1, 10.99, 0.66, 11.65, 'Takeout');
INSERT INTO orders VALUES (5005, 1001, NULL, 2001, 3015, 2, 19.98, 1.20, 21.18, 'Dine-in');
INSERT INTO orders VALUES (5006, 1002, NULL, 2002, 3020, 1, 11.99, 0.72, 12.71, 'Delivery');
INSERT INTO orders VALUES (5007, 1000, NULL, 2000, 3032, 3, 5.97, 0.36, 6.33, 'Takeout');
INSERT INTO orders VALUES (5008, 1001, NULL, 2001, 3039, 1, 9.99, 0.60, 10.59, 'Dine-in');
INSERT INTO orders VALUES (5009, 1002, NULL, 2002, 3054, 2, 13.98, 0.84, 14.82, 'Delivery');
INSERT INTO orders VALUES (5010, 1000, NULL, 2000, 3063, 1, 3.99, 0.24, 4.23, 'Takeout');
INSERT INTO orders VALUES (5011, 1001, NULL, 2001, 3060, 1, 4.99, 0.30, 5.29, 'Dine-in');
INSERT INTO orders VALUES (5012, 1002, NULL, 2002, 3070, 2, 5.98, 0.36, 6.34, 'Delivery');
INSERT INTO orders VALUES (5013, 1000, NULL, 2000, 3071, 1, 2.99, 0.18, 3.17, 'Takeout');
INSERT INTO orders VALUES (5014, 1000, NULL, 2003, 3002, 1, 9.99, 0.60, 10.59, 'Dine-in');
INSERT INTO orders VALUES (5015, 1001, NULL, 2004, 3015, 2, 19.98, 1.20, 21.18, 'Takeout');
INSERT INTO orders VALUES (5016, 1002, NULL, 2005, 3033, 3, 8.97, 0.54, 9.51, 'Delivery');
INSERT INTO orders VALUES (5017, 1000, NULL, 2006, 3058, 1, 6.99, 0.42, 7.41, 'Takeout');
INSERT INTO orders VALUES (5018, 1001, NULL, 2007, 3064, 2, 9.98, 0.60, 10.58, 'Dine-in');
INSERT INTO orders VALUES (5019, 1002, NULL, 2008, 3070, 3, 8.97, 0.54, 9.51, 'Delivery');
INSERT INTO orders VALUES (5020, 1000, NULL, 2009, 3018, 1, 10.99, 0.66, 11.65, 'Dine-in');

