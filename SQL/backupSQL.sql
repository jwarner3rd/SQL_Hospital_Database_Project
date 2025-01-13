-- Database selected

USE HospitalDB;

-- Creating Patient Table
DROP TABLE IF EXISTS Patient;

Create table Patient ( 
	Patient_ID INT NOT NULL, 
	Patient_FName VARCHAR(100) NOT NULL, 
	Patient_LName VARCHAR(100) NOT NULL,
	dob DATE, 
	Patient_race VARCHAR(10),
	Blood_type VARCHAR(5),
	Patient_Address VARCHAR(100), 
	Patient_Email VARCHAR(100), 
	Patient_phone VARCHAR(15),
	Patient_Gender VARCHAR(100),
	Patient_Emergency_Contact INT,
	PCP INT, 
	Constraint Patient_PK Primary Key (Patient_ID),
	Constraint Patient_Doc_FK Foreign Key (PCP) references Doctor (Doctor_ID)
); 

-- Create Doctor Table
DROP TABLE IF EXISTS Doctor;

Create Table Doctor( 
	Doctor_ID INT NOT NULL, 
	Doctor_FName VARCHAR(100), 
	Doctor_LName VARCHAR(100), 
	Doctor_dob DATE, 
	Doctor_Gender VARCHAR(100), 
	Doctor_Address VARCHAR(100), 
	Doctor_Email VARCHAR(100),
	Doctor_phone VARCHAR(15),
	Constraint Doctor_PK Primary Key (Doctor_ID) 
); 

-- Creat Nurses Table
DROP TABLE IF EXISTS Nurse;

Create Table Nurse( 
	Nurse_ID INT NOT NULL, 
	Nurse_FName VARCHAR(100), 
	Nurse_LName VARCHAR(100), 
	Nurse_dob DATE, 
	Nurse_Gender VARCHAR(100), 
	Nurse_Address VARCHAR(100), 
	Nurse_Email VARCHAR(100),
	Nurse_phone VARCHAR(15),
	Constraint Nurse_PK Primary Key (Nurse_ID) 
); 

-- Adding Room table 

DROP TABLE IF EXISTS Room;

Create Table Room( 
	Room_no VARCHAR(50) NOT NULL, 
	Room_type VARCHAR(100), 
	Room_availibility boolean, 
	Room_Cost  DECIMAL(10,2),
	Constraint Room_PK Primary Key (Room_no) 
); 
-- Adding check in and out

DROP TABLE IF EXISTS Check_IN_OUT;

Create Table Check_IN_OUT( 
	Stay_ID INT NOT NULL,
	Patient_ID INT Not NUll, 
	Room_no VARCHAR (50) Not Null, 
	Join_date datetime, 
	Leave_date datetime, 
	Discharge_status VARCHAR (50),
	Constraint Check_IN_OUT_PK Primary Key (Stay_ID),
	Constraint Patient_IN_FK Foreign Key (Patient_ID) references Patient (Patient_ID),
	Constraint Room_no_FK Foreign Key (Room_no) references Room (Room_no)
);

-- Adding table for Emergency Contact

DROP TABLE IF EXISTS Emergency_Contact;

CREATE TABLE Emergency_Contact(
    Contact_ID INT  NOT NULL,
    Contact_Name VARCHAR(20) NOT NULL,
    Phone VARCHAR(12) NOT NULL,
    Relation VARCHAR(20) NOT NULL,
    Patient_ID  INT NOT NULL,
    Constraint Contact_ID_PK PRIMARY KEY (Contact_ID),
    Constraint Patient_FK FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID)
);

DROP TABLE IF EXISTS Lab_Screening;

CREATE TABLE  Lab_Screening (
    Lab_ID INT NOT NULL,
    Patient_ID  INT  NOT NULL,
    Technician_ID  INT  NOT NULL,
    Doctor_ID  INT NOT NULL,
    Test_Cost  DECIMAL(10,2),
    Date  DATE  NOT NULL,
    Constraint Lab_ID_PK PRIMARY KEY (Lab_ID),
    Constraint Patient_LS_FK FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID),
    Constraint Doctor_LS_FK FOREIGN KEY (Doctor_ID) REFERENCES Doctor (Doctor_ID),
	Constraint Technician_LS_FK FOREIGN KEY (Technician_ID) REFERENCES Techinican (Technician_ID)
);

DROP TABLE IF EXISTS Medicine;

CREATE TABLE Medicine (
    Medicine_ID INT  NOT NULL,
    Med_Name VARCHAR(20) NOT NULL,
    Med_Quantity INT NOT NULL,
    Med_Cost  Decimal(10,2),
   Constraint Medicine_ID_PK PRIMARY KEY (Medicine_ID)
);
    
DROP TABLE IF EXISTS Prescription;
    
CREATE TABLE Prescription (
    Prescription_ID INT NOT NULL,
    Patient_ID INT NOT NULL,
    Medicine_ID INT NOT NULL,
    Date_start DATE,
    Quanitity INT NOT NULL,
    Dosage INT, -- Dosage is number of times in a day
    Doctor_ID INT NOT NULL,
    Constraint Prescription_ID_PK PRIMARY KEY (Prescription_ID),
    Constraint Patient_ID_FK FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID),
    Constraint Doctor_ID_FK FOREIGN KEY (Doctor_ID) REFERENCES Doctor (Doctor_ID),
    Constraint Medicine_ID_FK FOREIGN KEY (Medicine_ID) REFERENCES Medicine (Medicine_ID)
);
    
 DROP TABLE IF EXISTS Appointment;
 
