select * from dbo.coviddeaths
order by 3,4

--select * from dbo.covidvaccinations
--order by 3,4

-- selecting the data that i need
select Location, date, Total_cases, new_cases, total_deaths, population
from dbo.coviddeaths
order by 1,2

-- Deaths percentage
select Location, date, Total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from dbo.coviddeaths
-- where location like '%United states%'
order by 1,2

-- Affected population percentage
select Location, date, population, Total_cases, ((total_cases/population)*100) as affectedpopulationPercentage
from dbo.coviddeaths
order by 1,2

-- countries with highest infection rate
select Location, population, max(Total_cases) as Heighestinfectedcount, max((total_cases/population)*100) as affectedpopulationPercentage
from dbo.coviddeaths
-- where location like '%India%'
group by Location, population
order by affectedpopulationPercentage DESC

-- countries with highest death count per population
select Location, max(cast(Total_deaths as int)) as Totaldeathscount
from dbo.coviddeaths
-- where location like '%India%'
-- where continent is not null
group by Location
order by Totaldeathscount DESC


-- Breaking it by continents with highest death count
select continent, max(cast(Total_deaths as int)) as Totaldeathscount
from dbo.coviddeaths
-- where location like '%India%'
where continent is not null
group by continent
order by Totaldeathscount DESC

-- Global numbers
-- New cases, Deaths and deaths percentage on each day
select date, sum(new_cases) as Totalnewcases, sum(cast(new_deaths as int)) as Totalnewdeaths,
(sum(cast(new_deaths as int))/sum(new_cases))*100 as NewcasesDeathPercentage
from dbo.coviddeaths
-- where location like '%United states%'
where continent is not null
group by date
order by 1,2

-- Total sum of new cases, Deaths and deaths percentage 
select sum(new_cases) as Totnewcases, sum(cast(new_deaths as int)) as Totnewdeaths, 
(sum(cast(new_deaths as int))/sum(new_cases))*100 as NewcasesDeathPercentage
from dbo.coviddeaths
-- where location like '%United states%'
where continent is not null
--group by date
order by 1,2

-- join deaths and vaccinations table
select * from coviddeaths d join covidvaccinations v
on d.location=v.location and d.date=v.date

-- Sum of new vaccinations 
select d.continent,d.location,d.date,d.population,v.new_vaccinations,
sum(cast(v.new_vaccinations as bigint)) over(partition by d.location order by d.location,d.date) as rolingsumnewvaccinations
from coviddeaths d join covidvaccinations v
on d.location=v.location and d.date=v.date
where d.continent is not null
order by 2,3

-- CTE (Common Table Expression)
with popvsvac (continent, location, date, population,new_vaccinations,rolingsumnewvaccinations) as
(
select d.continent,d.location,d.date,d.population,v.new_vaccinations,
sum(cast(v.new_vaccinations as bigint)) over(partition by d.location order by d.location,d.date) as rolingsumnewvaccinations
from coviddeaths d join covidvaccinations v
on d.location=v.location and d.date=v.date
where d.continent is not null
--order by 2,3
)
select *, (rolingsumnewvaccinations/population)*100 as newvaccinationspercentage from popvsvac

-- TEMP Table
drop table if exists #percntpopvac
create table #percntpopvac
(
continent varchar(255),
location varchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
rolingsumnewvaccinations numeric
)
insert into #percntpopvac
select d.continent,d.location,d.date,d.population,v.new_vaccinations,
sum(cast(v.new_vaccinations as bigint)) over(partition by d.location order by d.location,d.date) as rolingsumnewvaccinations
from coviddeaths d join covidvaccinations v
on d.location=v.location and d.date=v.date
--where d.continent is not null
--order by 2,3

select *, (rolingsumnewvaccinations/population)*100 as newvaccinationspercentage from #percntpopvac

-- creating VIEW to store data for later visualization
drop view if exists percentpopvac

create VIEW percentpopvac as
select d.continent,d.location,d.date,d.population,v.new_vaccinations,
sum(cast(v.new_vaccinations as bigint)) over(partition by d.location order by d.location,d.date) as rolingsumnewvaccinations
from coviddeaths d join covidvaccinations v
on d.location=v.location and d.date=v.date
where d.continent is not null
--order by 2,3

select * from percentpopvac