DROP TABLE employee;
DROP TABLE customer;
DROP TABLE item;
DROP TABLE cost_to_make;
DROP TABLE orders;


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
  date_sold DATE NOT NULL, 
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
INSERT INTO cost_to_make VALUES (1, 3001, 3.50, '2023-01-15');
INSERT INTO cost_to_make VALUES (2, 3002, 6.00, '2023-01-15');
INSERT INTO cost_to_make VALUES (3, 3003, 3.75, '2023-01-15');
INSERT INTO cost_to_make VALUES (4, 3004, 5.00, '2023-01-15');
INSERT INTO cost_to_make VALUES (5, 3005, 4.50, '2023-01-15');
INSERT INTO cost_to_make VALUES (6, 3006, 4.50, '2023-01-15');
INSERT INTO cost_to_make VALUES (7, 3007, 5.25, '2023-01-15');
INSERT INTO cost_to_make VALUES (8, 3008, 6.75, '2023-01-15');
INSERT INTO cost_to_make VALUES (9, 3009, 7.50, '2023-01-15');
INSERT INTO cost_to_make VALUES (10, 3010, 5.00, '2023-01-15');
INSERT INTO cost_to_make VALUES (11, 3011, 8.25, '2023-01-15');
INSERT INTO cost_to_make VALUES (12, 3012, 9.00, '2023-01-15');
INSERT INTO cost_to_make VALUES (13, 3013, 6.50, '2023-01-15');
INSERT INTO cost_to_make VALUES (14, 3014, 7.25, '2023-01-15');
INSERT INTO cost_to_make VALUES (15, 3015, 5.75, '2023-01-15');
INSERT INTO cost_to_make VALUES (16, 3016, 6.00, '2023-01-15');
INSERT INTO cost_to_make VALUES (17, 3017, 8.75, '2023-01-15');
INSERT INTO cost_to_make VALUES (18, 3018, 6.75, '2023-01-15');
INSERT INTO cost_to_make VALUES (19, 3019, 5.50, '2023-01-15');
INSERT INTO cost_to_make VALUES (20, 3020, 7.25, '2023-01-15');
INSERT INTO cost_to_make VALUES (21, 3021, 8.00, '2023-01-15');

INSERT INTO cost_to_make VALUES (30, 3030, 3.50, '2023-01-15');
INSERT INTO cost_to_make VALUES (31, 3031, 1.75, '2023-01-15');
INSERT INTO cost_to_make VALUES (32, 3032, 0.75, '2023-01-15');
INSERT INTO cost_to_make VALUES (33, 3033, 1.00, '2023-01-15');
INSERT INTO cost_to_make VALUES (34, 3034, 2.25, '2023-01-15');
INSERT INTO cost_to_make VALUES (35, 3035, 1.25, '2023-01-15');
INSERT INTO cost_to_make VALUES (36, 3036, 4.00, '2023-01-15');
INSERT INTO cost_to_make VALUES (37, 3037, 1.50, '2023-01-15');
INSERT INTO cost_to_make VALUES (38, 3038, 0.50, '2023-01-15');
INSERT INTO cost_to_make VALUES (39, 3039, 3.75, '2023-01-15');