CREATE TABLE Appointment (
    Appt_ID INT NOT NULL,
    Scheduled_On DATETIME NOT NULL,
    Appt_Date DATE,
    Appt_Time TIME,
    Appt_kept Boolean,
    Doctor_ID INT NOT NULL,
    Patient_ID  INT NOT NULL,
    Constraint Appt_ID_PK PRIMARY KEY (Appt_ID),
    Constraint Doctor_FK FOREIGN KEY (Doctor_ID) REFERENCES Doctor (Doctor_ID), 
    Constraint Patient_Appt_FK FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID)
);

DROP TABLE IF EXISTS Diagnosis;

CREATE TABLE Diagnosis (
	Patient_ID INT NOT NULL,
    Doctor_ID  INT NOT NULL,
    Diagnosis_ID INT NOT NULL,
    Diagnosis VARCHAR(30) NOT NULL, 
    Lab_ID INT,
    Test_ID INT,
    since DATE NOT NULL, 
    enddate DATE,
    Constraint Diagnosis_ID_PK PRIMARY KEY (Diagnosis_ID),
	Constraint Doctor_D_FK FOREIGN KEY (Doctor_ID) REFERENCES Doctor (Doctor_ID),
	Constraint Lab_D_FK FOREIGN KEY (Lab_ID) REFERENCES Lab_Screening (Lab_ID),
	Constraint Patient_D_FK FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID),
    Constraint Test_D_FK FOREIGN KEY (Test_ID) REFERENCES Test (Test_ID)
);
    
DROP TABLE IF EXISTS Vitals_rounds;

CREATE TABLE Vitals_rounds (
	Vitals_rounds_ID INT NOT NULL,
    Patient_ID  INT  NOT NULL,
    Nurse_ID INT,
    BP_Systolic INT,
    BP_Diastolic INT,
    O2_Saturation INT,
    Temp INT,
    Date DATETIME,
    Med_dispense_ID INT NOT NULL,
	Constraint Vitals_rounds_ID_PK PRIMARY KEY (Vitals_rounds_ID),
    Constraint Patient_VR_FK FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID),
    Constraint Nurse_VR_FK FOREIGN KEY (Nurse_ID) REFERENCES Nurse (Nurse_ID),
    Constraint Med_dispense_VR_FK FOREIGN KEY (Med_dispense_ID) REFERENCES Med_dispense (Med_dispense_ID)
);

DROP TABLE IF EXISTS Techinican;

CREATE TABLE Techinican (
	Technician_ID INT NOT NULL,
    Technician_FName VARCHAR(100), 
	Technician_LName VARCHAR(100), 
	Technician_dob DATE, 
	Technician_Gender VARCHAR(100), 
	Technician_Address VARCHAR(100), 
	Technician_Email VARCHAR(100),
	Technician_phone VARCHAR(15),
	Constraint Technician_PK Primary Key (Technician_ID) 
    );

DROP TABLE IF EXISTS Test;

CREATE TABLE Test (
	Test_ID INT NOT NULL,
    Test_Name VARCHAR(100),
	Patient_ID  INT  NOT NULL,
    Doctor_ID INT NOT NULL,
    Technician_ID INT NOT NULL,
    Test_result VARCHAR(100),
	Constraint Test_ID_PK PRIMARY KEY (Test_ID),
	Constraint Patient_Test_FK FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID),
	Constraint Doctor_Test_FK FOREIGN KEY (Doctor_ID) REFERENCES Doctor (Doctor_ID),
	Constraint Technician_Test_FK FOREIGN KEY (Technician_ID) REFERENCES Techinican (Technician_ID)
);

DROP TABLE IF EXISTS Treatment;

CREATE TABLE Treatment (
	Treatment_ID INT NOT NULL,
	Treatment_Name VARCHAR(100),
    Patient_ID  INT  NOT NULL,
    Doctor_ID INT NOT NULL,
    Nurse_ID INT,
    Treatment_Date DATETIME,
	Constraint Treatment_ID_PK PRIMARY KEY (Treatment_ID),
	Constraint Patient_Treat_FK FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID),
	Constraint Doctor_Treat_FK FOREIGN KEY (Doctor_ID) REFERENCES Doctor (Doctor_ID),
	Constraint Nurse_Treat_FK FOREIGN KEY (Nurse_ID) REFERENCES Nurse (Nurse_ID)
);

DROP TABLE IF EXISTS Med_dispense;

