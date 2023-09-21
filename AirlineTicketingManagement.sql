-- AIRLINE TIICKET MANAGEMENT SYSTEM

-- Group: 2
-- Kiya kebe - ugr/25298/14
-- Fitsum Tafesa - UGR/25418/14
-- Bereket Daniel - UGR/25430/14
-- Hayat Musa - UGR/25497/14
-- Feleke Birhanu - UGR/25967/14

-- CREATE TABLES - line 10 - 132

USE AirlineTicketReservation;

-- Table 1

CREATE TABLE Airline
(
    AirlineID VARCHAR(10),
    AirlineName VARCHAR(50),
    IATACode VARCHAR(4),

    PRIMARY KEY (AirlineID)
);

-- Table 2

CREATE TABLE AirPorts
(
    AirPortID VARCHAR(10),
    AirpotName VARCHAR(20),
    AirlineID VARCHAR(10),
    PortLocation VARCHAR(100),

    PRIMARY KEY(AirPortID),

    FOREIGN KEY (AirlineID) REFERENCES Airline(AirlineID)
);

-- Table 3

CREATE TABLE Planes
(
    PlaneId VARCHAR(10),
    OwnerAirline VARCHAR(10),
    Capacity INT,

    PRIMARY KEY(PlaneId),

    FOREIGN KEY (OwnerAirline) REFERENCES Airline(AirlineID)
);

-- Table 4

CREATE TABLE Flight
(
    FlightID VARCHAR(10),
    AirlineID VARCHAR(10),
    PlaneId VARCHAR(10),
    DepartureAirport VARCHAR(10),
    ArrivalAirport VARCHAR(10),
    DepartueDate DATE,
    DepartureTime TIME,
    ArrivalTime TIME,
    Price float,

    PRIMARY KEY(FlightID),

    FOREIGN KEY (AirlineID) REFERENCES Airline(AirlineID),
    FOREIGN KEY (PlaneId) REFERENCES Planes(PlaneId),
    FOREIGN KEY (DepartureAirport) REFERENCES AirPorts(AirPortID),
    FOREIGN KEY (ArrivalAirport) REFERENCES AirPorts(AirPortID)
);

-- Table 5

-- We can get the specific place and airport detail from the fliight, so we do not need to include them here

CREATE TABLE Seats
(
    SeatNumber INT IDENTITY(1,1),
    FlightID VARCHAR(10),
    IsReserved INT,

    PRIMARY KEY (SeatNumber, FlightID), --composite primary key
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID)
);

-- Table 6

CREATE TABLE Passengers
(
    PassengerID INT IDENTITY(1,1),
    FullName VARCHAR(50),
    Email VARCHAR(50),
    Gender VARCHAR(1),
    Contact VARCHAR(15),
    Birthdate DATE,
    Nationality VARCHAR(20),
    EmmergencyName VARCHAR(50),
    EmergencyContact VARCHAR(15),

    PRIMARY KEY(PassengerID)
);

-- Table 7

CREATE TABLE Bookings
(
    BookingID VARCHAR(10),
    FlightID VARCHAR(10),
    SeatNumber INT,
    PassengerID INT,
    BookingDate DATE,

    PRIMARY KEY(BookingID),

    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID),
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID)
);

-- Table 8

CREATE TABLE Ticket
(
    TicketID VARCHAR(10),
    BookingID VARCHAR(10),
    PaymentCompleted Int,

    PRIMARY Key(TicketID),

    FOREIGN key ( BookingID ) REFERENCES Bookings(BookingID)
);


-- ========================================================================================================================

-- POPULATING THE DATA

-- Table 1

INSERT INTO Airline
    (AirlineID, AirlineName, IATACode)
VALUES
    ('A001', 'Ethiopian Airline', 'ET'),
    ('A002', 'Fly Emirates', 'EK'),
    ('A003', 'BRITISH AIRWAYS P.L.C.', 'BA'),
    ('A004', 'AIR INDIA LTD.', 'AI'),
    ('A005', 'FINNAIR O/Y', 'AY');

-- Table 2

INSERT INTO AirPorts
    (AirPortID, AirpotName, AirlineID, PortLocation)
