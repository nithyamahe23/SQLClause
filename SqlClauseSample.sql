CREATE DATABASE HealthcareSystemDB;
USE HealthcareSystemDB;

CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    PhoneNumber VARCHAR(20),
    Email VARCHAR(150) NOT NULL UNIQUE,
    City VARCHAR(100),
    Country VARCHAR(100)
);

CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Specialization VARCHAR(150) NOT NULL,
    PhoneNumber VARCHAR(20),
    Email VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATETIME NOT NULL,
    Reason TEXT,
    Status ENUM('Scheduled', 'Completed', 'Canceled') NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Prescriptions (
    PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT,
    MedicineName VARCHAR(150) NOT NULL,
    Dosage VARCHAR(50) NOT NULL,
    Duration VARCHAR(50) NOT NULL,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE MedicalRecords (
    RecordID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    Diagnosis TEXT,
    Treatment TEXT,
    RecordDate DATETIME NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(150) NOT NULL UNIQUE,
    HeadDoctorID INT,
    FOREIGN KEY (HeadDoctorID) REFERENCES Doctors(DoctorID) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Billing (
    BillID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    AppointmentID INT,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    PaidAmount DECIMAL(10, 2) NOT NULL,
    BalanceAmount DECIMAL(10, 2) NOT NULL,
    PaymentStatus ENUM('Paid', 'Unpaid', 'Partial') NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert Expanded Sample Data
INSERT INTO Patients (FirstName, LastName, DateOfBirth, Gender, PhoneNumber, Email, City, Country) VALUES
('John', 'Doe', '1980-01-15', 'Male', '123-456-7890', 'john.doe@example.com', 'New York', 'USA'),
('Jane', 'Smith', '1985-05-20', 'Female', '123-555-7890', 'jane.smith@example.com', 'Los Angeles', 'USA'),
('Alice', 'Johnson', '1990-03-25', 'Female', '555-123-7890', 'alice.j@example.com', 'Chicago', 'USA'),
('Bob', 'Brown', '1975-11-30', 'Male', '555-987-6543', 'bob.b@example.com', 'Miami', 'USA'),
('Eve', 'Davis', '1988-07-15', 'Female', '555-654-3210', 'eve.d@example.com', 'Houston', 'USA'),
('Charlie', 'Miller', '1992-09-05', 'Male', '555-321-6548', 'charlie.m@example.com', 'Seattle', 'USA'),
('David', 'Wilson', '1982-04-20', 'Male', '555-789-4561', 'david.w@example.com', 'San Francisco', 'USA'),
('Fiona', 'Taylor', '1987-12-10', 'Female', '555-456-7893', 'fiona.t@example.com', 'Denver', 'USA'),
('Grace', 'Martinez', '1995-02-17', 'Female', '555-123-9876', 'grace.m@example.com', 'Austin', 'USA');

INSERT INTO Doctors (FirstName, LastName, Specialization, PhoneNumber, Email) VALUES
('Gregory', 'House', 'Diagnostic Medicine', '555-678-1234', 'house.g@example.com'),
('Meredith', 'Grey', 'General Surgery', '555-987-6543', 'grey.m@example.com'),
('John', 'Watson', 'Internal Medicine', '555-321-7654', 'watson.j@example.com'),
('Amelia', 'Shepherd', 'Neurosurgery', '555-987-3214', 'shepherd.a@example.com'),
('Derek', 'Shepherd', 'Cardiology', '555-654-9874', 'shepherd.d@example.com'),
('Miranda', 'Bailey', 'Pediatrics', '555-123-6548', 'bailey.m@example.com');

INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Reason, Status) VALUES
(1, 1, '2023-07-01 10:00:00', 'Routine Checkup', 'Completed'),
(2, 2, '2023-07-02 14:00:00', 'Surgery Consultation', 'Scheduled'),
(3, 3, '2023-07-03 16:00:00', 'Follow-up Visit', 'Completed'),
(4, 4, '2023-07-04 09:00:00', 'Neurosurgery Consultation', 'Scheduled'),
(5, 5, '2023-07-05 11:00:00', 'Cardiology Consultation', 'Completed'),
(6, 6, '2023-07-06 08:00:00', 'Pediatric Checkup', 'Completed'),
(7, 1, '2023-07-07 10:00:00', 'Routine Checkup', 'Scheduled'),
(8, 2, '2023-07-08 12:00:00', 'Surgery Follow-up', 'Completed'),
(9, 3, '2023-07-09 15:00:00', 'Internal Medicine Consultation', 'Canceled');

INSERT INTO Prescriptions (AppointmentID, MedicineName, Dosage, Duration) VALUES
(1, 'Ibuprofen', '200mg', '7 days'),
(3, 'Paracetamol', '500mg', '5 days'),
(5, 'Aspirin', '100mg', '10 days'),
(6, 'Amoxicillin', '250mg', '7 days'),
(8, 'Ciprofloxacin', '500mg', '5 days'),
(9, 'Metformin', '500mg', '30 days');

INSERT INTO MedicalRecords (PatientID, DoctorID, Diagnosis, Treatment, RecordDate) VALUES
(1, 1, 'Hypertension', 'Lifestyle modification', '2023-07-01 10:30:00'),
(3, 3, 'Common Cold', 'Rest and hydration', '2023-07-03 16:30:00'),
(5, 5, 'Heart Disease', 'Medication and lifestyle changes', '2023-07-05 11:30:00'),
(6, 6, 'Asthma', 'Inhaler and medication', '2023-07-06 08:30:00'),
(7, 1, 'Diabetes', 'Insulin and diet management', '2023-07-07 10:30:00'),
(9, 3, 'Thyroid Disorder', 'Medication', '2023-07-09 15:30:00');

INSERT INTO Departments (DepartmentName, HeadDoctorID) VALUES
('Cardiology', 5),
('Surgery', 2),
('Internal Medicine', 3),
('Neurosurgery', 4),
('Pediatrics', 6),
('Diagnostic Medicine', 1);

INSERT INTO Billing (PatientID, AppointmentID, TotalAmount, PaidAmount, BalanceAmount, PaymentStatus) VALUES
(1, 1, 200.00, 200.00, 0.00, 'Paid'),
(2, 2, 1500.00, 500.00, 1000.00, 'Partial'),
(3, 3, 100.00, 100.00, 0.00, 'Paid'),
(4, 4, 3000.00, 0.00, 3000.00, 'Unpaid'),
(5, 5, 500.00, 500.00, 0.00, 'Paid'),
(6, 6, 250.00, 250.00, 0.00, 'Paid'),
(7, 7, 200.00, 100.00, 100.00, 'Partial'),
(8, 8, 1500.00, 1500.00, 0.00, 'Paid'),
(9, 9, 100.00, 0.00, 100.00, 'Unpaid');

/* Ticket 2*/
/*list all female patients*/
select * from patients where gender = 'female';

/* Appointment scheduled but not completed*/ 
select * from appointments;
select * from appointments where status in('scheduled', 'canceled');
select * from appointments where not status = 'completed';

/* doctors in Internal Medicine */
select * from doctors;
select * from doctors where specialization = 'internal medicine';

/*dob > jan1 1985*/
select * from patients;
select * from patients where dateofbirth > '1985-01-01';

/*diagnosis includes cold*/
select * from medicalrecords;
select * from medicalrecords where diagnosis like '%cold%';

/* Ticket 3 */
/* sort by last name in ascending order*/
select * from patients order by lastname;

/* doctors - sorted by specialization in desc order*/
select * from doctors order by specialization desc;

/* appointments - sorted by AppointmentDate in descending order */
select * from appointments order by appointmentdate desc; 

/*departments sorted by DepartmentName in ascending order.*/
select * from departments order by departmentname;

/* Retrieve all bills sorted by BalanceAmount in descending order */
select * from billing order by balanceamount desc;

/*Ticket 4 */
/* Count the number of patients per country.*/
select * from patients;
select country, count(*) as count from patients
 group by country;
 
 /* Find the total number of appointments per doctor*/
 select * from appointments;
 select doctorId, count(*) as appointmentCount 
 from appointments
 group by doctorId;
 
 /*Retrieve the total amount billed per patient*/
 select * from billing;
 
 select patientId, sum(totalamount) as totalbillamount
 from billing
 group by patientid;
 
 /*Get the number of appointments each doctor has scheduled,
 but only show doctors with more than 1 scheduled appointment.*/
 
 select doctorId, count(*) as total
 from appointments
 group by doctorId
 having total > 1;
 
 /* Ticket 5 - Like Operator */
 /* Find all patients whose first name starts with "J"*/
 select * from patients 
 where firstName like 'J%';
 
 /*Retrieve all doctors whose last name contains "son".*/
 select * from doctors;
 select * from doctors
 where lastName like '%son%';
 
 /*List all departments whose name ends with "y"*/
 select * from departments 
 where departmentName like '%y';
 
 /* Find all medical records where the diagnosis contains "Hypertension" */
 select * from medicalrecords;
 
 select * from medicalRecords 
 where diagnosis like '%hypertension%';
 
 /*Retrieve all patients whose email domain is "example.com"*/
 select * from patients 
 where email like '%example.com';
 
 /* Ticket 6 - Between operator*/
 /*List all appointments scheduled between '2023-07-01' and '2023-07-03'.*/
 select * from appointments;
 select * from appointments 
 where appointmentDate between '2023-07-01' and '2023-07-03';
 
 /* Find all patients born between '1980-01-01' and '1990-12-31'*/
 select * from patients;
 select * from patients 
 where dateOfBirth between '1980-01-01' and '1990-12-31';
 
 /*Retrieve all bills with a TotalAmount between $100 and $500*/
 select * from billing;
 select * from billing
 where totalAmount between 100 and 500;
 
 /* Get all appointments scheduled within the next 7 days (assume today is '2023-07-01') */
 select * from appointments;
 select * from appointments 
 where appointmentDate between '2023-07-01' and '2023-07-08';
 
 /* Ticket 7 - Limit Operator */
 /* Retrieve the first 5 patients sorted by LastName */
 select * from patients
 order by LastName
 limit 5;
 
 /* Get the top 3 most expensive bills */
 select * from billing
 order by totalAmount desc
 limit 3;
 
 /* List the first 10 appointments scheduled*/
 select * from appointments;
 
 select * from appointments
 order by appointmentDate
 limit 10;
 
 /* Retrieve the first 5 doctors sorted by FirstName */
 select * from doctors;
 select * from doctors
 order by firstName
 limit 5;
 
 /* Find the top 5 patients with the highest balance amount. */
 select * from billing;
 select * from billing
 order by balanceAmount desc
 limit 5;
 
 /* Ticket 8 - Chaining SQL Clauses */
 /* 1. Retrieve the first 3 patients sorted by LastName who are female and live in the USA */
 select * from patients
 where gender = 'female' and country = 'USA'
 order by lastName
 limit 3;
 
 /* 2. Find the total number of appointments per doctor, 
 but only show doctors who have scheduled more than 2 appointments. 
 Sort the results by the total number of appointments in descending order.*/
 
 select * from appointments;
 
 select doctorId, count(*) as total
 from appointments
 group by doctorId
 having total > 2
 order by total desc;
 
 /* 3. List all patients whose last name starts with "S", who were born after 1985, 
 and sort them by DateOfBirth in ascending order.*/
 select * from patients;
 select * from patients
 where lastName like 's%' and year(dateOfBirth) > 1985
 order by dateOfBirth;
 
  select * from patients
 where lastName like 's%' and dateOfBirth > '1986-01-01'
 order by dateOfBirth;
 
 /* Retrieve the total amount billed per patient for those whose total billed amount is between $200 and $1500. 
 Only show patients who have made more than 2 appointments. */
 select * from billing;
 select patientId, sum(totalAmount) as totalAmount, count(*) as total
 from billing
 group by patientId
 having total > 2 and totalAmount between 200 and 1500 ;
 
 INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Reason, Status) VALUES
(1, 1, '2023-07-08 10:00:00', 'Routine Checkup', 'Scheduled'),
(2, 2, '2023-07-12 14:00:00', 'Surgery Consultation', 'Scheduled');

select * from appointments;
 
 INSERT INTO Billing (PatientID, AppointmentID, TotalAmount, PaidAmount, BalanceAmount, PaymentStatus) VALUES
(1, 10, 500.00, 200.00, 0.00, 'Paid'),
(2, 11, 1000.00, 500.00, 1000.00, 'Partial'),
(1, 12, 100.00, 100.00, 0.00, 'Paid'),
(2, 13, 2000.00, 0.00, 3000.00, 'Unpaid');
 
 select * from billing;
