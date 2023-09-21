
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