CREATE TABLE Med_dispense (
	Med_dispense_ID INT NOT NULL,
    Patient_ID  INT  NOT NULL,
    Doctor_ID INT NOT NULL,
    Nurse_ID INT NOT NULL,
    Medicine_ID INT  NOT NULL,
    Prescription_ID INT NOT NULL,
    Dispense_Date DATETIME,
	Constraint Med_dispense_ID_PK PRIMARY KEY (Med_dispense_ID),
	Constraint Patient_MD_FK FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID),
	Constraint Doctor_MD_FK FOREIGN KEY (Doctor_ID) REFERENCES Doctor (Doctor_ID),
	Constraint Nurse_MD_FK FOREIGN KEY (Nurse_ID) REFERENCES Nurse (Nurse_ID),
	Constraint Medicine_MD_FK FOREIGN KEY (Medicine_ID) REFERENCES Medicine (Medicine_ID),
    Constraint Prescription_MD_FK FOREIGN KEY (Medicine_ID) REFERENCES Prescription (Prescription_ID)
);
INSERT INTO Doctor (Doctor_ID, Doctor_FName, Doctor_LName, Doctor_dob, Doctor_Gender, Doctor_Address, Doctor_Email, Doctor_phone) VALUES
(1, 'Gregory', 'House', '1959-06-11', 'Male', '221B Baker Street, Princeton, NJ', 'ghouse@princetonplainsboro.com', '123-456-7890'),
(2, 'Meredith', 'Grey', '1978-02-19', 'Female', '123 Seattle Grace Dr, Seattle, WA', 'mgrey@grey-sloan.com', '123-456-7891'),
(3, 'John', 'Dorian', '1979-04-22', 'Male', '555 Sacred Heart Way, San Diego, CA', 'jdorian@sacredheart.com', '123-456-7892'),
(4, 'Derek', 'Shepherd', '1966-11-13', 'Male', '789 Seattle Grace Dr, Seattle, WA', 'dshepherd@grey-sloan.com', '123-456-7893'),
(5, 'Christina', 'Yang', '1976-07-15', 'Female', '321 Seattle Grace Dr, Seattle, WA', 'cyang@grey-sloan.com', '123-456-7894'),
(6, 'James', 'Wilson', '1969-10-07', 'Male', '222B Baker Street, Princeton, NJ', 'jwilson@princetonplainsboro.com', '123-456-7895'),
(7, 'Leonard', 'McCoy', '1965-01-20', 'Male', 'USS Enterprise, Space', 'lmccoy@starfleet.com', '123-456-7896'),
(8, 'Mark', 'Sloan', '1968-05-05', 'Male', '654 Seattle Grace Dr, Seattle, WA', 'msloan@grey-sloan.com', '123-456-7897'),
(9, 'Miranda', 'Bailey', '1970-10-20', 'Female', '987 Seattle Grace Dr, Seattle, WA', 'mbailey@grey-sloan.com', '123-456-7898'),
(10, 'Lisa', 'Cuddy', '1967-06-21', 'Female', '223B Baker Street, Princeton, NJ', 'lcuddy@princetonplainsboro.com', '123-456-7899'),
(11, 'Michaela', 'Quinn', '1963-02-15', 'Female', 'Colorado Springs, CO', 'mquinn@drquinn.com', '123-456-7800'),
(12, 'Doug', 'Ross', '1962-01-27', 'Male', 'County General Hospital, Chicago, IL', 'dross@countygen.com', '123-456-7801'),
(13, 'Elizabeth', 'Corday', '1966-10-05', 'Female', 'County General Hospital, Chicago, IL', 'ecorday@countygen.com', '123-456-7802'),
(14, 'Philip', 'Chandler', '1948-11-12', 'Male', 'St. Eligius Hospital, Boston, MA', 'pchandler@steligius.com', '123-456-7803'),
(15, 'Steven', 'Kiley', '1942-09-16', 'Male', 'San Francisco Memorial Hospital, San Francisco, CA', 'skiley@sfmemorial.com', '123-456-7804'),
(16, 'Benjamin', 'Hawkeye', '1924-04-04', 'Male', '4077th MASH, Uijeongbu, South Korea', 'bpierce@mash4077.com', '123-456-7805'),
(17, 'John', 'Watson', '1952-03-31', 'Male', '221B Baker Street, London, UK', 'jwatson@bakerstreet.com', '123-456-7806'),
(18, 'Noah', 'Wyle', '1971-06-04', 'Male', 'County General Hospital, Chicago, IL', 'nwyle@countygen.com', '123-456-7807'),
(19, 'Juliet', 'Burke', '1968-06-12', 'Female', 'The Island, South Pacific', 'jburke@theisland.com', '123-456-7808'),
(20, 'Perry', 'Cox', '1961-03-02', 'Male', '555 Sacred Heart Way, San Diego, CA', 'pcox@sacredheart.com', '123-456-7809');

-- Insert data into Nurse Table

INSERT INTO Nurse (Nurse_ID, Nurse_FName, Nurse_LName, Nurse_dob, Nurse_Gender, Nurse_Address, Nurse_Email, Nurse_phone) VALUES
(1, 'Carla', 'Espinosa', '1975-11-27', 'Female', '555 Sacred Heart Way, San Diego, CA', 'cespinosa@sacredheart.com', '123-456-7890'),
(2, 'Jackie', 'Peyton', '1970-04-14', 'Female', 'All Saints Hospital, New York, NY', 'jpeyton@allsaints.com', '123-456-7891'),
(3, 'Samantha', 'Taggart', '1973-08-19', 'Female', 'County General Hospital, Chicago, IL', 'staggart@countygen.com', '123-456-7892'),
(4, 'Peter', 'Petrelli', '1977-12-23', 'Male', 'New York City, NY', 'ppetrelli@nyc.com', '123-456-7893'),
(5, 'Abby', 'Lockhart', '1969-01-10', 'Female', 'County General Hospital, Chicago, IL', 'alockhart@countygen.com', '123-456-7894'),
(6, 'Zoey', 'Barkow', '1984-03-15', 'Female', 'All Saints Hospital, New York, NY', 'zbarkow@allsaints.com', '123-456-7895'),
(7, 'Carol', 'Hathaway', '1967-11-10', 'Female', 'County General Hospital, Chicago, IL', 'chathaway@countygen.com', '123-456-7896'),
(8, 'Jackie', 'Bouvier', '1940-07-28', 'Female', 'New York, NY', 'jbouvier@ny.com', '123-456-7897'),
(9, 'Helen', 'Rosenthal', '1955-02-13', 'Female', 'St. Eligius Hospital, Boston, MA', 'hrosenthal@steligius.com', '123-456-7898'),
(10, 'Ray', 'Barnett', '1975-05-20', 'Male', 'County General Hospital, Chicago, IL', 'rbarnett@countygen.com', '123-456-7899'),
(11, 'Gloria', 'Akalitus', '1953-06-03', 'Female', 'All Saints Hospital, New York, NY', 'gakalitus@allsaints.com', '123-456-7800'),
(12, 'Kit', 'Voss', '1962-08-22', 'Female', 'Chastain Park Memorial, Atlanta, GA', 'kvoss@chastainpark.com', '123-456-7801'),
(13, 'Eddie', 'Johnson', '1980-09-09', 'Male', 'Chicago Med, Chicago, IL', 'ejohnson@chicagomed.com', '123-456-7802'),
(14, 'Julia', 'Hanlon', '1971-04-05', 'Female', 'County General Hospital, Chicago, IL', 'jhanlon@countygen.com', '123-456-7803'),
(15, 'Robert', 'Roman', '1985-12-30', 'Male', 'St. Eligius Hospital, Boston, MA', 'rroman@steligius.com', '123-456-7804'),
(16, 'Sam', 'Bennett', '1973-05-08', 'Male', 'Oceanside Wellness Group, Santa Monica, CA', 'sbennett@oceanside.com', '123-456-7805'),
(17, 'April', 'Kepner', '1982-04-23', 'Female', 'Grey Sloan Memorial, Seattle, WA', 'akepner@greysloan.com', '123-456-7806'),
(18, 'Rita', 'Alvarez', '1978-09-11', 'Female', 'Chastain Park Memorial, Atlanta, GA', 'ralvarez@chastainpark.com', '123-456-7807'),
(19, 'Izzie', 'Stevens', '1981-02-11', 'Female', 'Grey Sloan Memorial, Seattle, WA', 'istevens@greysloan.com', '123-456-7808'),
(20, 'Thor', 'Lundgren', '1977-03-03', 'Male', 'Seattle Grace Hospital, Seattle, WA', 'tlundgren@seattlegra.com', '123-456-7809');

