use OkulSabahDB
select*from Ogrenciler
--herbir ��rencinin hangi s�n�fta oldu�unu ��renci ad�,soyad�,s�n�f no ve �ubesi �eklinde s�rala
select o.OgrenciAdi,o.OgrenciSoyadi,s.S�n�flarID,s.S�n�fNo,s.S�n�fSubesi from Ogrenciler as o
inner join S�n�flar as s on o.SinifID=s.S�n�flarID
--s�n�flar�n no,�ubesini,s�n�f ��retmenini listeleyiniz
select s.S�n�fNo,s.S�n�fSubesi,o.OgretmenAdi + ' '+ o.OgretmenSoyadi as '��retmen Ad�-Soyad�'from Ogretmenler as o inner join S�n�flar as s on s.OgretmenID=o.OgretmenlerID
--��renci ad�,soyad�,veli ad�,soyad�
select o.OgrenciAdi,o.OgrenciSoyadi,v.VeliAdi,v.VeliSoyadi from OgrenciVeli as ov
join Veliler as v on v.VelilerID=ov.VeliID
join Ogrenciler as o on ov.OgrenciID=o.OgrencilerID 
--**************************************************
--Group by
--**************************************************
--bir veri i�in ba�ka bir tablo birden fazla i�lem ger�ekle�mi�se o verinin di�er tablo/tablolarda ger�ekle�me say�s�n� group by ile kodlay�p g�sterebiliriz
--tekrarl� verileri gruplay�p bir functiona g�re i�lem yapt�r�r
--1) group by ile yaz�lan kolon ba�ka bir kolon yoksa select ile from aras�nda yaz�lmak zorunda
--s�n�f�d yerine ba�ka bir�ey yazarsak hata verir.��nk� gruplanan s�n�f�d

select SinifID from Ogrenciler
group by SinifID
--2)group by ile yaz�lan colon select ile from aras�na yaz�lmam�� ise bir haz�r fonksiyon (sum,count,max,min,datepart,datediff)
select count(OgrencilerID)from Ogrenciler
group by SinifID
--3)hem fonksiyonu hem de group by ile beraber kullan�lan kolonu yazabiliriz en �ok kullan�lan yaz�m �ekli budur.
select SinifID, count(OgrencilerID) from Ogrenciler
group by SinifID

select s.S�n�flarID,s.S�n�fNo,s.S�n�fSubesi,count(OgrencilerID) from Ogrenciler as o
join S�n�flar as s on o.SinifID=s.S�n�flarID
group by s.S�n�flarID,s.S�n�fNo,s.S�n�fSubesi
--group by SinifID


--space(1)=> space tu�una bas�l�nca ��kan bo�luk de�eri 1 kadar bo�luk b�rak�r
--sanal isimlendirme(alinas) ile yap�lan isimlendirmeleri order by ile kullanabiliriz
select s.S�n�flarID,s.S�n�fNo +SPACE(1)+ s.S�n�fSubesi as 's�n�f�',count(OgrencilerID) as '��renci Say�s�' from Ogrenciler as  o
join S�n�flar as s on o.SinifID=s.S�n�flarID
group by s.S�n�flarID,s.S�n�fNo,s.S�n�fSubesi order by [��renci Say�s�]
--MS SQL ��renmek i�in w3school dan takip edebiliriz

--herbir kan grubunda ka� ��rencim oldu�unu hesaplayal�m 
select k.KanGruplariID,k.KanGrubuAdi,COUNT(o.OgrencilerID) as '��renci say�s�' from Ogrenciler as o
 join KanGruplari as k on k.KanGruplariID=o.KanGrubuID
group by k.KanGrubuAdi,k.KanGruplariID

--kan grubu listeye dahil edilmeyen ��rencileri de ekleyelim
select k.KanGruplariID,k.KanGrubuAdi,COUNT(o.OgrencilerID) as '��renci say�s�' from Ogrenciler as o
left join KanGruplari as k on k.KanGruplariID=o.KanGrubuID
group by k.KanGrubuAdi,k.KanGruplariID

select*from Ogrenciler where KanGrubuID is null

--herbir kullan�c�n�n ka� ��renci kayd�nda g�rev yapt���n� kullan�c� ad�,soyad�, ve g�rev ald��� ��renci say�s� �eklinde listeleyiniz
select k.KullanicilarID,k.KullaniciAdi,COUNT(o.OgrencilerID) as Say�s� from Kullanicilar as k
join Ogrenciler as o on o.KullaniciID=k.KullanicilarID
group by k.KullanicilarID,k.KullaniciAdi
--count null kolonlar� saymaz. 
--count ile * kullan�nca o tablodan b�t�n kolonlar� hesaba katar bu da performans i�in olumsuz etki yarat�r.Bunun yerine Primary key oln bir kolon kullan�rsak performans da �ok etkilenmez istedi�imiz sonucu da elde etmi� oluruz.
--*************************************************************
--HAVING
--*************************************************************
--group by ile yap�lan hesaplamalar� where ile ko�ulland�ramay�z.Bunun yerine having kullan�l�r.
select k.KullanicilarID,k.KullaniciAdi,COUNT(o.OgrencilerID) as Say�s� from Kullanicilar as k
join Ogrenciler as o on o.KullaniciID=k.KullanicilarID
--where COUNT(o.OgrencilerID)>15
--bu �ekilde bir ko�ul ile sonu� elde edemeyiz.Where var olan kolonlar �zerinde ko�ul yazmam�z� sa�lar ama bir haz�r fonksiyon ile bir hesaplama yaparak yeni bir de�er elde ettik ve bunu birden fazla kolon �zerinde hesaplat�yoruz.Bu i�lemi where ger�ekle�tiremez.Bunun i�in group by dan sonra having yazarak hesaplama yapabiliriz.
group by k.KullanicilarID,k.KullaniciAdi
having COUNT(o.OgrencilerID)>15

--mevcudu en fazla olan 5 s�n�f�n listesi
--1.yol
select s.S�n�flarID,s.S�n�fNo+space(2)+s.S�n�fSubesi,count(o.OgrencilerID) as say�s� from Ogrenciler as o
join S�n�flar as s on s.S�n�flarID=o.SinifID
group by s.S�n�flarID,s.S�n�fNo,s.S�n�fSubesi
order by say�s� desc
--2.yol
select s.S�n�flarID,s.S�n�fNo+space(2)+s.S�n�fSubesi,count(o.OgrencilerID) as say�s� from Ogrenciler as o
join S�n�flar as s on s.S�n�flarID=o.SinifID
group by s.S�n�flarID,s.S�n�fNo,s.S�n�fSubesi
having count(o.OgrencilerID)>10






