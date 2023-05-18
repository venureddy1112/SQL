select * from NashvilleHousing

-- standardize Date format
select SaleDate, CONVERT(date, SaleDate) from NashvilleHousing

update NashvilleHousing set SaleDate=CONVERT(date, SaleDate)
--above one is not worked

alter table NashvilleHousing add saledateconverted date;

update NashvilleHousing set saledateconverted=CONVERT(date, SaleDate)
select SaleDate, saledateconverted from NashvilleHousing
 
-- populate property address data
select * from NashvilleHousing
order by ParcelID

--dealing with null values in address
select a.ParcelID,a.PropertyAddress, b.ParcelID,b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
from NashvilleHousing a join NashvilleHousing b
on a.ParcelID=b.ParcelID and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

update a 
set PropertyAddress= ISNULL(a.PropertyAddress,b.PropertyAddress)
from NashvilleHousing a join NashvilleHousing b
on a.ParcelID=b.ParcelID and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

--check for result of null values in address
select PropertyAddress from NashvilleHousing
where PropertyAddress is null

--Breaking out address into individual columns(Address, city, state)
select PropertyAddress from NashvilleHousing
--order by ParcelID

-- used substring and charindex to slipt columns
select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as city
from NashvilleHousing

--update new splitted address columns
alter table NashvilleHousing add Propertysplitaddress varchar(250);

update NashvilleHousing set Propertysplitaddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

alter table NashvilleHousing add Propertysplitcity varchar(250);

update NashvilleHousing set Propertysplitaddress = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

-- Address was splited and updated
select * from NashvilleHousing

select OwnerAddress from NashvilleHousing

select 
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
from NashvilleHousing

alter table NashvilleHousing add Ownersplitaddress varchar(250);

update NashvilleHousing set Ownersplitaddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

alter table NashvilleHousing add Ownersplitcity varchar(250);

update NashvilleHousing set Ownersplitcity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

alter table NashvilleHousing add Ownersplitstate varchar(250);

update NashvilleHousing set Ownersplitstate = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

select * from NashvilleHousing

-- change & update Y and N as yes and no
select distinct(SoldAsVacant), COUNT(SoldAsVacant)
from NashvilleHousing
group by SoldAsVacant
order by 2

select SoldAsVacant,
case when SoldAsVacant='Y' then 'YES'
     when SoldAsVacant='N' then 'NO'
	 else SoldAsVacant
	 END
from NashvilleHousing

update NashvilleHousing
set SoldAsVacant= case when SoldAsVacant='Y' then 'YES'
     when SoldAsVacant='N' then 'NO'
	 else SoldAsVacant
	 END

--Remove duplicates
select *,
	ROW_NUMBER() over(
	partition by ParcelID, PropertyAddress, SaleDate, SalePrice, LegalReference
	order by UniqueID) dup
from NashvilleHousing

--CTE (show all duplicates as 2 or more)
with dupnumCTE as(
select *,
	ROW_NUMBER() over(
	partition by ParcelID, PropertyAddress, SaleDate, SalePrice, LegalReference
	order by UniqueID) dup
from NashvilleHousing
)
select * from dupnumCTE
where dup > 1
order by PropertyAddress

--CTE (delete duplicates as 2 or more) 
with dupnumCTE as(
select *,
	ROW_NUMBER() over(
	partition by ParcelID, PropertyAddress, SaleDate, SalePrice, LegalReference
	order by UniqueID) dup
from NashvilleHousing
)
delete from dupnumCTE
where dup > 1

--Delete unused columns

select * from NashvilleHousing

alter table NashvilleHousing
drop column PropertyAddress, OwnerAddress, TaxDistrict, SaleDate