ALTER TABLE Patient MODIFY COLUMN Patient_race VARCHAR(100);

INSERT INTO Patient (Patient_ID, Patient_FName, Patient_LName, dob, Patient_race, Blood_type, Patient_Address, Patient_Email, Patient_phone, Patient_Gender, Patient_Emergency_Contact, PCP) VALUES
(1, 'Michael', 'Kyle', '1965-08-15', 'Black', 'A+', 'Stamford, CT', 'mkyle@stamford.com', '123-456-7001', 'Male', 1234567002, 1),
(2, 'Janet', 'Kyle', '1968-01-21', 'Black', 'O-', 'Stamford, CT', 'jkyle@stamford.com', '123-456-7002', 'Female', 1234567001, 2),
(3, 'Junior', 'Kyle', '1989-10-27', 'Black', 'B+', 'Stamford, CT', 'jkylejr@stamford.com', '123-456-7003', 'Male', 1234567002, 3),
(4, 'Claire', 'Kyle', '1992-07-02', 'Black', 'AB-', 'Stamford, CT', 'ckyle@stamford.com', '123-456-7004', 'Female', 1234567002, 4),
(5, 'Kady', 'Kyle', '1998-09-22', 'Black', 'O+', 'Stamford, CT', 'kkyle@stamford.com', '123-456-7005', 'Female', 1234567002, 5),
(6, 'Franklin', 'Mumford', '1998-05-14', 'Black', 'A-', 'Stamford, CT', 'fmumford@stamford.com', '123-456-7006', 'Male', 1234567005, 6),
(7, 'Will', 'Smith', '1968-09-25', 'Black', 'B+', 'Bel-Air, CA', 'wsmith@belair.com', '123-456-7007', 'Male', 1234567008, 7),
(8, 'Philip', 'Banks', '1946-01-30', 'Black', 'O+', 'Bel-Air, CA', 'pbanks@belair.com', '123-456-7008', 'Male', 1234567007, 8),
(9, 'Vivian', 'Banks', '1951-04-15', 'Black', 'A-', 'Bel-Air, CA', 'vbanks@belair.com', '123-456-7009', 'Female', 1234567008, 9),
(10, 'Carlton', 'Banks', '1971-08-12', 'Black', 'AB+', 'Bel-Air, CA', 'cbanks@belair.com', '123-456-7010', 'Male', 1234567009, 10),
(11, 'Hilary', 'Banks', '1969-11-30', 'Black', 'B-', 'Bel-Air, CA', 'hbanks@belair.com', '123-456-7011', 'Female', 1234567010, 11),
(12, 'Ashley', 'Banks', '1979-04-22', 'Black', 'O-', 'Bel-Air, CA', 'abanks@belair.com', '123-456-7012', 'Female', 1234567011, 12),
(13, 'Geoffrey', 'Butler', '1948-03-27', 'Black', 'A+', 'Bel-Air, CA', 'gbutler@belair.com', '123-456-7013', 'Male', 1234567012, 13),
(14, 'Julius', 'Rock', '1966-10-31', 'Black', 'O+', 'Bed-Stuy, NY', 'jrock@bedstuy.com', '123-456-7014', 'Male', 1234567013, 14),
(15, 'Rochelle', 'Rock', '1971-03-19', 'Black', 'A-', 'Bed-Stuy, NY', 'rrock@bedstuy.com', '123-456-7015', 'Female', 1234567014, 15),
(16, 'Gloria', 'Delgado-Pritchett', '1972-04-05', 'Hispanic', 'AB+', 'Los Angeles, CA', 'gpritchett@modernfamily.com', '123-456-7016', 'Female', 1234567017, 16),
(17, 'Jay', 'Pritchett', '1947-07-15', 'Hispanic', 'O-', 'Los Angeles, CA', 'jpritchett@modernfamily.com', '123-456-7017', 'Male', 1234567016, 17),
(18, 'Manny', 'Delgado', '1998-07-01', 'Hispanic', 'B+', 'Los Angeles, CA', 'mdelgado@modernfamily.com', '123-456-7018', 'Male', 1234567017, 18),
(19, 'Alex', 'Dunphy', '1997-01-14', 'Hispanic', 'AB-', 'Los Angeles, CA', 'adunphy@modernfamily.com', '123-456-7019', 'Female', 1234567018, 19),
(20, 'Gloria', 'Pritchett', '1972-04-05', 'Hispanic', 'A+', 'Los Angeles, CA', 'gpritchett@modernfamily.com', '123-456-7020', 'Female', 1234567017, 20),
(21, 'Sofia', 'Vergara', '1972-07-10', 'Hispanic', 'B-', 'Los Angeles, CA', 'svergara@modernfamily.com', '123-456-7021', 'Female', 1234567020, 1),
(22, 'Manny', 'Alvarez', '1998-09-12', 'Hispanic', 'O+', 'Chicago, IL', 'malvarez@chicago.com', '123-456-7022', 'Male', 1234567021, 2),
(23, 'Gloria', 'Mendoza', '1980-03-25', 'Hispanic', 'A-', 'Brooklyn, NY', 'gmendoza@brooklyn.com', '123-456-7023', 'Female', 1234567022, 3),
(24, 'Esteban', 'Julio Ricardo Montoya de la Rosa Ramírez', '1974-12-31', 'Hispanic', 'AB+', 'Boston, MA', 'esteban@boston.com', '123-456-7024', 'Male', 1234567023, 4),
(25, 'Angela', 'Puente', '1985-06-18', 'Hispanic', 'O-', 'Miami, FL', 'apuente@miami.com', '123-456-7025', 'Female', 1234567024, 5),
(26, 'Tom', 'Haverford', '1975-05-07', 'Asian', 'A+', 'Pawnee, IN', 'thaverford@pawnee.com', '123-456-7026', 'Male', 1234567027, 6),
(27, 'Rajesh', 'Koothrappali', '1981-10-06', 'Asian', 'O-', 'Pasadena, CA', 'rkoothrappali@pasadena.com', '123-456-7027', 'Male', 1234567026, 7),
(28, 'Ken', 'Jeong', '1969-07-13', 'Asian', 'B+', 'Los Angeles, CA', 'kjeong@losangeles.com', '123-456-7028', 'Male', 1234567027, 8),
(29, 'Margaret', 'Cho', '1968-12-05', 'Asian', 'AB-', 'San Francisco, CA', 'mcho@sanfrancisco.com', '123-456-7029', 'Female', 1234567028, 9),
(30, 'Amy', 'Wong', '2978-12-03', 'Asian', 'O+', 'New New York, NY', 'awong@newnewyork.com', '123-456-7030', 'Female', 1234567029, 10),
(31, 'Fujimoto', 'Glenn', '1960-02-23', 'Asian', 'A-', 'Tokyo, Japan', 'fujimoto@tokyo.com', '123-456-7031', 'Male', 1234567030, 11),
(32, 'Mindy', 'Lahiri', '1979-06-24', 'Asian', 'B-', 'New York, NY', 'mlahiri@newyork.com', '123-456-7032', 'Female', 1234567031, 12),
(33, 'Appa', 'Kim', '1956-08-19', 'Asian', 'AB+', 'Toronto, Canada', 'appakim@toronto.com', '123-456-7033', 'Male', 1234567032, 13),
(34, 'Umma', 'Kim', '1960-11-29', 'Asian', 'O-', 'Toronto, Canada', 'ummakim@toronto.com', '123-456-7034', 'Female', 1234567033, 14),
(35, 'Janet', 'Kim', '1989-04-09', 'Asian', 'A+', 'Toronto, Canada', 'janetkim@toronto.com', '123-456-7035', 'Female', 1234567034, 15),
(36, 'Chris', 'Traeger', '1972-09-25', 'Native American', 'A+', 'Pawnee, IN', 'chris.traeger@pawnee.com', '123-456-7036', 'Male', 1234567035, 16),
(37, 'Jerry', 'Gergich', '1948-04-09', 'Native American', 'O-', 'Pawnee, IN', 'jerry.gergich@pawnee.com', '123-456-7037', 'Male', 1234567036, 17),
(38, 'Jay', 'Jackson', '1965-12-15', 'Pacific Islander', 'AB-', 'Honolulu, HI', 'jjackson@honolulu.com', '123-456-7038', 'Male', 1234567037, 18),
(39, 'Reggie', 'Bush', '1985-03-02', 'Pacific Islander', 'O+', 'Los Angeles, CA', 'rbush@losangeles.com', '123-456-7039', 'Male', 1234567038, 19),
(40, 'Johnson', 'Haynes', '1978-08-20', 'Pacific Islander', 'B+', 'Maui, HI', 'jhaynes@maui.com', '123-456-7040', 'Male', 1234567039, 20),
(41, 'Ned', 'Flanders', '1952-03-22', 'White', 'O+', 'Springfield, IL', 'ned.flanders@springfield.com', '123-456-7041', 'Male', 1234567040, 1),
(42, 'Moe', 'Szyslak', '1952-11-24', 'White', 'A+', 'Springfield, IL', 'moe.szyslak@springfield.com', '123-456-7042', 'Male', 1234567041, 2),
(43, 'Barney', 'Gumble', '1956-04-20', 'White', 'B-', 'Springfield, IL', 'barney.gumble@springfield.com', '123-456-7043', 'Male', 1234567042, 3),
(44, 'Principal', 'Seymour Skinner', '1953-11-05', 'White', 'AB+', 'Springfield, IL', 'skinner@springfield.com', '123-456-7044', 'Male', 1234567043, 4),
(45, 'Groundskeeper', 'Willie', '1955-07-15', 'White', 'O-', 'Springfield, IL', 'willie@springfield.com', '123-456-7045', 'Male', 1234567044, 5),
(46, 'Waylon', 'Smithers', '1960-10-01', 'White', 'A-', 'Springfield, IL', 'smithers@springfield.com', '123-456-7046', 'Male', 1234567045, 6),
(47, 'Lenny', 'Leonard', '1952-06-23', 'White', 'B+', 'Springfield, IL', 'lenny@springfield.com', '123-456-7047', 'Male', 1234567046, 7),
(48, 'Carl', 'Carlson', '1956-09-24', 'White', 'AB-', 'Springfield, IL', 'carl@springfield.com', '123-456-7048', 'Male', 1234567047, 8),
(49, 'Seymour', 'Hoffman', '1949-04-30', 'White', 'O+', 'Springfield, IL', 'hoffman@springfield.com', '123-456-7049', 'Male', 1234567048, 9),
(50, 'Edna', 'Krabappel', '1950-10-25', 'White', 'A-', 'Springfield, IL', 'krabappel@springfield.com', '123-456-7050', 'Female', 1234567049, 10),
(51, 'Agnes', 'Skinner', '1925-11-23', 'White', 'AB+', 'Springfield, IL', 'askinner@springfield.com', '123-456-7051', 'Female', 1234567050, 11),
(52, 'Clancy', 'Wiggum', '1952-09-18', 'White', 'O+', 'Springfield, IL', 'wiggum@springfield.com', '123-456-7052', 'Male', 1234567051, 12),
(53, 'Helen', 'Lovejoy', '1953-02-12', 'White', 'B-', 'Springfield, IL', 'hlovejoy@springfield.com', '123-456-7053', 'Female', 1234567052, 13),
(54, 'Reverend', 'Timothy Lovejoy', '1950-12-19', 'White', 'AB+', 'Springfield, IL', 'tlovejoy@springfield.com', '123-456-7054', 'Male', 1234567053, 14),
(55, 'Marge', 'Bouvier', '1956-10-01', 'White', 'O-', 'Springfield, IL', 'marge@springfield.com', '123-456-7055', 'Female', 1234567054, 15),
(56, 'Sideshow', 'Bob', '1957-07-29', 'White', 'A+', 'Springfield, IL', 'sbob@springfield.com', '123-456-7056', 'Male', 1234567055, 16),
(57, 'Krusty', 'the Clown', '1952-09-03', 'White', 'B+', 'Springfield, IL', 'krusty@springfield.com', '123-456-7057', 'Male', 1234567056, 17),
(58, 'Patty', 'Bouvier', '1952-02-18', 'White', 'AB-', 'Springfield, IL', 'patty@springfield.com', '123-456-7058', 'Female', 1234567057, 18),
(59, 'Selma', 'Bouvier', '1952-02-18', 'White', 'O+', 'Springfield, IL', 'selma@springfield.com', '123-456-7059', 'Female', 1234567058, 4),
(60, 'Ron', 'Swanson', '1960-05-06', 'White', 'B-', 'Pawnee, IN', 'rswanson@pawnee.com', '123-456-7060', 'Male', 1234567020, 1);

