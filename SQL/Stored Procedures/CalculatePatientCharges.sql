-- -----------------------------------------------------
-- procedure CalculatePatientCharges
-- -----------------------------------------------------

USE `HospitalDB`;
DROP procedure IF EXISTS `HospitalDB`.`CalculatePatientCharges`;

DELIMITER $$
USE `HospitalDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CalculatePatientCharges`()
BEGIN
    WITH StayDetails AS (
        SELECT 
            Check_IN_OUT.Stay_id,
            Check_IN_OUT.Patient_ID,
            CONCAT(Patient.Patient_FName, ' ', Patient.Patient_LName) AS FullName,
            Check_IN_OUT.Join_date,
            IFNULL(Check_IN_OUT.Leave_date, CURDATE()) AS Leave_date, -- Use current date if patient hasn't checked out
            DATEDIFF(IFNULL(Check_IN_OUT.Leave_date, CURDATE()), Check_IN_OUT.Join_date) AS StayDuration, -- Calculate stay duration
            Room.Room_Cost,
            CONCAT(Doctor.Doctor_FName, ' ', Doctor.Doctor_LName) AS PCPName
        FROM 
            Check_IN_OUT
        LEFT JOIN 
            Patient ON Check_IN_OUT.Patient_ID = Patient.Patient_ID
        LEFT JOIN 
            Room ON Check_IN_OUT.Room_no = Room.Room_no
        LEFT JOIN 
            Doctor ON Patient.PCP = Doctor.Doctor_ID
    ),
    MedicationDispenses AS (
        SELECT 
            md.Vitals_rounds_ID,
            md.Prescription_ID,
            COUNT(md.Med_dispense_ID) AS DispenseCount
        FROM 
            Med_dispense md
        GROUP BY 
            md.Vitals_rounds_ID, md.Prescription_ID
    ),
    MedicationCosts AS (
        SELECT 
            vr.Patient_ID,
            SUM(m.Med_Cost * disp.DispenseCount) AS TotalMedCost
        FROM 
            MedicationDispenses disp
        JOIN 
            Prescription p ON disp.Prescription_ID = p.Prescription_ID
        JOIN 
            Medicine m ON p.Medicine_ID = m.Medicine_ID
        JOIN 
            Vitals_rounds vr ON disp.Vitals_rounds_ID = vr.Vitals_rounds_ID
        GROUP BY 
            vr.Patient_ID
    )
    SELECT 
        sd.Stay_id,
        sd.FullName,
        sd.PCPName,
        sd.Join_date,
        sd.Leave_date,
        sd.StayDuration,
        (sd.StayDuration * sd.Room_Cost) AS TotalRoomCharge,
        COALESCE(mc.TotalMedCost, 0) AS TotalMedCost,
        ((sd.StayDuration * sd.Room_Cost) + COALESCE(mc.TotalMedCost, 0)) AS TotalAmount
    FROM 
        StayDetails sd
    LEFT JOIN 
        MedicationCosts mc ON sd.Patient_ID = mc.Patient_ID;
END$$

DELIMITER ;
