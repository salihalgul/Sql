declare @ToplamKayitSayisi int
select @ToplamKayitSayisi=COUNT(*) from DimProduct


if @ToplamKayitSayisi<=100
begin
		print 'Toplam Sayi 100 den küçük veya eşit'
end
else if @ToplamKayitSayisi>100 and @ToplamKayitSayisi<=200

begin
		print 'Toplam sayı 100 ile 200 arasındadır'
end
else
begin
		print 'Toplam sayı 200 den buyuktur'
end