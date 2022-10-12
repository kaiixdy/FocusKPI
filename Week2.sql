-- 1.In the table “Customer”, add a new row based on your information
INSERT INTO Customer (FirstName, LastName, City, Email)
VALUES
	('Kai', 'Pham', 'Stockton', 'ABC@GMAI.COM'),
	('Alex', 'Ji', 'SF', '123@GMAIL.COM')

-- 2.In the table “Invoice”, find out the top 3 billing countries by totals.
SELECT BillingCountry  AS top_3_countries FROM Invoice i 
ORDER BY Total DESC 
LIMIT 3

-- 3.Find out the top 3 countries (use the country column in table “Customer”) by totals.
SELECT c.Country 
FROM Invoice i 
JOIN Customer c 
	ON i.BillingCountry  = c.Country 
	ORDER BY i.Total DESC 
	LIMIT 3
	
-- 4.How many invoices that showing different billing country vs. customer’s country?

SELECT COUNT(i.InvoiceId)
FROM Invoice i 
JOIN Customer c 
	ON i.BillingCountry = c.Country 
	WHERE  i.BillingCountry <> c.Country
	

--5. Find out the top 3 countries (use the one in table “Customer”) by quantity.
SELECT DISTINCT c.Country 
FROM Customer c 
JOIN Invoice i 
	ON c.Country = i.BillingCountry 
JOIN InvoiceLine il 
	ON il.InvoiceId = i.InvoiceId 
	ORDER BY il.Quantity DESC
	LIMIT 3


--6. Create a table that looks like this:
CREATE TABLE country(
	Countries,
	Revenue INT, 
	Sales INT
)

INSERT INTO country (Countries, Revenue, Sales  )
SELECT BillingCountry, UnitPrice * Quantity, Total 
FROM Invoice 
LEFT JOIN InvoiceLine 
	ON Invoice.InvoiceId = InvoiceLine.InvoiceId 

select * from country 




