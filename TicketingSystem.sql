CREATE DATABASE TicketingSystemDB;
USE TicketingSystemDB;

-- User table: Stores information about users who interact with the system
CREATE TABLE User (
    UserID INT NOT NULL AUTO_INCREMENT,
    UserName VARCHAR(50),
    UserEmail VARCHAR(30),
    UserAddress VARCHAR(50),
    UserPhone VARCHAR(50),
    UserPassword VARCHAR(20),
    PRIMARY KEY (UserID)
);

-- Driver table: Stores information about bus drivers
CREATE TABLE Driver (
    DriverID INT NOT NULL AUTO_INCREMENT,
    DriverName VARCHAR(50),
    DriverEmail VARCHAR(50),
    DriverPhone VARCHAR(20),
    DriverAddress VARCHAR(20),
    PRIMARY KEY (DriverID)
);

-- Bus table: Records details about buses available in the system
CREATE TABLE Bus (
    BusID INT NOT NULL AUTO_INCREMENT,
    BusLevel VARCHAR(10),
    BusType VARCHAR(20),
    LicensePlate VARCHAR(10),
    CurrentCity VARCHAR(50),
    DriverID INT,
    PRIMARY KEY (BusID),
    FOREIGN KEY (DriverID) REFERENCES Driver(DriverID)
);

-- Ticket table: Represents individual tickets booked by users
CREATE TABLE Ticket (
    TicketID INT AUTO_INCREMENT,
    DepartureCity VARCHAR(50),
    DestinationCity VARCHAR(50),
    DepartureDateTime DATETIME NOT NULL,
    ArrivalDateTime DATETIME  NOT NULL,
    Price REAL,
	SeatNumber INT NOT NULL,
    UserID INT,
    DriverID INT,
    PRIMARY KEY (TicketID),
    INDEX (SeatNumber),
    INDEX (Price),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (DriverID) REFERENCES Driver(DriverID)
);

-- Reservation table: Stores information about reservations made by users
CREATE TABLE Reservation (
    ReservationID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    TicketID INT,
    SeatNumber INT NOT NULL,
    ReservationDateTime DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (TicketID) REFERENCES Ticket(TicketID),
    FOREIGN KEY (SeatNumber) REFERENCES Ticket(SeatNumber)
);


-- Payment table: Records payments made by users for their tickets
CREATE TABLE Payment (
    PaymentID INT AUTO_INCREMENT,
    UserID INT,
    TicketID INT,
    PaymentMethod VARCHAR(20),
    Price REAL,
    TransactionDateTime DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    Status VARCHAR(20),
    PRIMARY KEY (PaymentID),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (TicketID) REFERENCES Ticket(TicketID),
    FOREIGN KEY (Price) REFERENCES Ticket(Price)
);

-- Transaction table: Records various transactions related to users
CREATE TABLE Transaction (
    TransactionID INT AUTO_INCREMENT,
    UserID INT,
    price REAL,
    TransactionDateTime DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    TransactionType VARCHAR(20),
    PRIMARY KEY (TransactionID),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (Price) REFERENCES Ticket(Price)
);



-- Insert data into the User table
INSERT INTO User (UserName, UserEmail, UserAddress, UserPhone, UserPassword)
VALUES
    ('Yohannes Gezachew', 'yohannes@example.com', '123 Addis Ababa', '1234567890', 'password1'),
    ('Fatima Ali', 'fatima@example.com', '456 Oromia', '9876543210', 'password2'),
    ('Ephrem Negash', 'ephrem@example.com', '789 Tigray', '5555555555', 'password3'),
    ('Aida Wondimu', 'aida@example.com', '321 Amhara', '1111111111', 'password4'),
    ('Abdullah Mohammed', 'abdullah@example.com', '654 Southern Nations, Nationalities, and Peoples', '9999999999', 'password5'),
    ('Sara Abate', 'sara@example.com', '987 Afar', '8888888888', 'password6'),
    ('Yordanos Tadesse', 'yordanos@example.com', '753 Somali', '7777777777', 'password7'),
    ('Hassan Omar', 'hassan@example.com', '852 Benishangul-Gumuz', '6666666666', 'password8'),
    ('Daniel Girma', 'daniel@example.com', '159 Dire Dawa', '5555555555', 'password9'),
    ('Selamawit Hailu', 'selamawit@example.com', '357 Gambela', '4444444444', 'password10'),
    ('Ibrahim Ahmed', 'ibrahim@example.com', '753 Harari', '3333333333', 'password11'),
    ('Betelhem Alemu', 'betelhem@example.com', '159 Sidama', '2222222222', 'password12'),
    ('Tsehay Solomon', 'tsehay@example.com', '357 SNNPR', '1111111111', 'password13'),
    ('Mohammed Ali', 'mohammed@example.com', '753 Addis Ababa', '9999999999', 'password14'),
    ('Amina Hassan', 'amina@example.com', '159 Oromia', '8888888888', 'password15'),
    ('Hassan Ahmed', 'hassan@example.com', '357 Tigray', '7777777777', 'password16'),
    ('Yasin Ali', 'yasin@example.com', '753 Jumeirah Rd, Dubai', '6666666666', 'password17'),
    ('Firdaws Omar', 'firdaws@example.com', '159 Oxford St, London', '5555555555', 'password18'),
    ('Layla Mohammed', 'layla@example.com', '357 Champs-Élysées, Paris', '4444444444', 'password19'),
    ('Ahmed Abdi', 'ahmed@example.com', '753 5th Avenue, New York', '3333333333', 'password20');
    
