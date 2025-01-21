-- -----------------------------------------------------
-- procedure dispense_medicine
-- -----------------------------------------------------

USE `HospitalDB`;
DROP procedure IF EXISTS `HospitalDB`.`dispense_medicine`;

DELIMITER $$
USE `HospitalDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `dispense_medicine`(
    IN p_Prescription_ID INT,
    IN p_Vitals_rounds_ID INT
)
BEGIN
    DECLARE v_Medicine_ID INT;
    DECLARE v_Med_Quantity INT;
    DECLARE v_Dosage INT;
    DECLARE v_Prescribed_Dosage INT;
    DECLARE v_Total_Dosage INT;
    DECLARE v_Dispense_Date DATE;

    -- Get the Medicine_ID and Dosage from the Prescription table
    SELECT Medicine_ID, Dosage INTO v_Medicine_ID, v_Prescribed_Dosage
    FROM Prescription
    WHERE Prescription_ID = p_Prescription_ID;

    -- Get the current quantity of the medication
    SELECT Med_Quantity INTO v_Med_Quantity
    FROM Medicine
    WHERE Medicine_ID = v_Medicine_ID;

    -- Get the dispense date from the Vitals_rounds table
    SELECT DATE INTO v_Dispense_Date
    FROM Vitals_rounds
    WHERE Vitals_rounds_ID = p_Vitals_rounds_ID;

    -- Calculate the total dosage dispensed for the specific prescription on the given date
    SELECT IFNULL(SUM(p.Dosage), 0) INTO v_Total_Dosage
    FROM Med_dispense md
    JOIN Prescription p ON md.Prescription_ID = p.Prescription_ID
    JOIN Vitals_rounds vr ON md.Vitals_rounds_ID = vr.Vitals_rounds_ID
    WHERE md.Prescription_ID = p_Prescription_ID
      AND DATE(vr.Date) = v_Dispense_Date;

    -- Check if the medication quantity is greater than 0
    IF v_Med_Quantity > 0 THEN
        -- Check if the total dosage for the date does not exceed the prescribed dosage
        IF v_Total_Dosage + v_Prescribed_Dosage <= v_Prescribed_Dosage THEN
            -- Insert into Med_dispense table
            INSERT INTO Med_dispense (Prescription_ID, Vitals_rounds_ID)
            VALUES (p_Prescription_ID, p_Vitals_rounds_ID);
            
            -- Update the Med_Quantity in the Medicine table
            UPDATE Medicine
            SET Med_Quantity = Med_Quantity - 1
            WHERE Medicine_ID = v_Medicine_ID;
        ELSE
            -- Raise an error if the total dosage for the date exceeds the prescribed dosage
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Daily dosage limit exceeded';
        END IF;
    ELSE
        -- Raise an error if the medication quantity is 0
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient medication quantity';
    END IF;
END$$

DELIMITER ;
