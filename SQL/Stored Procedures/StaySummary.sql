-- -----------------------------------------------------
-- procedure StaySummary
-- -----------------------------------------------------

USE `HospitalDB`;
DROP procedure IF EXISTS `HospitalDB`.`StaySummary`;

DELIMITER $$
USE `HospitalDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `StaySummary`()
BEGIN

SELECT 
    Check_IN_OUT.Room_no, 
    Check_IN_OUT.Join_date, 
    CONCAT(Patient.Patient_LName, ', ', Patient.Patient_FName) AS full_name, 
    CURDATE(),
    DATEDIFF(CURDATE(), Check_IN_OUT.Join_date)
FROM 
    Check_IN_OUT
LEFT JOIN 
    Patient 
ON 
    Check_IN_OUT.Patient_ID = Patient.Patient_ID;
    
WITH ComputedValues AS (
    SELECT 
        Check_IN_OUT.Room_no, 
        Check_IN_OUT.Join_date,
        CURDATE() AS Today,
        DATEDIFF(CURDATE(), Check_IN_OUT.Join_date) AS DaysCheckedIn,
        CONCAT(Patient.Patient_LName, ', ', Patient.Patient_FName) AS FullName,
        Patient.Patient_ID,  
        CONCAT(Doctor.Doctor_FName, ' ', Doctor.Doctor_LName) AS PCPName  
    FROM 
        Check_IN_OUT
    LEFT JOIN 
        Patient ON Check_IN_OUT.Patient_ID = Patient.Patient_ID
	LEFT JOIN 
        Doctor ON Patient.PCP = Doctor.Doctor_ID
    WHERE
        Check_IN_OUT.Leave_date IS NULL
),
Medications AS (
    SELECT 
        Prescription.Patient_ID,
        GROUP_CONCAT(Medicine.Med_Name SEPARATOR ', ') AS Medications
    FROM 
        Prescription
    JOIN 
        Medicine ON Prescription.Medicine_ID = Medicine.Medicine_ID
    GROUP BY 
        Prescription.Patient_ID
),
Last_Round AS (
    SELECT 
        Vitals_rounds.Patient_ID,
        MAX(Vitals_rounds.Date) AS LastRoundDate
    FROM
        Vitals_rounds
    GROUP BY 
        Vitals_rounds.Patient_ID
),
Last_Round_nurse AS (
    SELECT 
        lr.Patient_ID,
        lr.LastRoundDate,
        CONCAT(Nurse.Nurse_FName, ', ', Nurse.Nurse_LName) AS NurseName,
        CONCAT(vr.BP_Systolic, '/', vr.BP_Diastolic) AS LastBloodPressure,
        vr.O2_saturation AS LastO2Saturation,
        vr.Temp AS LastTemp
    FROM (
        SELECT 
            Patient_ID,
            MAX(Date) AS LastRoundDate
        FROM 
            Vitals_rounds
        GROUP BY 
            Patient_ID
    ) lr
    JOIN 
        Vitals_rounds vr ON lr.Patient_ID = vr.Patient_ID AND lr.LastRoundDate = vr.Date
    JOIN 
        Nurse ON vr.Nurse_ID = Nurse.Nurse_ID
)SELECT 
    cv.Room_no,
    cv.Join_date,
    cv.FullName,
    cv.DaysCheckedIn,
    cv.PCPName,
    COALESCE(m.Medications, 'None') AS Medications,
    lr.LastRoundDate,
    lrn.NurseName,
    lrn.LastBloodPressure,
    lrn.LastO2Saturation,
    lrn.LastTemp
FROM 
    ComputedValues cv
LEFT JOIN 
    Medications m ON cv.Patient_ID = m.Patient_ID
LEFT JOIN 
    Last_Round lr ON cv.Patient_ID = lr.Patient_ID
LEFT JOIN 
    Last_Round_nurse lrn ON cv.Patient_ID = lrn.Patient_ID AND lr.LastRoundDate = lrn.LastRoundDate;


END$$

DELIMITER ;
