create table Ornek4
(
ID int primary key,
Isim nvarchar(20),
Soyisim nvarchar(20),
Yas int check(Yas>10)
)

insert into Ornek4(ID,Isim,Soyisim,Yas) VALUES(2,'Can','Boz',6)

select * from Ornek4