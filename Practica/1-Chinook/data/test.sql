-- PRIMERA PARTE
-- 1.
SELECT *
FROM customers
WHERE Country == 'Brazil';

-- 2.
SELECT *
FROM employees
WHERE Title == 'Sales Support Agent';

-- 3.
SELECT t.*
FROM tracks AS t
INNER JOIN albums AS a ON t.AlbumId = a.AlbumId
INNER JOIN artists AS ar ON a.ArtistId = ar.ArtistId
WHERE ar.ArtistId == 1;

-- 4.
SELECT c.FirstName, c.LastName, c.CustomerId, c.Country
FROM customers AS c
WHERE Country <> 'USA';

-- 5.
SELECT
    e.FirstName,
    e.LastName,
    e.City,
    e.State,
    e.Country,
    e.Email
FROM employees AS e
WHERE Title == 'Sales Support Agent';

-- 6.
SELECT DISTINCT BillingCountry
FROM invoices;

-- 7.
SELECT DISTINCT State, COUNT(CustomerId) AS TotalCustomers
FROM customers
WHERE Country = 'USA'
GROUP BY State;

-- 8.
SELECT InvoiceId ,SUM(Quantity) AS TotalItems
FROM invoice_items
WHERE InvoiceID == 37;

-- 9.
SELECT ar.Name, COUNT(t.TrackId) AS TotalTracks
FROM tracks AS t
INNER JOIN albums AS a ON t.AlbumId = a.AlbumId
INNER JOIN artists AS ar ON a.ArtistId = ar.ArtistId
WHERE ar.ArtistId == 1;

-- 10. 
SELECT DISTINCT InvoiceId, SUM(Quantity) AS Quantity
FROM invoice_items
GROUP BY InvoiceId LIMIT 10;

-- 11. 
SELECT DISTINCT BillingCountry, COUNT(InvoiceId) AS TotalInvoices
FROM invoices
GROUP BY BillingCountry;

-- 12.
SELECT COUNT(InvoiceId) AS TotalInvoices
FROM invoices AS i
WHERE DATE(i.InvoiceDate) LIKE '2009%' OR DATE(i.InvoiceDate) LIKE '2011%';

-- 13. 
SELECT COUNT(InvoiceId) AS TotalInvoices
FROM invoices AS i
WHERE DATE(i.InvoiceDate) BETWEEN '2009' AND '2012';

-- 14. 
SELECT DISTINCT Country, COUNT(CustomerId) AS TotalCustomers
FROM customers
WHERE Country LIKE 'Spain' OR Country LIKE 'Brazil'
GROUP BY Country;

-- 15. 
SELECT *
FROM tracks
WHERE Name LIKE 'You%';

-- SEGUNDA PARTE
-- 1. 
SELECT 
    c.FirstName,
    i.InvoiceId,
    i.InvoiceDate,
    i.BillingCountry
FROM invoices AS i
INNER JOIN customers AS c ON i.CustomerId == c.CustomerId
WHERE i.BillingCountry == 'Brazil';

-- 2. 
SELECT e.FirstName, e.LastName, i.*
FROM invoices AS i 
INNER JOIN customers AS c ON i.CustomerId == c.CustomerId
INNER JOIN employees AS e ON c.SupportRepId == e.EmployeeId;

-- 3. 
SELECT
    c.FirstName AS CustomerName,
    c.Country,
    e.FirstName AS AgentName,
    SUM(i.Total) AS Total
FROM invoices AS i 
INNER JOIN customers AS c ON i.CustomerId == c.CustomerId
INNER JOIN employees AS e ON c.SupportRepId == e.EmployeeId
GROUP BY c.FirstName;

-- 4. 
SELECT i.InvoiceLineId, t.Name
FROM invoice_items AS i 
INNER JOIN tracks AS t ON i.TrackId == t.TrackId
GROUP BY i.InvoiceLineId LIMIT 20;

-- 5. 
SELECT
    t.Name,
    m.Name AS MediaType,
    a.Title AS AlbumName,
    g.Name AS Genre
FROM tracks AS t 
INNER JOIN media_types AS m ON t.MediaTypeId == m.MediaTypeId
INNER JOIN albums AS a ON t.AlbumId == a.AlbumId
INNER JOIN genres AS g ON t.GenreId == g.GenreId
GROUP BY t.Name;

-- 6. 
SELECT PlaylistId, COUNT(TrackId) AS Tracks
FROM playlist_track
GROUP BY PlaylistId;

-- 7. 
SELECT
    e.EmployeeId,
    e.FirstName,
    e.Title,
    SUM(i.Total) AS TotalSales
FROM invoices AS i
INNER JOIN customers AS c ON i.CustomerId == c.CustomerId
INNER JOIN employees AS e ON c.SupportRepId == e.EmployeeId
GROUP BY e.EmployeeId;

-- 8. 
SELECT
    e.EmployeeId,
    e.FirstName,
    COUNT(i.InvoiceDate) AS TotalSales
FROM invoices AS i
INNER JOIN customers AS c ON i.CustomerId == c.CustomerId
INNER JOIN employees AS e ON c.SupportRepId == e.EmployeeId
WHERE DATE(i.InvoiceDate) LIKE '2009%'
GROUP BY e.EmployeeId
ORDER BY TotalSales DESC LIMIT 1;

-- 9. 
SELECT ar.Name, SUM(i.Total) AS TotalSales
FROM tracks AS t
INNER JOIN albums AS a ON t.AlbumId == a.AlbumId
INNER JOIN artists AS ar ON a.ArtistId == ar.ArtistId
INNER JOIN invoice_items AS it ON t.TrackId == it.TrackId
INNER JOIN invoices AS i ON it.InvoiceId == i.InvoiceId
GROUP BY ar.Name
ORDER BY TotalSales DESC LIMIT 3;
