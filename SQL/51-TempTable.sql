--Local Temp TABLE:#
--Global temp table:##


create table #Personel
(
Id int primary key,
Isim nvarchar(20) not null,
Soyisim nvarchar(20)not null

)

insert into #Personel(Id,Isim,Soyisim) values (1,'Can','Boz')
insert into #Personel(Id,Isim,Soyisim) values (2,'Can','Bozzzzzzz')

select * from #Personel

update #Personel
set
Isim='oSMANNN'
where Id=1

Delete #Personel
where
Id=2

--TRY CATCH
--BEGIN TRY
--??LEM VEYA ??LEMLER
--END TRY
--BEGIN CATCH
--HATA OLDU?U ZAMAN YAPMAK ?STED???M?Z ??LEMLER? TANIMLIYORUZ
--END CATCH


begin try
insert into #Personel(Id,Isim,Soyisim) VALUES (5,'Can','SADASDA')
end try
begin catch
	print 'Hata Olu?tu'
end catch


