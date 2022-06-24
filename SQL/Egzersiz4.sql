

--Filmin adını
--Filmin kaç kere oskara aday olduğunu
--Kaç kere oskar kazandığını 

select FilmName,FilmOscarNominations,FilmOscarWins from tblFilm

--Oscar kazanma sayısına göre en çok kazanan yukarıda olacak şekilde sıralayalım
--Hiç aday olmamışlar da gelmesin

select FilmName,FilmOscarNominations,FilmOscarWins 
from tblFilm
where FilmOscarNominations !=0 and FilmOscarNominations is not null
order by FilmOscarWins desc,FilmOscarNominations desc

--ADI t ile başlayan c ile bitmeyen kaç film var?
select count(*) from tblFilm
where FilmName like 't%'
and FilmName not like '%c'

--en uzun 10 film(film adı, süresi,konusu)
select top 10 FilmName,FilmRunTimeMinutes,FilmSynopsis from tblFilm
order by FilmRunTimeMinutes desc

--tüm ülkeleri ekrana getireleim

select * from tblCountry

--tüm dilleri ekrana getirelim



--Ülke sayısını ve dil ayısını ekranan getirin

--query ->select sorgusu
--() -->subquery altsorgu
--select (select...) as kolonadı (select ..) as kolonadiikinci




select (select count(*) from tblCountry) AS [ÜLke Sayısı],(select count(*) from tblLanguage) as [Dil Sayısı]


--Film tablosundaki tüm film isimlerini ve FilLanguaageID alanını getirelim
select * from tblFilm
select * from tblLanguage


select f.FilmName,f.FilmLanguageID,
(select Language from tblLanguage where LanguageID=f.FilmLanguageID) AS [Dil İsmi] 
from tblFilm f

--Director
--Filmlerin isimleri yanında yönetmelerin isimleri ayrı bir sütün olarak gelsin

select* from tblFilm
select * from tblDirector

select FilmName,(select DirectorName from tblDirector where DirectorID=tblFilm.FilmDirectorID) AS Yönetmen
 from tblFilm

 --Cast tablosundaki tüm bilgiler gelsin
 --Yanında ayrıca bir sutun olarak aktör isimleri gelsin

 select * from tblCast
 select * from tblActor

  select *,( select ActorName from tblActor where ActorID=tblCast.CastActorID) as Aktör from tblCast

  select * from tblFilm
  --1990-2000 yılları arsında olan filmlerin isimleri ve tarihlerini getir

  select *
  from tblFilm
  where FilmReleaseDate > 1990-01-01
  and FilmReleaseDate < 2000-01-01

  select FilmName,FilmReleaseDate
  from tblFilm
  where DATEPART(YEAR, FilmReleaseDate) > 1989
  and  DATEPART(YEAR, FilmReleaseDate) < 2001

  --En düşük bütçeli 20 filmi getirelim

  select top 20 FilmName
  from tblFilm
  order by FilmBudgetDollars

  --Aday olduğu tüm oscarları kazanmış filmleri getir(adaylığı olmayanlar gelmesin)

  select FilmName
  from tblFilm
  where FilmOscarNominations=FilmOscarWins
  and FilmOscarNominations !=0