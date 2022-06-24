--Egitim adında bir database oluşturun
--bu databasede tblBranslar,tblEgitmenler,tblSinif ve TblEgitimler adında tablolar oluşturun
--Database diagramını oluşturun

--Bütün eğitimleri alfabetik sıralayarak listeyelim ve bu eğitimlerin olduğu sınıfı kolon halinde gösterin

select *,(select s.SinifAdi from tblSinif s where s.SınıfID=e.SınıfID) AS [Sınıf Adı] from tblEgitimler e
order by [EgitimAdı]

select * from tblEgitimler e
inner join tblSinif c
on e.SınıfID=c.SınıfID



select e.*,c.SinifAdi from tblEgitimler e
inner join tblSinif c
on e.SınıfID=c.SınıfID

--Kartezyen join
select * from tblEgitimler,tblSinif


--inner joinle aynı işi yapar
select * from tblEgitimler e,tblSinif s
where e.SınıfID=s.SınıfID


--tblCast tablom ile tblActor tablosunu birleştiricem

select * from tblCast
select * from tblActor
select * from tblFilm
select * from tblCountry
select * from tblLanguage


select * from tblCast cast
inner join tblActor act
on cast.CastActorID=act.ActorID
inner join tblFilm film
on cast.CastFilmID=film.FilmID
inner join tblLanguage lang
on film.FilmLanguageID=lang.LanguageID
inner join tblCountry country
on film.FilmCountryID=country.CountryID
