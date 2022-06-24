use SQLFULL
GO
create table Personel
(
PersonelID int,
Isim nvarchar(40),
Soyisim nvarchar(40),
EmailAdres nvarchar(60)
)

Alter table Personel
Add TelefonNumarasi nvarchar(12)

Alter table Personel
Drop column TelefonNumarasi

drop table Personel