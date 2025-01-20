



# Database Schema

## Appointment
| Column Name   | Data Type   | Null | Key  | Default       | Extra          |
|---------------|-------------|------|------|---------------|----------------|
| Appt_ID       | int         | NO   | PRI  | NULL          | auto_increment |
| Scheduled_On  | datetime    | NO   |      | NULL          |                |
| Appt_Date     | date        | YES  |      | NULL          |                |
| Appt_Time     | time        | YES  |      | NULL          |                |
| Appt_kept     | tinyint     | YES  |      | 0             |                |
| Doctor_ID     | int         | NO   | MUL  | NULL          |                |
| Patient_ID    | int         | NO   | MUL  | NULL          |                |

---

## Check_IN_OUT
| Column Name       | Data Type   | Null | Key  | Default       | Extra          |
|-------------------|-------------|------|------|---------------|----------------|
| Stay_ID           | int         | NO   | PRI  | NULL          | auto_increment |
| Patient_ID        | int         | NO   | MUL  | NULL          |                |
| Room_no           | varchar(50) | NO   | MUL  | NULL          |                |
| Join_date         | datetime    | YES  |      | NULL          |                |
| Leave_date        | datetime    | YES  |      | NULL          |                |
| Discharge_status  | varchar(50) | YES  |      | NULL          |                |

---

## Diagnosis
| Column Name   | Data Type     | Null | Key  | Default       | Extra          |
|---------------|---------------|------|------|---------------|----------------|
| Patient_ID    | int           | NO   | MUL  | NULL          |                |
| Doctor_ID     | int           | NO   | MUL  | NULL          |                |
| Diagnosis_ID  | int           | NO   | PRI  | NULL          | auto_increment |
| Diagnosis     | varchar(30)   | NO   |      | NULL          |                |
| Lab_ID        | int           | YES  | MUL  | NULL          |                |
| Test_ID       | int           | YES  | MUL  | NULL          |                |
| since         | date          | NO   |      | NULL          |                |
| enddate       | date          | YES  |      | NULL          |                |

---

## Doctor
| Column Name     | Data Type     | Null | Key  | Default       | Extra          |
|-----------------|---------------|------|------|---------------|----------------|
| Doctor_ID       | int           | NO   | PRI  | NULL          |                |
| Doctor_FName    | varchar(100)  | YES  |      | NULL          |                |
| Doctor_LName    | varchar(100)  | YES  |      | NULL          |                |
| Doctor_dob      | date          | YES  |      | NULL          |                |
| Doctor_Gender   | varchar(100)  | YES  |      | NULL          |                |
| Doctor_Address  | varchar(100)  | YES  |      | NULL          |                |
| Doctor_Email    | varchar(100)  | YES  |      | NULL          |                |
| Doctor_phone    | varchar(15)   | YES  |      | NULL          |                |

---

## Emergency_Contact
| Column Name     | Data Type     | Null | Key  | Default       | Extra          |
|-----------------|---------------|------|------|---------------|----------------|
| Contact_ID      | int           | NO   | PRI  | NULL          |                |
| Contact_Name    | varchar(20)   | NO   |      | NULL          |                |
| Phone           | varchar(12)   | NO   |      | NULL          |                |
| Relation        | varchar(20)   | NO   |      | NULL          |                |
| Patient_ID      | int           | NO   | MUL  | NULL          |                |

---

## Lab_Screening
| Column Name    | Data Type     | Null | Key  | Default       | Extra          |
|----------------|---------------|------|------|---------------|----------------|
| Lab_ID         | int           | NO   | PRI  | NULL          | auto_increment |
| Patient_ID     | int           | NO   | MUL  | NULL          |                |
| Technician_ID  | int           | NO   | MUL  | NULL          |                |
| Doctor_ID      | int           | NO   | MUL  | NULL          |                |
| Test_Cost      | decimal(10,2) | YES  |      | NULL          |                |
| Date           | date          | NO   |      | NULL          |                |

---

## Med_dispense
| Column Name         | Data Type   | Null | Key  | Default       | Extra          |
|---------------------|-------------|------|------|---------------|----------------|
| Med_dispense_ID     | int         | NO   | PRI  | NULL          | auto_increment |
| Prescription_ID     | int         | NO   | MUL  | NULL          |                |
| Vitals_rounds_ID    | int         | YES  | MUL  | NULL          |                |
| Stay_ID             | int         | YES  | MUL  | NULL          |                |

---

## Patient
| Column Name               | Data Type     | Null | Key  | Default       | Extra |
|---------------------------|---------------|------|------|---------------|-------|
| Patient_ID                | int           | NO   | PRI  | NULL          |       |
| Patient_FName             | varchar(100)  | NO   |      | NULL          |       |
| Patient_LName             | varchar(100)  | NO   |      | NULL          |       |
| dob                       | date          | YES  |      | NULL          |       |
| Patient_race              | varchar(100)  | YES  |      | NULL          |       |
| Blood_type                | varchar(5)    | YES  |      | NULL          |       |
| Patient_Address           | varchar(100)  | YES  |      | NULL          |       |
| Patient_Email             | varchar(100)  | YES  |      | NULL          |       |
| Patient_phone             | varchar(15)   | YES  |      | NULL          |       |
| Patient_Gender            | varchar(100)  | YES  |      | NULL          |       |
| Patient_Emergency_Contact | int           | YES  |      | NULL          |       |
| PCP                       | int           | YES  | MUL  | NULL          |       |

---

## Prescription
| Column Name         | Data Type     | Null | Key  | Default       | Extra          |
|---------------------|---------------|------|------|---------------|----------------|
| Prescription_ID     | int           | NO   | PRI  | NULL          | auto_increment |
| Patient_ID          | int           | NO   | MUL  | NULL          |                |
| Doctor_ID           | int           | NO   | MUL  | NULL          |                |
| Medication          | varchar(255)  | NO   |      | NULL          |                |
| Dose                | varchar(50)   | NO   |      | NULL          |                |
| Frequency           | varchar(50)   | NO   |      | NULL          |                |
| Start_date          | date          | NO   |      | NULL          |                |
| End_date            | date          | YES  |      | NULL          |                |

---

## Vitals_Rounds
| Column Name         | Data Type     | Null | Key  | Default       | Extra          |
|---------------------|---------------|------|------|---------------|----------------|
| Vitals_rounds_ID    | int           | NO   | PRI  | NULL          | auto_increment |
| Patient_ID          | int           | NO   | MUL  | NULL          |                |
| Heart_rate          | int           | YES  |      | NULL          |                |
| Blood_pressure      | varchar(50)   | YES  |      | NULL          |                |
| Temperature         | decimal(5,2)  | YES  |      | NULL          |                |
| Checked_on          | datetime      | NO   |      | NULL          |                |

