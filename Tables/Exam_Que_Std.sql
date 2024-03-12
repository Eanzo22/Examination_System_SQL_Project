create table Exam_Que_Std(

std_Answer varchar (100) not null,
Que_Id int not null,
Ex_Id int not null,
Std_Id int not null,
primary key (Que_Id,Ex_Id,Std_Id)


)