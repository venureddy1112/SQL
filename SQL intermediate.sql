
--Table Query:
Create Table EmpSalary 
(EmployeeID int, 
JobTitle varchar(50), 
Salary int
)

--Table Insert:
Insert Into EmpSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000),
(1010, 'Data Analyst', 45000),
(1011, 'B A', 60000),
(1012,'', 55000)

select * from EmployeeDemographics;
select * from EmpSalary;
select * from EmployeeSalary;
--Joins
select * from EmployeeDemographics inner join EmpSalary on EmployeeDemographics.EmployeeID = EmpSalary.EmployeeID
select * from EmployeeDemographics full outer join EmpSalary on EmployeeDemographics.EmployeeID = EmpSalary.EmployeeID
select * from EmployeeDemographics left outer join EmpSalary on EmployeeDemographics.EmployeeID = EmpSalary.EmployeeID
select * from EmployeeDemographics right join EmpSalary on EmployeeDemographics.EmployeeID = EmpSalary.EmployeeID

select EmployeeDemographics.EmployeeID,FirstName,LastName, JobTitle, Salary from EmployeeDemographics inner join EmpSalary
on EmployeeDemographics.EmployeeID = EmpSalary.EmployeeID
select EmployeeDemographics.EmployeeID,FirstName,LastName, JobTitle, Salary from EmployeeDemographics right outer join EmpSalary
on EmployeeDemographics.EmployeeID = EmpSalary.EmployeeID

select EmployeeDemographics.EmployeeID,FirstName,LastName, JobTitle, Salary from EmployeeDemographics inner join EmpSalary
on EmployeeDemographics.EmployeeID = EmpSalary.EmployeeID
where FirstName <> 'Michael'
order by Salary DESC
select JobTitle, avg(Salary) from EmployeeDemographics inner join EmpSalary
on EmployeeDemographics.EmployeeID = EmpSalary.EmployeeID
where JobTitle = 'salesman'
group by JobTitle

-- Case
select FirstName, LastName, Age,
CASE
	when Age > 30 then 'old'
	else 'young'
end
from EmployeeDemographics 
where Age is not null
order by Age

select FirstName, LastName, JobTitle, Salary,
CASE
	when JobTitle='Salesman' then Salary+(Salary*.05)
	when JobTitle='Acountant' then Salary+(Salary*.03)
	else Salary+(Salary*.01) 
end as SalaryRaise
from EmployeeDemographics 
join EmployeeSalary on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

-- Having Clause
select JobTitle, count(JobTitle) from EmployeeDemographics 
join EmployeeSalary on EmployeeDemographics.EmployeeID=EmployeeSalary.EmployeeID
group by JobTitle
having COUNT(JobTitle) > 1

select JobTitle, avg(Salary) from EmployeeDemographics 
join EmployeeSalary on EmployeeDemographics.EmployeeID=EmployeeSalary.EmployeeID
group by JobTitle
having avg(salary) > 45000
order by avg(salary)

-- update and delete
select * from EmpSalary;
update EmpSalary
set JobTitle='Dev'
where EmployeeID=1012

delete from EmpSalary
where JobTitle='Dev'

-- Aliasing
select FirstName as Fname from EmployeeDemographics
select FirstName+' '+LastName as FullName from EmployeeDemographics 

select Demo.EmployeeID, sal.Salary from EmployeeDemographics as Demo join EmployeeSalary as sal
on Demo.EmployeeID=sal.EmployeeID

-- Partition
select FirstName, LastName, Gender, Salary, count(Gender) over ( partition by Gender) as TotalGender
from EmployeeDemographics join EmployeeSalary on EmployeeDemographics.EmployeeID= EmployeeSalary.EmployeeID
