-- -----------------------------------------------------
-- procedure AddVitals_Rounds
-- -----------------------------------------------------

USE `HospitalDB`;
DROP procedure IF EXISTS `HospitalDB`.`AddVitals_Rounds`;

DELIMITER $$
USE `HospitalDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddVitals_Rounds`(
    IN p_Patient_ID INT,
    IN p_Nurse_ID INT,
    IN p_BP_Systolic INT,
    IN p_BP_Diastolic INT,
    IN p_O2_Saturation INT,
	IN p_Temp INT,
	IN p_Date DATETIME,
    IN p_Stay_ID INT
)
BEGIN
    INSERT INTO Vitals_rounds (Patient_ID, Nurse_ID_ID, BP_Systolic, BP_Diastolic, O2_Saturation,Temp, Date, Stay_ID)
    VALUES (p_Patient_ID, p_Nurse_ID, p_BP_Systolic, p_BP_Diastolic, p_O2_Saturation, p_Temp, p_Date, p_Stay_ID);
END$$

DELIMITER ;
