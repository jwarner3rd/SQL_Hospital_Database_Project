DELIMITER ;
USE `HospitalDB`;

DELIMITER $$

USE `HospitalDB`$$
DROP TRIGGER IF EXISTS `HospitalDB`.`NewStayTrigger` $$
USE `HospitalDB`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `HospitalDB`.`NewStayTrigger`
AFTER INSERT ON `HospitalDB`.`Check_IN_OUT`
FOR EACH ROW
BEGIN
    IF NEW.Leave_date IS NULL THEN
        UPDATE Room
        SET Room_availibility = 0
        WHERE Room_no = NEW.Room_no;
    END IF;
END$$
