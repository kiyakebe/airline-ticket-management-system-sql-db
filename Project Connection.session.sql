
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
    IsReserved BOOLEAN,

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
    Birthdate DATA,
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
    SeatNumber INT,
    TicketPrice FLOAT,

    PRIMARY Key(TicketID),

    FOREIGN key ( BookingID ) REFERENCES Bookings(BookingID)
);
