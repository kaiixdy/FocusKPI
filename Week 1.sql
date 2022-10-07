-- 1. In the table “Customer”, how many customers are from North America (USA or Canada)? 21
SELECT COUNT(CustomerId) 
FROM Customer c 
WHERE Country IN ('USA','Canada') 

-- 2.In the table “Customer”, how many customers can be considered as business customers (with a valid company)? 10
SELECT COUNT(CustomerId) 
FROM Customer c 
WHERE NOT Company = ' '

-- 3.In the table “Invoice”, how many invoices had valid addresses (no missing information in address/city/state/zip code)? 203 countries
SELECT COUNT(InvoiceId) 
FROM Invoice i 
WHERE NOT BillingAddress  = '' AND NOT BillingCity = '' 
	AND NOT BillingPostalCode = '' AND NOT BillingState = ''

-- 4. In the table “Invoice”, how many invoices they sold in 2008? Comparing to 2007, what % of growth/decline we saw? 1% growth rate
SELECT COUNT(InvoiceId)
FROM Invoice i 
WHERE InvoiceDate >= '2007-01-01 00:00:00' 
	AND InvoiceDate < '2008-01-01 00:00:00'
--# of invoices in 2007: 83

SELECT COUNT(InvoiceId)
FROM Invoice i 
WHERE InvoiceDate >= '2008-01-01 00:00:00' 
	AND InvoiceDate < '2009-00:00:00'
--# of invoices in 2008: 83
	
SELECT (83/83) AS percent_of_growth

-- 5. In the table “InvoiceLine”, how many different unit price they offered? 2
SELECT DISTINCT UnitPrice 
FROM InvoiceLine il 

