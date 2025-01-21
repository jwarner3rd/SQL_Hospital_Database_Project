-- -----------------------------------------------------
-- procedure GenerateInvoice
-- -----------------------------------------------------

USE `HospitalDB`;
DROP procedure IF EXISTS `HospitalDB`.`GenerateInvoice`;

DELIMITER $$
USE `HospitalDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerateInvoice`()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE stay_id INT;
    DECLARE cur CURSOR FOR SELECT Stay_id FROM Check_IN_OUT WHERE Leave_date IS NOT NULL;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO stay_id;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Create a temporary table to store the invoice details for the current stay
        CREATE TEMPORARY TABLE IF NOT EXISTS InvoiceDetails (
            ItemDescription VARCHAR(255),
            ItemCost DECIMAL(10, 2)
        );

        -- Insert room charge
        INSERT INTO InvoiceDetails (ItemDescription, ItemCost)
        SELECT CONCAT('Room charge for Stay ID ', stay_id), TotalRoomCharge
        FROM Check_IN_OUT
        WHERE Stay_id = stay_id;

        -- Insert medication costs
        INSERT INTO InvoiceDetails (ItemDescription, ItemCost)
        SELECT CONCAT('Medication cost for Stay ID ', stay_id), TotalMedCost
        FROM MedicationCosts
        WHERE Stay_id = stay_id;

        -- Fetch and display all other charges (if any)

        -- Print invoice for the current stay
        SELECT * FROM InvoiceDetails;

        -- Drop the temporary table
        DROP TEMPORARY TABLE IF EXISTS InvoiceDetails;
    END LOOP;

    CLOSE cur;
END$$

DELIMITER ;