VALUES
    ('AP001', 'Adiss Ababa Airport', 'A001', 'Ethiopia, Adiss Ababa'),
    ('AP002', 'Adama Airport', 'A001', 'Ethiopia, Adama'),
    ('AP003', 'Jimma Airport', 'A001', 'Ethiopia, Jimma'),
    ('AP004', 'Emirates Airport', 'A002', 'Arab Emirates, Emirates'),
    ('AP005', 'BRITISH Airport', 'A003', 'Biritain, London'),
    ('AP006', 'AIR INDIA Airport', 'A004', 'India, New Delhi'),
    ('AP007', 'FINNAIR O/Y Airport', 'A005', 'China, Chicago');

-- Table 3
-- Since 'A001' is the airport using this system all the plane belong to 'A001'

INSERT INTO Planes
    (PlaneId, OwnerAirline, Capacity)
VALUES
    ('P001', 'A001', 200),
    ('P002', 'A001', 150),
    ('P003', 'A001', 180),
    ('P004', 'A001', 220),
    ('P005', 'A001', 30), -- we need small number of seats for demonstration
    ('P006', 'A001', 210),
    ('P007', 'A001', 170),
    ('P008', 'A001', 160);

-- Table 4

-- since 'A001' is using the system all flights go throug 'A001'
-- we have created 4 flights to for demostration

INSERT INTO Flight
    (FlightID, AirlineID, PlaneId, DepartureAirport, ArrivalAirport, DepartueDate, DepartureTime, ArrivalTime, Price)
VALUES
    ('F001', 'A001', 'P001', 'AP004', 'AP001', '2023-09-26', '09:30:00', '11:30:00', 250.0),
    ('F002', 'A001', 'P005', 'AP001', 'AP001', '2023-09-24', '09:30:00', '11:30:00', 250.0), -- we have used this flight to demonstrate the transaction
    ('F003', 'A001', 'P008', 'AP007', 'AP001', '2023-09-26', '09:30:00', '11:30:00', 250.0),
    ('F004', 'A001', 'P003', 'AP001', 'AP005', '2023-09-28', '09:30:00', '11:30:00', 150.0),
    ('F005', 'A001', 'P008', 'AP007', 'AP001', '2023-09-21', '09:30:00', '11:30:00', 250.0),
    ('F006', 'A001', 'P003', 'AP001', 'AP005', '2023-09-30', '09:30:00', '11:30:00', 150.0);

-- Table 5

-- As we mentioned earlier, we have inserted 30 seats for the flight 'F002'

INSERT INTO Seats (FlightID, IsReserved)
SELECT TOP 30 'F002', 0 --ensures that only the top 30 rows are selected.
FROM sys.syscolumns -- generate multiple rows without explicitly specifying the column values.

-- Table 6

