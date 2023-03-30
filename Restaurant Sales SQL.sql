#Orders placed in a day by customers to restaurants in a food delivery app.
#New food business wants to know which location is ideal and cuisine
#Which zone had the most sales and least amount of sales?
#Which cuisine most popular?

use restaurant_sales;

SELECT * FROM orders;
SELECT * FROM restaurants;

#Renaming Columns
ALTER Table Orders
RENAME COLUMN `Order ID` TO Order_ID;

Alter Table Orders
RENAME COLUMN `Customer Name` TO Customer_Name;

ALTER TABLE Orders
RENAME COLUMN `Restaurant ID` TO Restaurant_ID;

ALTER TABLE Orders
RENAME COLUMN `Order Date` TO Order_Date;

ALTER TABLE Orders
RENAME COLUMN `Quantity of Items` TO Quantity_of_Items;

ALTER TABLE Orders
RENAME COLUMN `Order Amount` TO Order_Amount;

ALTER TABLE Orders
RENAME COLUMN `Payment Mode` TO Payment_Mode;

ALTER TABLE Orders
RENAME COLUMN `Delivery Time Taken (mins)` TO Delivery_Time_Mins;

ALTER TABLE Orders
RENAME COLUMN `Customer Rating-Food` TO Customer_Rating_Food;

ALTER TABLE Orders
RENAME COLUMN `Customer Rating-Delivery` TO Customer_Rating_Delivery;

ALTER TABLE Restaurants
RENAME COLUMN RestaurantID TO Restaurant_ID;

ALTER TABLE Restaurants
RENAME COLUMN RestaurantName TO Restaurant_Name;

#Check For Any Null Values
SELECT  
    Restaurant_ID,
    Order_Amount,
    Customer_Rating_Food,
    Customer_Rating_Delivery
FROM 
    Orders
WHERE
    Restaurant_ID IS NULL OR Order_Amount IS NULL OR Customer_Rating_Food IS NULL OR Customer_Rating_Delivery IS NULL;

SELECT
    Restaurant_ID,
    Restaurant_Name,
    Cuisine,
    Zone
FROM
    restaurants
WHERE
    Restaurant_ID IS NULL OR Restaurant_Name IS NULL OR Cuisine IS NULL OR Zone IS NULL;

#Data Exploration
# Which customer spent the most money?
SELECT
    Customer_Name,
    Order_Amount
FROM
    Orders
ORDER BY
    Order_Amount DESC
LIMIT 1;
    
#Which restaurant made the least money?
SELECT
    Orders.Restaurant_ID,
    SUM(Order_Amount),
    Restaurants.Restaurant_Name,
    Restaurants.Zone
FROM
    Orders
	INNER JOIN
    Restaurants ON Orders.Restaurant_ID = Restaurants.Restaurant_ID
GROUP BY
    Restaurant_ID
ORDER BY
    SUM(Order_Amount) DESC;


#Which zone made the most and least money?
SELECT
    SUM(Order_Amount),
    Restaurants.Zone
FROM
    Orders
	RIGHT JOIN
    Restaurants ON Orders.Restaurant_ID = Restaurants.Restaurant_ID
GROUP BY
    Zone
Order BY
    SUM(Order_Amount) DESC;

#Average customer food and delivery rating for each restaurant. Order in Descending 
SELECT
    Orders.Restaurant_ID,
    Restaurants.Restaurant_Name,
    ROUND(AVG(Customer_Rating_Food), 2) AS 'Customer Food Rating',
    ROUND(AVG(Customer_Rating_Delivery), 2) AS 'Customer Delivery Rating'
FROM
    Orders
	LEFT JOIN
    Restaurants ON Orders.Restaurant_ID = Restaurants.Restaurant_ID
GROUP BY
    Restaurant_ID
ORDER BY
    Restaurant_ID DESC;


#Most liked and least liked cuisine?
SELECT
    Restaurants.Cuisine,
    SUM(Order_amount),
    ROUND(AVG(Customer_Rating_Delivery), 2) AS 'Customer Delivery Rating',
    ROUND(AVG(Customer_Rating_Food), 2) AS 'Customer Food Rating'
FROM
    Orders
	INNER JOIN
    Restaurants ON Orders.Restaurant_ID = Restaurants.Restaurant_ID
GROUP BY
    Cuisine
ORDER BY
    ROUND(AVG(Customer_Rating_Food), 2) DESC;

