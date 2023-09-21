
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