INSERT INTO Emergency_Contact (Contact_ID, Contact_Name, Phone, Relation, Patient_ID) VALUES
(1, 'Jack McCoy', '555-123-1001', 'Spouse', 1),
(2, 'Anita Van Buren', '555-123-1002', 'Parent', 2),
(3, 'Olivia Benson', '555-123-1003', 'Sibling', 3),
(4, 'Elliot Stabler', '555-123-1004', 'Friend', 4),
(5, 'Lennie Briscoe', '555-123-1005', 'Child', 5),
(6, 'Rey Curtis', '555-123-1006', 'Sibling', 6),
(7, 'Mike Logan', '555-123-1007', 'Spouse', 7),
(8, 'Bobby Goren', '555-123-1008', 'Friend', 8),
(9, 'Alex Eames', '555-123-1009', 'Child', 9),
(10, 'Cyrus Lupo', '555-123-1010', 'Friend', 10),
(11, 'Kevin Bernard', '555-123-1011', 'Parent', 11),
(12, 'Joe Fontana', '555-123-1012', 'Friend', 12),
(13, 'Rey Curtis', '555-123-1013', 'Sibling', 13),
(14, 'Ben Stone', '555-123-1014', 'Friend', 14),
(15, 'Paul Robinette', '555-123-1015', 'Child', 15),
(16, 'Arthur Branch', '555-123-1016', 'Friend', 16),
(17, 'Michael Cutter', '555-123-1017', 'Sibling', 17),
(18, 'Connie Rubirosa', '555-123-1018', 'Friend', 18),
(19, 'Nora Lewin', '555-123-1019', 'Spouse', 19),
(20, 'Ed Green', '555-123-1020', 'Child', 20),
(21, 'Phil Cerreta', '555-123-1021', 'Friend', 21),
(22, 'Nick Falco', '555-123-1022', 'Parent', 22),
(23, 'Jamie Ross', '555-123-1023', 'Friend', 23),
(24, 'Serena Southerlyn', '555-123-1024', 'Sibling', 24),
(25, 'Arthur Branch', '555-123-1025', 'Friend', 25),
(26, 'Nora Lewin', '555-123-1026', 'Parent', 26),
(27, 'Adam Schiff', '555-123-1027', 'Friend', 27),
(28, 'Connie Rubirosa', '555-123-1028', 'Sibling', 28),
(29, 'Ben Stone', '555-123-1029', 'Friend', 29),
(30, 'Paul Robinette', '555-123-1030', 'Parent', 30),
(31, 'Arthur Branch', '555-123-1031', 'Friend', 31),
(32, 'Jack McCoy', '555-123-1032', 'Child', 32),
(33, 'Nora Lewin', '555-123-1033', 'Friend', 33),
(34, 'Serena Southerlyn', '555-123-1034', 'Sibling', 34),
(35, 'Michael Cutter', '555-123-1035', 'Friend', 35),
(36, 'Connie Rubirosa', '555-123-1036', 'Parent', 36),
(37, 'Mike Logan', '555-123-1037', 'Friend', 37),
(38, 'Lennie Briscoe', '555-123-1038', 'Child', 38),
(39, 'Rey Curtis', '555-123-1039', 'Sibling', 39),
(40, 'Joe Fontana', '555-123-1040', 'Friend', 40),
(41, 'Anita Van Buren', '555-123-1041', 'Parent', 41),
(42, 'Rey Curtis', '555-123-1042', 'Sibling', 42),
(43, 'Olivia Benson', '555-123-1043', 'Friend', 43),
(44, 'Elliot Stabler', '555-123-1044', 'Child', 44),
(45, 'Ed Green', '555-123-1045', 'Friend', 45),
(46, 'Nina Cassidy', '555-123-1046', 'Sibling', 46),
(47, 'Cyrus Lupo', '555-123-1047', 'Friend', 47),
(48, 'Kevin Bernard', '555-123-1048', 'Parent', 48),
(49, 'Nina Cassady', '555-123-1049', 'Friend', 49),
(50, 'Joe Fontana', '555-123-1050', 'Child', 50),
(51, 'Carmichael', '555-123-1051', 'Friend', 51),
(52, 'Phil Cerreta', '555-123-1052', 'Parent', 52),
(53, 'Lennie Briscoe', '555-123-1053', 'Friend', 53),
(54, 'Rey Curtis', '555-123-1054', 'Sibling', 54),
(55, 'Mike Logan', '555-123-1055', 'Friend', 55),
(56, 'Adam Schiff', '555-123-1056', 'Child', 56),
(57, 'Jamie Ross', '555-123-1057', 'Friend', 57),
(58, 'Serena Southerlyn', '555-123-1058', 'Parent', 58),
(59, 'Arthur Branch', '555-123-1059', 'Friend', 59),
(60, 'Jack McCoy', '555-123-1060', 'Sibling', 60);

