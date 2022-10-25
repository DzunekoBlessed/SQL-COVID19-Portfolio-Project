--covid SQL data exploration

select*
from Portfolioproject..CovidDeaths$
order by 3,4

--select data that we are going to use

select Location, date, total_cases, new_cases, total_deaths, population
from Portfolioproject..CovidDeaths$
order by 1,2

--Looking at the total cases and deaths in South Africa

select Location, date, total_cases, new_cases, total_deaths, population
from Portfolioproject..CovidDeaths$
where Location = 'South Africa'
order by 1,2

--Looking at the Total Cases vs Total Deaths and Mortality_rate
--shows the risk of death if you get covid in each country

select Location, date, total_cases,total_deaths, (total_deaths/total_cases) *100 as mortality_rate
from Portfolioproject..CovidDeaths$
order by 1,2
 
 --Looking at the Total Cases vs Total Deaths and Mortality_rate in South Africa
 --shows the risk of death if you get covid in my country

 select Location, date, total_cases,total_deaths, (total_deaths/total_cases) *100 as mortality_rate
from Portfolioproject..CovidDeaths$
where location = 'South Africa'
order by 1,2

--Total_cases vs population
--shows the total percentage of people infected by covid worldwide

select Location, date, total_cases,population, (total_deaths/population) *100 as infection_rate
from Portfolioproject..CovidDeaths$
order by 1,2

--Total_cases vs population
--shows the total percentage of people infected by covid in South Africa

select Location, date, total_cases,population, (total_deaths/population) *100 as infection_rate
from Portfolioproject..CovidDeaths$
where location = 'South Africa'
order by 1,2
 
 --Looking at Countries with Highest infection rate in relation to population

select Location, population, MAX(total_cases) as HighestInfectionCount, MAX(total_cases/population) *100 as infection_rate
from Portfolioproject..CovidDeaths$
Group by location, population
order by infection_rate desc

--Countries with the highest number of deaths per population

select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
from Portfolioproject..CovidDeaths$
Group by location
order by TotalDeathCount desc

--Let's Break things down by continet
select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
from Portfolioproject..CovidDeaths$
where continent is null
Group by location
order by TotalDeathCount desc


select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
from Portfolioproject..CovidDeaths$
where continent is not null
Group by location
order by TotalDeathCount desc

select*
from Portfolioproject..CovidDeaths$
order by 3,4

--select*
--from Portfolioproject..CovidVaccinations$
--order by 3,4

--select data that we are going to use

select Location, date, total_cases, new_cases, total_deaths, population
from Portfolioproject..CovidDeaths$
order by 1,2

--Looking at the total cases and deaths in South Africa

select Location, date, total_cases, new_cases, total_deaths, population
from Portfolioproject..CovidDeaths$
where Location = 'South Africa'
order by 1,2

--Looking at the Total Cases vs Total Deaths and Mortality_rate
--shows the risk of death if you get covid in each country
select Location, date, total_cases,total_deaths, (total_deaths/total_cases) *100 as mortality_rate
from Portfolioproject..CovidDeaths$
order by 1,2
 
 --Looking at the Total Cases vs Total Deaths and Mortality_rate in South Africa
 --shows the risk of death if you get covid in my country

 select Location, date, total_cases,total_deaths, (total_deaths/total_cases) *100 as mortality_rate
from Portfolioproject..CovidDeaths$
where location = 'South Africa'
order by 1,2

--Total_cases vs population
--shows the total percentage of people infected by covid worldwide

select Location, date, total_cases,population, (total_deaths/population) *100 as infection_rate
from Portfolioproject..CovidDeaths$
order by 1,2

--Total_cases vs population
--shows the total percentage of people infected by covid in South Africa

select Location, date, total_cases,population, (total_deaths/population) *100 as infection_rate
from Portfolioproject..CovidDeaths$
where location = 'South Africa'
order by 1,2
 
 --Looking at Countries with Highest infection rate in relation to population

select Location, population, MAX(total_cases) as HighestInfectionCount, MAX(total_cases/population) *100 as infection_rate
from Portfolioproject..CovidDeaths$
Group by location, population
order by infection_rate desc

