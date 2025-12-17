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

-- 1. Insert Kategori
INSERT INTO Category (CategoryID, CategoryName) VALUES 
('C0001', 'Sedan'),
('C0002', 'SUV'),
('C0003', 'MPV'),
('C0004', 'Hatchback'),
('C0005', 'Luxury');

-- 2. Insert Pelanggan
INSERT INTO Customer (CustomerID, CustomerName, CustomerGender, CustomerAddress, CustomerEmail, CustomerDOB) VALUES
('U0001', 'Budi Santoso', 'Male', 'Jl. Merdeka No. 1', 'budi@email.com', '1990-05-15'),
('U0002', 'Siti Aminah', 'Female', 'Jl. Mawar No. 12', 'siti@email.com', '1992-08-20'),
('U0003', 'Agus Wijaya', 'Male', 'Jl. Sudirman No. 5', 'agus@email.com', '1985-12-01'),
('U0004', 'Dewi Lestari', 'Female', 'Jl. Gatot Subroto', 'dewi@email.com', '1995-03-10'),
('U0005', 'Eko Prasetyo', 'Male', 'Jl. Diponegoro No. 8', 'eko@email.com', '1988-07-25');

-- 3. Insert Produk
INSERT INTO CarInfo (ProductID, CategoryID, Price, Manufacturer, ModelName, ModelYear, Color, Engine, Odometer, EngineNumber, VIN, RegistrationNumber) VALUES
('P0001', 'C0001', 350000000, 'Toyota', 'Camry', '2022', 'Black', '2500cc', 5000, 'ENG123', 'VIN12345678901234', 'B 1234 ABC'),
('P0002', 'C0002', 500000000, 'Honda', 'CR-V', '2023', 'White', '1500cc Turbo', 1200, 'ENG456', 'VIN12345678901235', 'B 5678 DEF'),
('P0003', 'C0001', 280000000, 'Honda', 'Civic', '2021', 'Black', '1800cc', 15000, 'ENG789', 'VIN12345678901236', 'B 9012 GHI'),
('P0004', 'C0003', 250000000, 'Toyota', 'Avanza', '2022', 'Silver', '1300cc', 8000, 'ENG012', 'VIN12345678901237', 'B 3456 JKL'),
('P0005', 'C0005', 1200000000, 'BMW', '320i', '2023', 'Blue', '2000cc', 500, 'ENG345', 'VIN12345678901238', 'B 7890 MNO');

-- 4. Insert TransactionHeader
INSERT INTO TransactionHeader (TransactionID, CustomerID, TransactionDate, TransactionTime, TransactionDesc) VALUES
('T0001', 'U0001', '2023-10-01', '10:00:00', 'Cash Purchase'),
('T0002', 'U0002', '2023-10-02', '14:30:00', 'Credit Purchase'),
('T0003', 'U0003', '2023-10-03', '09:15:00', 'Full Payment'),
('T0004', 'U0004', '2023-10-04', '16:45:00', 'Cash Purchase'),
('T0005', 'U0005', '2023-10-05', '11:20:00', 'Full Payment');

-- 5. Insert TransactionDetail
INSERT INTO TransactionDetail (TransactionID, ProductID, Quantity, UnitPrice, PaymentMethod) VALUES
('T0001', 'P0001', 1, 350000000, 'Cash'),
('T0002', 'P0002', 1, 500000000, 'Credit'),
('T0003', 'P0003', 1, 280000000, 'Transfer'),
('T0004', 'P0001', 1, 350000000, 'Cash'),
('T0005', 'P0004', 1, 250000000, 'Transfer');

-- Menampilkan semua isi tabel
SELECT * FROM Category;
SELECT * FROM Customer;
SELECT * FROM CarInfo;
SELECT * FROM TransactionHeader;
SELECT * FROM TransactionDetail;

-- Kategori Paling Laku (jumlah unit yang terjual)
SELECT 
    c.CategoryName, 
    SUM(td.Quantity) AS TotalTerjual
FROM TransactionDetail td
JOIN CarInfo p ON td.ProductID = p.ProductID
JOIN Category c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName
ORDER BY TotalTerjual DESC;

-- Warna Paling Laku (jumlah unit yang terjual)
SELECT 
    p.Color, 
    SUM(td.Quantity) AS TotalTerjual
FROM TransactionDetail td
JOIN CarInfo p ON td.ProductID = p.ProductID
GROUP BY p.Color
ORDER BY TotalTerjual DESC;
