-- common table expression

with CTE_Employee as
(select FirstName, LastName, Gender, Salary,
count(Gender) over ( partition by Gender) as TotalGender,
avg(Salary) over ( partition by Salary) as Avgsal
from EmployeeDemographics join EmployeeSalary 
on EmployeeDemographics.EmployeeID= EmployeeSalary.EmployeeID
where Salary>'45000')

select * from CTE_Employee

-- Temp tables
drop table if exists #temp_emp
create table #temp_emp(EmployeeID int, JobTitle varchar(30), Salary int)

insert into #temp_emp values(1001, 'HR', '55000')
select * from #temp_emp

insert into #temp_emp select * from EmployeeSalary

drop table if exists #temp_emp2
create table #temp_emp2(JobTitle varchar(30),empperjob int, avgage int, avgsalary int)

insert into #temp_emp2
select JobTitle, count(JobTitle), avg(age), avg(salary)
from EmployeeDemographics join EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
group by JobTitle

select * from #temp_emp2

--Drop Table EmployeeErrors;
CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

Select *
From EmployeeErrors

-- Using Trim, LTRIM, RTRIM

Select EmployeeID, TRIM(employeeID) AS IDTRIM
FROM EmployeeErrors 

Select EmployeeID, RTRIM(employeeID) as IDRTRIM
FROM EmployeeErrors 

Select EmployeeID, LTRIM(employeeID) as IDLTRIM
FROM EmployeeErrors 

-- Using Replace

Select LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed
FROM EmployeeErrors

-- Using Substring

select SUBSTRING(FirstName, 1,3) from EmployeeErrors

Select Substring(err.FirstName,1,3), Substring(dem.FirstName,1,3), Substring(err.LastName,1,3), Substring(dem.LastName,1,3)
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
	on Substring(err.FirstName,1,3) = Substring(dem.FirstName,1,3)
	and Substring(err.LastName,1,3) = Substring(dem.LastName,1,3)

-- Using UPPER and lower

Select firstname, LOWER(firstname)
from EmployeeErrors

Select Firstname, UPPER(FirstName)
from EmployeeErrors

-- Procedures
create procedure test
as
select * from EmployeeDemographics

exec test

create procedure empage @age int
as
select * from EmployeeDemographics
where age= @age

exec empage @age='30'

create procedure empag @age int, @Gender varchar(30) as
select * from EmployeeDemographics
where age= @age and Gender= @Gender

exec empag @age='30', @Gender='male'

-- Subqueries
select * from EmployeeSalary

-- Subqueries in selelct statement
select EmployeeID, Salary,(select avg(Salary) from EmployeeSalary) as allavgsalary
from EmployeeSalary

-- how to do with partion by
select EmployeeID, Salary, avg(salary) over() as allavgsalary
from EmployeeSalary

-- why group by doesn't work
select EmployeeID, Salary, avg(salary) as allavgsalary
from EmployeeSalary
group by EmployeeID, Salary
order by 1,2

-- subquery in from
select a.EmployeeID, allavgsalary
from (select EmployeeID, Salary, avg(salary) over() as allavgsalary from EmployeeSalary) a

-- Subquery in where
select EmployeeID, JobTitle, Salary from EmployeeSalary
where EmployeeID in (select EmployeeID from EmployeeDemographics
where Age>30)