INSERT INTO Passengers (FullName, Email, Gender, Contact, Birthdate, Nationality, EmmergencyName, EmergencyContact)
VALUES
    ('Abebe Kebede', 'abebe.kebede@example.com', 'M', '+251912345678', '1995-01-01', 'Ethiopia', 'Jane Doe', '+251987654321'),
    ('Meskerem Mekonnen', 'meskerem.mekonnen@example.com', 'F', '+251987654321', '1990-03-15', 'Ethiopia', 'John Smith', '+251123456789'),
    ('Mulugeta Haile', 'mulugeta.haile@example.com', 'M', '+251555555555', '1985-07-10', 'Ethiopia', 'Michelle Johnson', '+251666666666'),
    ('Sara Alemu', 'sara.alemu@example.com', 'F', '+251999999999', '1993-11-28', 'Ethiopia', 'Ethan Davis', '+251111111111'),
    ('Temesgen Hailu', 'temesgen.hailu@example.com', 'M', '+251222222222', '1989-06-05', 'Ethiopia', 'Danielle Wilson', '+251444444444'),
    ('Genet Assefa', 'genet.assefa@example.com', 'F', '+251777777777', '1992-09-17', 'Ethiopia', 'Samuel Anderson', '+251888888888'),
    ('Mekonnen Tadesse', 'mekonnen.tadesse@example.com', 'M', '+251666666666', '1995-02-03', 'Ethiopia', 'Olivia Taylor', '+251555555555'),
    ('Yeshiwork Tsegaye', 'yeshiwork.tsegaye@example.com', 'F', '+251444444444', '1990-04-20', 'Ethiopia', 'Elijah Brown', '+251222222222'),
    ('Solomon Assefa', 'solomon.assefa@example.com', 'M', '+251888888888', '1994-08-08', 'Ethiopia', 'Alexander Martinez', '+251777777777'),
    ('Alemnesh Berhanu', 'alemnesh.berhanu@example.com', 'F', '+251111111111', '1988-12-12', 'Ethiopia', 'Sophie Clark', '+251999999999'),
    ('Mulualem Tekle', 'mulualem.tekle@example.com', 'M', '+251911111111', '1990-01-01', 'Ethiopia', 'Selamawit Alemu', '+251911111112'),
    ('Hirut Gebremedhin', 'hirut.gebremedhin@example.com', 'F', '+251922222222', '1993-03-15', 'Ethiopia', 'Birhanu Mekonnen', '+251922222223'),
    ('Yonas Tadesse', 'yonas.tadesse@example.com', 'M', '+251933333333', '1988-07-10', 'Ethiopia', 'Tigist Hailu', '+251933333334'),
    ('Aster Mengistu', 'aster.mengistu@example.com', 'F', '+251944444444', '1992-11-28', 'Ethiopia', 'Abel Mulugeta', '+251944444445'),
    ('Solomon Abebe', 'solomon.abebe@example.com', 'M', '+251955555555', '1987-06-05', 'Ethiopia', 'Meron Kebede', '+251955555556'),
    ('Alemnesh Gebre', 'alemnesh.gebre@example.com', 'F', '+251966666666', '1991-09-17', 'Ethiopia', 'Fikru Berhanu', '+251966666667'),
    ('Elias Alemayehu', 'elias.alemayehu@example.com', 'M', '+251977777777', '1990-02-03', 'Ethiopia', 'Rahel Tekle', '+251977777778'),
    ('Kidist Tefera', 'kidist.tefera@example.com', 'F', '+251988888888', '1992-04-20', 'Ethiopia', 'Nebiyu Gebremedhin', '+251988888889'),
    ('Dawit Tsegaye', 'dawit.tsegaye@example.com', 'M', '+251999999999', '1989-08-08', 'Ethiopia', 'Winta Tesfaye', '+251999999990'),
    ('Rahel Hailu', 'rahel.hailu@example.com', 'F', '+251910101010', '1991-12-12', 'Ethiopia', 'Yosef Mekonnen', '+251910101011'),
    ('Fikadu Assefa', 'fikadu.assefa@example.com', 'M', '+251921212121', '1994-01-01', 'Ethiopia', 'Genet Tesfaye', '+251921212122'),
    ('Tirhas Girma', 'tirhas.girma@example.com', 'F', '+251932323232', '1989-03-15', 'Ethiopia', 'Gizachew Bekele', '+251932323233'),
    ('Abel Assefa', 'abel.assefa@example.com', 'M', '+251943434343', '1992-07-10', 'Ethiopia', 'Birtukan Demissie', '+251943434344'),
    ('Hanna Mekonnen', 'hanna.mekonnen@example.com', 'F', '+251954545454', '1988-11-28', 'Ethiopia', 'Yared Hailu', '+251954545455'),
    ('Nardos Gebre', 'nardos.gebre@example.com', 'F', '+251965656565', '1991-06-05', 'Ethiopia', 'Teshome Gebremedhin', '+251965656566'),
    ('Mulugeta Berhanu', 'mulugeta.berhanu@example.com', 'M', '+251976767676', '1993-09-17', 'Ethiopia', 'Amira Tadesse', '+251976767677'),
    ('Sosina Tekle', 'sosina.tekle@example.com', 'F', '+251987878787', '1995-02-03', 'Ethiopia', 'Nathan Mulugeta', '+251987878788'),
    ('Mekonnen Haile', 'mekonnen.haile@example.com', 'M', '+251998989898', '1990-04-20', 'Ethiopia', 'Rebecca Alemu', '+251998989899'),
    ('Yetnebersh Assefa', 'yetnebersh.assefa@example.com', 'F', '+251909090909', '1994-08-08', 'Ethiopia', 'Ephrem Haile', '+251909090910');


-- ==================================================================================================================

-- SELECT STATEMENT FROM ALL TABLE
-- Table 1

