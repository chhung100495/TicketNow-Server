DELIMITER //
CREATE PROCEDURE insertSeatsForVenues()
BEGIN
    DECLARE i int DEFAULT 1;
    DECLARE j int DEFAULT 1;
    DECLARE _rows varchar(255) DEFAULT 'A';
    DECLARE location_id int DEFAULT 1; /* Sân Thống Nhất */
    DECLARE block_id int DEFAULT 1; /* Khán đài A */
    WHILE i <= 120 DO
        IF i = 13 THEN SET _rows = 'B'; SET j = 1; END IF;
    	  IF i = 25 THEN SET _rows = 'C'; SET j = 1; END IF;
		  IF i = 37 THEN SET _rows = 'D'; SET j = 1; END IF;
		  IF i = 49 THEN SET _rows = 'E'; SET j = 1; END IF;
		  IF i = 61 THEN SET _rows = 'F'; SET j = 1; END IF;
		  IF i = 73 THEN SET _rows = 'G'; SET j = 1; END IF;
		  IF i = 85 THEN SET _rows = 'H'; SET j = 1; END IF;
		  IF i = 97 THEN SET _rows = 'I'; SET j = 1; END IF;
		  IF i = 109 THEN SET _rows = 'J'; SET j = 1; END IF;
        INSERT INTO seats (row, number, type, location_id, block_id) VALUES (_rows, j, 0, location_id, block_id);
        SET i = i + 1;
        SET j = j + 1;
    END WHILE;
END //
DELIMITER ;