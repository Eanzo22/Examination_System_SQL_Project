use Examination_System
CREATE TABLE Instructor
(
  Ins_Id INT NOT NULL,
  Ins_Name VARCHAR(40) NOT NULL,
  Ins_Degree INT NOT NULL,
  Ins_Salary INT NOT NULL,
  PRIMARY KEY (Ins_Id)
);

CREATE TABLE Exam
(
  Ex_Duration DATE NOT NULL,
  Ex_Id INT NOT NULL,
  PRIMARY KEY (Ex_Id)
);

CREATE TABLE Topic
(
  Topic_Id INT NOT NULL,
  Topic_name VARCHAR(30) NOT NULL,
  PRIMARY KEY (Topic_Id)
);

CREATE TABLE Department
(
  Manager_HireDate DATE NOT NULL,
  Dept_Desc VARCHAR(50) NOT NULL,
  Dept_Name VARCHAR(30) NOT NULL,
  Dept_id INT NOT NULL,
  Manager_Id INT NOT NULL,
  PRIMARY KEY (Dept_id),
  FOREIGN KEY (Manager_Id) REFERENCES Instructor(Ins_Id)
);

CREATE TABLE Course
(
  
  Crs_Name VARCHAR(50) NOT NULL,
  Crs_Id INT NOT NULL,
  Topic_Id INT NOT NULL,
  PRIMARY KEY (Crs_Id),
  FOREIGN KEY (Topic_Id) REFERENCES Topic(Topic_Id)
);

CREATE TABLE Student
(
  Std_Name VARCHAR(50) NOT NULL,
  Std_Id INT NOT NULL,
  Std_Address VARCHAR(50) NOT NULL,
  Std_Age INT NOT NULL,
  Dept_id INT NOT NULL,
  PRIMARY KEY (Std_Id),
  FOREIGN KEY (Dept_id) REFERENCES Department(Dept_id)
);

CREATE TABLE Question
(
  Correct_Ans VARCHAR(100) NOT NULL,
  Que_Grade INT NOT NULL,
  Que_Type VARCHAR(50) NOT NULL,
  Que_Id INT NOT NULL,
  Crs_Id INT NOT NULL,
  PRIMARY KEY (Que_Id),
  FOREIGN KEY (Crs_Id) REFERENCES Course(Crs_Id)
);

CREATE TABLE Exam_Que_Std
(
  std_Answer VARCHAR(100) NOT NULL,
  Que_Id INT NOT NULL,
  Ex_Id INT NOT NULL,
  Std_Id INT NOT NULL,
  PRIMARY KEY (Que_Id, Ex_Id, Std_Id),
  FOREIGN KEY (Que_Id) REFERENCES Question(Que_Id),
  FOREIGN KEY (Ex_Id) REFERENCES Exam(Ex_Id),
  FOREIGN KEY (Std_Id) REFERENCES Student(Std_Id)
);

CREATE TABLE crs_std
(
  Crs_Id INT NOT NULL,
  Std_Id INT NOT NULL,
  PRIMARY KEY (Crs_Id, Std_Id),
  FOREIGN KEY (Crs_Id) REFERENCES Course(Crs_Id),
  FOREIGN KEY (Std_Id) REFERENCES Student(Std_Id)
);

CREATE TABLE crs_ins
(
  Crs_Id INT NOT NULL,
  Ins_Id INT NOT NULL,
  PRIMARY KEY (Crs_Id, Ins_Id),
  FOREIGN KEY (Crs_Id) REFERENCES Course(Crs_Id),
  FOREIGN KEY (Ins_Id) REFERENCES Instructor(Ins_Id)
);

CREATE TABLE Works_on
(
  Ins_Id INT NOT NULL,
  Dept_id INT NOT NULL,
  PRIMARY KEY (Ins_Id, Dept_id),
  FOREIGN KEY (Ins_Id) REFERENCES Instructor(Ins_Id),
  FOREIGN KEY (Dept_id) REFERENCES Department(Dept_id)
);

CREATE TABLE Question_Choices
(
  Que_Choices INT NOT NULL,
  Que_Id INT NOT NULL,
  PRIMARY KEY (Que_Choices, Que_Id),
  FOREIGN KEY (Que_Id) REFERENCES Question(Que_Id)
);