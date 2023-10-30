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
SELECT
    FirstName || ' ' || LastName AS FullName,
    CustomerId AS ID,
    Country
FROM customers
WHERE Country <> 'USA';

-- 5.
SELECT
    FirstName || ' ' || LastName AS FullName,
    City || ' ' || State || ' ' || Country AS Address,
    Email
FROM employees
WHERE Title == 'Sales Support Agent';

-- 6.
SELECT DISTINCT BillingCountry
FROM invoices;

-- 7.
SELECT State, COUNT(CustomerId) AS TotalCustomers
FROM customers
WHERE Country = 'USA'
GROUP BY State
ORDER BY 2 DESC;

-- 8.
SELECT InvoiceId, SUM(Quantity) AS TotalItems
FROM invoice_items
WHERE InvoiceID IN (37);

-- 9.
SELECT ar.Name, COUNT(t.TrackId) AS TotalTracks
FROM tracks AS t
INNER JOIN albums AS a ON t.AlbumId = a.AlbumId
INNER JOIN artists AS ar ON a.ArtistId = ar.ArtistId
WHERE ar.ArtistId == 1;

-- 10. 
SELECT InvoiceId, SUM(Quantity) AS TotalItems
FROM invoice_items
GROUP BY 1
ORDER BY 2 DESC;

-- 11. 
SELECT DISTINCT BillingCountry, COUNT(InvoiceId) AS TotalInvoices
FROM invoices
GROUP BY 1
ORDER BY 2 DESC;

-- 12.
SELECT
    strftime('%Y', InvoiceDate) AS Year,
    COUNT(InvoiceId) AS TotalInvoices
FROM invoices
WHERE Year IN ('2009', '2011')
GROUP BY Year;

-- 13. 
SELECT
    strftime('%Y', InvoiceDate) AS Years,
    COUNT(InvoiceId) AS TotalInvoices
FROM invoices
WHERE Years BETWEEN '2009' AND '2011'
GROUP BY 1;

-- 14. 
SELECT Country, COUNT(CustomerId) AS TotalCustomers
FROM customers
WHERE Country IN ('Spain', 'Brazil')
GROUP BY 1;

-- 15. 
SELECT name
FROM tracks
WHERE Name LIKE 'You%';

-- SEGUNDA PARTE
-- 1. 
SELECT 
    c.FirstName || ' ' || c.LastName AS ClientName,
    c.Country AS ClientCountry,
    i.InvoiceId,
    i.InvoiceDate,
    i.BillingCountry
FROM invoices AS i
INNER JOIN customers AS c ON i.CustomerId == c.CustomerId
WHERE c.Country == 'Brazil'
GROUP BY 3;

-- 2. 
SELECT
    e.FirstName || ' ' || e.LastName AS FullName,
    i.*
FROM invoices AS i 
INNER JOIN customers AS c ON i.CustomerId == c.CustomerId
INNER JOIN employees AS e ON c.SupportRepId == e.EmployeeId;

-- 3. 
SELECT
    c.FirstName || ' ' || c.LastName AS CustomerName,
    c.Country AS CustomerCountry,
    e.FirstName || ' ' || e.LastName AS AgentName,
    SUM(i.Total) AS TotalPuchases
FROM invoices AS i 
INNER JOIN customers AS c ON i.CustomerId == c.CustomerId
INNER JOIN employees AS e ON c.SupportRepId == e.EmployeeId
GROUP BY 1
ORDER BY 4 DESC;

-- 4. 
SELECT i.InvoiceLineId, t.Name AS SongName
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
SELECT
    pt.PlaylistId,
    p.name AS PlaylistName,
    COUNT(pt.TrackId) AS Tracks
FROM playlist_track AS pt
INNER JOIN playlists AS p ON pt.PlaylistId == p.PlaylistId
GROUP BY 1, 2
ORDER BY 3 DESC;

-- 7. 
SELECT
    e.EmployeeId,
    e.FirstName || ' ' || e.LastName AS FullName,
    SUM(i.Total) AS TotalSales
FROM invoices AS i
INNER JOIN customers AS c ON i.CustomerId == c.CustomerId
INNER JOIN employees AS e ON c.SupportRepId == e.EmployeeId
GROUP BY 1
ORDER BY 3 DESC;

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
SELECT
    ar.ArtistId,
    ar.Name AS ArtistName,
    SUM(i.Total) AS TotalSales
FROM tracks AS t
INNER JOIN albums AS a ON t.AlbumId == a.AlbumId
INNER JOIN artists AS ar ON a.ArtistId == ar.ArtistId
INNER JOIN invoice_items AS it ON t.TrackId == it.TrackId
INNER JOIN invoices AS i ON it.InvoiceId == i.InvoiceId
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 3;
