#DATABASES
#Library
#SQL Exercises

#1.Show the members under the name "Jens S." who were born before 1970 that became members of the library in 2013.
SELECT *
FROM tmember
WHERE cName = 'Jens S.'
AND dBirth < '1970-01-01'
AND dNewMember LIKE '2013%';


#2.Show those books that have not been published by the publishing companies with ID 15 and 32,
#except if they were published before 2000.
SELECT *
FROM tbook
WHERE NOT nPublishingCompanyID = 15 AND NOT nPublishingCompanyID = 32
OR nPublishingYear < '2000-01-01';

SELECT *
FROM tbook
WHERE nPublishingCompanyID NOT IN (15, 32)
OR nPublishingYear < '2000-01-01';


#3.Show the name and surname of the members who have a phone number, but no address.
SELECT cName, cSurname
FROM tmember
WHERE cPhoneNo IS NOT NULL
AND cAddress IS NULL;


#4.Show the authors with surname "Byatt" whose name starts by an "A" (uppercase) and contains an "S" (uppercase).
SELECT *
FROM tauthor
WHERE cSurname = 'Byatt'
AND cName LIKE 'A%'
 AND cName LIKE '%S%';


#5.Show the number of books published in 2007 by the publishing company with ID 32.
SELECT COUNT(nPublishingYear)
FROM tbook
WHERE nPublishingYear = 2007
AND nPublishingCompanyID = 32;


#6.For each day of the year 2014, show the number of books loaned by the member with CPR "0305393207";
SELECT COUNT(cTitle)
FROM tloan, tbook, tbookcopy
WHERE cCPR = '0305393207'
AND dLoan LIKE '2014%'
AND tloan.cSignature = tbookcopy.cSignature
AND tbookcopy.nBookID = tbook.nBookID
GROUP BY tloan.cCPR;


#7.Modify the previous clause so that only those days where the member was loaned more than one book appear.
SELECT dLoan
FROM tloan
WHERE cCPR = '0305393207'
AND dLoan LIKE '2014%'
GROUP BY dLoan
HAVING COUNT(*) > 1;


#8.Show all library members from the newest to the oldest. Those who became members on the same day
#will be sorted alphabetically (by surname and name) within that day.
SELECT cName, cSurname, dNewMember
FROM tmember
ORDER BY dNewMember DESC, cSurname, cName;


#9.Show the title of all books published by the publishing company with ID 32 along with their theme or themes.
SELECT cTitle, cName
FROM tbook, tbooktheme, ttheme
WHERE nPublishingCompanyID = '32'
AND tbook.nBookID = tbooktheme.nBookID
AND tbooktheme.nThemeID = ttheme.nThemeID;


#10.Show the name and surname of every author along with the number of books authored by them,
#but only for authors who have registered books on the database.
SELECT cName, cSurname, COUNT(cTitle)
FROM tauthor, tauthorship, tbook
WHERE cTitle IS NOT NULL
AND tauthor.nAuthorID = tauthorship.nAuthorID
AND tauthorship.nBookID = tbook.nBookID
GROUP BY cName, cSurname;


#11.Show the name and surname of all the authors with published books along with the lowest publishing year for their books.
SELECT cName, cSurname, MIN(nPublishingYear)
FROM tauthor, tauthorship, tbook
WHERE cTitle IS NOT NULL
AND tauthor.nAuthorID = tauthorship.nAuthorID
AND tauthorship.nBookID = tbook.nBookID
GROUP BY cName, cSurname;


#12.For each signature and loan date, show the title of the corresponding books and the
#name and surname of the member who had them loaned.
SELECT tloan.cSignature, dLoan, cTitle, cName, cSurname
FROM tloan, tbookcopy, tbook, tmember
WHERE tloan.cSignature = tbookcopy.cSignature
AND tbookcopy.nBookID = tbook.nBookID
AND tloan.cCPR = tmember.cCPR;

