CREATE DATABASE IF NOT EXISTS StockDB;
USE StockDB;

CREATE TABLE IF NOT EXISTS Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    quantity INT,
    min_stock INT
);

INSERT IGNORE INTO Products VALUES
(1, 'Laptop', 10, 5),
(2, 'Mouse', 50, 10),
(3, 'Keyboard', 8, 5),
(4, 'Monitor', 3, 5);

CREATE TABLE IF NOT EXISTS Alerts (
    alert_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    message VARCHAR(255),
    alert_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TRIGGER IF EXISTS stock_alert;

CREATE TRIGGER stock_alert
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    IF NEW.quantity < NEW.min_stock THEN
        INSERT INTO Alerts(product_id, message)
        VALUES (NEW.product_id, CONCAT('Low stock alert for product ID: ', NEW.product_id));
    END IF;
END;

UPDATE Products
SET quantity = 2
WHERE product_id = 1;

SELECT product_id, product_name, quantity, min_stock 
FROM products;