-- ALTERING DRIVER TABLE BY ADDING AN ATTRIBUTE DriverPassword IN TO IT
ALTER TABLE Driver ADD COLUMN DriverPassword varchar(20);

-- Insert data into the Driver table
INSERT INTO Driver (DriverName, DriverEmail, DriverPhone, DriverAddress, DriverPassword)
VALUES
    ('Muhammed Samson', 'muhammed@example.com', '1234567890', 'Bole', 'password1'),
    ('Fahmi Dinsefa', 'fahmi@example.com', '9876543210', 'Adama', 'password2'),
    ('Nebiyu Musbah', 'nebiyu@example.com', '5555555555', 'Addis Ababa', 'password3'),
    ('Abel Gezu', 'abel@example.com', '1111111111', 'China', 'password1'),
    ('Asegid Adane', 'asegid@example.com', '9999999999', 'Dubai', 'password2'),
    ('Yohannes Gezachew', 'yohannes@example.com', '5555555555', 'Addis Ababa', 'password3');


-- Insert data into the Ticket table
INSERT INTO Ticket (DepartureCity, DestinationCity, DepartureDateTime, ArrivalDateTime, Price, SeatNumber, UserID, DriverID)
VALUES
    ('Addis Ababa', 'Dire Dawa', '2024-02-01 08:00:00', '2024-02-01 16:00:00', 150.00, 10, 1, 1),
    ('Bishoftu', 'Adama', '2024-02-02 09:30:00', '2024-02-02 18:00:00', 180.00, 15, 2, 2),
    ('Mekelle', 'Jimma', '2024-02-03 11:15:00', '2024-02-03 20:30:00', 200.00, 20, 3, 3),
    ('Bahir Dar', 'Arba Minch', '2024-02-04 10:45:00', '2024-02-04 19:15:00', 170.00, 12, 4, 4),
    ('Bishoftu', 'Dessie', '2024-02-05 12:30:00', '2024-02-05 21:45:00', 190.00, 18, 5, 5),
    ('Adama', 'Sodo', '2024-02-06 14:20:00', '2024-02-06 23:30:00', 160.00, 8, 6, 6);



-- Insert data into the Bus table
INSERT INTO Bus (BusLevel, BusType, LicensePlate, CurrentCity, DriverID)
VALUES
    ('Level 1', 'Minibus', 'ABC123', 'Addis Ababa', 1),
    ('Level 2', 'Autobus', 'XYZ456', 'Addis Ababa', 2),
    ('Level 1', 'Selambus', 'DEF789', 'Addis Ababa', 3),
    ('Level 2', 'Dolphine', 'GHI101', 'Addis Ababa', 4),
    ('Level 1', 'Minibus', 'JKL202', 'Addis Ababa', 5),
    ('Level 2', 'Autobus', 'MNO303', 'Addis Ababa', 6);

-- Insert data into the Reservation table
INSERT INTO Reservation (UserID, TicketID, SeatNumber)
VALUES
    (1, 1, 10),
    (2, 2, 15),
    (3, 3, 20),
    (4, 4, 12),
    (5, 5, 18),
    (6, 6, 8);

