
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
