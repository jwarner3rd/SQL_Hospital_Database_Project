# Introduction

The HospitalDB database simulates a hospital management database, demonstrating SQL functionality, including triggers and stored procedures. It automates tasks like updating room availability, enforcing prescription dosage limits, and maintaining consistency across interrelated tables such as patients, rooms, and medications.

### Included Files and Features:

#### **Hospital_Export_Full.sql**: 
Contains the SQL code to create the database structure, including tables, relationships, constraints, triggers, and stored procedures.

#### **seed.sql**: 
Populates the database with test data for demonstration and testing purposes.

#### **Stored Procedures/**: 
Contains individual stored procedures. These files define specific actions or logic to be executed on the database, such as adding a new patient or updating medication records.

- **AddDiagnosis.sql**:
Adds a patient's diagnosis to the `Diagnosis` table, including attending doctor, patient ID, diagnosis start date, and related details.

- **AddLabScreening.sql**:
Logs lab screening details in the `Lab_Screening` table, including patient ID, technician, doctor, cost, and screening date.

- **AddPrescription.sql**:
Creates records in the `Prescription` table, specifying prescribed medicines, dosage, duration, prescribing doctor, start date, and patient ID.

- **AddTest.sql**:
Records test information in the `Test` table, including test name, ordering doctor, associated technician, test date, results, and patient ID.

- **AddVitalsRounds.sql**:
Logs vital signs and patient rounds in the `Vitals_Rounds` table, capturing date/time, nurse details, oxygen levels, blood pressure, temperature, patient ID, and stay ID.

- **CalculatePatientCharges.sql**:
Calculates and summarizes patient charges based on room type (shared or single), stay duration, and medications dispensed. Includes start and end dates, patient name, and primary care physician (PCP).

- **CheckIn.sql**:
Manages patient check-in by recording the check-in date and assigning a room in the `Check_IN_OUT` table.

- **ClosePatientStay.sql**:
Handles patient discharge by updating the discharge date and stay status in the `Check_IN_OUT` table.

- **CurrentStaySummary.sql**:
Provides a real-time summary of current patient stays, including recent rounds, medications dispensed, oxygen levels, blood pressure, and other vitals.

- **DispenseMedicine.sql**:
Logs medications dispensed in the `Med_dispense` table, linking them to the corresponding Vitals_RoundsID and prescription details.

- **StaySummary.sql**:
Generates a detailed summary of ongoing patient stays (those without a discharge date), including start date, room number, length of stay, PCP, medications, last rounds completed, attending nurse, and vitals like blood pressure, temperature, and oxygen levels.

#### **triggers/**: 
Contains individual SQL trigger files. These files define automatic actions that occur in response to changes in the database, such as inventory updates after medication dispensing.

- **NewStayTrigger**:  Updates the Room_availibility field in the `Room` table to 0 (not available) when a new stay is added to the Check_IN_OUT table and the Leave_date is NULL, indicating that the room is currently occupied.

- **UpdateLeaveDateTrigger**:  Updates the Room_availibility field in the `Room` table to 1 (available) when a stay's Leave_date is updated from NULL to a specific date, indicating that the room is now vacant.

- **BeforeInsertCheckInOutTrigger**:  Checks room availability before inserting a new entry into the `Check_IN_OUT` table. If the room is unavailable, it raises an error with the message "Room is not available for check-in.

- **AfterInsertMedDispenseTrigger**:  Reduces the Med_Quantity field in the Medicine table by 1 for the corresponding Medicine_ID when a new entry is added to the `Med_dispense` table, reflecting that medication has been dispensed.

- **BeforeInsertMedDispenseTrigger**:  Ensures that the total medication dispensed for a specific prescription does not exceed the prescribed daily dosage. It checks the prescribed dosage against the total dispensed entries for the given prescription and date. If the daily dosage limit is exceeded, an error with the message "Daily dosage limit exceeded" is raised.

### How to Use
1- Run Hospital_Export_Full.sql to create the database schema.
2- Use seed.sql to populate the database with sample data.
3- Test database functionality with stored procedures and triggers to explore its features.


# Database Schema

### Appointment
| Column Name   | Data Type   | Null | Key  | Default       | Extra          |
|---------------|-------------|------|------|---------------|----------------|
| Appt_ID       | int         | NO   | PRI  | NULL          | auto_increment |
| Scheduled_On  | datetime    | NO   |      | NULL          |                |
| Appt_Date     | date        | YES  |      | NULL          |                |
| Appt_Time     | time        | YES  |      | NULL          |                |
| Appt_kept     | tinyint     | YES  |      | NULL            |                |
| Doctor_ID     | int         | NO   | MUL  | NULL          |                |
| Patient_ID    | int         | NO   | MUL  | NULL          |                |

---

### Check_IN_OUT
| Column Name       | Data Type   | Null | Key  | Default       | Extra          |
|-------------------|-------------|------|------|---------------|----------------|
| Stay_ID           | int         | NO   | PRI  | NULL          | auto_increment |
| Patient_ID        | int         | NO   | MUL  | NULL          |                |
| Room_no           | varchar(50) | NO   | MUL  | NULL          |                |
| Join_date         | datetime    | YES  |      | NULL          |                |
| Leave_date        | datetime    | YES  |      | NULL          |                |
| Discharge_status  | varchar(50) | YES  |      | NULL          |                |

---

### Diagnosis
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

### Doctor
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

### Emergency_Contact
| Column Name     | Data Type     | Null | Key  | Default       | Extra          |
|-----------------|---------------|------|------|---------------|----------------|
| Contact_ID      | int           | NO   | PRI  | NULL          |                |
| Contact_Name    | varchar(20)   | NO   |      | NULL          |                |
| Phone           | varchar(12)   | NO   |      | NULL          |                |
| Relation        | varchar(20)   | NO   |      | NULL          |                |
| Patient_ID      | int           | NO   | MUL  | NULL          |                |

