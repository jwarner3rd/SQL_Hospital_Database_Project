-- -----------------------------------------------------
-- procedure Current_Stay_Summary
-- -----------------------------------------------------

USE `HospitalDB`;
DROP procedure IF EXISTS `HospitalDB`.`Current_Stay_Summary`;

DELIMITER $$
USE `HospitalDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Current_Stay_Summary`()
BEGIN
    -- Get the stay data with patient and PCP information, including closed stays
    WITH StayDetails AS (
        SELECT 
            cio.Stay_ID,
            cio.Room_no,
            cio.Join_date,
            cio.Leave_date,
            CURDATE() AS Today,
            DATEDIFF(CURDATE(), cio.Join_date) AS DaysCheckedIn,
            CONCAT(p.Patient_LName, ', ', p.Patient_FName) AS FullName,
            CONCAT(d.Doctor_FName, ' ', d.Doctor_LName) AS PCPName
        FROM 
            Check_IN_OUT cio
        LEFT JOIN 
            Patient p ON cio.Patient_ID = p.Patient_ID
        LEFT JOIN 
            Doctor d ON p.PCP = d.Doctor_ID
        WHERE 
            cio.Leave_date IS NULL  -- Use this condition for open stays, but adjust if you want closed stays
            OR cio.Leave_date > CURDATE()  -- Optionally, include stays that are still closed (future leave date)
    ),
    -- Gather medications for each stay
    Medications AS (
        SELECT 
            md.Stay_ID,
            GROUP_CONCAT(DISTINCT m.Med_Name SEPARATOR ', ') AS Medications
        FROM 
            Med_dispense md
        JOIN 
            Prescription p ON md.Prescription_ID = p.Prescription_ID
        JOIN 
            Medicine m ON p.Medicine_ID = m.Medicine_ID
        GROUP BY 
            md.Stay_ID
    ),
    -- Find the latest vitals round for each stay
    Last_Round AS (
        SELECT 
            vr.Stay_ID,
            MAX(vr.Date) AS LastRoundDate
        FROM 
            Vitals_rounds vr
        GROUP BY 
            vr.Stay_ID
    ),
    -- Retrieve vitals round details
    Last_Round_Details AS (
        SELECT 
            lr.Stay_ID,
            lr.LastRoundDate,
            CONCAT(n.Nurse_FName, ', ', n.Nurse_LName) AS NurseName,
            CONCAT(vr.BP_Systolic, '/', vr.BP_Diastolic) AS LastBloodPressure,
            vr.O2_Saturation AS LastO2Saturation,
            vr.Temp AS LastTemp
        FROM 
            Last_Round lr
        JOIN 
            Vitals_rounds vr ON lr.Stay_ID = vr.Stay_ID AND lr.LastRoundDate = vr.Date
        LEFT JOIN 
            Nurse n ON vr.Nurse_ID = n.Nurse_ID
    )
    -- Combine all the details and check for NULL values in medications and vitals
    SELECT 
        sd.Stay_ID,
        sd.Room_no,
        sd.Join_date,
        sd.FullName,
        sd.DaysCheckedIn,
        sd.PCPName,
        COALESCE(m.Medications, 'None') AS Medications,
        COALESCE(lrd.LastRoundDate, 'No Vitals') AS LastRoundDate,
        COALESCE(lrd.NurseName, 'No Nurse') AS NurseName,
        COALESCE(lrd.LastBloodPressure, 'No BP') AS LastBloodPressure,
        COALESCE(lrd.LastO2Saturation, 'No O2') AS LastO2Saturation,
        COALESCE(lrd.LastTemp, 'No Temp') AS LastTemp
    FROM 
        StayDetails sd
    LEFT JOIN 
        Medications m ON sd.Stay_ID = m.Stay_ID
    LEFT JOIN 
        Last_Round_Details lrd ON sd.Stay_ID = lrd.Stay_ID
    ORDER BY 
        sd.Stay_ID;
END$$

DELIMITER ;
