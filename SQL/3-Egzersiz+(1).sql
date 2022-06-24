--SELECT EGZERSİZİ
--Part1
--İlkVeritabanı adında bir database oluşturun 
--tblKisiler adında bir tablo oluşturun
--Bu tabloya  ad soyad telefon ve kayıt tarihi bilgilerini giriniz

CREATE DATABASE IlkVeritabani
select * 
from tblKisilerr

--Part2
--Adı Cagla veya Dilara olan kişilerin verilerini getir

select * 
from tblKisilerr
where Ad='Cagla'
or Ad='Dilara'


--Tablodan ad verilerini getir
select Ad,Telefon 
from tblKisilerr

--Part3
--Kayıt tarihi 2018-12-01 den sonra olan insanların verilerini getir
select * 
from tblKisilerr
where KayıtTarihi>='2018-12-01'

--Part4
--2018 yılının Aralık ayında kaydolan insanların verilerini getir
select * 
from tblKisilerr
where KayıtTarihi>='2018-12-01'
and KayıtTarihi<='2018-12-30'

select * 
from tblKisilerr
where KayıtTarihi between '2018-12-01'
and '2018-12-30'

--Tablomda kaç kişiye ait veri var
select COUNT(*) as KisiSayisi
from tblKisilerr


--Tablomdaki ilk 3 verimi alıyorum

select top 3 * 
from tblKisilerr