INSERT INTO Medicine (Medicine_ID, Med_Name, Med_Quantity, Med_Cost) VALUES
(1, 'Acetaminophen', 200, 5.99),
(2, 'Ibuprofen', 150, 7.49),
(3, 'Amoxicillin', 100, 10.99),
(4, 'Lisinopril', 125, 12.99),
(5, 'Levothyroxine', 180, 8.99),
(6, 'Metformin', 100, 9.99),
(7, 'Atorvastatin', 150, 11.49),
(8, 'Simvastatin', 200, 10.99),
(9, 'Omeprazole', 180, 9.99),
(10, 'Metoprolol', 200, 12.99),
(11, 'Losartan', 150, 11.99),
(12, 'Amlodipine', 175, 10.49),
(13, 'Albuterol', 120, 15.99),
(14, 'Hydrocodone', 100, 18.99),
(15, 'Azithromycin', 80, 14.49),
(16, 'Gabapentin', 200, 11.99),
(17, 'Furosemide', 100, 9.99),
(18, 'Sertraline', 150, 13.99),
(19, 'Metronidazole', 90, 12.49),
(20, 'Amitriptyline', 80, 14.99),
(21, 'Citalopram', 175, 13.49),
(22, 'Prednisone', 200, 8.99),
(23, 'Warfarin', 100, 11.49),
(24, 'Tramadol', 150, 10.99),
(25, 'Folic Acid', 100, 7.99),
(26, 'Cephalexin', 125, 9.49),
(27, 'Potassium Chloride', 180, 8.49),
(28, 'Clonazepam', 150, 12.99),
(29, 'Fluoxetine', 200, 9.99),
(30, 'Bupropion', 150, 14.49),
(31, 'Cyclobenzaprine', 100, 13.99),
(32, 'Meloxicam', 175, 11.99),
(33, 'Naproxen', 200, 8.99),
(34, 'Duloxetine', 150, 15.49),
(35, 'Escitalopram', 120, 12.99),
(36, 'Methotrexate', 100, 16.49),
(37, 'Carvedilol', 150, 11.99),
(38, 'Trazodone', 200, 10.49),
(39, 'Doxycycline', 90, 9.99),
(40, 'Alprazolam', 175, 13.49),
(41, 'Zolpidem', 150, 14.99),
(42, 'Venlafaxine', 200, 12.99),
(43, 'Lorazepam', 100, 11.99),
(44, 'Mirtazapine', 125, 15.49),
(45, 'Rosuvastatin', 150, 12.99),
(46, 'Alendronate', 180, 9.99),
(47, 'Clobetasol', 200, 11.99),
(48, 'Diazepam', 150, 14.99),
(49, 'Paroxetine', 175, 13.49),
(50, 'Benazepril', 200, 10.99),
(51, 'Ciprofloxacin', 100, 12.49),
(52, 'Fluticasone', 150, 11.99),
(53, 'Lansoprazole', 175, 10.99),
(54, 'Hydrochlorothiazide', 180, 8.99),
(55, 'Tamsulosin', 100, 9.99),
(56, 'Quetiapine', 125, 14.49),
(57, 'Metoclopramide', 150, 12.99),
(58, 'Sulfamethoxazole', 200, 10.99),
(59, 'Methylprednisolone', 100, 13.49),
(60, 'Cefdinir', 175, 9.99),
(61, 'Cyclosporine', 150, 16.49),
(62, 'Nortriptyline', 180, 10.99),
(63, 'Budesonide', 200, 11.99),
(64, 'Nystatin', 150, 8.49),
(65, 'Risperidone', 100, 14.99),
(66, 'Clindamycin', 125, 12.49),
(67, 'Benzonatate', 200, 9.99),
(68, 'Fluconazole', 150, 11.99),
(69, 'Prednisolone', 175, 10.49),
(70, 'Triamcinolone', 100, 13.99),
(71, 'Levofloxacin', 150, 12.99),
(72, 'Mupirocin', 180, 10.49),
(73, 'Olanzapine', 200, 14.49),
(74, 'Doxazosin', 100, 11.99),
(75, 'Pantoprazole', 125, 9.99);

