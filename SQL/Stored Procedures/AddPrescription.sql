-- -----------------------------------------------------
-- procedure AddPrescription
-- -----------------------------------------------------

USE `HospitalDB`;
DROP procedure IF EXISTS `HospitalDB`.`AddPrescription`;

DELIMITER $$
USE `HospitalDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddPrescription`(
    IN p_Patient_ID INT,
    IN p_Medicine_ID INT,
    IN p_Date_start DATE,
    IN p_Quantity INT,
    IN p_Dosage VARCHAR(255),
    IN p_Doctor_ID INT
)
BEGIN
    INSERT INTO Prescription (Patient_ID, Medicine_ID, Date_start, Quantity, Dosage, Doctor_ID)
    VALUES (p_Patient_ID, p_Medicine_ID, p_Date_start, p_Quantity, p_Dosage, p_Doctor_ID);
END$$

DELIMITER ;
