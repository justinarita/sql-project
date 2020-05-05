-- STORED PROCEDURE
# create a procedure where you can easily identify google trends phone interest values for a certain time frame.
## I tried to write it so that you could set the variable for the phone type, but could not figure it out, so you would have to go inside the query to specify if you would want iPhone, Galaxy, or Huawei.
DELIMITER $$
DROP PROCEDURE IF EXISTS getAveragePhoneInterestByTime$$

CREATE PROCEDURE getAveragePhoneInterestByTime(IN inDateStart DATE, IN inDateEnd DATE)
BEGIN
	SET @inDateStart := inDateStart;
	SET @inDateEnd := inDateEnd;

	SELECT 
	Date AS Start_Date, 
	AVG(iphone) AS Avg_Phone_Interest,  
	(
			SELECT AVG(iphone)
			FROM InterestbyTime
		) AS Overall_Phone_Interest
	FROM InterestbyTime
	WHERE Date BETWEEN @inDateStart AND @inDateEnd;
END$$

DELIMITER ;

CALL getAveragePhoneInterestByTime('2015-01-01', '2018-12-01');