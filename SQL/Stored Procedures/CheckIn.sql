-- -----------------------------------------------------
-- procedure CheckIn
-- -----------------------------------------------------

USE `HospitalDB`;
DROP procedure IF EXISTS `HospitalDB`.`CheckIn`;

DELIMITER $$
USE `HospitalDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckIn`(
    IN patient_id INT,
    IN room_no VARCHAR(10),
    IN join_date DATETIME
)
BEGIN
    DECLARE new_stay_id INT;
    
    -- Find the highest Stay_ID and increment by 1
    SELECT IFNULL(MAX(Stay_ID), 0) + 1 INTO new_stay_id FROM Check_IN_OUT;
    
    -- Insert the new stay record
    INSERT INTO Check_IN_OUT (Stay_ID, Patient_ID, Room_no, Join_date, Leave_date, Discharge_status)
    VALUES (new_stay_id, patient_id, room_no, join_date, NULL, 'NULL');
    
    SELECT new_stay_id AS New_Stay_ID;
END$$

DELIMITER ;