SELECT AirlineID, AirlineName, IATACode
FROM Airline;
-- Table 2
SELECT AirPortID, AirpotName, AirlineID, PortLocation
FROM AirPorts;
-- Table 3
SELECT PlaneId, OwnerAirline, Capacity
FROM Planes;
-- Table 4 flight
SELECT FlightID, AirlineID, PlaneId, DepartureAirport, ArrivalAirport, DepartueDate, DepartureTime, ArrivalTime, Price
FROM Flight;
-- Table 5
SELECT SeatNumber, FlightID, IsReserved
FROM Seats;
-- Table 6
SELECT PassengerID, FullName, Email, Gender, Contact, Birthdate, Nationality, EmmergencyName, EmergencyContact
FROM Passengers;
-- Table 7
SELECT BookingID, FlightID, SeatNumber, PassengerID, BookingDate
FROM Bookings;
DELETE from Bookings;
-- Table 8
SELECT TicketID, BookingID, PaymentCompleted
FROM Ticket;

-- *******************************
-- joins, subqueries, and aggregate 


-- DISPLAY AVOILABLE FLIIGHTS
CREATE VIEW dbo.AvoilableBookings
AS
    SELECT SeatNumber, FlightID, IsReserved
    FROM Seats where IsReserved = 0;
GO
select * from AvoilableBookings;

-- DISPLAY PASSENGERS LIST AND HIDE SOME INFORMATION ABOUT THEM
GO
CREATE VIEW dbo.PassengersList
AS
SELECT FullName, Email, Gender, Contact, Birthdate, Nationality -- LETS IMAGIN PassengerID is private
FROM Passengers;
GO
select * from PassengersList

-- DISPLAY ALL FLIGHTS AVOILABLE IN THE AIRPORT
GO
CREATE VIEW dbo.FlightList
AS
SELECT FlightID, AirlineID, PlaneId, DepartureAirport, ArrivalAirport, DepartueDate, DepartureTime, ArrivalTime, Price
FROM Flight;
GO
SELECT * FROM FlightList;

-- DISPLAY BOOKINGS THAT ARE NOT COMPLETED - with complex quey
GO
CREATE VIEW dbo.UncompletedBooking
As 
SELECT BookingID, FlightID, SeatNumber, PassengerID, BookingDate
FROM Bookings
    WHERE BookingID NOT IN 
   ( SELECT BookingID FROM Ticket);

GO

DROP VIEW UncompletedBooking;

SELECT * FROM UncompletedBooking

GO
-- CUSTOMERS WHO HAVE BOOKING - with join
CREATE VIEW dbo.PassengersWithBooking
AS
SELECT Passengers.PassengerID, Passengers.FullName, Passengers.Email
FROM Passengers
INNER JOIN Bookings
ON Passengers.PassengerID = Bookings.PassengerID;

GO

SELECT * FROM PassengersWithBooking

-- CALCULATE TOTAL EARNINGS - with aggregate function and subquery
GO
CREATE VIEW dbo.TotalAirlineEarning
AS
    SELECT SUM(Price) AS Total
    FROM Flight WHERE FlightID IN
    (SELECT FlightID FROM Bookings WHERE BookingID IN(
        SELECT BookingID FROM Bookings WHERE BookingID IN(
            SELECT BookingID FROM Ticket
        )
    ));

GO

PRINT 'The totla earning of the airpory'

SELECT Total from TotalAirlineEarning;


-- ========================================================================================================================
-- comprehensive scenario of transaction


-- Booking management transaction

CREATE PROCEDURE BookingTransaction
    @SeatNumber INT,
    @FlightID VARCHAR(10),
    @IsReserved INT,
    -- selected from the table based on SeatNumber and FlightID

    @BookingID VARCHAR(10),
    @PassengerID INT
-- We Only registered 28 passengers with Id 1 - 28

AS
BEGIN
    BEGIN TRAN
    BEGIN TRY
            -- UPDATE RESERVED TO TRUE
        SELECT @IsReserved = IsReserved FROM Seats WHERE SeatNumber = @SeatNumber AND FlightID = @FlightID;

        IF @IsReserved = 0
        BEGIN
            UPDATE Seats
                SET IsReserved = 1
                WHERE SeatNumber = @SeatNumber AND FlightID = @FlightID;

            --add to booking
            INSERT INTO Bookings
                (BookingID, FlightID, PassengerID, BookingDate, SeatNumber)
            VALUES
                (@BookingID, @FlightID, @PassengerID, FORMAT(GETDATE(), 'yyyy-MM-dd'), @SeatNumber);

            PRINT 'Booking successfull! Please finish your booking by completing your payment.';
        END
        ELSE
        BEGIN
            PRINT 'The selected seat is not avoilable or Not valid!'
        END
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;
        PRINT 'Transaction rolled back due to an error: ' + ERROR_MESSAGE();

    END CATCH
    COMMIT TRAN
