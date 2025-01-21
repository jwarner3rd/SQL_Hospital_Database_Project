USE `HospitalDB`$$
DROP TRIGGER IF EXISTS `HospitalDB`.`after_insert_med_dispense` $$
USE `HospitalDB`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `HospitalDB`.`after_insert_med_dispense`
AFTER INSERT ON `HospitalDB`.`Med_dispense`
FOR EACH ROW
BEGIN
    DECLARE v_Medicine_ID INT;
    
    -- Get the Medicine_ID from the Prescription table
    SELECT Medicine_ID INTO v_Medicine_ID
    FROM Prescription
    WHERE Prescription_ID = NEW.Prescription_ID;

    -- Update the Med_Quantity in the Medicine table
    UPDATE Medicine
    SET Med_Quantity = Med_Quantity - 1
    WHERE Medicine_ID = v_Medicine_ID;
END$$
