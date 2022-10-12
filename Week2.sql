-- 1.In the table “Customer”, add a new row based on your information
INSERT INTO Customer (FirstName, LastName, City, Email)
VALUES
	('Kai', 'Pham', 'Stockton', 'ABC@GMAI.COM'),
	('Alex', 'Ji', 'SF', '123@GMAIL.COM')

-- 2.In the table “Invoice”, find out the top 3 billing countries by totals.
SELECT BillingCountry, SUM(Total)  FROM Invoice i 
GROUP BY BillingCountry 
ORDER BY SUM(Total) DESC 
LIMIT 3


-- 3.Find out the top 3 countries (use the country column in table “Customer”) by totals.
SELECT c.Country, COUNT(i.Total) 
FROM Customer c  
LEFT JOIN Invoice i ON i.BillingCountry = c.Country 
GROUP BY c.Country 
ORDER BY COUNT(i.Total) DESC 
LIMIT 3

	
-- 4.How many invoices that showing different billing country vs. customer’s country?

SELECT COUNT(i.InvoiceId)
FROM Invoice i 
JOIN Customer c 
	ON i.BillingCountry = c.Country 
	WHERE  i.BillingCountry <> c.Country
	

--5. Find out the top 3 countries (use the one in table “Customer”) by quantity.
SELECT c.Country, COUNT(il.Quantity )
FROM Customer c 
LEFT JOIN Invoice i  ON c.Country = i.BillingCountry 
JOIN InvoiceLine il ON il.InvoiceId = i.InvoiceId 
GROUP BY(c.Country)
	ORDER BY il.Quantity DESC
	LIMIT 3


--6. Create a table that looks like this:
--First, create table
CREATE TABLE country(
	Countries,
	Revenue INT, 
	Sales INT
)

--Add Data into table:
INSERT INTO country (Countries, Revenue, Sales)
SELECT i.BillingCountry, SUM(il.UnitPrice * il.Quantity), SUM(i.Total)
FROM Invoice i
LEFT JOIN InvoiceLine il
	ON i.InvoiceId = il.InvoiceId 
GROUP BY (i.BillingCountry )

--Check table
select * FROM country



