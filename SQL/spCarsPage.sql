
create proc spGetManufacturer
as
begin
	select NAME from Manufacturer
end


create proc spGetLine
@name nvarchar(50)
as
begin
	select line from Line
	where ManufacturerName= @name
end

create proc getDealership
as
begin
	select name from DealerShip
end

select * from DealerShipSites

create proc getDealershipSite 
@name nvarchar(50)
as
begin
	select CitySite
	from DealerShipSites as ds
	where ds.dealerShipName = @name
end 
select * from Cars

alter table Cars
add CarPic nvarchar(max) null

---27/02/2019
create proc LineSearch
@Manufacturer nvarchar(50),
@Line nvarchar(50)
as
begin
	select * from Line
	where ManufacturerName like '%'+@Manufacturer+'%' or Line like '%'+@Line+'%'
end

create proc DealershipSearch
@Dname nvarchar(50)
as
begin
	select * from DealerShip where name like '%'+@Dname+ '%'
end

--01/03/2019
create proc DealerShipSitesSearch
@Dname nvarchar(50),
@Dsite nvarchar(255)
as
begin
	if(@Dname is null or len(@Dname)=0)
	begin
		select * from DealerShipSites where CitySite= @Dsite
	end

	else if(@Dsite is null or len(@Dsite)=0)
		begin
			select * from DealerShipSites where dealerShipName=@Dname
		end

	else
		begin
			select * from DealerShipSites
			where dealerShipName like @Dname and CitySite like  @Dsite
		end
end

-- 09/03/2019
create proc CarsUpdate
@SerialNumber varchar(7),
@OldSerialNumber varchar(7),
@Manufacturer nvarchar(50),
@Line nvarchar(50),
@Year int,
@Color nvarchar(50),
@Class nvarchar(50),
@Fuel nvarchar(50),
@Engine int,
@Gearbox nvarchar(50),
@NumOfKM int,
@Price int,
@Dealership nvarchar(50),
@Site nvarchar(50),
@CarPic nvarchar(max)

as
begin
	update Cars
	set serialNumber = @SerialNumber,
		manufacturer_Name_Line = @Manufacturer,
		LineName = @Line,
		Year = @Year,
		Color  = @Color,
		Class = @Class,
		Fuel = @Fuel,
		Engine = @Engine,
		Gearbox = @Gearbox,
		NumOfKM = @NumOfKM,
		Price = @Price,
		DealershipName = @Dealership,
		DealershipNameSite = @Site,
		CarPic = @CarPic
	where serialNumber = @OldSerialNumber
end

create proc CarsDelete
@carNumber varchar(7)
as
begin
	delete from Cars 
	where serialNumber = @carNumber
end


create proc CarSearch
@serialNumber varchar(7),
@manufacturer nvarchar(50),
@line nvarchar(50),
@Minyear int,
@MaxYear int,
@class nvarchar(50),
@fuel nvarchar(50),
@MinEngine int,
@MaxEngine int,
@gearbox nvarchar(50),
@MinnumKM int,
@MaxnumKM int,
@Minprice int,
@MaxPrice int,
@dealership nvarchar(50),
@citySite nvarchar(50)
as
begin
	select * from Cars where 
	serialNumber like @serialNumber
	and manufacturer_Name_Line like @manufacturer
	and LineName like @line
	and (year>= @Minyear and year <= @Maxyear)
	and class like @class
	and fuel like @fuel
	and (Engine >= @MinEngine and Engine <= @MaxEngine)
	and Gearbox like @gearbox
	and (NumOfKM >= @MinnumKM and NumOfKM <= @MaxnumKM)
	and (price >= @Minprice and price <= @MaxPrice)
	and DealershipName like @dealership
	and DealershipNameSite like @citySite
end

create proc SearchCarNumber
@carnumber varchar(7)
as
begin
	select * from Cars
	where serialNumber=@carnumber
end

create proc MiniSearch
@class nvarchar(50),
@manufacturer nvarchar(50),
@Line nvarchar(50),
@minYear int,
@MaxYear int,
@MinPrice int,
@MaxPrice int
as
begin
	select * from cars
	where class like '%'+ @class+'%'
	and manufacturer_Name_Line like '%'+@manufacturer+'%'
	and LineName like '%'+@Line+'%'
	and (year >= @minYear and year <= @MaxYear)
	and (price >= @MinPrice and price <= @MaxPrice)
end

-- VIEW 12/05/2019--
--- vwCountManufacturer FOR DASHBOARD ----
create view vwCountManufacturer
as
select c.manufacturer_Name_Line as 'שם יצרן',count(c.manufacturer_Name_Line) as 'כמות'
from cars c
group by c.manufacturer_Name_Line

--- FOR MEETINGS REPORT
create view vmMeetingsReport
as
select m.id,m.CustomerFirstName,m.customerLastName,m.DateOfMeeting,m.TimeOfMeeting,m.DealershipName,m.DealrshipSite,m.carnumber, c.manufacturer_Name_Line,c.LineName,c.Year
from Meetings as m
inner join Cars as c
on m.CarNumber =c.serialNumber

---spMeetingReport
create proc MeetingReport @Company='',@Site='',@FromDate='01/05/2000',@ToDate='05/29/3000'
@FromDate date,
@ToDate date,
@Company nvarchar(50),
@Site nvarchar(50)
as
begin
	select * from vmMeetingsReport
	where DealershipName like'%' + @Company +'%'
	and DealrshipSite like'%' + @Site +'%'
	and(DateOfMeeting >= @FromDate and DateOfMeeting<= @ToDate)
end