#13.Repeat exercises 9 to 12 using the modern JOIN notation.
#9.1#
SELECT cTitle, cName
FROM tbook
JOIN tbooktheme ON tbook.nBookID = tbooktheme.nBookID
JOIN ttheme ON tbooktheme.nThemeID = tbooktheme.nThemeID
WHERE nPublishingCompanyID = '32';

#10.1#
SELECT cName, cSurname, COUNT(*)
FROM tauthor
JOIN tauthorship ON tauthor.nAuthorID = tauthorship.nAuthorID
JOIN tbook ON tauthorship.nBookID = tbook.nBookID
WHERE cTitle IS NOT NULL
GROUP BY cName, cSurname;

#11.1#
SELECT cName, cSurname, MIN(nPublishingYear)
FROM tauthor
JOIN tauthorship ON tauthor.nAuthorID = tauthorship.nAuthorID
JOIN tbook ON tauthorship.nBookID = tbook.nBookID
WHERE cTitle IS NOT NULL
GROUP BY cName, cSurname;

#12.1#
SELECT tloan.cSignature, dLoan, cTitle, cName, cSurname
FROM tloan
JOIN tbookcopy on tloan.cSignature = tbookcopy.cSignature
JOIN tbook  on tbookcopy.nBookID = tbook.nBookID
JOIN tmember on tloan.cCPR = tmember.cCPR;
#---------------------------------------------------------------------

#14.Show all theme names along with the titles of their associated books.
#All themes must appear (even if there are no books for some particular themes).Sort by theme name.
SELECT ttheme.cName, cTitle
FROM  tbook
LEFT JOIN tbooktheme on tbook.nBookID = tbooktheme.nBookID
LEFT JOIN ttheme on tbooktheme.nThemeID = ttheme.nThemeID
ORDER BY ttheme.cNAme, cTitle;


#15.Show the name and surname of all members who joined the library in 2013 along with the title of the books
#they took on loan during that same year. All members must be shown, even if they did not take any book on loan during 2013.
#Sort by member surname and name.
SELECT cName, cSurname, if(dLoan LIKE '2013%', tbook.cTitle, '') AS BookRentedIn2013
FROM tmember
LEFT JOIN tloan on tmember.cCPR = tloan.cCPR
LEFT JOIN tbookcopy on tloan.cSignature = tbookcopy.cSignature
LEFT JOIN tbook on tbookcopy.nBookID = tbook.nBookID
WHERE dNewMember LIKE '2013%'
GROUP BY cName, cSurname, if(dLoan LIKE '2013%', tbook.cTitle, '')
ORDER BY cName, cSurname;


#16.Show the name and surname of all authors along with their nationality or nationalities and the titles of their books.
#Every author must be shown, even though s/he has no registered books. Sort by author name and surname.
SELECT tauthor.cName, tauthor.cSurname, tcountry.cName, if(tauthor.nAuthorID =! tauthorship.nBookID, '*', tbook.cTitle) AS TITLE
FROM tauthor
LEFT JOIN tnationality ON tauthor.nAuthorID = tnationality.nAuthorID
LEFT JOIN tcountry ON tnationality.nCountryID = tcountry.nCountryID
LEFT JOIN tauthorship ON tauthor.nAuthorID = tauthorship.nAuthorID
LEFT JOIN tbook ON tauthorship.nBookID = tbook.nBookID
ORDER BY  tauthor.cName, cSurname;


#17.Show the title of those books which have had different editions published in both 1970 and 1989.
SELECT cTitle, nPublishingYear
FROM tbook
WHERE nPublishingYear = 1970
OR nPublishingYear = 1989
GROUP BY cTitle
HAVING COUNT(*) > 1;


#18.Show the surname and name of all members who joined the library in December 2013
#followed by the surname and name of those authors whose name is “William”.
SELECT tmember.cSurname, tmember.cName, tauthor.cSurname, tauthor.cName
FROM tmember, tauthor
WHERE dNewMember LIKE '2013-12%'
AND tauthor.cName = 'William';


