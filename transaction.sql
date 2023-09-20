
-- Booking management transaction

CREATE PROCEDURE BookingTransaction
    @SeatNumber INT,
    @FlightID VARCHAR(10),
    @IsReserved INT,

    @BookingID VARCHAR(10),
    @PassengerID INT -- We Only registered 28 passengers with Id 1 - 28

AS
BEGIN
    BEGIN TRAN
        BEGIN TRY
            -- UPDATE RESERVED TO TRUE
            IF @IsReserved = 0
            BEGIN 
                UPDATE Seats
                SET IsReserved = 1
                WHERE SeatNumber = @SeatNumber AND FlightID = @FlightID;

                --add to booking
                INSERT INTO Bookings (BookingID, FlightID, PassengerID, BookingDate)
                VALUES (@BookingID, @FlightID, @PassengerID, FORMAT(GETDATE(), 'yyyy-MM-dd')); 

                COMMIT TRANSACTION;
                PRINT 'Booking successfully!';
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

-- As we mentioned earlier, we have inserted 30 seats for the flight 'F002'
-- So for demonstration we have to only use 'F002'

EXECUTE BookingTransaction
    @SeatNumber = 13,
    @FlightID = 'F002',
    @IsReserved = 1,
    @BookingID = 'B0001',
    @PassengerID = 12;  -- only from ( 1 - 28 ) - the reason is mentioned above


-- we are going to use flight Id from (1 - 28) since we only have 28 passengers
