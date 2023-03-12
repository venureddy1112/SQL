--Table 1 Query:
Create Table EmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)

--Table 2 Query:
Create Table EmployeeSalary 
(EmployeeID int, 
JobTitle varchar(50), 
Salary int
)

--Table 1 Insert:
Insert into EmployeeDemographics VALUES
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')

--Table 2 Insert:
Insert Into EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)

--Select
select * from EmployeeDemographics;
select * from EmployeeSalary;

select top 5* from EmployeeDemographics;
select FirstName,LastName from EmployeeDemographics;
select distinct(Gender) from EmployeeDemographics;
select COUNT(LastName) from EmployeeDemographics;
--allocating column name
select COUNT(LastName) as LastNameCount from EmployeeDemographics;
select MIN(Salary) from EmployeeSalary;
select Max(Salary) from EmployeeSalary;
select avg(Salary) from EmployeeSalary;

--Where
select * from EmployeeDemographics where FirstName='jim';
select * from EmployeeDemographics where FirstName<>'jim';
select * from EmployeeDemographics where Age<30;
select * from EmployeeDemographics where Gender='male' and  Age>30;
select * from EmployeeDemographics where Gender='male' or  Age>33;
select * from EmployeeDemographics where FirstName like 'j%';
select * from EmployeeDemographics where FirstName like '%t';
select * from EmployeeDemographics where Age is null;
select * from EmployeeDemographics where Age is not null;
select * from EmployeeDemographics where Gender in ('Female');

--Group by
select Gender from EmployeeDemographics group by Gender;
select Gender, COUNT(gender) from EmployeeDemographics group by Gender;
select Gender, Age, COUNT(gender) from EmployeeDemographics group by Gender, Age;
select Gender, COUNT(gender) from EmployeeDemographics where Age<31 group by Gender;
--Order by (Default ascending order)
select * from EmployeeDemographics order by Age;
select * from EmployeeDemographics order by Age, Gender DESC;
select Gender, COUNT(Gender) as GenderCount from EmployeeDemographics where Age<31 group by Gender order by GenderCount;

