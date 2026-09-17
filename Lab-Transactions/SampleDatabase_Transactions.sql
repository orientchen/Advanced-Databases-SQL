DROP TABLE IF EXISTS students;
create table students (
    ID          integer not null AUTO_INCREMENT,
    lastName    varchar(50) not null,
    firstName   varchar(50) not null,
    major       varchar(30) not null,
    year_study  varchar(20) not null,
    GPA         float       not null,
    constraint  GPA_check check (GPA between 0 and 4.0),
    constraint  year_check check (year_study in 
                ('freshman', 'sophomore', 'junior', 'senior')),
    index	students_last_name	(lastName),
    index	students_first_name	(firstName),
    constraint  students_pk primary key (ID));

insert into students    (lastName, firstName, major, year_study, GPA)
values                  ('Einstein', 'Albert', 'physics', 'senior', 4.0),
                        ('Washington', 'George', 'animal husbandry', 'junior', 3.95),
                        ('Washington', 'Denzel', 'theatre arts', 'sophomore', 2.5),
                        ('the Frog', 'Kermit', 'theatre arts', 'freshman', 3.2);
