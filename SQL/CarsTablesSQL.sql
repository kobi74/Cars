create table Manufacturer(
Name nvarchar(50) primary key
)


create table Line(
ManufacturerName nvarchar(50) references Manufacturer(Name),
Line nvarchar(50),
primary key(ManufacturerName,Line)
)

create table DealerShip(
Name nvarchar(50) primary key,
logo nvarchar(max)
)

create table DealerShipSites(
dealerShipName nvarchar(50) references DealerShip(name),
CitySite nvarchar(255),
address nvarchar(50) not null,
phone nvarchar(10) not null,
openDay int not null check(openday between 1 and 7),
openTime time not null,
closeTime time not null,
primary key(dealerShipName,CitySite)
)

create table Cars(
serialNumber varchar(7) primary key,
manufacturer_Name_Line nvarchar(50),
LineName nvarchar(50),
Year int not null,
Color nvarchar(50) not null,
Class nvarchar(50) not null,
Fuel nvarchar(50) not null,
Engine nvarchar(50) not null,
Gearbox nvarchar(50) not null,
NumOfKM int not null,
Price int,
DealershipName nvarchar(50),
DealershipNameSite nvarchar(50),
foreign key (manufacturer_Name_Line,LineName)references Line(ManufacturerName,Line)
)

create table Meetings(
ID int identity(1,1) primary key,
CustomerFirstName nvarchar(50) not null,
customerLastName nvarchar(50) not null,
customerPhone nvarchar(10) not null,
DateOfMeeting date not null check(DateOfMeeting>=getdate()),
TimeOfMeeting time,
DealershipName nvarchar(50),
DealrshipSite nvarchar(255),
foreign key(DealershipName,DealrshipSite) references DealerShipSites(dealerShipName,CitySite)
)

create table MeetingsAboutCars(
MeetingID int references Meetings(ID),
CarSerialNumber varchar(7) references Cars(serialNumber),
primary key(MeetingID,CarSerialNumber)
)

create table SearchLog(
ID int identity(1,1) primary key,
ipAddress varchar(50) not null,
Manufacturer nvarchar(50),
Line nvarchar(50),
Color nvarchar(50),
FromYear int,
ToYear int,
fromPrice int,
ToPrice int,
MinKM int,
MaxKM int,
Fuel nvarchar(50),
engine nvarchar(50),
gearbox nvarchar(50)
)

create table Users(
	ID int identity(1000,1) primary key,
	FirstName nvarchar(50),
	LastName nvarchar(50),
	UserName nvarchar(50) unique,
	Password nvarchar(10),
	Position  nvarchar(50)
)

---- Alter-----
alter table Meetings
add CarNumber varchar(7) references Cars(serialNumber)