INSERT INTO cost_to_make VALUES (50, 3050, 2.00, '2023-01-15');
INSERT INTO cost_to_make VALUES (51, 3051, 2.50, '2023-01-15');
INSERT INTO cost_to_make VALUES (52, 3052, 3.00, '2023-01-15');
INSERT INTO cost_to_make VALUES (53, 3053, 2.50, '2023-01-15');
INSERT INTO cost_to_make VALUES (54, 3054, 3.00, '2023-01-15');
INSERT INTO cost_to_make VALUES (55, 3055, 2.50, '2023-01-15');
INSERT INTO cost_to_make VALUES (56, 3056, 2.00, '2023-01-15');
INSERT INTO cost_to_make VALUES (57, 3057, 3.00, '2023-01-15');
INSERT INTO cost_to_make VALUES (58, 3058, 2.50, '2023-01-15');
INSERT INTO cost_to_make VALUES (59, 3059, 2.00, '2023-01-15');
INSERT INTO cost_to_make VALUES (60, 3060, 2.00, '2023-01-15');
INSERT INTO cost_to_make VALUES (61, 3061, 2.50, '2023-01-15');
INSERT INTO cost_to_make VALUES (62, 3062, 1.50, '2023-01-15');
INSERT INTO cost_to_make VALUES (63, 3063, 2.00, '2023-01-15');
INSERT INTO cost_to_make VALUES (64, 3064, 2.00, '2023-01-15');
INSERT INTO cost_to_make VALUES (65, 3065, 2.50, '2023-01-15');

INSERT INTO cost_to_make VALUES (70, 3070, 1.00, '2023-01-15');
INSERT INTO cost_to_make VALUES (71, 3071, 1.00, '2023-01-15');