-- Insert data into the Payment table with different payment methods
INSERT INTO Payment (UserID, TicketID, PaymentMethod, Price, Status)
VALUES
    (1, 1, 'Telebirr', 150.00, 'Paid'),
    (2, 2, 'CBE', 180.00, 'Paid'),
    (3, 3, 'Cash', 200.00, 'Paid'),
    (4, 4, 'Telebirr', 170.00, 'Paid'),
    (5, 5, 'Cash', 190.00, 'Paid'),
    (6, 6, 'CBE', 160.00, 'Paid');

-- Insert data into the Transaction table for payments
INSERT INTO Transaction (UserID, price, TransactionType)
VALUES
    (1, 150.00, 'Payment'),
    (2, 180.00, 'Payment'),
    (3, 200.00, 'Payment'),
    (4, 170.00, 'Payment'),
    (5, 190.00, 'Payment'),
    (6, 160.00, 'Payment');
-- ------------------------------------------------------ Transaction ---------------------------------------------------------
use TicketingSystemDB;
START TRANSACTION;
-- Step 1: User Registration
INSERT INTO User (UserName, UserEmail, UserAddress, UserPhone, UserPassword)
VALUES ('Yonas Zekarias', 'yonas.zekarias@example.com', '123 Main St', '555-1234', 'password123');

-- Get the ID of the newly added user
SET @yonasUserId = LAST_INSERT_ID();

-- Display the details of the new user
SELECT * FROM User WHERE UserID = @yonasUserId;

-- Step 2: Ticket Selection
SET @selectedTicketId = 1;  

-- Display the available ticket details
SELECT * FROM Ticket WHERE TicketID = @selectedTicketId;

-- Step 3: Reservation
-- User makes a reservation
INSERT INTO Reservation (UserID, TicketID, SeatNumber)
VALUES (@yonasUserId, @selectedTicketId, 15);  -- we can enter desired seat number

-- Display the reservation details
SELECT * FROM Reservation WHERE UserID = @yonasUserId;

-- Step 4: Payment
SET @paymentMethod = 'Telebirr';  

-- user makes payment
INSERT INTO Payment (UserID, TicketID, PaymentMethod, Price, Status)
VALUES (@yonasUserId, @selectedTicketId, @paymentMethod, 150.00, 'Paid');

-- Step 4: Transaction

-- Record the payment transaction
INSERT INTO Transaction (UserID, Price, TransactionType)
VALUES (@yonasUserId, @ticketPrice, 'Payment');
-- Display the transaction history for the user
SELECT * FROM Transaction WHERE UserID = @yonasUserId;
COMMIT;
    
-- ------------------------------------------------------ View  --------------------------------------------------------------------------------------------
    
CREATE VIEW RESERVATION_LIST AS
SELECT
    U.UserName,
    D.DriverName,
    T.DepartureCity,
    T.DestinationCity,
    T.DepartureDateTime,
    T.ArrivalDateTime,
    T.Price,
    P.PaymentMethod,
    T.SeatNumber
FROM
    Reservation R
    JOIN User U ON R.UserID = U.UserID
    JOIN Ticket T ON R.TicketID = T.TicketID
    JOIN Driver D ON T.DriverID = D.DriverID
    JOIN Payment P ON R.TicketID = P.TicketID;
select * from RESERVATION_LIST;
 
CREATE VIEW Driver_Info AS
select 
D.DriverName,
D.DriverEmail,
D.DriverAddress,
D.DriverPhone,
B.LicensePlate,
B.BusType,
B.Buslevel
 From 
 Bus B
 JOIN Driver D ON B.DriverID = D.DriverID;

select * from Driver_Info;


CREATE VIEW User_Info AS
SELECT
U.UserName,
U.UserPhone,
U.UserEmail,
U.UserAddress,
B.BusLevel,
B.BusType,
B.LicensePlate,
T.SeatNumber,
D.DriverName
From
Ticket T
JOIN User U ON T.UserID = U.UserID
JOIN Driver D On T.DriverID = D.DriverID
JOIN Bus B on B.DriverID = D.DriverID;

select * from User_info;


CREATE VIEW UserTransactionHistory AS
SELECT
    U.UserName,
    T.TransactionID,
    T.price,
    T.TransactionDateTime,
    T.TransactionType
FROM
    Transaction T
    JOIN User U ON T.UserID = U.UserID;
    
select * from UserTransactionHistory;

