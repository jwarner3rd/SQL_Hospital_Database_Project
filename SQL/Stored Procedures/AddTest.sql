-- -----------------------------------------------------
-- procedure AddTest
-- -----------------------------------------------------

USE `HospitalDB`;
DROP procedure IF EXISTS `HospitalDB`.`AddTest`;

DELIMITER $$
USE `HospitalDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddTest`(
    IN p_Test_Name VARCHAR(255),
    IN p_Patient_ID INT,
    IN p_Doctor_ID INT,
    IN p_Technician_ID INT,
    IN p_Test_result VARCHAR(255)
)
BEGIN
    INSERT INTO Test (Test_Name, Patient_ID, Doctor_ID, Technician_ID, Test_result)
    VALUES (p_Test_Name, p_Patient_ID, p_Doctor_ID, p_Technician_ID, p_Test_result);
END$$

DELIMITER ;
