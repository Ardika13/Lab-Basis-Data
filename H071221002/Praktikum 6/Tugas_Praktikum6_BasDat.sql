USE classicmodels;
-- no 1
SELECT 
	CONCAT(e.firstName, ' ', e.lastName) 'nama employee',
	GROUP_CONCAT(o.orderNumber) 'nomor orderan',
	COUNT(o.orderNumber) 'jumlah pesanan'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o
USING(customernumber)
GROUP BY e.employeeNumber;


-- no 2
SELECT p.productCode, p.productName, p.quantityInStock, o.orderDate
FROM products p
JOIN orderdetails od
USING(productcode)
JOIN orders o
USING(ordernumber)
GROUP BY p.productCode
HAVING p.quantityInStock > 5000
ORDER BY o.orderDate;

-- no 3
SELECT 
	oc.addressLine1 AS 'alamat pertama',
	CONCAT(LEFT(oc.phone, 6), '* ****') AS 'nomor telp',
	COUNT(DISTINCT(e.employeeNumber)) AS 'jumlah karyawan',
	COUNT(DISTINCT(c.customerNumber)) AS 'jumlah pelanggan',
	ROUND(AVG(py.amount), 2) AS 'rata-rata penghasilan'
FROM offices oc
LEFT JOIN employees e
USING(officecode)
LEFT JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments py
USING(customernumber)
GROUP BY oc.addressLine1
ORDER BY oc.phone;

-- no 4
SELECT 
	c.customerName,
	YEAR(o.orderDate) AS tahun,
	MONTH(o.orderDate) AS bulan,
	COUNT(c.customerNumber) 'jumlah pelanggan',
	SUM(od.priceEach*od.quantityOrdered) 'uang total'
FROM customers c
JOIN orders o
USING(customernumber)
JOIN orderdetails od
USING(ordernumber)
GROUP BY c.customerName, bulan
HAVING tahun = 2003;