-- Insert data into Technician Table

INSERT INTO Techinican (Technician_ID, Technician_FName, Technician_LName, Technician_dob, Technician_Gender, Technician_Address, Technician_Email, Technician_phone) VALUES
(1, 'Jeff', 'Winger', '1973-11-20', 'Male', 'Greendale, CO', 'jeff.winger@greendale.edu', '123-456-8001'),
(2, 'Britta', 'Perry', '1980-10-19', 'Female', 'Greendale, CO', 'britta.perry@greendale.edu', '123-456-8002'),
(3, 'Abed', 'Nadir', '1983-03-24', 'Male', 'Greendale, CO', 'abed.nadir@greendale.edu', '123-456-8003'),
(4, 'Annie', 'Edison', '1990-12-19', 'Female', 'Greendale, CO', 'annie.edison@greendale.edu', '123-456-8004'),
(5, 'Troy', 'Barnes', '1989-04-04', 'Male', 'Greendale, CO', 'troy.barnes@greendale.edu', '123-456-8005'),
(6, 'Shirley', 'Bennett', '1971-11-12', 'Female', 'Greendale, CO', 'shirley.bennett@greendale.edu', '123-456-8006'),
(7, 'Pierce', 'Hawthorne', '1944-01-24', 'Male', 'Greendale, CO', 'pierce.hawthorne@greendale.edu', '123-456-8007'),
(8, 'Ben', 'Chang', '1969-05-02', 'Male', 'Greendale, CO', 'ben.chang@greendale.edu', '123-456-8008'),
(9, 'Dean', 'Pelton', '1972-08-13', 'Male', 'Greendale, CO', 'dean.pelton@greendale.edu', '123-456-8009'),
(10, 'Magnitude', 'Magnitude', '1985-06-28', 'Male', 'Greendale, CO', 'magnitude@greendale.edu', '123-456-8010');

