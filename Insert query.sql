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
    (AirPortID, AirpotName, AirlineID)
VALUES
    ('AP001', 'Adiss Ababa Airport', 'A001', 'Ethiopia, Adiss Ababa'),
    ('AP002', 'Adama Airport', 'A001', 'Ethiopia, Adama'),
    ('AP003', 'Jimma Airport', 'A001', 'Ethiopia, Jimma'),
    ('AP004', 'Emirates Airport', 'A002', "Arab Emirates, Emirates"),
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
    ('F002', 'A001', 'P005', 'AP001', 'AP001', '2023-09-26', '09:30:00', '11:30:00', 250.0), -- we have used this flight to demonstrate the transaction
    ('F003', 'A001', 'P008', 'AP007', 'AP001', '2023-09-26', '09:30:00', '11:30:00', 250.0),
    ('F004', 'A001', 'P003', 'AP001', 'AP005', '2023-09-26', '09:30:00', '11:30:00', 150.0);

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

-- Table 7



-- Table 8






-- Table 2
-- Table 3
-- Table 4
-- Table 5
-- Table 6
-- Table 7
-- Table 8

