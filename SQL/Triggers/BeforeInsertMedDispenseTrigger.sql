USE `HospitalDB`$$
DROP TRIGGER IF EXISTS `HospitalDB`.`before_insert_med_dispense` $$
USE `HospitalDB`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `HospitalDB`.`before_insert_med_dispense`
BEFORE INSERT ON `HospitalDB`.`Med_dispense`
FOR EACH ROW
BEGIN
    DECLARE v_Medicine_ID INT;
    DECLARE v_Prescribed_Dosage INT;
    DECLARE v_Total_Dosage INT;
    DECLARE v_Dispense_Date DATE;
    DECLARE v_Current_Day_Dosage INT;

    -- Get the Prescription details
    SELECT Medicine_ID, Dosage INTO v_Medicine_ID, v_Prescribed_Dosage
    FROM Prescription
    WHERE Prescription_ID = NEW.Prescription_ID;

    -- Get the dispense date from the Vitals_rounds table
    SELECT `Date` INTO v_Dispense_Date
    FROM Vitals_rounds
    WHERE Vitals_rounds_ID = NEW.Vitals_rounds_ID;

    -- Calculate the total dosage dispensed for the specific prescription on the given date
    SELECT IFNULL(COUNT(*), 0) INTO v_Total_Dosage
    FROM Med_dispense md
    JOIN Vitals_rounds vr ON md.Vitals_rounds_ID = vr.Vitals_rounds_ID
    WHERE md.Prescription_ID = NEW.Prescription_ID
      AND DATE(vr.Date) = DATE(v_Dispense_Date);

    -- Determine the current dosage count for the day including the new entry
    SET v_Current_Day_Dosage = v_Total_Dosage + 1;

    -- Check if the total dosage for the date does not exceed the prescribed dosage
    IF v_Current_Day_Dosage > v_Prescribed_Dosage THEN
        -- Raise an error if the total dosage for the date exceeds the prescribed dosage
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Daily dosage limit exceeded';
    END IF;
END$$


DELIMITER ;
