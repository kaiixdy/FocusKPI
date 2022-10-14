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
SELECT c.Country, SUM(i.Total) 
FROM Customer c  
LEFT JOIN Invoice i ON i.BillingCountry = c.Country 
GROUP BY c.Country 
ORDER BY  SUM(i.Total) DESC 
LIMIT 3

	
-- 4.How many invoices that showing different billing country vs. customer’s country?

SELECT COUNT(i.InvoiceId)
FROM Invoice i 
JOIN Customer c 
	ON i.BillingCountry = c.Country 
	WHERE  i.BillingCountry <> c.Country
	

--5. Find out the top 3 countries (use the one in table “Customer”) by quantity.
SELECT c.Country, SUM(il.Quantity )
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

INSERT INTO country (Countries, Revenue, Sales)
VALUES
	('Total', SUM(country.Revenue), SUM(country.Sales)
	
	
--Check table
select * FROM country



--7. Aggregate the sales (unit price x quantity) by playlist name and filer on all playlists that had sales > $10

SELECT p.Name, SUM(il.UnitPrice * il.Quantity) AS SALES FROM Playlist p 
LEFT JOIN PlaylistTrack pt USING (PlaylistId)
JOIN InvoiceLine il USING(TrackId)
GROUP BY (p.Name)
HAVING SALES > 10

--8. Create a table
CREATE TABLE summary (InvoiceLineId  INT, InvoiceId INT, TrackId INT, TrackName, AlbumName, GenreName,
	PlayListName, UnitPrice, Quantity, Total, CustomerId, FirstName, LastName, Country, State);

INSERT INTO summary 
	SELECT il.InvoiceLineId, il.InvoiceId, t.TrackId, t.Name, a.Title, g.Name, 
p.Name, il.UnitPrice, il.Quantity, i.Total, c.CustomerId, c.FirstName, c.LastName, c.Country, c.State
FROM InvoiceLine il 
LEFT JOIN Track t ON t.TrackId = il.TrackId 
LEFT JOIN PlaylistTrack pt ON pt.TrackId = il.TrackId 
LEFT JOIN Playlist p ON p.PlaylistId = pt.PlaylistId 
LEFT JOIN Invoice i ON il.InvoiceId = i.InvoiceId 
LEFT JOIN Customer c ON i.BillingCountry = c.Country 
LEFT JOIN Album a ON a.AlbumId = t.AlbumId 
LEFT JOIN Genre g ON g.GenreId = t.GenreId 

SELECT * FROM summary 