#19.Show the name and surname of the first chronological member of the library using subqueries.
SELECT cName, cSurname
FROM tmember
WHERE dNewMember = (SELECT dNewMember FROM tmember
                    ORDER BY dNewMember
                    LIMIT 1);


#20.For each publishing year, show the number of book titles published by publishing companies
#from countries that constitute the nationality for at least three authors. Use subqueries.
SELECT nPublishingYear, COUNT(*) AS 'No. Books Published', cName
FROM tbook, (SELECT cName FROM tcountry
            LEFT JOIN tnationality ON tcountry.nCountryID = tnationality.nCountryID
            GROUP BY cName
            HAVING COUNT(*) >= 3) name
GROUP BY nPublishingYear, cName
ORDER BY nPublishingYear;


#21.Show the name and country of all publishing companies with the headings "Name" and "Country".
SELECT p.cName AS 'Name', c.cName AS 'Country'
FROM tpublishingcompany AS p
JOIN tcountry AS c ON p.nCountryID = c.nCountryID;


#22.Show the titles of the books published between 1926 and 1978 that were
#not published by the publishing company with ID 32.
SELECT cTitle
FROM tbook
WHERE nPublishingYear BETWEEN 1926 AND 1978
AND nPublishingCompanyID != 32;


#23.Show the name and surname of the members who joined the library after 2016 and have no address.
SELECT cName, cSurname
FROM tmember
WHERE dNewMember > '2016-01-01'
AND cAddress IS NULL;


#24.Show the country codes for countries with publishing companies. Exclude repeated values.
SELECT DISTINCT nCountryID
FROM tpublishingcompany
WHERE tpublishingcompany.cName IS NOT NULL;


#25.Show the titles of books whose title starts by "The Tale" and that are not published by "Lynch Inc".
SELECT cTitle, cName
FROM tbook
JOIN tpublishingcompany ON tbook.nPublishingCompanyID = tpublishingcompany.nPublishingCompanyID
WHERE cTitle LIKE 'The Tale%' AND tpublishingcompany.cName != 'Lynch Inc';


#26.Show the list of themes for which the publishing company "Lynch Inc" has published books, excluding repeated values.
SELECT DISTINCT ttheme.cName
FROM ttheme
JOIN tbooktheme on ttheme.nThemeID = tbooktheme.nThemeID
JOIN tbook on tbooktheme.nBookID = tbook.nBookID
JOIN tpublishingcompany ON tbook.nPublishingCompanyID = tpublishingcompany.nPublishingCompanyID
WHERE tpublishingcompany.cName = 'Lynch Inc'
GROUP BY ttheme.cName;


#27.Show the titles of those books which have never been loaned.
SELECT cTitle FROM tbook
JOIN tbookcopy ON tbook.nBookID = tbookcopy.nBookID
JOIN tloan ON tbookcopy.cSignature = tloan.cSignature
WHERE tloan.dLoan IS NULL;


#28.For each publishing company, show its number of existing books under the heading "No. of Books".
SELECT tpublishingcompany.cName, COUNT(*) AS 'No. of Books'
FROM tpublishingcompany
JOIN tbook t on tpublishingcompany.nPublishingCompanyID = t.nPublishingCompanyID
GROUP BY tpublishingcompany.cName;


#29.Show the number of members who took some book on a loan during 2013.
SELECT COUNT(DISTINCT tmember.cName) AS 'Members who loaned' FROM tmember
JOIN tloan ON tmember.cCPR = tloan.cCPR
WHERE dLoan BETWEEN '2013-01-01' AND '2013-12-31';


#30.For each book that has at least two authors, show its title and number of authors
#under the heading "No. of Authors".
SELECT tbook.cTitle, COUNT(tauthor.nAuthorID) AS "No. of Authors"
FROM tbook
JOIN tauthorship ON tbook.nBookID = tauthorship.nBookID
JOIN tauthor ON tauthorship.nAuthorID = tauthor.nAuthorID
GROUP BY tbook.cTitle
HAVING COUNT(tauthor.nAuthorID) > 1;