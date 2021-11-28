sp_helptext spupdateManufacturer

create proc deleteManufacturer
@name nvarchar(50)
as
begin
delete from Manufacturer where Name=@name
end

create proc spUpdateManufacturer
@newName nvarchar(50),
@oldName nvarchar(50)
as
begin
update Manufacturer
set name = @newName
where name = @oldName
end

select * from Line

---------------------------------------------------------------------------------------------------------
create proc DealerShipSitesUpdate
@OldDealerName nvarchar(50),
@OldCity nvarchar(255),
@NewDealerName nvarchar(50),
@NewCity nvarchar(255),
@NewAddress nvarchar(50),
@NewPhone nvarchar(10)
as
begin
update DealerShipSites
set dealerShipName = @NewDealerName, CitySite = @NewCity, address = @NewAddress, phone = @NewPhone
where dealerShipName= @OldDealerName and CitySite = @OldCity
end

--*****

create proc [dbo].[DealershipDelete]
@DealerName nvarchar(50)
as
begin
	delete from DealerShip where name = @DealerName
end

create proc [dbo].[DealerShipSitesDelete]
@OldDealerName nvarchar(50),
@OldCity nvarchar(255)
as
begin
delete from DealerShipSites
where dealerShipName= @OldDealerName and CitySite= @OldCity
end

create proc [dbo].[DealerShipSitesUpdate]
@OldDealerName nvarchar(50),
@OldCity nvarchar(255),
@NewDealerName nvarchar(50),
@NewCity nvarchar(255),
@NewAddress nvarchar(50),
@NewPhone nvarchar(10)
as
begin
update DealerShipSites
set dealerShipName = @NewDealerName, CitySite = @NewCity, address = @NewAddress, phone = @NewPhone
where dealerShipName= @OldDealerName and CitySite = @OldCity
end

CREATE proc [dbo].[spDealershipUpdate]
@NewName nvarchar(50),
@OldName nvarchar(50),
@NewLogo nvarchar(max),
@OldLogo nvarchar(max)
as
begin
	if((@NewName!=@OldName) and ((@NewLogo = @OldLogo) or ((len(@NewLogo)<=0) or @NewLogo is null))) -- change name only
		begin
			update DealerShip
			set Name=@NewName
			where name=@OldName
		end--end if
	else if((@NewName!=@OldName) and (@NewLogo!=@OldLogo))-- change name and logo
		begin
			update DealerShip
			set  Name=@NewName , logo=@NewLogo
			where name=@OldName and logo=@OldLogo
		end--end else

	else if(((@NewLogo!=@OldLogo) or (@NewLogo is null) or(len(@NewLogo)=0)) and (@OldName = @NewName))-- change only logo
		begin
			update DealerShip
			set logo=@NewLogo
			where logo=@OldLogo
		end
end


create proc [dbo].[spLineDelete]
@ManufacturerDelete nvarchar(50),
@lineDelete nvarchar(50)
as
begin
	delete from line 
	where ManufacturerName= @ManufacturerDelete and line= @lineDelete
end


CREATE proc [dbo].[spLineUpdate]
@NewManufacturer nvarchar(50),
@OldManufacturer nvarchar(50),
@NewLine nvarchar(50),
@OldLine nvarchar(50)
as
begin
	update line
	set ManufacturerName = @NewManufacturer, line = @NewLine
	where line=@OldLine and ManufacturerName=@OldManufacturer
end

CREATE proc [dbo].[spSearchManufacturer]
@name nvarchar(50) = null
as
begin
select * from Manufacturer where(Name=@name or @name is null)
end













