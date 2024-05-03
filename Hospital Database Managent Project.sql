--CREATE DATABASE
CREATE DATABASE HospitalDB;

----use database----
USE  HospitalDB; 
GO

-- Address Table
CREATE TABLE Address (
    AddressID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Address1 NVARCHAR(50) NOT NULL,
    Address2 NVARCHAR(50),
    City NVARCHAR(50),
    PostCode VARCHAR(20) NOT NULL
    CONSTRAINT UC_Address UNIQUE (Address1, PostCode)
);
----patients table
CREATE TABLE Patients (
    PatientID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Gender NVARCHAR(10) NOT NULL,
    DateOfBirth DATE NOT NULL,
    AddressID INT NOT NULL,
    Email NVARCHAR(100) CHECK (Email LIKE '%_@_%._%'),
    PhoneNumber NVARCHAR(15),
    Username NVARCHAR(50) UNIQUE NOT NULL,
    HashedPassword NVARCHAR(50) NOT NULL,
    Salt UNIQUEIDENTIFIER,
    RegistrationDate DATE DEFAULT GETDATE(),
    LeaveDate DATE,
    FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);  

SELECT * FROM PATIENTS


----insurance Table----

CREATE TABLE Insurance (
    InsuranceID INT IDENTITY(1,1) PRIMARY KEY,
    InsuranceName NVARCHAR(100) NOT NULL,
    PolicyNumber NVARCHAR(50),
    ExpirationDate DATE,
    AddressID INT NOT NULL,
    PatientID INT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);


-- Departments Table
CREATE TABLE Departments (
    DepartmentID INT IDENTITY(1001,1) PRIMARY KEY,
    DepartmentName NVARCHAR(100) NOT NULL
);

