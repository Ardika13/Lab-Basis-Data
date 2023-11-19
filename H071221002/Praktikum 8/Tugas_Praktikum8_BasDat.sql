-- nomor 1
(SELECT c.customername, p.productname,  (p.buyprice * SUM(od.quantityordered)) AS "modal"
FROM customers c 
JOIN orders USING (customernumber)
JOIN orderdetails od USING (ordernumber)
JOIN products p USING (productcode)
GROUP BY customername
ORDER BY modal DESC 
LIMIT 3)
UNION
(SELECT c.customername, p.productname,  (p.buyprice * SUM(od.quantityordered)) AS "modal"
FROM customers c 
JOIN orders USING (customernumber)
JOIN orderdetails od USING (ordernumber)
JOIN products p USING (productcode)
GROUP BY customername
ORDER BY modal
LIMIT 3);


-- nomor 2
SELECT city FROM (
(SELECT city, customername, COUNT(*) AS total
FROM customers 
WHERE customername LIKE "L%"
GROUP BY city
ORDER BY total DESC
LIMIT 1)
UNION
(SELECT o.city, COUNT(*) AS total
FROM employees e JOIN offices o USING (officecode)
WHERE e.firstname LIKE "L%"
GROUP BY o.city
ORDER BY total 
LIMIT 1)) AS total
GROUP BY city;


-- nomor 3
SELECT customerName AS 'nama karyawan/pelanggan', 'Pelanggan' AS status
FROM customers
WHERE salesRepEmployeeNumber IN (
    SELECT employeeNumber
    FROM employees
    WHERE officeCode IN (
        SELECT officeCode
        FROM employees
        GROUP BY officeCode
        HAVING COUNT(*) = (
            SELECT MIN(employee)
            FROM (
                SELECT COUNT(*) AS employee
                FROM employees
                GROUP BY officeCode
            ) AS office
        )
    )
)
UNION
SELECT firstName AS 'nama karyawan/pelanggan', 'Karyawan' AS status
FROM employees
WHERE officeCode IN (
    SELECT officeCode
    FROM employees
    GROUP BY officeCode
    HAVING COUNT(*) = (
        SELECT MIN(employee)
        FROM (
            SELECT COUNT(*) AS employee
            FROM employees
            GROUP BY officeCode
        ) AS office
    )
)
ORDER BY `nama karyawan/pelanggan`;


-- nomor 4
SELECT tanggal, GROUP_CONCAT(riwayat SEPARATOR ' dan ') AS riwayat
FROM (
    SELECT o.orderDate AS tanggal, CONCAT('memesan barang') AS riwayat
    FROM orders o
    WHERE YEAR(o.orderDate) = 2003 AND MONTH(o.orderDate) = 4
    UNION
    SELECT p.paymentDate AS tanggal, CONCAT('membayar pesanan') AS riwayat
    FROM payments p
    WHERE YEAR(p.paymentDate) = 2003 AND MONTH(p.paymentDate) = 4
) AS combined_data
GROUP BY tanggal
ORDER BY tanggal;



#soal tambahan
SELECT p.productCode, p.productName, COALESCE(SUM(od.priceEach * od.quantityOrdered), 0) AS totalRevenue
FROM orderdetails AS od
RIGHT JOIN products AS p USING (productCode)
GROUP BY p.productCode

UNION 

SELECT p.productCode, p.productName, SUM(od.priceEach * od.quantityOrdered) AS totalRevenue
FROM orderdetails AS od
LEFT JOIN products AS p USING (productCode)
GROUP BY p.productCode
ORDER BY `totalRevenue` ;

SELECT p.productName  FROM products p
JOIN orderdetails AS od USING (productCode)
GROUP BY p.productCode

