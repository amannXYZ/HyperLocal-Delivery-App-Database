--HANDELLING NOTIFICATIONS
CREATE TABLE Notifications(
	NotificationID INT IDENTITY (1,1) PRIMARY KEY,
	Message NVARCHAR(200),
	ScheduledTime TIME,
	DayOfWeek NVARCHAR(10),
	CreatedAt DATETIME DEFAULT GETDATE()
);

INSERT INTO Notifications (Message, ScheduledTime, DayOfWeek)
VALUES
('Your burger misses you ', '09:00:00', 'Monday'),
('Pizza is calling... answer now', '13:00:00', 'Tuesday'),
('Diet starts tomorrow', '20:00:00', 'Wednesday'),
('Biryani detected nearby', '19:30:00', 'Thursday'),
('Late night cravings unlocked', '23:00:00', 'Friday'),
('Weekend + Food = Perfect', '12:00:00', 'Saturday'),
('Sunday special? Order now', '14:00:00', 'Sunday');

SELECT * FROM Notifications;


CREATE PROCEDURE sp_SendNotificationTemp 
AS
BEGIN
	DECLARE @Today NVARCHAR(10) = DATENAME(WEEKDAY , GETDATE());
	DECLARE @CurrentTime TIME = CAST(GETDATE() AS TIME);

	SELECT Message FROM Notifications AS n
	WHERE n.DayOfWeek = @Today 
	--AND n.ScheduledTime <= @CurrentTime
	--AND n.ScheduledTime>= DATEADD(MINUTE, -1 , @CurrentTime);
END;

EXEC sp_SendNotificationTemp;