-- Doctors Table with Availability
CREATE TABLE Doctors (
    DoctorID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Gender NVARCHAR(10) NOT NULL,
    Specialization NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) check (Email LIKE '%_@_%._%'),
    PhoneNumber NVARCHAR(15),
	DepartmentID INT NOT NULL,
    Availability NVARCHAR(50), 
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Appointments Table
CREATE TABLE Appointments (
    AppointmentID INT IDENTITY(0101,1) PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATE,
    AppointmentTime TIME,
	PatientsReviews NVARCHAR(MAX),
    Status NVARCHAR(20) NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

SELECT * FROM APPOINTMENTS
------PastAppointments----
CREATE TABLE PastAppointments (
    PastAppointmentID INT IDENTITY (1,1)PRIMARY KEY,
	AppointmentID INT NOT NULL,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATE,
    AppointmentTime TIME,
    PatientsReviews NVARCHAR(MAX),
    Status NVARCHAR(20),
);

SELECT * FROM PastAppointments



-----Medical Records-----------
CREATE TABLE MedicalRecords (
    RecordID INT IDENTITY(1,1) PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
	PastAppointmentID INT,
    AppointmentID INT NOT NULL,
	Diagnose NVARCHAR(100) NOT NULL ,
	Allergy NVARCHAR(MAX),
    RecordDate DATE NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
	FOREIGN KEY (PastappointmentID) REFERENCES Pastappointments(PastappointmentID)
);


-------Prescription Table--------
CREATE TABLE Prescriptions (
    PrescriptionID INT IDENTITY(1,1) PRIMARY KEY,
    RecordID INT NOT NULL,
    Medicine NVARCHAR(MAX),
    MedicinePrescribedDate DATE,
    Dosage NVARCHAR(50),
    FOREIGN KEY (RecordID) REFERENCES MedicalRecords(RecordID)
);




-----insert into Address---------
INSERT INTO Address (Address1, City, PostCode)
VALUES
    ('15 Parsonage Street', 'Bury', 'BL9 6PH'),
    ('10 Downing Street', 'London', 'SW1A 2AA'),
    ('1 Canada Square (One Canada Square)', 'London', 'E14 5AB'),
    ('Trafalgar Square', 'London', 'WC2N 5DN'),
    ('The Shard', 'London', 'SE1 9SG'),
    ('20 Fenchurch Street (The Walkie Talkie)', 'London', 'EC3M 3BY'),
    ('221B Baker Street', 'London', 'NW1 6XE'),
    ('Tower Bridge Road', 'London', 'SE1 2UP');	

SELECT * FROM Address





-----insert into Patients------

INSERT INTO Patients (FirstName, LastName, Gender, DateOfBirth, AddressID, Email, PhoneNumber, Username, HashedPassword, Salt, RegistrationDate, LeaveDate)
VALUES
    ('Fidelis', 'Joel', 'Male', '1982-03-15', 1, 'Fidelis.Joel@gmail.com', '07234567890', 'Fidelis_Joel', HASHBYTES('SHA1', 'MEntee123&&'), NEWID(), GETDATE(), NULL),
    ('Jane', 'Smith', 'Female', '1984-05-20', 2, 'jane.smith@gmail.com', '07876543210', 'jane_smith', HASHBYTES('SHA1', 'weRUNtheWORLD989@'), NEWID(), GETDATE(), NULL),
    ('Alice', 'Johnson', 'Female', '1983-09-30', 3, 'alice.johnson@gmail.com', '0755555555', 'alice_johnson', HASHBYTES('SHA1', 'MAGicjohnsonnn232@*'), NEWID(), GETDATE(), NULL),
    ('Bob', 'Brown', 'Male', '1972-03-20', 4, 'bob.brown@gmail.com', '07777777777', 'bob_brown', HASHBYTES('SHA1', 'qwertyuIOP098!@#'), NEWID(), GETDATE(), NULL),
    ('Emily', 'Davis', 'Female', '1988-07-10', 5, 'emily.davis@gmail.com', '07999999999', 'emily_davis', HASHBYTES('SHA1', 'writtenINtheClo34!&*'), NEWID(), GETDATE(), NULL),
    ('Michael', 'Adeniran', 'Male', '1994-11-25', 6, 'michael.Adeniran@gmail.com', '07111111111', 'michael_Adeniran', HASHBYTES('SHA1', 'weDRINKTOthat5^$#!@*'), NEWID(), GETDATE(), NULL),
    ('Jessica', 'Martinez', 'Female', '2018-06-05', 7, NULL, NULL, 'jessica_martinez', HASHBYTES('SHA1', 'bOUrne3455^*99'), NEWID(), GETDATE(), NULL),
    ('David', 'Taylor', 'Male', '2018-02-12', 8, NULL, NULL, 'david_taylor', HASHBYTES('SHA1', 'PURSUITOFhappyness23'), NEWID(), GETDATE(), NULL);

SELECT * FROM PATIENTS

	INSERT INTO Insurance (InsuranceName, PolicyNumber, ExpirationDate, AddressID, PatientID)
VALUES
('Alpha Insurance', 'POL001', '2025-01-01', 1, 1),
('Epsilon Protection', 'POL002', '2024-12-31', 2, 2),
('Iota Assurance','POL003', '2024-11-30', 3, 3),
('Delta Coverage','POL004','2024-10-15', 4, 4),
('Lambda Coverage', 'POL005', '2024-09-20', 5, 5),
('Epsilon Protection','POL006', '2024-08-25', 6, 6),
('Omicron Protection', 'POL007', '2024-07-30', 7, 7),
('Upsilon Protection', 'POL008', '2024-06-05', 8, 8)

SELECT * FROM Insurance

-- Insert data into Departments table
	INSERT INTO Departments (DepartmentName)
	VALUES
	     ('Gastroenterology'),
		('Cardiology'),
		('Oncology'),
		('Neurology'),
		('Pediatrics'),
		('Dermatology'),
		('Orthopedics'),
		('Ophthalmology');

SELECT * FROM Departments


-------insert data into doctors----
INSERT INTO Doctors (FirstName, LastName, Gender, Specialization, PhoneNumber, Email, DepartmentID, Availability)
VALUES
    ('Mark', 'Johnson', 'M', 'Gastroenterologist', '07131231234', 'mark.johnson@yahoo.com', 1001, 'Available'),
    ('Emily', 'Wilson', 'F', 'Cardiologist', '07342342345', 'emily.wilson@gmail.com', 1002, 'Available'),
    ('Michael', 'Brown', 'M', 'Oncologist', '07453453456', 'michael.brown@gmail.com', 1003, 'Available'),
    ('Sarah', 'Davis', 'F', 'Neurologist', '07564564567', 'sarah.davis@gmail.com', 1004, 'Available'),
    ('James', 'Martinez', 'M', 'Pediatrician', '07675675678', 'james.martinez@gmail.com',1005, 'Available'),
    ('Jessica', 'Garcia', 'F', 'Dermatologist', '07786786789', 'jessica.garcia@gmail.com', 1006, 'Available'),
    ('David', 'Taylor', 'M', 'Orthopedic Surgeon', '07897897890', 'david.taylor@yahoo.com',1007, 'Available'),
    ('Laura', 'Anderson', 'F', 'Ophthalmologist', '07908908901', 'laura.anderson@gmail.com',1008, 'Available');
SELECT * FROM Doctors


------- insert data into Appointment
INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate,  AppointmentTime,PatientsReviews, Status)
VALUES 
(1, 1, '2024-04-23', '09:00:00', 'Great appointment!','Completed'),
(2, 2, '2024-04-23', '10:30:00','Satisfactory', 'Completed'),
(3, 3, '2024-04-24', '14:00:00', NULL,'Pending'),
(4, 4, '2024-04-24', '11:15:00', NULL,'Cancelled'),
(5, 5, '2024-04-24', '12:00:00',NULL, 'Pending'),
(6, 6, '2024-04-25', '13:30:00',NULL, 'Cancelled'),
(7, 7, '2024-04-26', '15:45:00',NULL, 'Pending'),
(8, 8, '2024-04-27', '16:00:00', NULL,'Pending');

