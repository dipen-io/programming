--Creating an table

CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(40),
    price DECIMAL(10,2),
    qty INT
);

--insert data multiple/single
INSERT INTO products (id, name, price)
VALUES
(1, 'Gaming Mouse', 'Ergonomic RGB wireless mouse', 59.99);
(2, 'Mechanical Keyboard', 'Blue switches, backlit', 89.00),
RETURNING *;  -- see exactly what was saved immediately:

--insert the single one no need for skip column list if providing exact same list
INSERT INTO products
VALUES (5, 'Short description here', 'Monitor Stand', 25.00);

-- updating string/int
UPDATE product SET name='new desc' WHERE id = 3;
UPDATE product SET price=100.00 WHERE id = 3;

-- PK and FK

-- 1. Add the new column first
ALTER TABLE products ADD COLUMN cat_id INT;

-- 2. Link it to the categories table
ALTER TABLE products 
ADD CONSTRAINT fk_category 
FOREIGN KEY (cat_id) 
REFERENCES categories(category_id);

-- 3. create new category
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

-- 4. update products
UPDATE products SET cat_id = 1 WHERE id = 1;

-- 4 returing the data which have that category_name
SELECT product.name, product.price, categories.category_name
FROM product
JOIN categories ON product.cat_id = categories.category_id;
