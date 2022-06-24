create table Ornek3
(
ID int primary key,
Isim nvarchar(20),
Soyisim nvarchar(20),
Yas int
)

insert into Ornek3(ID,Isim,Soyisim,Yas) values(1,'Can','Boz',26)
insert into Ornek3(ID,Isim,Soyisim,Yas) values(2,'Can','Boz',26)

SELECT * FROM Ornek3