SELECT * FROM Appointments



-- Inserting past appointments data along with patient reviews into the PastAppointments table
INSERT INTO PastAppointments (AppointmentID, PatientID, DoctorID, AppointmentDate, AppointmentTime, PatientsReviews, Status)
VALUES 
    (101, 1, 1, '2024-04-01', '09:00:00', 'Great service and very helpful staff.', 'Completed'), 
    (102, 2, 2, '2024-04-02', '10:00:00', 'The doctor was knowledgeable and provided clear explanations.', 'Completed'), 
    (103, 3, 3, '2024-04-03', '11:00:00', 'Friendly environment and minimal waiting time.', 'Completed'), 
    (104, 4, 4, '2024-04-04', '12:00:00', 'The doctor took the time to address all my concerns.', 'Completed'), 
    (105, 5, 5, '2024-04-05', '13:00:00', 'Professional and efficient service.', 'Completed'), 
    (106, 6, 6, '2024-04-06', '14:00:00', 'Received excellent care from the medical team.', 'Completed'), 
    (107, 7, 7, '2024-04-07', '15:00:00', 'Highly satisfied with the treatment received.', 'Completed'), 
    (108, 8, 8, '2024-04-08', '16:00:00', 'The doctor provided valuable insights into my condition.', 'Completed');

SELECT * FROM PastAppointments




-- Inserting data into the MedicalRecords table
INSERT INTO MedicalRecords (PatientID, DoctorID,PastAppointmentID, AppointmentID, Diagnose, Allergy, RecordDate)
VALUES 
(1, 1,1, 101, 'Stomach Ulcer', 'Penicillin', '2024-04-23'),
(2, 2,2, 102, 'Heart disease', 'Sulfa drugs', '2024-04-23'),
(3, 3,3,103, 'Cancer', 'None', '2024-04-24'),
(4, 4,4, 104, 'Brain Injury', 'None', '2024-04-24'),
(5, 5,5, 105, 'Flu', 'Peanuts', '2024-04-24'),
(6, 6, 6,106, 'Skin Rashes', 'Peanuts', '2024-04-25'),
(7, 7, 7, 107, 'broken bone', 'None', '2024-04-26'),
(8, 8,8,108, 'eye infection', 'oil', '2024-04-27');