--Countries with the highest number of deaths per population

select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
from Portfolioproject..CovidDeaths$
Group by location
order by TotalDeathCount desc

--Let's Break things down by continet
select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
from Portfolioproject..CovidDeaths$
where continent is null
Group by location
order by TotalDeathCount desc


select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
from Portfolioproject..CovidDeaths$
where continent is not null
Group by location
order by TotalDeathCount desc

--Showing the continets with highest mortality rate

select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
from Portfolioproject..CovidDeaths$
where continent is not null
Group by continent
order by TotalDeathCount desc

--covid stats globally

select date, SUM (new_cases) --total_cases,population, (total_deaths/population) *100 as infection_rate
from Portfolioproject..CovidDeaths$
where continent is not null
group by date
order by 1,2

--Daily cases and deaths count globally

select date,SUM (new_cases), SUM(cast(new_deaths as int))
from Portfolioproject..CovidDeaths$
where continent is not null
group by date
order by 1,2

--African Mortality Rate by day

select date,SUM (new_cases) as total_new_cases, sum(cast(new_deaths as int)) as total_new_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as MortalityRateDaily  
from Portfolioproject..CovidDeaths$
where continent like 'Africa'
group by date
order by 1,2



--Joining Twon data tables

select*
from Portfolioproject..CovidDeaths$ dea
join Portfolioproject..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
   
--Total vaccinations Globally

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from Portfolioproject..CovidDeaths$ dea
join Portfolioproject..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 1,2,3

--Looking at the total count of vaccinations each day by continent
  
select dea.continent, dea.date, dea.population, vac.new_vaccinations, SUM(cast(vac.new_vaccinations as int)) over (Partition by dea.continent) as TotalVaccinations
from Portfolioproject..CovidDeaths$ dea
join Portfolioproject..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by TotalVaccinations desc

--Total vaccinations count per day from each country

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(cast(vac.new_vaccinations as int)) over (Partition by dea.Location Order by dea.location, dea.date)
from Portfolioproject..CovidDeaths$ dea
join Portfolioproject..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3

-- Ranking African Countries by total vaccination

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(cast(vac.new_vaccinations as int)) over (Partition by dea.Location order by dea.location) as TotalVaccinations
from Portfolioproject..CovidDeaths$ dea
join Portfolioproject..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent = 'Africa'
order by TotalVaccinations

-- Ranking Top 10 African Countries by total vaccination

select top 10 (dea.continent), dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(cast(vac.new_vaccinations as int)) over (Partition by dea.Location order by dea.location) as TotalVaccinations
from Portfolioproject..CovidDeaths$ dea
join Portfolioproject..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent = 'Africa'
order by TotalVaccinations desc


--Total vaccinations count per day from South Africa

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(cast(vac.new_vaccinations as int)) over (Partition by dea.Location order by dea.location)
from Portfolioproject..CovidDeaths$ dea
join Portfolioproject..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null and dea.location = 'South Africa'
order by 2,3

--USE CTE to get the Percentage of the population vaccinciated 

with popvsVac (continent,location, date, population, new_vaccinations,TotalVaccinations)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(cast(vac.new_vaccinations as int)) over (Partition by dea.Location order by dea.location, dea.date) as TotalVaccinations
from Portfolioproject..CovidDeaths$ dea
join Portfolioproject..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
)
select*, (TotalVaccinations/ population)*100
from popvsVac


--Showing the Percentage of Vaccinated people in Africa using a TEMP TABLE

Drop table if exists #PercentageOfVaccinations
Create Table #PercentageOfVaccinations
(
continent nvarchar(255),
Location nvarchar(255),
Date datetime,
population numeric,
New_vaccinations numeric,
TotalVaccinations numeric
)
insert into #PercentageOfVaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(cast(vac.new_vaccinations as int)) over (Partition by dea.Location order by dea.location, dea.date) as TotalVaccinations
from Portfolioproject..CovidDeaths$ dea
join Portfolioproject..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent = 'Africa'

select*, (TotalVaccinations/ population)*100
from #PercentageOfVaccinations