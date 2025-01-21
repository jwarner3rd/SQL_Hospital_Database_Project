-- -----------------------------------------------------
-- procedure AddDiagnosis
-- -----------------------------------------------------

USE `HospitalDB`;
DROP procedure IF EXISTS `HospitalDB`.`AddDiagnosis`;

DELIMITER $$
USE `HospitalDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddDiagnosis`(
    IN p_Patient_ID INT,
    IN p_Doctor_ID INT,
    IN p_Diagnosis VARCHAR(255),
    IN p_since DATE
)
BEGIN
    INSERT INTO Diagnosis (Patient_ID, Doctor_ID, Diagnosis, since)
    VALUES (p_Patient_ID, p_Doctor_ID, p_Diagnosis, p_since);
    
    END$$

DELIMITER ;