-- ------------------------------------------------------ Procedure  --------------------------------------------------------------------------------------------
-- a.  GetAllUserDeatil()
       -- Returns a specific user detail: no parameter
DELIMITER //
CREATE PROCEDURE GetAllUserDeatil()
BEGIN
	SELECT *
	FROM User;
END//
DELIMITER ;
call  GetAllUserDeatil();

-- B.  GetUserDeatil()
       -- Returns a specific user detail
       -- takes userID as a parameter
DELIMITER //
CREATE PROCEDURE GetUserDetails(IN p_user_id INT)
BEGIN
    SELECT *
    FROM User
    WHERE UserID = p_user_id;
END //
DELIMITER ;

-- C.  GetDriverrDeatil()
       -- Returns a specific driver detail
       -- takes DriverID as a parameter
DELIMITER //
CREATE PROCEDURE GetDriverDetails(IN d_driver_id INT)
BEGIN
    SELECT *
    FROM Driver
    WHERE DriverID = d_driver_id;
END //
DELIMITER ;	

-- D.GetUserReservations
	-- Return user reservation list
    -- takes UserID as a parameter
DELIMITER //
CREATE PROCEDURE GetUserReservations(IN userId INT)
BEGIN
    SELECT
        R.ReservationID,
        T.TicketID,
        T.DepartureCity,
        T.DestinationCity,
        T.DepartureDateTime,
        T.ArrivalDateTime,
        T.Price,
        R.SeatNumber,
        R.ReservationDateTime
    FROM
        Reservation AS R
    JOIN
        Ticket AS T ON R.TicketID = T.TicketID
    WHERE
        R.UserID = userId;
END //

DELIMITER ;

-- E.UpdateUser()
	-- Updates a specific user info
    -- takes UserID,UserName,UserEmail,UserAddress,UserPhone and UserPassword as a parameter
DELIMITER //
CREATE PROCEDURE UpdateUser(
   IN U_UserID INT ,
   IN U_UserName VARCHAR(50),
   IN U_UserEmail VARCHAR(30),
   IN U_UserAddress VARCHAR(50),
   IN U_UserPhone VARCHAR(50),
   IN U_UserPassword VARCHAR(20)
)
BEGIN
    UPDATE User
    SET
		UserName = U_UserName,  
		UserEmail = U_UserEmail,
		UserAddress = U_UserAddress, 
		UserPhone = U_UserPhone,
		UserPassword = U_UserPassword
    WHERE
        UserID = U_UserID;
END//


DELIMITER ;
-- F. GetReservationDetails:
	-- It retrieves details about a specific reservation, including the user, ticket, and payment information.
	-- takes p_reservation_id as a parameter.
DELIMITER //
CREATE PROCEDURE GetReservationDetails(IN p_reservation_id INT)
BEGIN
    SELECT
        R.ReservationID,
        U.UserName,
        T.DepartureCity,
        T.DestinationCity,
        T.DepartureDateTime,
        T.ArrivalDateTime,
        T.Price,
        R.SeatNumber,
        R.ReservationDateTime,
        P.PaymentMethod,
        P.Status
    FROM
        Reservation R
        JOIN User U ON R.UserID = U.UserID
        JOIN Ticket T ON R.TicketID = T.TicketID
        JOIN Payment P ON R.TicketID = P.TicketID
    WHERE
        R.ReservationID = p_reservation_id;
END //
DELIMITER ;
-- ------------------------------------------------------ Triggers  --------------------------------------------------------------------------------------------

-- A Table To store Audit Information for a specifc table
CREATE TABLE AuditTrail (
    AuditID INT AUTO_INCREMENT,
    Action VARCHAR(10),     
    TableName VARCHAR(50),   
    RecordID INT,            
    Timestamp DATETIME,      
    PRIMARY KEY (AuditID)
);
 
 -- Trigger for User table
DELIMITER //
CREATE TRIGGER User_Audit
AFTER INSERT ON User
FOR EACH ROW
BEGIN
    INSERT INTO AuditTrail (Action, TableName, RecordID, Timestamp)
    VALUES ('INSERT', 'User', NEW.UserID, NOW());
END;
//

DELIMITER ;

DELIMITER //
CREATE TRIGGER User_Audit_Update
AFTER UPDATE ON User
FOR EACH ROW
BEGIN
    INSERT INTO AuditTrail (Action, TableName, RecordID, Timestamp)
    VALUES ('UPDATE', 'User', NEW.UserID, NOW());