SELECT * FROM  MedicalRecords




--- Insert data into Presciptions----
INSERT INTO Prescriptions (RecordID, Medicine, MedicinePrescribedDate, Dosage)
VALUES
    (1, 'Omeprazole', '2024-04-23', '20mg once daily'),
    (2, 'Statins', '2024-04-23', '10mg once daily'), 
    (3, 'Cyclophosphamide', '2024-04-24', '100mg once weekly'),
    (4, 'Ibuprofen', '2024-04-24', '400mg every 6 hours as needed'),
    (5, 'Antihistamines', '2024-04-24', '10mg once daily'),
    (6, 'Loratadine', '2024-04-25', '10mg once daily'),
    (7, 'Naproxen', '2024-04-26', '220mg twice daily'), 
    (8, 'Eyedrop', '2024-04-27', '1 drop in each eye every 6 hours');

SELECT * FROM Prescriptions


SELECT * FROM Patients

--- 2) Add the constraint to check that the appointment date is not in the past

ALTER TABLE Appointments
ADD CONSTRAINT Check_AppointmentDate 
CHECK (AppointmentDate >= CAST(GETDATE() AS DATE));

INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate,  AppointmentTime, Status)
VALUES
(8, 7, '2024-04-20', '16:00:00', 'Pending');


---3---List all the patients with older than 40 and have Cancer in diagnosis.
SELECT P.PatientID, P.FirstName, P.LastName, P.DateOfBirth
FROM Patients P
JOIN MedicalRecords MR ON P.PatientID = MR.PatientID
WHERE P.DateOfBirth <= DATEADD(YEAR, -40, GETDATE()) 
AND MR.Diagnose = 'Cancer'; 


4)--Search the database of the hospital for matching character strings by name ofmedicine. Results should be sorted with most recent medicine prescribed date first.

CREATE PROCEDURE SearchMedicineByName
    @MedicineName NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT p.FirstName, p.LastName, pr.Medicine, pr.MedicinePrescribedDate
    FROM Patients p
    JOIN MedicalRecords mr ON p.PatientID = mr.PatientID
    JOIN Prescriptions pr ON mr.RecordID = pr.RecordID
    WHERE pr.Medicine LIKE '%ra%'
    ORDER BY pr.MedicinePrescribedDate DESC;
END

EXEC SearchMedicineByName @MedicineName= 'ra';

----4B)Return a full list of diagnosis and allergies for a specific patient who has anappointment today (i.e., the system date when the query is run
-- Create the function
CREATE FUNCTION GetDiagnosisAndAllergiesForPatients (@PatientID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT PatientID,Diagnose, Allergy
    FROM MedicalRecords MR
    WHERE MR.PatientID = @PatientID
    AND EXISTS (
        SELECT 1
        FROM Appointments A
        WHERE A.AppointmentID = MR.AppointmentID
        AND CONVERT(DATE, A.AppointmentDate) = CONVERT(DATE, GETDATE())
    )
);

SELECT * FROM GetDiagnosisAndAllergiesForPatients(1);

-----4c)Update the details for an existing doctor

CREATE PROCEDURE UpdateDoctorDetails
    @DoctorID INT,
    @NewName NVARCHAR(100),
    @NewPhoneNumber NVARCHAR(20)
AS
BEGIN
    -- Update the doctor's details
    UPDATE Doctors
    SET FirstName = @NewName, 
        PhoneNumber = @NewPhoneNumber 
    WHERE DoctorID = @DoctorID; 
END;



EXEC UpdateDoctorDetails @DoctorID = 4, @NewName = 'David', @NewPhoneNumber = '07865432678';

SELECT * FROM DOCTORS 
WHERE DOCTORID = 4;


