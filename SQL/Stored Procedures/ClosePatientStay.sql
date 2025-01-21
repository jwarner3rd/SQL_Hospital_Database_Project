-- -----------------------------------------------------
-- procedure ClosePatientStay
-- -----------------------------------------------------

USE `HospitalDB`;
DROP procedure IF EXISTS `HospitalDB`.`ClosePatientStay`;

DELIMITER $$
USE `HospitalDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ClosePatientStay`(
    IN p_Stay_ID INT,
    IN p_Leave_date DATETIME,
    IN p_Discharge_status VARCHAR(255)
)
BEGIN
    -- Update the Leave_date and Discharge_status for the given Stay_ID
    UPDATE Check_IN_OUT
    SET Leave_date = p_Leave_date,
        Discharge_status = p_Discharge_status
    WHERE Stay_ID = p_Stay_ID;

    -- Check if the update was successful
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stay_ID not found';
    END IF;
END$$

DELIMITER ;
