declare @KullaniciAdi nvarchar(20),@Sifre nvarchar(20)
set @KullaniciAdi='Can'
set @Sifre='123'


if @KullaniciAdi='Cann' and @Sifre='123'
begin
	print 'Kullanici giris işlemi başarılı'
end

else
begin

	print 'Kullanici Giriş işlemi başarısız'
end