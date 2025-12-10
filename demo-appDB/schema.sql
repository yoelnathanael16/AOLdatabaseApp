CREATE DATABASE IF NOT EXISTS showroom_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE showroom_db;

CREATE TABLE Customer (
    CustomerID CHAR(5) PRIMARY KEY,
    CustomerName VARCHAR(50),
    CustomerGender VARCHAR(10),
    CustomerAddress VARCHAR(50),
    CustomerEmail VARCHAR(50),
    CustomerDOB DATE
);

CREATE TABLE Category (
    CategoryID CHAR(5) PRIMARY KEY,
    CategoryName VARCHAR(50)
);

CREATE TABLE CarInfo (
    ProductID CHAR(5) PRIMARY KEY,
    CategoryID CHAR(5),
    Price FLOAT,
    Manufacturer VARCHAR(50),
    ModelName VARCHAR(50),
    ModelYear CHAR(4),
    Color VARCHAR(50),
    Engine VARCHAR(50),
    Odometer INT,
    EngineNumber VARCHAR(50),
    VIN CHAR(17),
    RegistrationNumber VARCHAR(10),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID) ON DELETE SET NULL
);

CREATE TABLE TransactionHeader (
    TransactionID CHAR(5) PRIMARY KEY,
    CustomerID CHAR(5),
    TransactionDate DATE,
    TransactionTime TIME,
    TransactionDesc VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE SET NULL
);

CREATE TABLE TransactionDetail (
    TransactionID CHAR(5),
    ProductID CHAR(5),
    Quantity INT(11),
    UnitPrice FLOAT,
    PaymentMethod VARCHAR(50),
    PRIMARY KEY (TransactionID),
    FOREIGN KEY (TransactionID) REFERENCES TransactionHeader(TransactionID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES CarInfo(ProductID) ON DELETE SET NULL
);
