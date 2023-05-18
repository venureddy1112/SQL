--View the data
select * from dbo.raw_sales

-- standardize Date format
alter table dbo.raw_sales add dateofsold date;
update dbo.raw_sales set dateofsold=CONVERT(date, datesold)

select * from dbo.raw_sales

--checking for nullvales
select * from dbo.raw_sales
where price is null

--No of bedrroms, propertytype & Postcodes
select distinct propertytype from dbo.raw_sales
select distinct bedrooms from dbo.raw_sales
select distinct postcode from dbo.raw_sales

--Looking for houses sold as 0 bedroms  
select * from raw_sales
where bedrooms = 0 

select propertyType, count(*) as sold_as_zerobedrooms from raw_sales
where bedrooms = 0
group by propertyType

--Total properties sold bedrooms wise and property type
select propertyType, bedrooms, count(propertyType) as no_of_soldproperty from raw_sales
group by propertyType, bedrooms
order by bedrooms

--Make sure length of all postcode are same
select distinct(len(postcode)) as lenofpostcode from raw_sales



-- No of Sales each year
select year(dateofsold) as year_of_sold, count(*) as count_of_sales from raw_sales
group by year(dateofsold)
order by count_of_sales DESC

--Average sales prices of all years 
select year(dateofsold) as year_of_sold, CAST(AVG(price) as int) as avg_price from raw_sales
group by  year(dateofsold)
order by avg_price DESC

--Top 10 postcodes with highest average price of sales
select top 10 postcode,CAST(AVG(price) as int) as avg_price from raw_sales
group by postcode
order by avg_price DESC

--Top 10 highest average price of sales per year & postcodes 
select top 10 year(dateofsold) as year_of_sold, postcode, CAST(AVG(price) as int) as avg_price from raw_sales
group by  year(dateofsold), postcode
order by avg_price DESC


--Property wise Min,Max and average prices
select propertyType, MIN(price) as least_price, max(price) as highest_price, CAST(AVG(price) as int) as avg_price from raw_sales
group by propertyType
order by MIN(price), MAX(price)

--Bedrooms wise Min,Max and average prices
select bedrooms, MIN(price) as least_price, max(price) as highest_price, CAST(AVG(price) as int) as avg_price from raw_sales
group by bedrooms
order by MIN(price), MAX(price)

--Property & Bedrooms wise Min,Max and average prices
select propertyType, bedrooms, MIN(price) as least_price, max(price) as highest_price, CAST(AVG(price) as int) as avg_price from raw_sales
group by propertyType, bedrooms
order by MIN(price), MAX(price)


--Min,Max and average prices by Year & Property Type
select year(dateofsold) as year_of_sold, propertyType, MIN(price) as least_price, max(price) as highest_price, CAST(AVG(price) as int) as avg_price from raw_sales
group by year(dateofsold), propertyType
order by year(dateofsold), MIN(price), MAX(price)

--Min,Max and average prices by Year, Postcode & Property Type
select year(dateofsold) as year_of_sold, postcode, propertyType, MIN(price) as least_price, max(price) as highest_price, CAST(AVG(price) as int) as avg_price from raw_sales
group by year(dateofsold), postcode, propertyType
order by year(dateofsold), MIN(price), MAX(price)
