# Project Overview

This hospital database project is designed to explore database design and MySQL functions in a simulated hospital environment. While the system is not intended for real-world use, it aims to model key operational tasks that hospital staff would need to address, such as patient management, doctor assignments, procedures, and medicine administration. The goal is to test out database interactions, including the use of stored procedures and functions to improve user experience and reduce errors.

The hospital management system (HMS) helps track patients, their illnesses, doctors, procedures, and prescribed medications. It also manages room assignments and keeps records of treatments and staff involvement. Key features of the system include:

- <B>Patient Management</B>: Stores patient details, stay information, and illness history.
- <B>Doctor Assignment</B>: Links doctors to patients and records activity.
- <B>Medicine Administration</B>: Tracks prescribed medicines based on patient illness.
- <B>Procedures and Treatments</B>: Monitors patient treatments and related dates.
- <B>Staff Assignments</B>: Manages doctor, nurse, and technician allocations.

This project also allowed me to test MySQL functions, such as normalization (up to 3NF), and design ER diagrams to visualize relationships between entities. The goal was to ensure the system is structured, efficient, and scalable, reducing errors and improving hospital operations.


# EER Diagram of Hospital Database

![EER Diagram](https://github.com/jwarner3rd/SQL_Hospital_Database_Project/blob/main/Images/EER%20Hospital.png)

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