END;
//

DELIMITER ;

DELIMITER //
CREATE TRIGGER User_Audit_Delete
AFTER DELETE ON User
FOR EACH ROW
BEGIN
    INSERT INTO AuditTrail (Action, TableName, RecordID, Timestamp)
    VALUES ('DELETE', 'User', OLD.UserID, NOW());
END;
//

DELIMITER ;

-- Trigger for Driver table
DELIMITER //
CREATE TRIGGER Driver_Audit
AFTER INSERT ON Driver
FOR EACH ROW
BEGIN
    INSERT INTO AuditTrail (Action, TableName, RecordID, Timestamp)
    VALUES ('INSERT', 'Driver', NEW.DriverID, NOW());
END;
//

DELIMITER ;


DELIMITER //
CREATE TRIGGER Driver_Audit_Update
AFTER UPDATE ON Driver
FOR EACH ROW
BEGIN
    INSERT INTO AuditTrail (Action, TableName, RecordID, Timestamp)
    VALUES ('UPDATE', 'Driver', NEW.DriverID, NOW());
END;
//

DELIMITER ;


DELIMITER //
CREATE TRIGGER Driver_Audit_Delete
AFTER DELETE ON Driver
FOR EACH ROW
BEGIN
    INSERT INTO AuditTrail (Action, TableName, RecordID, Timestamp)
    VALUES ('DELETE', 'Driver', OLD.DriverID, NOW());
END;
//

DELIMITER ;

-- Trigger for Ticket table
DELIMITER //
CREATE TRIGGER Ticket_Audit
AFTER INSERT ON Ticket
FOR EACH ROW
BEGIN
    INSERT INTO AuditTrail (Action, TableName, RecordID, Timestamp)
    VALUES ('INSERT', 'Ticket', NEW.TicketID, NOW());
END;
//

DELIMITER ;


DELIMITER //
CREATE TRIGGER Ticket_Audit_Update
AFTER UPDATE ON Ticket
FOR EACH ROW
BEGIN
    INSERT INTO AuditTrail (Action, TableName, RecordID, Timestamp)
    VALUES ('UPDATE', 'Ticket', NEW.TicketID, NOW());
END;
//

DELIMITER ;


DELIMITER //
CREATE TRIGGER Ticket_Audit_Delete
AFTER DELETE ON Ticket
FOR EACH ROW
BEGIN
    INSERT INTO AuditTrail (Action, TableName, RecordID, Timestamp)
    VALUES ('DELETE', 'Ticket', OLD.TicketID, NOW());
END;
//
DELIMITER ;

SHOW TRIGGERS;

-- ---------------------------------------------------- Security ------------------------------------------------------------------------------

-- Yonas
CREATE USER 'Yonas'@'localhost' IDENTIFIED BY '12345678';
GRANT SELECT, INSERT, UPDATE, DELETE ON TicketingSystemDB.User TO 'Yonas'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON TicketingSystemDB.Driver TO 'Yonas'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON TicketingSystemDB.Payment TO 'Yonas'@'localhost';

SHOW GRANTS FOR 'Yonas'@'localhost';

-- Naol
CREATE USER 'Naol'@'localhost' IDENTIFIED BY '12345678';
GRANT SELECT, INSERT, UPDATE, DELETE ON TicketingSystemDB.Bus TO 'Naol'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON TicketingSystemDB.Reservation TO 'Naol'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON TicketingSystemDB.Ticket TO 'Naol'@'localhost';

SHOW GRANTS FOR 'Naol'@'localhost';

-- Abuzer
CREATE USER 'Abuzer'@'localhost' IDENTIFIED BY '12345678';
GRANT SELECT, INSERT, UPDATE, DELETE ON TicketingSystemDB.User TO 'Abuzer'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON TicketingSystemDB.Driver TO 'Abuzer'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON TicketingSystemDB.Bus TO 'Abuzer'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON TicketingSystemDB.Ticket TO 'Abuzer'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON TicketingSystemDB.Reservation TO 'Abuzer'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON TicketingSystemDB.Payment TO 'Abuzer'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON TicketingSystemDB.Transaction TO 'Abuzer'@'localhost';

SHOW GRANTS FOR 'Abuzer'@'localhost';
