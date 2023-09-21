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
