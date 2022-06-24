--Count Kullanımı:
--select count(kolon) from Tablo where şart....



select count(*) from DimProduct
where
color='Yellow'

select AVG(SafetyStockLevel) from DimProduct
where color='Black'