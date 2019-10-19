-- 1) Ürünler tablosundaki ilk 10 kaydi listeleyin
	select top 10 *from Products

-- 2) Bugünün tarihini kolon isimleri Yil, Ay ve Gün olacaksekilde listeleyiniz.
	select DATEPART(year,GetDate()) as Yil,DATEPART(month,GetDate()) as Ay,DATEPART(DAY,GetDate()) as Gün

-- 3) Kendi yasinizi çikartan sorguyu yaziniz.
	select DATEDIFF(year,'1995-01-01',GetDate()) Yas

-- 4) Birebir firma sahibi ile temas kurulan tedarikçileri listeleyin
	select*from Suppliers where  ContactTitle like '%Owner%'

-- 5) Stokta mevcut olan ve fiyati en büyük olan 3 ürünü listeleyin
	select top 3 *from products where UnitsInStock>0 order by UnitPrice desc

--? 6) Hangi çalisanlarim Almanca biliyor?
	select*from Employees where Notes like '%German%'

-- 7) Stokta 40 tan fazla olan ürünlerimin adlari ve categoriIdleri?
	select ProductName, CategoryID from Products where UnitsInStock>40 

-- 8) ismi 'chai' olanlarin ya da kategorisi 3 olan ve 29 dan fazla stogu olan ürünleri listeleyin
	select*from products where ProductName like '%chai%' or CategoryID=3 and UnitsInStock>29 

-- 9) Stogu 42 ile 100 arasinda olan ürünleri listeleyin
	select*from products where UnitsInStock between 42 and 100

--? 10) Dogum tarihleri 1961-01-01 ve 2010-10-10 tarihleri arasinda ve kadin çalisanlarimi listeleyin
	select*from Employees where BirthDate between '1961-01-01' and '2010-10-10' and TitleOfCourtesy='Ms.' or TitleOfCourtesy='Mrs.'

-- 11) Yasadigisehir London ve Seattle olmayan çalisanlarimiz kimlerdir?
	select*from Employees where City!='seattle' and City!='London'

-- 12) Adinda ve soyadinda 'e' harfi geçmeyen çalisanlarimiz kimlerdir?
	select*from Employees where FirstName not like '%e%' and LastName not like '%e%'

-- 13) Tüm müsterilerim olansirketlerin isimlerini ve isimlerinin ilk ve son karakterlerini aralarinda 1 bosluk olacaksekilde listeleyin.
	select CompanyName,Concat(SUBSTRING(CompanyName,1,1),' ',SUBSTRING(CompanyName,LEN(CompanyName),LEN(CompanyName))) from Customers

-- 14) Stok miktari kritik seviyeye veya altina düsmesine ragmen hala siparisini vermedigim ürünler hangileridir?
	select*from Products where UnitsInStock+UnitsOnOrder<=ReorderLevel

-- 15)sisede sattigim ürünler nelerdir?
	select*from Products where QuantityPerUnit like '%bottle%'

-- 16) 30 dolardan fazla ucretli urunlerimi getir..
	select*from Products where UnitPrice>30

-- 17) Londra'da yasayan personellerimn adini soyadini gosteriniz...
	select FirstName,LastName from Employees where City='London'

-- 18) CategoryID'si 5 olmayan urunleri listeleyiniz..
	select*from Categories where CategoryID!=5

-- 19) 01.01.1993'ten sonra ise giren personelleri listeleyiniz...
	select*from Employees where HireDate>'1993-01-01'

-- 20) Mart ayinda alinmis olan siparislerin SiparisID'sini ve SiparisTarihini gosteriniz..
	select OrderID,OrderDate from Orders where DATEPART(month,OrderDate)=3

-- 21) Fiyati küsüratli ürünleri bulun.
	select*from Products where UnitPrice%1!=0

-- 22) Hepsini sattigimda en çok ciro yapacagim aktif ürünlerden ilk 5 tanesi hangisidir?
	select top 5 *, unitprice*UnitsInStock as Ciro  from Products where Discontinued=0  order by Ciro desc

-- 23) Artik satista olmayan en pahali ürünüm hangisidir?
	select top 1 * from Products where Discontinued=1 order by UnitPrice desc

-- 24) Stogu olmasina ragmen artik satisini yapmadigim ürünler hangisidir?
	select  * from Products where Discontinued=1 and UnitsInStock>0

-- 25) ismi birden fazla kelimeden olusan ürünler hangileridir?
	select*from Products where ProductName like '% %'

-- 26) Fax çekemeyecegim tedarikçilerim hangileridir?
	select*from Suppliers where Fax is null 