-----------------------4d) Delete the appointment who status is already completed-----
CREATE PROCEDURE DeleteCompletedAppointments
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Delete related prescriptions
        DELETE FROM Prescriptions
        WHERE RecordID IN (SELECT RecordID FROM MedicalRecords WHERE AppointmentID IN (SELECT AppointmentID FROM Appointments WHERE Status = 'Completed'));

        -- Archive completed appointments 
        INSERT INTO PastAppointments (AppointmentID, PatientID, DoctorID, AppointmentDate, AppointmentTime, PatientsReviews, Status)
        SELECT A.AppointmentID, A.PatientID, A.DoctorID, A.AppointmentDate, A.AppointmentTime, A.PatientsReviews, A.Status
        FROM Appointments A
        WHERE A.Status = 'Completed';

        -- Delete related records from MedicalRecords table
        DELETE FROM MedicalRecords
        WHERE AppointmentID IN (SELECT AppointmentID FROM Appointments WHERE Status = 'Completed');

        -- Delete completed appointments
        DELETE FROM Appointments
        WHERE Status = 'Completed';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback transaction in case of error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
         -- Handle errors
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;

EXEC DeleteCompletedAppointments

SELECT * FROM APPOINTMENTS

SELECT * FROM PastAppointments
---------------------------------------------------------------------

CREATE VIEW AppointmentDetails AS
SELECT 
    A.AppointmentID,
    A.PatientID,
    A.DoctorID,
    CONCAT(A.AppointmentDate, ' ', A.AppointmentTime) AS AppointmentDateTime,
    A.PatientsReviews AS PatientFeedback,
    D.FirstName AS DoctorFirstName,
    D.LastName AS DoctorLastName,
    D.Specialization AS DoctorSpecialization,
    Dep.DepartmentName AS DepartmentName
FROM 
    Appointments A
JOIN 
    Doctors D ON A.DoctorID = D.DoctorID
JOIN 
    Departments Dep ON D.DepartmentID = Dep.DepartmentID

UNION ALL

SELECT 
    PA.AppointmentID,
    PA.PatientID,
    PA.DoctorID,
    CONCAT(PA.AppointmentDate, ' ', PA.AppointmentTime) AS AppointmentDateTime,
    PA.PatientsReviews AS PatientFeedback,
    D.FirstName AS DoctorFirstName,
    D.LastName AS DoctorLastName,
    D.Specialization AS DoctorSpecialization,
    Dep.DepartmentName AS DepartmentName
FROM 
    PastAppointments PA
JOIN 
    Doctors D ON PA.DoctorID = D.DoctorID
JOIN 
    Departments Dep ON D.DepartmentID = Dep.DepartmentID;




SELECT * FROM AppointmentDetails;

--6)Create a trigger so that the current state of an appointment can be changed toavailable when it is cancelled
CREATE TRIGGER UpdateAppointmentStateOnCancellation
ON Appointments
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF (UPDATE(Status))
    BEGIN
        BEGIN TRY
            -- Begin a transaction
            BEGIN TRANSACTION;

            -- Update the status of cancelled appointments to 'Available'
            UPDATE A
            SET A.Status = 'Available'
            FROM Appointments A
            INNER JOIN inserted i ON A.AppointmentID = i.AppointmentID
            WHERE A.Status = 'Cancelled' AND i.Status = 'Cancelled';

            -- Commit the transaction if all operations succeed
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            -- Rollback the transaction if an error occurs
            IF @@TRANCOUNT > 0
                ROLLBACK TRANSACTION;

            -- Handle errors
            DECLARE @ErrorMessage NVARCHAR(MAX) = ERROR_MESSAGE();
            THROW 50000, @ErrorMessage, 1;
        END CATCH;
    END
END;


UPDATE Appointments
SET Status = 'Cancelled'
WHERE AppointmentID = 104;

SELECT * FROM Appointments




SELECT * FROM Appointments

--)-7--Write a select query which allows the hospital to identify the number ofcompleted appointments with the specialty of doctors as Gastroenterologis
SELECT COUNT(*) AS CompletedAppointments
FROM (
    SELECT A.AppointmentID
    FROM Appointments A
    JOIN Doctors D ON A.DoctorID = D.DoctorID
    JOIN Departments Dep ON D.DepartmentID = Dep.DepartmentID
    WHERE A.Status = 'Completed' 
    AND D.Specialization = 'Gastroenterologist'
) AS Subquery;

