use OkulSabahDB
select*from Ogrenciler
--herbir öðrencinin hangi sýnýfta olduðunu öðrenci adý,soyadý,sýnýf no ve þubesi þeklinde sýrala
select o.OgrenciAdi,o.OgrenciSoyadi,s.SýnýflarID,s.SýnýfNo,s.SýnýfSubesi from Ogrenciler as o
inner join Sýnýflar as s on o.SinifID=s.SýnýflarID
--sýnýflarýn no,þubesini,sýnýf öðretmenini listeleyiniz
select s.SýnýfNo,s.SýnýfSubesi,o.OgretmenAdi + ' '+ o.OgretmenSoyadi as 'Öðretmen Adý-Soyadý'from Ogretmenler as o inner join Sýnýflar as s on s.OgretmenID=o.OgretmenlerID
--öðrenci adý,soyadý,veli adý,soyadý
select o.OgrenciAdi,o.OgrenciSoyadi,v.VeliAdi,v.VeliSoyadi from OgrenciVeli as ov
join Veliler as v on v.VelilerID=ov.VeliID
join Ogrenciler as o on ov.OgrenciID=o.OgrencilerID 
--**************************************************
--Group by
--**************************************************
--bir veri için baþka bir tablo birden fazla iþlem gerçekleþmiþse o verinin diðer tablo/tablolarda gerçekleþme sayýsýný group by ile kodlayýp gösterebiliriz
--tekrarlý verileri gruplayýp bir functiona göre iþlem yaptýrýr
--1) group by ile yazýlan kolon baþka bir kolon yoksa select ile from arasýnda yazýlmak zorunda
--sýnýfýd yerine baþka birþey yazarsak hata verir.çünkü gruplanan sýnýfýd

select SinifID from Ogrenciler
group by SinifID
--2)group by ile yazýlan colon select ile from arasýna yazýlmamýþ ise bir hazýr fonksiyon (sum,count,max,min,datepart,datediff)
select count(OgrencilerID)from Ogrenciler
group by SinifID
--3)hem fonksiyonu hem de group by ile beraber kullanýlan kolonu yazabiliriz en çok kullanýlan yazým þekli budur.
select SinifID, count(OgrencilerID) from Ogrenciler
group by SinifID

select s.SýnýflarID,s.SýnýfNo,s.SýnýfSubesi,count(OgrencilerID) from Ogrenciler as o
join Sýnýflar as s on o.SinifID=s.SýnýflarID
group by s.SýnýflarID,s.SýnýfNo,s.SýnýfSubesi
--group by SinifID


--space(1)=> space tuþuna basýlýnca çýkan boþluk deðeri 1 kadar boþluk býrakýr
--sanal isimlendirme(alinas) ile yapýlan isimlendirmeleri order by ile kullanabiliriz
select s.SýnýflarID,s.SýnýfNo +SPACE(1)+ s.SýnýfSubesi as 'sýnýfý',count(OgrencilerID) as 'Öðrenci Sayýsý' from Ogrenciler as  o
join Sýnýflar as s on o.SinifID=s.SýnýflarID
group by s.SýnýflarID,s.SýnýfNo,s.SýnýfSubesi order by [Öðrenci Sayýsý]
--MS SQL öðrenmek için w3school dan takip edebiliriz

--herbir kan grubunda kaç öðrencim olduðunu hesaplayalým 
select k.KanGruplariID,k.KanGrubuAdi,COUNT(o.OgrencilerID) as 'Öðrenci sayýsý' from Ogrenciler as o
 join KanGruplari as k on k.KanGruplariID=o.KanGrubuID
group by k.KanGrubuAdi,k.KanGruplariID

--kan grubu listeye dahil edilmeyen öðrencileri de ekleyelim
select k.KanGruplariID,k.KanGrubuAdi,COUNT(o.OgrencilerID) as 'Öðrenci sayýsý' from Ogrenciler as o
left join KanGruplari as k on k.KanGruplariID=o.KanGrubuID
group by k.KanGrubuAdi,k.KanGruplariID

select*from Ogrenciler where KanGrubuID is null

--herbir kullanýcýnýn kaç öðrenci kaydýnda görev yaptýðýný kullanýcý adý,soyadý, ve görev aldýðý öðrenci sayýsý þeklinde listeleyiniz
select k.KullanicilarID,k.KullaniciAdi,COUNT(o.OgrencilerID) as Sayýsý from Kullanicilar as k
join Ogrenciler as o on o.KullaniciID=k.KullanicilarID
group by k.KullanicilarID,k.KullaniciAdi
--count null kolonlarý saymaz. 
--count ile * kullanýnca o tablodan bütün kolonlarý hesaba katar bu da performans için olumsuz etki yaratýr.Bunun yerine Primary key oln bir kolon kullanýrsak performans da çok etkilenmez istediðimiz sonucu da elde etmiþ oluruz.
--*************************************************************
--HAVING
--*************************************************************
--group by ile yapýlan hesaplamalarý where ile koþullandýramayýz.Bunun yerine having kullanýlýr.
select k.KullanicilarID,k.KullaniciAdi,COUNT(o.OgrencilerID) as Sayýsý from Kullanicilar as k
join Ogrenciler as o on o.KullaniciID=k.KullanicilarID
--where COUNT(o.OgrencilerID)>15
--bu þekilde bir koþul ile sonuç elde edemeyiz.Where var olan kolonlar üzerinde koþul yazmamýzý saðlar ama bir hazýr fonksiyon ile bir hesaplama yaparak yeni bir deðer elde ettik ve bunu birden fazla kolon üzerinde hesaplatýyoruz.Bu iþlemi where gerçekleþtiremez.Bunun için group by dan sonra having yazarak hesaplama yapabiliriz.
group by k.KullanicilarID,k.KullaniciAdi
having COUNT(o.OgrencilerID)>15

--mevcudu en fazla olan 5 sýnýfýn listesi
--1.yol
select s.SýnýflarID,s.SýnýfNo+space(2)+s.SýnýfSubesi,count(o.OgrencilerID) as sayýsý from Ogrenciler as o
join Sýnýflar as s on s.SýnýflarID=o.SinifID
group by s.SýnýflarID,s.SýnýfNo,s.SýnýfSubesi
order by sayýsý desc
--2.yol
select s.SýnýflarID,s.SýnýfNo+space(2)+s.SýnýfSubesi,count(o.OgrencilerID) as sayýsý from Ogrenciler as o
join Sýnýflar as s on s.SýnýflarID=o.SinifID
group by s.SýnýflarID,s.SýnýfNo,s.SýnýfSubesi
having count(o.OgrencilerID)>10