-- 27) Tedarikçilerim hangi ülkelerden?
	select distinct Country from Suppliers

-- 28) Bolge bilgisi olmayan sirketlerin listesini raporlayiniz...
	select*from Customers where Region is null 

-- 29) Region bilgisi olan personellerimi gosteriniz...
	select*from Employees where Region is not null

-- 30) CategoryID'si 5 olan, urun bedeli 20'den buyuk 300'den kucuk olan, stok durumu null olmayan urunlerimin adlarini ve id'lerini gosteriniz...
	select ProductID,ProductName from Products where CategoryID=5 and UnitPrice between 20 and 300 and UnitsInStock>0

-- 31) 'Dumon' ya da 'Alfki' idlerine sahip olan musterilerden alinmis, 1 nolu personelin onayladigi, 3 nolu kargo firmasi tarafindan gonderilmis ve ShipRegion'u null olan siparisleri gosteriniz...
	select*from orders where  EmployeeID=1 and CustomerID in('dumon','alfki' ) and ShipVia=3 and ShipRegion is null

-- 32) Teslimati Amerika'ya geç kalan siparisler hangileridir?
	select*from orders where RequiredDate<ShippedDate and ShipCountry='USA'

-- 33) En yasli çalisanimin adi ve iletisim bilgileri nelerdir?
	select top 1 concat(FirstName,' ' ,LastName) as AD, HomePhone,Address,City,Region,PostalCode,Country  from Employees order by  DATEDIFF(year,Birthdate,GetDate()) desc

-- 34) Dogum tarihi bu yil için henüz geçmemis çalisanlarimdan dogum tarihi en yakin olan çalisanimi bulun
	select*from Employees where DATEPART(month,BirthDate)>=DATEPART(month,GetDate()) and  DATEPART(day,BirthDate)>=DATEPART(day,GetDate()) order by  DATEPART(day,BirthDate)-DATEPART(day,GetDate()) asc

-- 35) Londra'da yasayan erkek çalisanlarinsirketteki pozisyonlari nelerdir?
	select distinct title from Employees where City='London' and TitleOfCourtesy='Mr.'

-- 36)sirketin sahibi kimdir?
	select*from Employees where ReportsTo is null

-- 37) Patron disinda hangi çalisanlar Fransizca biliyor?
	select*from Employees where Notes like '%French%' and ReportsTo is not null 

-- 38) Teslimati Almanya'ya geç kalan siparisler hangileridir?
	select*from orders where RequiredDate<ShippedDate and ShipCountry='Germany'

-- 39) Henüz teslimati gerçeklesmemis siparisler hangileridir?
	select*from orders where ShippedDate is null 

-- 40) Son teslim edilen 10 siparisi gosteriniz...
	select top 10 *from orders order by ShippedDate desc

-- 41) 1 dolarin altinda kargo ücreti olan siparisler hangileridir?
	select*from Orders where Freight<1

-- 42) Kargo ücreti ucuz diye hala teslim etmedigim siparisler hangileridir? (1 dolarin altindaki kargo ücreti)
	select*from Orders where Freight<1 and ShippedDate is null 

-- 43) En pahali sekilde kargolanan siparis hangisidir?
	select top 1 *from Orders order by Freight desc

-- 44) Son gününde teslim edilen siparisler hangileridir?
	select*from Orders where RequiredDate=ShippedDate

-- 45) 01.11.1997 - 06.06.1998 tarihleri arasindaki siparisleri gosteriniz...
	select*from Orders where OrderDate between '1997-11-01'and '1998-06-06'

-- 46) Bas harfi A olan, stoklarda bulunan, 10-250 dolar arasi ucreti olan urunleri alfabetik olarak siralayiniz..
	select*from Products where ProductName like 'A%' and UnitsInStock>0 and UnitPrice between 10 and 250

-- 47) Carsamba gunu alinan, kargo ucreti 20-75$ arasi olan, shipdate'i null olmayan siparislerin ID'lerini buyukten kucuge siralayiniz...
	select*from orders where FORMAT(ShippedDate,'dddd')='Wednesday' and Freight between 20 and 75 and ShippedDate is not null

-- 48) Stogumda hiç bulunmayip tedarikçilerime siparis verdigim ürünler hangileridir?
	select*from Products where UnitsInStock=0 and UnitsOnOrder>0

-- 49) Stogumda bulunup satisi durdurdugum ürünler hangileridir? 
	select*from Products where UnitsInStock>0 and Discontinued=1

--? 50) Yüksek lisans yapan çalisanlarim hangileridir?
	select*from Employees where  Notes like'%mba%' or TitleOfCourtesy='Dr.'or Notes like '%ma %'