--1. In the table “Customer”, how many customers using Gmail account?
SELECT * FROM Customer c 
WHERE c.Email LIKE '%gmail%'

--2.In the table “Customer”, how many customers might use foreign languages? (e.g. email account with ‘.de’, ‘.fr’, etc…)
SELECT * FROM Customer c 
WHERE NOT Email LIKE '%.com%'

--3.Based on the playlist names, please categorize them into 4 buckets and calculate their sales (unit price x quantity)
		--TV - playlist that contains TV keyword
		--Classical - playlist that contains ‘classic’ keyword
		--Music – playlist that contains music keyword
		--Others – everything else
SELECT p.Name, SUM(il.UnitPrice  * il.Quantity) AS Sales
 ,CASE 
	WHEN p.Name LIKE'TV%' THEN 'TV'
	WHEN p.Name LIKE'classic%' THEN 'Classical'
	WHEN p.Name LIKE 'music%' THEN 'Music'
	ELSE 'Others'
	END AS Categories
FROM Playlist p
LEFT JOIN PlaylistTrack pt  ON p.PlaylistId = pt.PlaylistId 
LEFT JOIN Track t  ON pt.TrackId = t.TrackId 
LEFT JOIN InvoiceLine il ON t.TrackId = il.TrackId 
GROUP BY p.Name 


--4. Please produce the following output:

SELECT c.Country
,SUM (CASE WHEN strftime('%Y-%m-%d', i.InvoiceDate) between '2011-01-01' and '2011-12-31' THEN il.UnitPrice * il.Quantity ELSE 0 END) AS Sales_2011
,SUM (CASE WHEN strftime('%Y-%m-%d', i.InvoiceDate) between '2010-01-01' and '2010-12-31' THEN il.UnitPrice * il.Quantity ELSE 0 END) AS Sales_2010
,SUM (CASE WHEN strftime('%Y-%m-%d', i.InvoiceDate) between '2011-01-01' and '2011-12-31' THEN il.UnitPrice * il.Quantity ELSE 0 END)
/SUM (CASE WHEN strftime('%Y-%m-%d', i.InvoiceDate) between '2010-01-01' and '2012-12-31' THEN il.UnitPrice * il.Quantity ELSE 0 END) -1 AS Sales_YOY
FROM InvoiceLine il 
LEFT JOIN Invoice i ON il.InvoiceId = i.InvoiceId 
LEFT JOIN Customer c ON i.CustomerId = c.CustomerId 
GROUP BY 1;
