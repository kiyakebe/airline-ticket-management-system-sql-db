
-- Table 1

SELECT AirlineID, AirlineName, IATACode
FROM Airline;

-- Table 2

SELECT AirPortID, AirportName, AirlineID
FROM AirPorts;

-- Table 3

SELECT PlaneId, OwnerAirline, Capacity, PortLocation
FROM Planes;

-- Table 4 flight

SELECT FlightID, AirlineID, PlaneId, DepartureAirport, ArrivalAirport, DepartueDate, DepartureTime, ArrivalTime, Price
FROM Flight;

-- Table 5

SELECT SeatNumber, FlightID
FROM Seats;

-- Table 6

SELECT PassengerID, FullName, Email, Gender, Contact, Birthdate, Nationality, EmmergencyName, EmergencyContact
FROM Passengers;

-- Table 7

SELECT BookingID, FlightID, SeatNumber, PassengerID, BookingDate
FROM Bookings;

-- Table 8

SELECT TicketID, BookingID, SeatNumber, TicketPrice
FROM Ticket;
