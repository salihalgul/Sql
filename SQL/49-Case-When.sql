--Genel Kullanım
--select case kolonadi
--when 'Red' then 'Kırmızı' 
--when 'Red' then 'Kırmızı' 
--when 'Red' then 'Kırmızı' 
--when 'Red' then 'Kırmızı' 
--when 'Red' then 'Kırmızı' 
--else 'Renksiz'
--end

select distinct(color) from DimProduct

select EnglishProductName,(case color
when 'Black' then 'Siyah'
when 'Blue' then 'Mavi'
when 'Grey' then 'Gri'
when 'Multi' then 'Çok Renkli'
when 'NA' then 'Renksiz'
when 'Red' then 'Kırmızı'
when 'Silver' then 'Gümüş'
when 'Silver/Black' then 'GümüşSiyah'
when 'White' then 'Beyaz'
when 'Yellow' then 'Sarı'
else 'Renk Tanımı Yapılmamaıs'
end
 )as Renkler from DimProduct