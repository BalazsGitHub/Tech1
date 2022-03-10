#1.How many songs are there in the playlist “Grunge”?
SELECT COUNT(TrackID)
FROM Playlisttrack
JOIN playlist p on playlisttrack.PlaylistId = p.PlaylistId
WHERE p.name = 'Grunge';


#2.Show information about artists whose name includes the text “Jack” and about artists
#whose name includes the text “John”, but not the text “Martin”.
SELECT *
FROM artist
WHERE Name LIKE '%Jack%'
OR name LIKE '%John%' AND name NOT LIKE '%Martin%';


#3.For each country where some invoice has been issued, show the total invoice monetary amount,
#but only for countries where at least $100 have been invoiced. Sort the information from higher to lower monetary amount.
SELECT BillingCountry, SUM(Total)
FROM invoice
GROUP BY BillingCountry
HAVING SUM(Total) > 100
ORDER BY SUM(Total) DESC;


#4.Get the phone number of the boss of those employees who have given support to clients
#who have bought some song composed by “Miles Davis” in “MPEG Audio File” format.
SELECT Phone
FROM employee
WHERE EmployeeId IN (SELECT ReportsTo FROM employee
WHERE EmployeeId IN (SELECT SupportRepId FROM customer
WHERE CustomerId IN (SELECT CustomerId FROM invoice
WHERE InvoiceId IN (SELECT InvoiceId FROM invoiceline
WHERE TrackId IN (SELECT TrackId FROM track
WHERE Composer = 'Miles Davis' AND MediaTypeId =
(SELECT MediaTypeId FROM mediatype WHERE Name = 'MPEG Audio File'))))));


#5.Show the information, without repeated records, of all albums that feature songs of the “Bossa Nova”
# genre whose title starts by the word “Samba”.
SELECT DISTINCT Title FROM album
WHERE AlbumId IN (SELECT AlbumId FROM track
WHERE GenreId = ( SELECT GenreId FROM genre
WHERE Name = 'Bossa Nova') and Name LIKE 'Samba%');


#6.For each genre, show the average length of its songs in minutes (without indicating seconds).
#Use the headers “Genre” and “Minutes”, and include only genres that have any song longer than half an hour.

/*SELECT genre.Name AS Genre, AVG(Milliseconds) AS Minutes
FROM genre, track
GROUP BY genre.Name;*/

SELECT  Genre.Name AS Genre, ROUND(AVG(Track.Milliseconds/60000)) AS Minutes FROM Genre
INNER JOIN Track ON Genre.GenreId = Track.GenreId
WHERE Milliseconds > 1800000 GROUP BY Genre.GenreId;


#7.How many client companies have no state?
SELECT (SELECT count(*) FROM Customer WHERE Customer.State is NULL) as NullStates;


#8.For each employee with clients in the “USA”, “Canada” and “Mexico” show the number of clients
#from these countries s/he has given support, only when this number is higher than 6.
#Sort the query by number of clients. Regarding the employee, show his/her first name and surname separated by a space.
#Use “Employee” and “Clients” as headers.
SELECT CONCAT(employee.FirstName, ' ', employee.LastName) AS Employee, COUNT(*) AS Clients
FROM employee
INNER JOIN customer ON employee.EmployeeId = customer.SupportRepId
WHERE customer.Country IN ('USA' , 'Canada' , 'Mexico')
GROUP BY employee.FirstName
HAVING COUNT(CustomerId) > 6
ORDER BY Employee;


#9.For each client from the “USA”, show his/her surname and name (concatenated and separated by a comma)
#and their fax number. If they do not have a fax number, show the text “S/he has no fax”.
#Sort by surname and first name.
SELECT CONCAT(FirstName, ',', LastName), IF(Fax IS NOT NULL, Fax, 'S/he has no Fax')
FROM customer
WHERE Country = 'USA';


#10.For each employee, show his/her first name, last name, and their age at the time they were hired.
SELECT FirstName, TIMESTAMPDIFF(YEAR, BirthDate, HireDate) AS Age_At_Hiring
FROM employee;