END;


DROP PROCEDURE dbo.BookingTransaction;
-- As we mentioned earlier, we have inserted 30 seats for the flight 'F002'
-- So for demonstration we have to only use 'F002'

EXECUTE BookingTransaction
    @SeatNumber = 19,
    @FlightID = 'F002',
    @BookingID = 'B0004',
    @PassengerID = 12,
	@IsReserved = 0;

-- only from ( 1 - 28 ) - the reason is mentioned above

-- we are going to use flight Id from (1 - 28) since we only have 28 passengers

-- Ticketing management transaction
-- ticketing system after the payment is complete

GO

CREATE PROCEDURE TicketingTransaction
    @TicketID VARCHAR(10),
    @BookingID VARCHAR(10),
    @PaymentCompleted INT
AS
BEGIN

    BEGIN TRAN
    BEGIN TRY

    -- add to ticket table if it is paid

        IF @PaymentCompleted = 1
        BEGIN

        INSERT INTO Ticket
            (TicketID, BookingID, PaymentCompleted)
        VALUES
            (@TicketID, @BookingID, @PaymentCompleted)
        PRINT 'Ticketing successfull! Your ticket Id is: ' + @TicketID;
    END
        ELSE
        BEGIN
        PRINT 'Ticketing was not successful, Try again.'
    END
    PRINT 'TRANSACTION'
    END TRY
    BEGIN CATCH

    ROLLBACK TRANSACTION
    PRINT 'Transaction rolled back due to an error: ' + ERROR_MESSAGE()

    END CATCH

    COMMIT TRAN

END;


EXECUTE TicketingTransaction
    @TicketID  = 'T0001',
    @BookingID  = 'B0001', -- the booking we have created in the above transaction
    -- It is assumed the passenger finishes the payment throught digital payment 
    -- the api will return PaymentCompleted code 1 when the payment is success
    @PaymentCompleted = 1; -- one mean completed the payment


-- remove booking if payment is noot compleeted

GO

CREATE PROCEDURE RollBAckBooking
    @BookingID VARCHAR(10),
    @FlightID VARCHAR(10),
    @SeatNumber INT
AS

-- TO TEST THIS TRANSACTION WE HAVE TO CREATE ANOTHER BOOKING WITH BookingID = 'B0001'ፍ

BEGIN
    BEGIN TRY
    --REMOVE FROM BOOKING
    DELETE FROM Bookings
    WHERE BookingID = @BookingID -- the booking to be rolled back

    -- UPDATE THE SEAT STATUS TO UNBOOKED
    SELECT @FlightID = FlightID, @SeatNumber = SeatNumber FROM Bookings WHERE BookingID = @BookingID
    UPDATE Seats SET IsReserved = 0 WHERE SeatNumber = @SeatNumber AND FlightID = @FlightID

   END TRY
   BEGIN CATCH
   ROLLBACK TRANSACTION
   PRINT 'Transaction rolled back due to an error: ' + ERROR_MESSAGE()
   END CATCH

END;

EXECUTE RollBAckBooking
    @BookingID = 'B0002'

-- ===========================================================================================================================
-- views and procedures

-- ** view


-- DISPLAY AVOILABLE FLIIGHTS
CREATE VIEW dbo.AvoilableBookings
AS
    SELECT SeatNumber, FlightID, IsReserved
    FROM Seats where IsReserved = 0;
GO
select * from AvoilableBookings;

-- DISPLAY PASSENGERS LIST AND HIDE SOME INFORMATION ABOUT THEM
GO
CREATE VIEW dbo.PassengersList
AS
SELECT FullName, Email, Gender, Contact, Birthdate, Nationality -- LETS IMAGIN PassengerID is private
FROM Passengers;
GO
select * from PassengersList

