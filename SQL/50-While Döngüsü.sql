--begin
 --kod veya kodlar
--end


declare @Isim nvarchar(20)='Can Boz'
declare @Sayac int=0

while @Sayac <=len(@Isim)
begin
	print substring(@Isim,1,@Sayac)
	set @Sayac =@Sayac +1
end

print 'While işlemi bitti'