--orders
INSERT INTO orders VALUES (5001, 1000, NULL, 2000, 3001, 2, 25.98, 1.56, 27.54, 'Takeout', '2021-01-15');
INSERT INTO orders VALUES (5002, 1001, NULL, 2001, 3005, 1, 6.99, 0.42, 7.41, 'Dine-in', '2021-02-20');
INSERT INTO orders VALUES (5003, 1002, NULL, 2002, 3012, 3, 44.97, 2.70, 47.67, 'Delivery', '2021-03-10');
INSERT INTO orders VALUES (5004, 1000, NULL, 2000, 3008, 1, 10.99, 0.66, 11.65, 'Takeout', '2021-04-05');
INSERT INTO orders VALUES (5005, 1001, NULL, 2001, 3015, 2, 19.98, 1.20, 21.18, 'Dine-in', '2021-05-12');
INSERT INTO orders VALUES (5006, 1002, NULL, 2002, 3020, 1, 11.99, 0.72, 12.71, 'Delivery', '2021-06-18');
INSERT INTO orders VALUES (5007, 1000, NULL, 2000, 3032, 3, 5.97, 0.36, 6.33, 'Takeout', '2021-07-23');
INSERT INTO orders VALUES (5008, 1001, NULL, 2001, 3039, 1, 9.99, 0.60, 10.59, 'Dine-in', '2021-08-30');
INSERT INTO orders VALUES (5009, 1002, NULL, 2002, 3054, 2, 13.98, 0.84, 14.82, 'Delivery', '2021-09-14');
INSERT INTO orders VALUES (5010, 1000, NULL, 2000, 3063, 1, 3.99, 0.24, 4.23, 'Takeout', '2021-10-08');
INSERT INTO orders VALUES (5011, 1001, NULL, 2001, 3060, 1, 4.99, 0.30, 5.29, 'Dine-in', '2021-11-19');
INSERT INTO orders VALUES (5012, 1002, NULL, 2002, 3070, 2, 5.98, 0.36, 6.34, 'Delivery', '2021-12-25');
INSERT INTO orders VALUES (5013, 1000, NULL, 2000, 3071, 1, 2.99, 0.18, 3.17, 'Takeout', '2021-01-01');
INSERT INTO orders VALUES (5014, 1000, NULL, 2003, 3002, 1, 9.99, 0.60, 10.59, 'Dine-in', '2021-02-14');
INSERT INTO orders VALUES (5015, 1001, NULL, 2004, 3015, 2, 19.98, 1.20, 21.18, 'Takeout', '2021-03-30');
INSERT INTO orders VALUES (5016, 1002, NULL, 2005, 3033, 3, 8.97, 0.54, 9.51, 'Delivery', '2021-04-11');
INSERT INTO orders VALUES (5017, 1000, NULL, 2006, 3058, 1, 6.99, 0.42, 7.41, 'Takeout', '2021-05-05');
INSERT INTO orders VALUES (5018, 1001, NULL, 2007, 3064, 2, 9.98, 0.60, 10.58, 'Dine-in', '2021-06-20');
INSERT INTO orders VALUES (5019, 1002, NULL, 2008, 3070, 3, 8.97, 0.54, 9.51, 'Delivery', '2021-07-07');
INSERT INTO orders VALUES (5020, 1000, NULL, 2009, 3018, 1, 10.99, 0.66, 11.65, 'Dine-in', '2021-08-12');
INSERT INTO orders VALUES (5021, 1001, NULL, 2003, 3011, 2, 27.98, 1.68, 29.66, 'Takeout', '2021-09-05');
INSERT INTO orders VALUES (5022, 1002, NULL, 2004, 3021, 1, 13.99, 0.84, 14.83, 'Dine-in', '2021-10-18');
INSERT INTO orders VALUES (5023, 1000, NULL, 2005, 3036, 3, 20.97, 1.26, 22.23, 'Delivery', '2021-11-30');
INSERT INTO orders VALUES (5024, 1001, NULL, 2006, 3061, 1, 4.99, 0.30, 5.29, 'Takeout', '2021-12-15');
INSERT INTO orders VALUES (5025, 1002, NULL, 2007, 3062, 2, 9.98, 0.60, 10.58, 'Dine-in', '2021-02-08');
INSERT INTO orders VALUES (5026, 1000, NULL, 2008, 3055, 1, 5.99, 0.36, 6.35, 'Delivery', '2021-03-22');
INSERT INTO orders VALUES (5027, 1001, NULL, 2009, 3034, 2, 9.98, 0.60, 10.58, 'Takeout', '2021-04-05');
INSERT INTO orders VALUES (5028, 1002, NULL, 2000, 3019, 3, 14.97, 0.90, 15.87, 'Dine-in', '2021-05-18');
INSERT INTO orders VALUES (5029, 1000, NULL, 2001, 3021, 1, 13.99, 0.84, 14.83, 'Delivery', '2021-06-30');
INSERT INTO orders VALUES (5030, 1001, NULL, 2002, 3037, 2, 7.98, 0.48, 8.46, 'Takeout', '2021-07-15');
INSERT INTO orders VALUES (5031, 1002, NULL, 2003, 3038, 1, 3.99, 0.24, 4.23, 'Delivery', '2021-08-05');
INSERT INTO orders VALUES (5032, 1000, NULL, 2004, 3020, 2, 23.98, 1.44, 25.42, 'Dine-in', '2021-09-18');
INSERT INTO orders VALUES (5033, 1001, NULL, 2005, 3013, 1, 10.99, 0.66, 11.65, 'Takeout', '2021-10-30');
INSERT INTO orders VALUES (5034, 1002, NULL, 2006, 3010, 3, 29.97, 1.80, 31.77, 'Delivery', '2021-11-15');
INSERT INTO orders VALUES (5035, 1000, NULL, 2007, 3035, 2, 4.98, 0.30, 5.28, 'Takeout', '2021-12-28');
INSERT INTO orders VALUES (5037, 1002, NULL, 2009, 3031, 3, 11.97, 0.72, 12.69, 'Delivery', '2021-02-25');
INSERT INTO orders VALUES (5038, 1000, NULL, 2000, 3064, 1, 5.99, 0.36, 6.35, 'Takeout', '2021-03-10');
INSERT INTO orders VALUES (5039, 1001, NULL, 2001, 3056, 2, 9.98, 0.60, 10.58, 'Dine-in', '2021-04-22');
INSERT INTO orders VALUES (5040, 1002, NULL, 2002, 3062, 1, 6.99, 0.42, 7.41, 'Delivery', '2021-05-05');
INSERT INTO orders VALUES (5041, 1000, NULL, 2003, 3021, 2, 27.98, 1.68, 29.66, 'Takeout', '2021-06-15');
INSERT INTO orders VALUES (5042, 1001, NULL, 2004, 3039, 1, 9.99, 0.60, 10.59, 'Dine-in', '2021-07-28');
INSERT INTO orders VALUES (5043, 1002, NULL, 2005, 3060, 3, 14.97, 0.90, 15.87, 'Delivery', '2021-08-10');
INSERT INTO orders VALUES (5044, 1000, NULL, 2006, 3063, 1, 3.99, 0.24, 4.23, 'Takeout', '2021-09-22');
INSERT INTO orders VALUES (5045, 1001, NULL, 2007, 3018, 2, 21.98, 1.32, 23.30, 'Dine-in', '2021-10-05');
INSERT INTO orders VALUES (5046, 1002, NULL, 2008, 3032, 1, 1.99, 0.12, 2.11, 'Delivery', '2021-11-18');
INSERT INTO orders VALUES (5047, 1000, NULL, 2009, 3057, 3, 9.00, 0.54, 9.54, 'Takeout', '2021-12-01');
INSERT INTO orders VALUES (5048, 1001, NULL, 2000, 3050, 1, 3.99, 0.24, 4.23, 'Dine-in', '2021-01-15');
INSERT INTO orders VALUES (5049, 1002, NULL, 2001, 3065, 2, 9.98, 0.60, 10.58, 'Delivery', '2021-02-28');
INSERT INTO orders VALUES (5050, 1000, NULL, 2002, 3070, 1, 2.99, 0.18, 3.17, 'Takeout', '2021-03-14');
INSERT INTO orders VALUES (5051, 1001, NULL, 2003, 3037, 2, 7.98, 0.48, 8.46, 'Takeout', '2021-04-28');
INSERT INTO orders VALUES (5052, 1002, NULL, 2004, 3064, 1, 5.99, 0.36, 6.35, 'Dine-in', '2021-05-10');
INSERT INTO orders VALUES (5053, 1000, NULL, 2005, 3020, 3, 20.97, 1.26, 22.23, 'Delivery', '2021-06-22');
INSERT INTO orders VALUES (5054, 1001, NULL, 2006, 3032, 1, 2.99, 0.18, 3.17, 'Takeout', '2021-07-05');
INSERT INTO orders VALUES (5055, 1002, NULL, 2007, 3031, 3, 11.97, 0.72, 12.69, 'Dine-in', '2021-08-18');
INSERT INTO orders VALUES (5056, 1000, NULL, 2008, 3059, 2, 9.98, 0.60, 10.58, 'Delivery', '2021-09-01');
INSERT INTO orders VALUES (5057, 1001, NULL, 2009, 3036, 1, 4.00, 0.24, 4.24, 'Takeout', '2021-10-15');
INSERT INTO orders VALUES (5058, 1002, NULL, 2000, 3033, 2, 3.98, 0.24, 4.22, 'Dine-in', '2021-11-27');
INSERT INTO orders VALUES (5059, 1000, NULL, 2001, 3061, 1, 4.99, 0.30, 5.29, 'Delivery', '2021-12-10');
INSERT INTO orders VALUES (5060, 1001, NULL, 2002, 3053, 3, 14.97, 0.90, 15.87, 'Takeout', '2021-01-23');
INSERT INTO orders VALUES (5061, 1002, NULL, 2003, 3030, 2, 7.98, 0.48, 8.46, 'Takeout', '2021-02-15');
INSERT INTO orders VALUES (5062, 1000, NULL, 2004, 3065, 1, 2.50, 0.15, 2.65, 'Dine-in', '2021-03-03');
INSERT INTO orders VALUES (5063, 1001, NULL, 2005, 3034, 3, 14.97, 0.90, 15.87, 'Delivery', '2021-04-18');
INSERT INTO orders VALUES (5065, 1000, NULL, 2007, 3057, 2, 8.00, 0.48, 8.48, 'Dine-in', '2021-06-14');
INSERT INTO orders VALUES (5066, 1001, NULL, 2008, 3039, 1, 9.99, 0.60, 10.59, 'Delivery', '2021-07-27');
INSERT INTO orders VALUES (5067, 1002, NULL, 2009, 3058, 3, 20.97, 1.26, 22.23, 'Takeout', '2021-08-09');
INSERT INTO orders VALUES (5068, 1000, NULL, 2000, 3062, 1, 4.99, 0.30, 5.29, 'Dine-in', '2021-09-22');
INSERT INTO orders VALUES (5070, 1002, NULL, 2002, 3060, 1, 4.99, 0.30, 5.29, 'Takeout', '2021-11-18');
INSERT INTO orders VALUES (5071, 1002, NULL, 2003, 3061, 2, 9.98, 0.60, 10.58, 'Takeout', '2021-12-01');
INSERT INTO orders VALUES (5073, 1001, NULL, 2005, 3031, 3, 11.97, 0.72, 12.69, 'Delivery', '2021-02-28');
INSERT INTO orders VALUES (5074, 1002, NULL, 2006, 3038, 1, 1.50, 0.09, 1.59, 'Takeout', '2021-03-14');
INSERT INTO orders VALUES (5075, 1000, NULL, 2007, 3064, 2, 8.98, 0.54, 9.52, 'Dine-in', '2021-04-27');
INSERT INTO orders VALUES (5076, 1001, NULL, 2008, 3052, 1, 3.00, 0.18, 3.18, 'Delivery', '2021-05-10');
INSERT INTO orders VALUES (5077, 1002, NULL, 2009, 3056, 3, 14.97, 0.90, 15.87, 'Takeout', '2021-06-22');
INSERT INTO orders VALUES (5078, 1000, NULL, 2000, 3063, 1, 3.99, 0.24, 4.23, 'Dine-in', '2021-07-05');
INSERT INTO orders VALUES (5079, 1001, NULL, 2001, 3059, 2, 9.98, 0.60, 10.58, 'Delivery', '2021-08-18');
INSERT INTO orders VALUES (5081, 1002, NULL, 2003, 3030, 2, 7.98, 0.48, 8.46, 'Takeout', '2021-02-15');
INSERT INTO orders VALUES (5082, 1000, NULL, 2004, 3065, 1, 2.50, 0.15, 2.65, 'Dine-in', '2021-03-03');
INSERT INTO orders VALUES (5083, 1001, NULL, 2005, 3034, 3, 14.97, 0.90, 15.87, 'Delivery', '2021-04-18');
INSERT INTO orders VALUES (5085, 1000, NULL, 2007, 3057, 2, 8.00, 0.48, 8.48, 'Dine-in', '2021-06-14');
INSERT INTO orders VALUES (5086, 1001, NULL, 2008, 3039, 1, 9.99, 0.60, 10.59, 'Delivery', '2021-07-27');
INSERT INTO orders VALUES (5087, 1002, NULL, 2009, 3058, 3, 20.97, 1.26, 22.23, 'Takeout', '2021-08-09');
INSERT INTO orders VALUES (5088, 1000, NULL, 2000, 3062, 1, 4.99, 0.30, 5.29, 'Dine-in', '2021-09-22');
INSERT INTO orders VALUES (5090, 1002, NULL, 2002, 3060, 5, 24.95, 1.50, 26.45, 'Takeout', '2021-11-18');
INSERT INTO orders VALUES (5091, 1002, NULL, 2003, 3030, 2, 7.98, 0.48, 8.46, 'Takeout', '2021-02-15');
INSERT INTO orders VALUES (5092, 1000, NULL, 2004, 3065, 1, 2.50, 0.15, 2.65, 'Dine-in', '2021-03-03');
INSERT INTO orders VALUES (5093, 1001, NULL, 2005, 3034, 3, 14.97, 0.90, 15.87, 'Delivery', '2021-04-18');
INSERT INTO orders VALUES (5095, 1000, NULL, 2007, 3057, 2, 8.00, 0.48, 8.48, 'Dine-in', '2021-06-14');
INSERT INTO orders VALUES (5096, 1001, NULL, 2008, 3039, 5, 49.95, 2.99, 52.94, 'Delivery', '2021-07-27');
INSERT INTO orders VALUES (5097, 1002, NULL, 2009, 3058, 3, 20.97, 1.26, 22.23, 'Takeout', '2021-08-09');
INSERT INTO orders VALUES (5098, 1000, NULL, 2000, 3062, 1, 4.99, 0.30, 5.29, 'Dine-in', '2021-09-22');
INSERT INTO orders VALUES (5100, 1002, NULL, 2002, 3060, 5, 24.95, 1.50, 26.45, 'Takeout', '2021-11-18');
INSERT INTO orders VALUES (5101, 1000, NULL, 2003, 3030, 2, 7.98, 0.48, 8.46, 'Takeout', '2021-02-15');
INSERT INTO orders VALUES (5102, 1001, NULL, 2004, 3065, 1, 2.50, 0.15, 2.65, 'Dine-in', '2021-03-03');
INSERT INTO orders VALUES (5103, 1002, NULL, 2005, 3034, 3, 14.97, 0.90, 15.87, 'Delivery', '2021-04-18');
INSERT INTO orders VALUES (5105, 1001, NULL, 2007, 3057, 2, 8.00, 0.48, 8.48, 'Dine-in', '2021-06-14');
INSERT INTO orders VALUES (5106, 1002, NULL, 2008, 3039, 5, 49.95, 2.99, 52.94, 'Delivery', '2021-07-27');
INSERT INTO orders VALUES (5107, 1000, NULL, 2009, 3058, 3, 20.97, 1.26, 22.23, 'Takeout', '2021-08-09');
INSERT INTO orders VALUES (5108, 1001, NULL, 2000, 3062, 1, 4.99, 0.30, 5.29, 'Dine-in', '2021-09-22');
INSERT INTO orders VALUES (5110, 1000, NULL, 2002, 3060, 5, 24.95, 1.50, 26.45, 'Takeout', '2021-11-18');
INSERT INTO orders VALUES (5111, 1001, NULL, 2003, 3031, 2, 7.98, 0.48, 8.46, 'Dine-in', '2021-12-01');
INSERT INTO orders VALUES (5112, 1002, NULL, 2004, 3056, 1, 3.99, 0.24, 4.23, 'Takeout', '2021-01-15');
INSERT INTO orders VALUES (5113, 1000, NULL, 2005, 3052, 3, 17.97, 1.08, 19.05, 'Delivery', '2021-02-28');
INSERT INTO orders VALUES (5114, 1001, NULL, 2006, 3061, 1, 4.99, 0.30, 5.29, 'Takeout', '2021-03-15');
INSERT INTO orders VALUES (5115, 1002, NULL, 2007, 3064, 2, 7.98, 0.48, 8.46, 'Dine-in', '2021-04-01');
INSERT INTO orders VALUES (5116, 1000, NULL, 2008, 3063, 3, 11.97, 0.72, 12.69, 'Delivery', '2021-05-15');
INSERT INTO orders VALUES (5117, 1001, NULL, 2009, 3071, 1, 2.99, 0.18, 3.17, 'Takeout', '2021-06-01');
INSERT INTO orders VALUES (5118, 1002, NULL, 2000, 3059, 2, 9.98, 0.60, 10.58, 'Dine-in', '2021-07-15');
INSERT INTO orders VALUES (5119, 1000, NULL, 2001, 3033, 3, 7.47, 0.45, 7.92, 'Takeout', '2021-08-01');
INSERT INTO orders VALUES (5120, 1001, NULL, 2002, 3065, 1, 2.50, 0.15, 2.65, 'Dine-in', '2021-09-15');
