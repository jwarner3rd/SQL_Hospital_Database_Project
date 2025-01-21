# Project Overview

This hospital database project is designed to explore database design and MySQL functions in a simulated hospital environment. While the system is not intended for real-world use, it aims to model key operational tasks that hospital staff would need to address, such as patient management, doctor assignments, procedures, and medicine administration. The goal is to test out database interactions, including the use of stored procedures and functions to improve user experience and reduce errors.

The hospital management system (HMS) helps track patients, their illnesses, doctors, procedures, and prescribed medications. It also manages room assignments and keeps records of treatments and staff involvement. Key features of the system include:

- **`Patient Management`**: Stores patient details, stay information, illness history, and follow up aftercare appointments.
- **`Doctor Assignment`**: Links doctors to patients and records activity.
- **`Medicine Administration`**: Tracks prescribed and dispensed medications based on patient prescriptions and manages medication inventories through stored procedures, automatically reducing stock after dispensing and preventing further dispensing when medications are out of stock.
- **`Procedures and Treatments`**: Monitors patient treatments, tests, lab results, and related dates.
- **`Staff Assignments`**: Manages doctor, nurse, and technician allocations.

This project also allowed me to test MySQL functions, such as normalization, and design ER diagrams to visualize relationships between entities. The goal was to ensure the system is structured, efficient, and scalable, reducing errors and improving hospital operations.

# SQL Scripts for Hospital Database Management System

This folder contains all the necessary SQL scripts for the Hospital Database Management System project. The scripts are organized into different categories to provide clarity and ease of use.

## Contents

- **`Hospital_Export_Full.sql`**: This file contains the full SQL code to create the entire database structure. It includes the creation of tables, relationships, constraints, as well as triggers and stored procedures.
  
- **`seed.sql`**: A script to populate the database with initial data, allowing for testing and demonstration purposes.

- **`procedures/`**: Contains individual stored procedures. These files define specific actions or logic to be executed on the database, such as adding a new patient or updating medication records.
  
- **`triggers/`**: Contains individual SQL trigger files. These files define automatic actions that occur in response to changes in the database, such as inventory updates after medication dispensing.

- **`queries/`**: Provides example SQL queries for common operations such as reading, updating, and deleting records in the database.

## Usage
1. To recreate the database, run the `schema.sql` file.
2. Populate the database with initial data by running the `seed.sql` file.
3. Refer to the `procedures/` and `triggers/` directories for individual stored procedures and triggers if needed.

## Database Normalization

# EER Diagram of Hospital Database

![EER Diagram](https://github.com/jwarner3rd/SQL_Hospital_Database_Project/blob/main/Images/EER%20Hospital.png)

# Data Dictionary

This data dictionary provides details on the tables, columns, and data types in the hospital database.

For a detailed overview, download the data dictionary as a CSV file:
[Download Data Dictionary (CSV)](docs/HospitalDB_datadictionary.csv
)

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

