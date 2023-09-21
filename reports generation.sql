
CREATE VIEW dbo.PassengersList
AS
SELECT FullName, Email, Gender, Contact, Birthdate, Nationality -- LETS IMAGIN PassengerID is private
FROM Passengers;

GO

SELECT * FROM PassengersList;

GO

CREATE VIEW dbo.FlightList

AS

SELECT FlightID, AirlineID, PlaneId, DepartureAirport, ArrivalAirport, DepartueDate, DepartureTime, ArrivalTime, Price
FROM Flight;

GO

SELECT * FROM FlightList;