-- DISPLAY ALL FLIGHTS AVOILABLE IN THE AIRPORT
GO
CREATE VIEW dbo.FlightList
AS
SELECT FlightID, AirlineID, PlaneId, DepartureAirport, ArrivalAirport, DepartueDate, DepartureTime, ArrivalTime, Price
FROM Flight;
GO
SELECT * FROM FlightList;

-- DISPLAY BOOKINGS THAT ARE NOT COMPLETED - with complex quey
GO
CREATE VIEW dbo.UncompletedBooking
As 
SELECT BookingID, FlightID, SeatNumber, PassengerID, BookingDate
FROM Bookings
    WHERE BookingID NOT IN 
   ( SELECT BookingID FROM Ticket);

GO

DROP VIEW UncompletedBooking;

SELECT * FROM UncompletedBooking

GO
-- CUSTOMERS WHO HAVE BOOKING - with join
CREATE VIEW dbo.PassengersWithBooking
AS
SELECT Passengers.PassengerID, Passengers.FullName, Passengers.Email
FROM Passengers
INNER JOIN Bookings
ON Passengers.PassengerID = Bookings.PassengerID;

GO

SELECT * FROM PassengersWithBooking

-- CALCULATE TOTAL EARNINGS - with aggregate function and subquery
GO
CREATE VIEW dbo.TotalAirlineEarning
AS
    SELECT SUM(Price) AS Total
    FROM Flight WHERE FlightID IN
    (SELECT FlightID FROM Bookings WHERE BookingID IN(
        SELECT BookingID FROM Bookings WHERE BookingID IN(
            SELECT BookingID FROM Ticket
        )
    ));
GO

PRINT 'The totla earning of the airpory'

SELECT Total from TotalAirlineEarning;


-- ** procedure

-- filter flighs based on price

CREATE PROCEDURE FilterFlightsByPrice
    @maxPrice FLOAT
AS
BEGIN
    SELECT *
    FROM Flight
    WHERE Price <= @maxPrice;
END;

DROP PROCEDURE FilterFlightsByPrice;

EXECUTE FilterFlightsByPrice
    @maxPrice = 200

-- Filter Flights based on date oF departure

GO

CREATE PROCEDURE FilterFlightsByDate
    @departueDate DATE
AS
BEGIN
    SELECT *
    FROM Flight
    WHERE DepartueDate = @departueDate;
END;

EXECUTE FilterFlightsByDate
    @departueDate = '2023-09-26'

-- SIMPLE REPORT 

PRINT 'The Total Earning of the Airline  is: ' + SELECT Total from TotalAirlineEarning;
DECLARE @AverageIncome DECIMAL(10,2);
PRINT 'That means the average income per person is: ' + SELECT @AverageIncome = Total / COUNT(*) FROM TotalAirlineEarning, PassengersWithBooking;
PRINT 'The Total number of customers that the company has ' + SELECT COUNT(*) FROM YourTableName;
PRINT 'The number of total flight the airport have ever had: ' + SELECT COUNT(*) FROM FlightList;
PRINT 'Total avoilable bookings of the airport: ' + SELECT COUNT(*) FROM AvoilableBookings;
PRINT 'The total number of uncomplete booking: ' + SELECT COUNT(*) FROM UncompletedBooking;
PRINT 'The total passengers that have a booking: ' + SELECT COUNT(*) FROM PassengersWithBooking;

-- =======================================================================================================================
-- Implement security

EXEC sp_addlogin 'MainAdmin', 'M123', 'AirlineTicketReservation'
GRANT SELECT, INSERT, UPDATE, DELETE ON Airline TO MainAdmin;
GRANT SELECT, INSERT, UPDATE, DELETE ON AirPorts TO MainAdmin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Planes TO MainAdmin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Flight TO MainAdmin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Customer_order TO MainAdmin

EXEC sp_addlogin 'AirportAdmin', 'A123', 'AirlineTicketReservation'
GRANT SELECT ON Bookings TO AirportAdmin
GRANT SELECT ON Passengers TO AirportAdmin

EXEC sp_addlogin 'BookingAdminstrator', 'B123', 'AirlineTicketReservation'
GRANT SELECT ON Bookings TO customer;
GRANT SELECT ON Ticket TO customer;

EXEC sp_addlogin 'PassengerAdminstrator', 'B123', 'AirlineTicketReservation'
GRANT SELECT ON Passengers TO customer;

