USE `HospitalDB`$$
DROP TRIGGER IF EXISTS `HospitalDB`.`before_insert_check_in_out` $$
USE `HospitalDB`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `HospitalDB`.`before_insert_check_in_out`
BEFORE INSERT ON `HospitalDB`.`Check_IN_OUT`
FOR EACH ROW
BEGIN
    IF NOT IsRoomAvailable(NEW.Room_no) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Room is not available for check-in.';
    END IF;
END$$
