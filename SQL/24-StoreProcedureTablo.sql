
create table Musteri
(
ID int primary key,
Isim nvarchar(30),
SoyIsim nvarchar(30),
EmailAdres nvarchar(60) default 'info@boztraing.com',
OlusturmaTarih datetime default getdate()
)
create table MusteriGirisBilgileri
(
MID int primary key,
KullaniciAdi nvarchar(30) unique not null,
Sifre nvarchar(30) check(Len(sifre)>6),
GizliSoru nvarchar(60) ,
Cevap nvarchar(60)
foreign key(MID) references Musteri(ID)
)

CREATE table Urun
(
UrunID int primary key,
Tanim nvarchar(50) not null,
Adet int check(Adet>0)
)

create table Satis
(
ID int primary key,
MID int not null,
UID int not null,
SatilanAdet int check(SatilanAdet>0)
)
