USE schooldb;
CREATE TABLE teacher(
teacherId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
teacherName VARCHAR (200) NOT NULL
);
ALTER TABLE teacher
AUTO_INCREMENT = 101;
INSERT INTO teacher(teacherName) VALUES 
("Sarah Chebet"),
("Robert Kinyua"),
("John Mutua"),
("Mercy Adhiambo"),
("Ali Yusuf"),
("Wanjiku Njoroge"),
("David Omondi"),
("Fatuma Hassan"),
("Kamau Mwangi"),
("Akinyi Otieno");

--Table for teacher registration
CREATE TABLE teacherReg(
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
tscNo INT(30) NOT NULL UNIQUE,
teacherName VARCHAR(200) NOT NULL
);
ALTER TABLE teacherreg
AUTO_INCREMENT=1;

INSERT INTO teacherreg(tscNo,teacherId) VALUES 
(7123456,101),
(6789012,102),
(0901234,103),
(4567890,104),
(4234567,105),
(1890123,106),
(8456788,107),
(9012345,108),
(0678901,109),
(5679569,110);

--Table existing classes
CREATE TABLE Classes (
ClassID INT AUTO_INCREMENT PRIMARY KEY,
ClassName VARCHAR(255) NOT NULL UNIQUE  
);
ALTER TABLE classes
AUTO_INCREMENT = 1;
INSERT INTO Classes (ClassName) VALUES
('Class 1'), ('Class 2'), ('Class 3'),
('Form 1'), ('Form 2'), ('Form 3');

CREATE TABLE  Streams (
    StreamID INT AUTO_INCREMENT PRIMARY KEY,
    StreamName VARCHAR(255) NOT NULL UNIQUE
);
INSERT INTO Streams (StreamName) VALUES
('Stream A'), ('Stream B'), ('Stream C'), 
('Red'), ('Blue'), ('Green');

CREATE TABLE Students (
    StudentAdm INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    DateOfBirth DATE,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    ClassID INT, -- Foreign key referencing the Classes table
    StreamID INT, -- Foreign key referencing the Streams table
    AdmissionDate DATE NOT NULL,
    -- Add a unique constraint to ensure no duplicate student entries based on first and last names
    UNIQUE (FirstName, LastName),
    -- Foreign key constraints to link Students to Classes and Streams tables
    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID),
    FOREIGN KEY (StreamID) REFERENCES Streams(StreamID)
);
ALTER TABLE students
AUTO_INCREMENT = 101;
INSERT INTO Students (FirstName, LastName, DateOfBirth, Gender, ClassID, StreamID, AdmissionDate) VALUES
    ('Alice', 'Smith', '2010-01-15', 'Female', 1, 1, '2020-09-01'),
    ('Bob', 'Johnson', '2009-05-20', 'Male', 1, 2, '2020-09-01'),
    ('Charlie', 'Brown', '2011-02-10', 'Male', 2, 1, '2021-09-01'),
    ('Diana', 'Miller', '2010-10-05', 'Female', 2, 3, '2021-09-01'),
    ('Ethan', 'Davis', '2008-07-22', 'Male', 3, 2, '2022-09-01'),
    ('Fiona', 'Wilson', '2009-03-18', 'Female', 3, 1, '2022-09-01'),
    ('George', 'Oloo', '2007-06-02', 'Male', 4, 4, '2023-01-15'),
    ('Halima', 'Abdi', '2006-09-28', 'Female', 4, 5, '2023-01-15'),
    ('Isaac', 'Kipchoge', '2005-12-11', 'Male', 5, 4, '2023-05-20'),
    ('Jane', 'Wanjiku', '2006-04-08', 'Female', 5, 6, '2023-05-20'),
    ('Kevin', 'Mutua', '2004-08-05', 'Male', 6, 5, '2024-01-10'),
    ('Lilian', 'Nekesa', '2005-01-20', 'Female', 6, 6, '2024-01-10');

CREATE TABLE Subjects (
    SubjectID INT AUTO_INCREMENT PRIMARY KEY,
    SubjectName VARCHAR(255) NOT NULL UNIQUE
);
ALTER TABLE subjects
AUTO_INCREMENT=1;
INSERT INTO Subjects (SubjectName) VALUES
    ('Mathematics'), ('English'), ('Science'),
    ('History'), ('Geography'), ('Physics'), 
    ('Chemistry'), ('Biology');

CREATE TABLE ClassSubjects (
    ClassID INT,
    SubjectID INT,
    PRIMARY KEY (ClassID, SubjectID), -- Composite primary key
    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID),
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);
INSERT INTO ClassSubjects (ClassID, SubjectID) VALUES
    (1, 1),
    (1, 2), 
    (1, 3),  
    (2, 1),
    (2, 2),
    (2, 4),  
    (3, 1),
    (3, 3),
    (3, 5),  
    (4, 1),
    (4, 2),
    (4, 6), 
    (5, 1),
    (5, 2), 
    (5, 7),  
    (6, 1),
    (6, 2),
    (6, 8); 

CREATE TABLE TeacherSubjects (
teacherId INT,
SubjectID INT,
PRIMARY KEY (teacherId, SubjectId),
FOREIGN KEY (teacherId) REFERENCES teacher(teacherId),
FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);
INSERT INTO TeacherSubjects (teacherId, SubjectID) VALUES
    (101, 1), (101, 3),  -- Mr. Mwangi teaches Math and Science
    (102, 2), (102, 4),  -- Mrs. Wambui teaches English and History
    (103, 1), (103, 5),  -- Mr. Ochieng teaches Math and Geography
    (104, 6), (104, 7), -- Ms. Kamau teaches Physics and Chemistry
    (105, 1), (105, 8), -- Mr. Barasa teaches Math and Biology
    (106, 2),    
    (107,6),(107,5),
    (108,3),
    (109,7),
    (110,8),(110,7);

CREATE TABLE StudentResults (
    ResultID INT AUTO_INCREMENT PRIMARY KEY,
    StudentAdm INT,
    SubjectID INT,
    Mark INT,
    Grade VARCHAR(2),  -- e.g., A, B, C, etc.
    ExamDate DATE,
    FOREIGN KEY (StudentAdm) REFERENCES students(StudentAdm),
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);

INSERT INTO StudentResults (StudentAdm, SubjectID, Mark, Grade, ExamDate) VALUES
    (101, 1, 75, 'B+', '2024-03-15'),
    (101, 2, 68, 'C+', '2024-03-15'),
    (102, 3, 82, 'A-', '2024-03-15'),
    (102, 1, 60, 'C', '2024-03-15'),
    (102, 2, 70, 'B-', '2024-03-15'),
    (104, 3, 78, 'B', '2024-03-15'),
    (104, 1, 85, 'A', '2024-03-15'),
    (104, 2, 72, 'B', '2024-03-15'),
    (105, 4, 65, 'C+', '2024-03-15'),
    (106, 1, 58, 'C-', '2024-03-15'),
    (106, 5, 79, 'B+', '2024-03-15'),
    (107, 1, 65, 'C+', '2024-03-15'),
    (107, 2, 58, 'C-', '2024-03-15'),
    (107, 6, 70, 'B-', '2024-03-15'),
    (108, 1, 78, 'B', '2024-03-15'),
    (108, 2, 82, 'A-', '2024-03-15'),
    (108, 6, 68, 'C+', '2024-03-15'),
    (109, 1, 90, 'A+', '2024-03-15'),
    (109, 2, 85, 'A', '2024-03-15'),
    (109, 7, 75, 'B+', '2024-03-15'),
    (110, 1, 70, 'B-', '2024-03-15');
    