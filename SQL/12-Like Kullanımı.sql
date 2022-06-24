-- % :Birden fazla bilinmeyen karakteri temsil ediyor
-- _: Sadece tek bir karakteri temsil eder

select EnglishProductName
from DimProduct
where 
EnglishProductName  not like '%d%' --içeresinde d geçen

select EnglishProductName
from DimProduct
where 
EnglishProductName  like 'L%'--Başı L ile başlayıp sonunda herhangi bir karakter olan

select EnglishProductName
from DimProduct
where 
EnglishProductName  like '%d'--Başı herhangi bir karakter olan sonunda d ile biten

select EnglishProductName
from DimProduct
where
EnglishProductName like '____e'--İlk 4 karakteri herhangi bir şey olan  sonu e ile biten 