-- Insert data into Room Table

INSERT INTO Room (Room_no, Room_type, Room_availibility, Room_Cost) VALUES
('01', 'Shared', true, 50.00),
('02', 'Shared', true, 50.00),
('03', 'Shared', true, 50.00),
('04', 'Shared', true, 50.00),
('05', 'Shared', true, 50.00),
('06', 'Shared', true, 50.00),
('07', 'Shared', true, 50.00),
('08', 'Shared', true, 50.00),
('09', 'Shared', true, 50.00),
('10', 'Shared', true, 50.00),
('11', 'Single', true, 100.00),
('12', 'Single', true, 100.00),
('13', 'Single', true, 100.00),
('14', 'Single', true, 100.00),
('15', 'Single', true, 100.00);

-- starting with Med_dispense.  I believe for this the dispence Id should also have a prescription_ID and vitals_round_ID
ALTER TABLE Vitals_rounds DROP FOREIGN KEY Med_dispense_VR_FK;
-- Add other necessary drop constraints commands here if there are more constraints.

ALTER TABLE Med_dispense MODIFY COLUMN Med_dispense_ID INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Med_dispense ADD CONSTRAINT Prescript_MD_FK FOREIGN KEY (Prescription_ID) REFERENCES Prescription (Prescription_ID);
ALTER TABLE Vitals_rounds ADD CONSTRAINT Med_dispense_VR_FK FOREIGN KEY (Med_dispense_ID) REFERENCES Med_dispense (Med_dispense_ID);

-- Add other necessary add constraints commands here if there are more constraints.

ALTER TABLE Med_dispense 
ADD CONSTRAINT Prescript_MD_FK FOREIGN KEY (Prescription_ID) REFERENCES Prescription (Prescription_ID); -- Didn't run

-- Continuing to appointment

ALTER TABLE Appointment MODIFY COLUMN Appt_ID INT NOT NULL AUTO_INCREMENT;

-- updating Diagnosis

ALTER TABLE Diagnosis MODIFY COLUMN Diagnosis_ID INT NOT NULL AUTO_INCREMENT;

-- Updating Lab_Screening
ALTER TABLE Diagnosis DROP FOREIGN KEY Lab_D_FK;

ALTER TABLE Lab_Screening MODIFY COLUMN Lab_ID INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Diagnosis ADD CONSTRAINT Lab_D_FK FOREIGN KEY (Lab_ID) REFERENCES Lab_Screening (Lab_ID);

-- Updating Prescription

ALTER TABLE Prescription MODIFY COLUMN Prescription_ID INT NOT NULL AUTO_INCREMENT;

-- Updating Test
ALTER TABLE Diagnosis DROP FOREIGN KEY Test_D_FK;

ALTER TABLE Test MODIFY COLUMN Test_ID INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Diagnosis ADD CONSTRAINT Test_D_FK FOREIGN KEY (Test_ID) REFERENCES Test (Test_ID);

-- Updating Treatment

ALTER TABLE Test MODIFY COLUMN Test_ID INT NOT NULL AUTO_INCREMENT;

-- Updating Vitals_rounds

ALTER TABLE Vitals_rounds MODIFY COLUMN Vitals_rounds_ID INT NOT NULL AUTO_INCREMENT; -- Didn't run

-- Everything updated with the execption of the med_dispense.  Making the changes

ALTER TABLE Med_dispense
ADD COLUMN Vitals_rounds_ID INT,
ADD CONSTRAINT Vitals_rounds_FK FOREIGN KEY (Vitals_rounds_ID) REFERENCES Vitals_rounds (Vitals_rounds_ID);

ALTER TABLE Vitals_rounds DROP FOREIGN KEY Med_dispense_VR_FK;

ALTER TABLE Vitals_rounds
DROP COLUMN Med_dispense_ID;


