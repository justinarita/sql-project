-- TRIGGERS
# Create a trigger to keep track of iPhone and Samsung updates in the InterestbyRegion table
# When google trends data changes for a specific region, you can change it manually through this trigger
	# example here is the country, Turkmenistan

DESCRIBE InterestbyRegion;

CREATE TABLE Interest_by_Region_Log (
User VARCHAR(255),
Region TEXT,
OldiPhone INT(11),
NewiPhone INT(11),
OldSamsungGalaxy INT(11),
NewSamsungGalaxy INT(11),
OldHuawei INT(11),
NewHuawei INT(11),
LogDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

SELECT USER();

DELIMITER $$
DROP TRIGGER IF EXISTS InterestbyRegion_After_Update$$
CREATE TRIGGER InterestbyRegion_After_Update
	AFTER UPDATE ON InterestbyRegion
	FOR EACH ROW
BEGIN
	INSERT INTO Interest_by_Region_Log 
	(`User`, `Region`, `OldiPhone`, `NewiPhone`, `OldSamsungGalaxy`, `NewSamsungGalaxy`, `OldHuawei`, `NewHuawei`)
	VALUES
	(User(), OLD.`Region (Country)`, OLD.iPhone, NEW.iPhone, OLD.`Samsung Galaxy`, NEW.`Samsung Galaxy`, OLD.Huawei, NEW.Huawei);

END$$
DELIMITER ;

SELECT *
FROM InterestbyRegion
ORDER BY RAND()
LIMIT 1;

UPDATE InterestbyRegion
SET `iPhone` = 70, `Samsung Galaxy` = 12, `Huawei` = 18
WHERE `Region (Country)` = 'Turkmenistan';

SELECT *
FROM Interest_by_Region_Log;

SELECT *
FROM InterestbyRegion
WHERE `Region (Country)` = 'Turkmenistan';

SHOW TRIGGERS;

SELECT *
FROM Interest_by_Region_Log;