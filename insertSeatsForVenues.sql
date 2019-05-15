DELIMITER $$
DROP PROCEDURE IF EXISTS insertSeatsForVenues$$
CREATE PROCEDURE insertSeatsForVenues()
BEGIN
    DECLARE i int DEFAULT 1;
    DECLARE _rows varchar(255) DEFAULT 'A';
    DECLARE location_id int DEFAULT 1; /* Sân Thống Nhất */
    DECLARE block_id int DEFAULT 1; /* Khán đài A */
    WHILE i <= 30 DO
    	  IF i = 11 THEN SET _rows = 'B'; END IF;
		  IF i = 21 THEN SET _rows = 'C'; END IF;
        INSERT INTO seats (row, number, type, location_id, block_id) VALUES (_rows, i, 0, location_id, block_id);
        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;

CALL insertSeatsForVenues(); 