---

### Lab_Screening
| Column Name    | Data Type     | Null | Key  | Default       | Extra          |
|----------------|---------------|------|------|---------------|----------------|
| Lab_ID         | int           | NO   | PRI  | NULL          | auto_increment |
| Patient_ID     | int           | NO   | MUL  | NULL          |                |
| Technician_ID  | int           | NO   | MUL  | NULL          |                |
| Doctor_ID      | int           | NO   | MUL  | NULL          |                |
| Test_Cost      | decimal(10,2) | YES  |      | NULL          |                |
| Date           | date          | NO   |      | NULL          |                |

---

### Med_dispense
| Column Name         | Data Type   | Null | Key  | Default       | Extra          |
|---------------------|-------------|------|------|---------------|----------------|
| Med_dispense_ID     | int         | NO   | PRI  | NULL          | auto_increment |
| Prescription_ID     | int         | NO   | MUL  | NULL          |                |
| Vitals_rounds_ID    | int         | YES  | MUL  | NULL          |                |
| Stay_ID             | int         | YES  | MUL  | NULL          |                |

---

### Medicine
| Column Name    | Data Type     | Null | Key  | Default       | Extra          |
|-----------------|---------------|------|------|---------------|----------------|
| Medicine_ID    | int(10)      | NO   | PRI  | NULL          |                |
| Med_Name       | varchar(20)  | NO   |      | NULL          |                |
| Med_Quantity   | int(10)      | NO   |      | NULL          |                |
| Med_Cost       | decimal(10,2)| YES  |      | NULL          |                |

---

### Nurse
| Column Name     | Data Type     | Null | Key  | Default       | Extra          |
|------------------|---------------|------|------|---------------|----------------|
| Nurse_ID         | int(10)      | NO   | PRI  | NULL          |                |
| Nurse_FName      | varchar(100) | YES  |      | NULL          |                |
| Nurse_LName      | varchar(100) | YES  |      | NULL          |                |
| Nurse_dob        | date         | YES  |      | NULL          |                |
| Nurse_Gender     | varchar(100) | YES  |      | NULL          |                |
| Nurse_Address    | varchar(100) | YES  |      | NULL          |                |
| Nurse_Email      | varchar(100) | YES  |      | NULL          |                |
| Nurse_phone      | varchar(15)  | YES  |      | NULL          |                |

---

### Patient
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

### Prescription
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

### Room
| Column Name         | Data Type     | Null | Key  | Default       | Extra          |
|---------------------|---------------|------|------|---------------|----------------|
| Room_no             | varchar(50)  | NO   | PRI  | NULL          |                |
| Room_type           | varchar(100) | YES  |      | NULL          |                |
| Room_availibility   | tinyint(3)   | YES  |      | NULL          |                |
| Room_Cost           | decimal(10,2)| YES  |      | NULL          |                |

--- 

### Technician
| Column Name          | Data Type     | Null | Key  | Default       | Extra          |
|----------------------|---------------|------|------|---------------|----------------|
| Technician_ID        | int(10)      | NO   | PRI  | NULL          |                |
| Technician_FName     | varchar(100) | YES  |      | NULL          |                |
| Technician_LName     | varchar(100) | YES  |      | NULL          |                |
| Technician_dob       | date         | YES  |      | NULL          |                |
| Technician_Gender    | varchar(100) | YES  |      | NULL          |                |
| Technician_Address   | varchar(100) | YES  |      | NULL          |                |
| Technician_Email     | varchar(100) | YES  |      | NULL          |                |
| Technician_phone     | varchar(15)  | YES  |      | NULL          |                |

---

### Test
| Column Name     | Data Type     | Null | Key  | Default       | Extra          |
|------------------|---------------|------|------|---------------|----------------|
| Test_ID          | int(10)      | NO   | PRI  | NULL          | auto_increment |
| Test_Name        | varchar(100) | YES  |      | NULL          |                |
| Patient_ID       | int(10)      | NO   | MUL  | NULL          |                |
| Doctor_ID        | int(10)      | NO   | MUL  | NULL          |                |
| Technician_ID    | int(10)      | NO   | MUL  | NULL          |                |
| Test_result      | varchar(100) | YES  |      | NULL          |                |

---

### Treatment
| Column Name       | Data Type     | Null | Key  | Default       | Extra          |
|-------------------|---------------|------|------|---------------|----------------|
| Treatment_ID      | int(10)      | NO   | PRI  | NULL          | auto_increment |
| Treatment_Name    | varchar(100) | YES  |      | NULL          |                |
| Patient_ID        | int(10)      | NO   | MUL  | NULL          |                |
| Doctor_ID         | int(10)      | NO   | MUL  | NULL          |                |
| Nurse_ID          | int(10)      | YES  | MUL  | NULL          |                |
| Treatment_Date    | datetime     | YES  |      | NULL          |                |

---

### Vitals_Rounds
| Column Name         | Data Type     | Null | Key  | Default       | Extra          |
|---------------------|---------------|------|------|---------------|----------------|
| Vitals_rounds_ID    | int           | NO   | PRI  | NULL          | auto_increment |
| Patient_ID          | int           | NO   | MUL  | NULL          |                |
| Heart_rate          | int           | YES  |      | NULL          |                |
| Blood_pressure      | varchar(50)   | YES  |      | NULL          |                |
| Temperature         | decimal(5,2)  | YES  |      | NULL          |                |
| Checked_on          | datetime      | NO   |      | NULL          |                |
