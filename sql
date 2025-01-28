-- Create Database
CREATE DATABASE LibraryDB;
USE LibraryDB;

-- Create Books Table
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    PublishedYear INT,
    CopiesAvailable INT NOT NULL DEFAULT 1
);

-- Create Borrowers Table
CREATE TABLE Borrowers (
    BorrowerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    Address TEXT
);

-- Create Loans Table
CREATE TABLE Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    BorrowerID INT,
    LoanDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID)
);

-- Query to Find Overdue Books
SELECT 
    Loans.LoanID, Books.Title, Borrowers.Name, Loans.DueDate 
FROM Loans
JOIN Books ON Loans.BookID = Books.BookID
JOIN Borrowers ON Loans.BorrowerID = Borrowers.BorrowerID
WHERE Loans.ReturnDate IS NULL AND Loans.DueDate < CURDATE();

-- Query to Get Borrower History
SELECT 
    Borrowers.Name, Books.Title, Loans.LoanDate, Loans.ReturnDate
FROM Loans
JOIN Books ON Loans.BookID = Books.BookID
JOIN Borrowers ON Loans.BorrowerID = Borrowers.BorrowerID
ORDER BY Borrowers.Name, Loans.LoanDate;
