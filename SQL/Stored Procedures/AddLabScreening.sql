-- -----------------------------------------------------
-- procedure AddLabScreening
-- -----------------------------------------------------

USE `HospitalDB`;
DROP procedure IF EXISTS `HospitalDB`.`AddLabScreening`;

DELIMITER $$
USE `HospitalDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddLabScreening`(
    IN p_Patient_ID INT,
    IN p_Technician_ID INT,
    IN p_Doctor_ID INT,
    IN p_Test_Cost DECIMAL(10, 2),
    IN p_Date DATE
)
BEGIN
    INSERT INTO Lab_Screening (Patient_ID, Technician_ID, Doctor_ID, Test_Cost, Date)
    VALUES (p_Patient_ID, p_Technician_ID, p_Doctor_ID, p_Test_Cost, p_Date);
END$$

DELIMITER ;
