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


-- filter flights based on date oF departure

