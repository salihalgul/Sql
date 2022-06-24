--Geriye sorgu döndüren fonksiyonlar

create function IDPRODUCT
(
@ID int
)
returns table
as
return(select * from DimProduct where ProductKey=@ID)

select * from dbo.IDPRODUCT(1)


alter function Personel
(
)
returns @PersonelTablo table
(
ID int,
Isim nvarchar(20),
Soyisim nvarchar(20)
)
as
begin
insert into @PersonelTablo(ID,Isim,Soyisim) values (1,'Can','Boz')
insert into @PersonelTablo(ID,Isim,Soyisim) values (2,'Cannnn','Bozzzzz')
return
end

select * from dbo.Personel()

