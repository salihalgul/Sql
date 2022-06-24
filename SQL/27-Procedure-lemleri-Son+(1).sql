
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

--create proc/procedure

create proc SP_Musteri_YeniKayit
(
@ID int,
@Isim nvarchar(30),
@Soyisim nvarchar(30),
@EmailAdres nvarchar(60),
@KullaniciAdi nvarchar(30),
@Sifre nvarchar(10),
@GizliSoru nvarchar(40),
@Cevap nvarchar(40)
)
as
begin
insert into Musteri(ID,Isim,SoyIsim,EmailAdres) values (@ID,@Isim,@Soyisim,@EmailAdres)
	if(@@ROWCOUNT>0)
	begin
		insert into MusteriGirisBilgileri(MID,KullaniciAdi,Sifre,GizliSoru,Cevap) values (@ID,@KullaniciAdi,@Sifre,@GizliSoru,@Cevap)
	end
end

CREATE table Urun
(
UrunID int primary key,
Tanim nvarchar(50) not null,
Adet int check(Adet>0)
)

create proc SP_uRUN_YeniKayit
(
@UrunID int,
@Tanim nvarchar(50),
@Adet int
)
as
begin
insert into Urun (UrunID,Tanim,Adet) values (@UrunID,@Tanim,@Adet)
end


create proc SP_urun_kayitduzenle
(
@UrunID int,
@Tanim nvarchar(50),
@Adet int
)
as
begin
		update Urun set Tanim=@Tanim,Adet=@Adet  where UrunID=@UrunID
end


create proc SP_Urun_Sil
(
@UrunId int
)
as
begin
delete Urun where UrunID=@UrunId
end

create proc SP_UrunListele
as
begin
select * from Urun
end


create Proc SP_Urun_Tekkayit
(
@UrunID int
)
as
begin 
select * from Urun where UrunID=@UrunID
end





create table Satis
(
ID int primary key,
MID int not null,
UID int not null,
SatilanAdet int check(SatilanAdet>0)
)


CREATE proc SP_Satis_YeniKayit
(
@ID int ,
@MID int ,
@UID int ,
@SatilanAdet int 
)
as 
begin
insert into Satis(ID,MID,UID,SatilanAdet) values (@ID,@MID,@UID,@SatilanAdet)
end

create proc SP_Satis_KayitDüzenle
(
@ID int ,
@MID int ,
@UID int ,
@SatilanAdet int 
)
as
begin
update Satis
set
MID=@MID,
UID=@UID,
SatilanAdet=@SatilanAdet
where
ID=@ID
end

alter procedure SP_Satis_KayitSil
(
@ID int
)

as
begin
delete Satis 
where ID=@ID
end

