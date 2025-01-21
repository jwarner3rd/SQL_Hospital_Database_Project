USE `HospitalDB`$$
DROP TRIGGER IF EXISTS `HospitalDB`.`UpdateLeaveDateTrigger` $$
USE `HospitalDB`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `HospitalDB`.`UpdateLeaveDateTrigger`
BEFORE UPDATE ON `HospitalDB`.`Check_IN_OUT`
FOR EACH ROW
BEGIN
    IF OLD.Leave_date IS NULL AND NEW.Leave_date IS NOT NULL THEN
        UPDATE Room
        SET Room_availibility = 1
        WHERE Room_no = OLD.Room_no;
    END IF;
END$$
