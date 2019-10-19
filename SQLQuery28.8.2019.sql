
use Northwind
--Yorum Satiri
/* 
Yorum Paragrafi
*/

----T-SQL--------
--DML
--DDL
--TCL

--DML
--CRUD
--Select
--Insert
--Update
--Delete

-------Select-----
--Veriyi Result ekranina tasir.
--Sorgu sonucu olusan datanin atanmasinda kullanilir.

Select 5
Select 5+5

--alias
select 5 as Sonuc
select 5+5 Sonuc

select 'Alafortanfoni' Metin

select 'Gözde'+' '+'Kaya' AdSoyad
select 'Gözde'+' '+'Kaya' [Ad Soyad]

--Result ekrani CTRL+R

--select 'Sinem'+5 hata verir.Tipler arasinda convert ya da cast sureci isletilmeli

--Cast - Convert
select 'Osman' + Cast(5 as varchar(5))
select 'Osman'+Convert(varchar(1),5)

select 'Osman' + Cast(5 as varchar(25))+'Alafortanfoni'
select 'Osman' + Cast(5 as char(25))+'Alafortanfoni'

--Degisken Deklerasyonu
--declare @degiskenAdi as degiskenTipi

declare @Sayi as int 
set @Sayi=5--sorgu icinde kullanilmaz ilk deger atamasi olarak kullanilir
select @Sayi=6--sorguyla beraber atama yapmak icin kullanilir.

--obje uzerinden data okuma
--from 
--select kolonAdi1,kolonAdi2,..... from DatabaseAdi.SchemaAdi.ObjeAdi
--select kolonAdi1...from TabloAdi
select ProductName from Northwind.dbo.Products
select ProductName from Northwind..Products--databasein altindaki tum semalarda arar Products'i arar.

use Northwind
select ProductName from Products
select ProductName,UnitPrice from Products
select*from Products
select*,UnitPrice from Products
select*,UnitPrice*2 IkiKatFiyat from Products
select*,'Alafortanfoni' from Products

--where
--select...from ... where sartlar 
--<,>,!=,<>,<=,>=,=,between
--and, or 
--+,-,/,*,%,

-- stogu 100 den az olan urunleri listeleyiniz.
Select*from Products
Select*from Products where UnitsInStock<100

-- stogu 20 ile 40 arasinda olan urunleri listeleyiniz
select*from Products where UnitsInStock>=20 and UnitsInStock<=40
select*from Products where UnitsInStock between 20 and 40 

select*from Products where 5>4--surekli true verecek
--Id'si 10 olan urun hangisidir 
select*from Products where ProductID=10

--Id'si 10,5,3,25,30,50,23,45 olan urunleri listeleyiniz.

--select*from Products where ProductID=10 or ProductID=5 
select*from Products where ProductID in (10,5,3,25,30,50,23,45)

--Id'si 10,5,3,25,30,50,23,45 olmaan urunleri listeleyiniz.
--not
select*from Products where ProductID not in (10,5,3,25,30,50,23,45)

--Kargolanmamis siparislerin numalarini listeleyiniz.
--select*from Orders where ShippedDate=null seklinde yazilmaz.
select*from Orders where ShippedDate is null

--Kargolanmis siparislerin numalarini listeleyiniz
select*from Orders where ShippedDate is  not null

--Adi Nancy olan calisanin bilgilerini listeleyiniz.
select*from Employees where FirstName='Nancy'

--like
--% : bos ya da herhangi bir karakter dizisi

--Adi North olan musteri bilgilerini listeleyiniz.
select*from Customers where CompanyName like '%NoRtH%'

--Firma ismi A harfi ile baslayan musterileri listeleyiniz.
select*from customers where CompanyName like'A%'

--Firma ismi A harfi ile biten musterileri listeleyiniz.
select*from customers where CompanyName like'%A'

--Firma isimleri a harfi ile baslamayan musterileri listeleyiniz.
select*from customers where CompanyName not like'A%'

--_ :tek karakter yerine gecer.Tek karakter olmasi zorunludur.

--Firma isimlerinde 3.Harfi e olan musterileri listeleyiniz.

select*from Customers where CompanyName like '__e%'

--Firma isimlerinde 3.Harfi e ya da a ya da r ya da g ya da t olan musterileri listeleyiniz.

--select*from Customers where CompanyName like '__e%'or CompanyName like '__a%'...

--[xyz] : icindeki karakterlerden herhangi biri 
select*from Customers where CompanyName like '__[eargt]%'

--[^xyz] : icindeki karakterlerden herhangi biri degil 
--Firma isimlerinde 3.Harfi e ya da a ya da r ya da g ya da t olan,5. harfi b,u,i olmayan musterileri listeleyiniz.
select*from Customers where CompanyName like '__[eargt]_[^bui]%'

--[a-d] : icindeki araliktaki tum harflerden biri 
--[^a-d] : icindeki araliktaki harflerden biri degil

--a'dan f'ye kadar harfler ile baslayan urunleri listeleyiniz.
select*from Products where ProductName like '[a-f]%'

--Tarih surecleri 
--'2019-08-21' Tarih yazim sekli
--'2019' 01.01.2019'a gider
--'2019-08-21 12:37:00'

--GetDate() == DateTime.Now
select GETDATE()

--1996'da alinmis siparisleri listeleyiniz.
select*from Orders WHERE OrderDate between '1996' and '1996-12-31 23:59:59'

--DatePart(secici,tarih)
select*from Orders WHERE DatePart(YEAR,OrderDate)=1996
select*from Orders where Year(OrderDate)=1996

--DateDiff(secici,baslangicTarih,bitisTarih)
--calisanlarimiz kac yasinda ise girmisler
select FirstName,LastName, DATEDIFF(year,BirthDate,HireDate) IseBaslamaYasi
 from Employees 

--Kac gundur ögreniyorsunuz ?
select DATEDIFF(day,'2019-06-26',GETDATE()) KursGunler

--Kac yasindasin ?
select DATEDIFF(year,'1994-03-12',GETDATE())  YAS

--en pahali urun kac dolar ? 
select max(unitprice) from Products

--Hangi ulkelere satis yapiyorum?Kac ulkeye satis yapiyorum?
select distinct Country from Customers--distinc tekrarlari almaz, count'tan daha dogru sonuc verir.
select count(Country) from Customers 

select count(Fax),count(CustomerID) from Customers
--count null degerleri saymaz...
select count(*) from Customers--satirlari sayar

--database'de kayitli ilk 3 calisanimi listeleyiniz.
select top 3 * from Employees

-------------------Sirlamalar-------------------
--order by kolonAdi/alias ile verilen kolon adi asc,desc
--sorgu calistiktan sonra olusan result siralanir

--urunleri fitayina göre pahalidan ucuza siralayiniz.
select*from Products order by UnitPrice desc

--urunleri fitayina göre ucuzdan pahaliya siralayiniz.
select UnitPrice UrunFiyati from Products order by UrunFiyati asc

--En son ise giren eleman kimdir ? 
select top 1 *from Employees order by HireDate desc

--En pahali kargoya sahip siparis ? 
select top 1 *from Orders order by Freight desc

--LONDON'daki musterilerimden isim siralamasina göre ilk 3 tanesini listeleyiniz
select top 3*from Customers where City='london' order by CompanyName 

-------------Union and Union All -----------------
select FirstName+' '+LastName FullName,Title from Employees union
select ContactName ,ContactTitle from Customers

--Region alani null olan sirketler
select CompanyName,ContactName,ContactTitle,[Address],City,Region,PostalCode,Country,Fax,null HomePage from Customers  where Region is null
union all
select CompanyName,ContactName,ContactTitle,[Address],City,Region,PostalCode,Country,Fax, HomePage from Suppliers
 where Region is null

 -------------------Case When---------------(if gibi)
 --1-Deger dinlemeli
 --Case degisken 
 --when deger1 then yapilacaklar1
 --when deger2 then yapilacaklar2
 --.....
 --else yapilacaklarN
 --end

 --Calisan tablomuzda calisanlarin isimlerini,soyisimlerini ve turkce unvanlarini listeleyiniz.
select 
	FirstName,
	LastName,
	--Title,
	(
		case Title
		when'Sales Representative' then 'Satis Temsilcisi'
		when 'Vice President,Sales' then 'Patron'
		when 'Sales Manager' then 'Satis Muduru'
		else 'Satis Koordinatöru'
		end
	) Unvan
from Employees

--2-Sartli Kullanim 
/*
case 
when kosul1 then yapilacaklar1
when kosul1 then yapilacaklar1
....
else yapilacaklarN
end
*/
--urunlerimden stogu;
--20'nin altinda olanlar icin 'Tedarikciden siparis et'
--100'un uzerinde olanlar icin 'Ýnidirim yap'
--digerleri icin 'null'
--uyarilarini veren sorgu

select
	ProductName,
	UnitsInStock,
	( 
	case
	when UnitsInStock<20 then 'Tedarikciden Siparis Et'
	when UnitsInStock>100 then 'Ýndirim yap' 	
	end
	) UyariMesaji
from Products

declare @Mesaj as varchar(50)
select @Mesaj=(Case 
	when UnitsInStock<20 
	then 'Ýndirim Yapilmali' 
	else 'Sorun Yok'
	end) 
 from Products where ProductID=40
 select @Mesaj

 --Fiyati 200 liranin ustunde olan urunler icin stok 3 un ustunde ise 
 --Fiyati 100 liranin ustunde olan urunler icin stok 6 in ustunde ise 
 --Fiyati 5 liranin ustunde olan urunler icin stok 10 un ustunde ise 
 --Fiyati 5 ve 5'in altinda olan urunler icin stok 10000000 un ustunde ise 
 --listele.

 select*
 from Products 
 where UnitsInStock>(case when UnitPrice>200 then 3
							when UnitPrice>100 then 6
							when UnitPrice>5 then 10
							else 10000000
							end)

---------------------------------JOIN-------------------------------
--Sadece iliskili tablolarda kullanilmaz...
--cross join
select*from Products,Categories
order by ProductID

select*from Products 
cross join Categories

--inner join
select*from Products,Categories 
where Products.CategoryID=Categories.CategoryID
order by ProductID

select*from Products p ,Categories c
where p.CategoryID=c.CategoryID
order by ProductID

select*from Products p 
inner join Categories c on p.CategoryID=c.CategoryID
order by ProductID

select*from Products p 
join Categories c on p.CategoryID=c.CategoryID
order by ProductID

select*from Products p 
join Categories c on p.CategoryID=c.CategoryID
join [Order Details] od on p.ProductID=od.ProductID
join Orders o on od.OrderID=o.OrderID
join Customers cu on o.CustomerID=cu.CustomerID

--left join
select*from Products p 
left join Categories c on p.CategoryID=c.CategoryID
order by ProductID

select*from Products p 
left join Categories c on p.CategoryID=c.CategoryID
left join [Order Details] od on p.ProductID=od.ProductID
left join Orders o on od.OrderID=o.OrderID
left join Customers cu on o.CustomerID=cu.CustomerID

--ustteki gibi bir durumda alttakine gitmek daha dogru olur
select*from Customers c 
join Orders o on c.CustomerID=o.CustomerID
join [Order Details] od on od.OrderID=o.OrderID
right join Products p on p.CategoryID=od.ProductID
left join Categories ca on p.CategoryID=ca.CategoryID

--right join

select*from Products p 
right join Categories c on p.CategoryID=c.CategoryID
order by ProductID

--full join
select*from Products p 
full join Categories c on p.CategoryID=c.CategoryID
order by ProductID

--self join 
--17.   Hangi calisanim hangi calisanima rapor veriyor? 
select calisan.FirstName Calisan,
	mudur.FirstName Mudur
from Employees calisan
join Employees mudur on calisan.ReportsTo=mudur.EmployeeID

--Muduru olmayan calisanlar icin left join ile : 
select calisan.FirstName Calisan,
	mudur.FirstName Mudur
from Employees calisan
left join Employees mudur on calisan.ReportsTo=mudur.EmployeeID

----------------AGGREGATE FUNCTIONS-----------------
/*
MAX
MIN
COUNT
SUM
AVG
*/

select max(UnitPrice) from Products
select min(UnitPrice) from Products
select avg(UnitPrice) from Products
select count(*) from Products
select count(ProductID) from Products
select count(Fax) from Customers
select SUM(UnitsInStock) as Stok from Products

--------Math Functions------------------

Select abs(-5)
select floor(3.001),FLOOR(7.999),FLOOR(-2.123)
select ceiling(3.001),ceiling(7.999),ceiling(-2.123)
select power(3,5)
select ROUND(5.2341,2)
select sqrt(16)
select ISNUMERIC('10'),ISNUMERIC('10A')

--UrUn fiyatlarini kusuratsiz olarak listeleyiniz.
select ProductName,FLOOR(UnitPrice) KusuratsizFiyat  from Products

--------String Functions------------------

select ASCII('a')
select char(98)
select charindex('i','Sinem')
select LEFT('SQL Server 2019',7)
select RIGHT('SQL Server 2019',7)
select LEN('SQL server 2019')
select Lower('SQL SERVER 2019')
select upper('sql server 2017')
select LTRIM('       sql server 2017')
select RTRIM('sql server 2017             ')
select NCHAR(12367)
select REPLACE('Wissen Akademie SQL Server 2017-Sinif 503','503','502')
select 'SQL Server' + SPACE(19)+'2019'
select SUBSTRING('SinemOzmen',6,Len('SinemOzmen'))

---------------------GROUP BY(Aitlik)-------------------------------
--kac adet urun satmisim 
select sum(quantity) from [Order Details]

--2017 cirom ne kadar ?
select Sum(od.UnitPrice*od.quantity*(1-od.Discount)) from [Order Details] od 
join orders o on o.OrderID=od.OrderID
where datepart(year,o.OrderDate)=1997

--Urunleri bana kazandirdigi miktarlar ile beraber listeleyiniz.

select p.ProductName , sum(od.unitprice*od.quantity*(1-od.discount)) UrununCirosu from Products p 
left join [Order Details] od on p.ProductID=od.ProductID
group by p.ProductID,p.ProductName

select p.ProductName,od.Quantity from Products p
join [Order Details] od on od.ProductID=p.ProductID
where od.Discount>0 and OrderID>11000
order by p.ProductName

 --Urunleri simdiye kadarki satis adetleriyle beraber listeleyiniz
 select p.ProductName , sum(quantity) as Adet from Products p
 left join [Order Details] od on p.ProductID=od.ProductID
 group by ProductName

--Ciroyu personel bazli gosteriniz.
select 
e.FirstName,
e.LastName,
sum(od.unitprice*od.quantity*(1-od.discount)) UrununCirosu 
from Employees e 
inner join Orders o on  e.EmployeeID =o.EmployeeID
join [Order Details] od on o.OrderID=od.OrderID
group by e.EmployeeID,e.FirstName,e.LastName,e.HomePhone

------------HAVING------------
--Grup by ile birlikte kullanilir.
--Ciroyu personel bazli gosteriniz.Ama cirosu 100000 ustunde olanlar gelsin

select 
e.FirstName,
e.LastName,
sum(od.unitprice*od.quantity*(1-od.discount)) UrununCirosu 
from Employees e 
inner join Orders o on  e.EmployeeID =o.EmployeeID
join [Order Details] od on o.OrderID=od.OrderID
group by e.EmployeeID,e.FirstName,e.LastName,e.HomePhone
having sum(od.unitprice*od.quantity*(1-od.discount)) >100000

--Id'si 5'ten buyuk olan calisanlarimin ulkeler bazinda 5 adetten fazla olan satis adeteri nelerdir?
--ulkelerin satis adetleri
--sadece personel id 5 uzerinde olacak
--ulkenin satisi 5 i gecmeli 

select o.EmployeeID,c.Country,sum(od.Quantity) Adet from Customers c 
join Orders o on c.CustomerID=o.CustomerID
join [Order Details] od on od.OrderID=o.OrderID
group by o.EmployeeID, c.Country
having o.EmployeeID>5 and sum(od.Quantity)>5

-- o.EmployeeID>5 group by yapilmadan da kisit olarak eklenebilir :
select o.EmployeeID,c.Country,sum(od.Quantity) Adet from Customers c 
join Orders o on c.CustomerID=o.CustomerID
join [Order Details] od on od.OrderID=o.OrderID
where o.EmployeeID>5 
group by o.EmployeeID, c.Country
having sum(od.Quantity)>5

--------------------------SubQuery--------------------------
--AMAÇ:Yeniden kullanma , Optimizasyon 

--Yazim yerine gore
--Select Clause
--Table Clause(from)
--Where Clause

--Bagimlilik turune gore 
--basic subQuery:disardaki sorgudan deger almaz
--correlated subquery:disardaki sorgudan deger alýr

--Nancy'nin aldigi siparisleri listeleyiniz.

select o.OrderID from  Orders o
join Employees e on e.EmployeeID=o.EmployeeID
where e.FirstName='Nancy'

select*from Employees
select*from Orders
--13*830 kez join þartý sorulur. 830 kez Nancy þartýný sorar.
select*from Orders where EmployeeID in 
(select EmployeeID from Employees where FirstName='Nancy')


select o.EmployeeID,c.Country,sum(od.Quantity) Adet from Customers c 
join(select OrderID,EmployeeID,CustomerID from Orders where EmployeeID>5) o on c.CustomerID=o.CustomerID/****/
join [Order Details] od on od.OrderID=o.OrderID
group by o.EmployeeID, c.Country
having sum(od.Quantity)>5

--Cirolarý personellere gore listeleyiniz.(AdSoyad,Ciro)
select
	o.EmployeeID,
	(select FirstName from Employees where EmployeeID=o.EmployeeID) Ad,
	(select  LastName from Employees where EmployeeID=o.EmployeeID) Soyad,
	sum(od.unitprice*od.quantity*(1-od.discount)) PersonelinCirosu
from Orders o 
	 join [Order Details] od on od.OrderID=o.OrderID
group by o.EmployeeID

---------------------Insert-Delete-Update----------------------------

Insert into Products values('Aladortanfoni',1,1,'Kelime Kelime',45,3,1,0,0)
Insert into Products values('Alaf',null,null,null,null,null,null,null,0)
Insert into Products(Discontinued,ProductName) values (0,'Fortan')

---------Update---------------------------
select*from Products where CategoryID=2
update Products set CategoryID=3 where CategoryID=2

update Products set ProductName='Þimdi ayvayý yedin.'

update Senetler set Tutar = 100

--Stogu 100'un uzerindeki urunlerde %10 indirim yap
--Stogu 50'nin uzerindekilerde %5 indirim yap
--stogu 20 nin altindakilerde %5 zam yap
--stogu 10 un altindakilerde %10 zam yap

select*from Products where UnitsInStock<20 or UnitsInStock>50
update Products set UnitPrice=(case
								when UnitsInStock>100 then UnitPrice*0.9
								when UnitsInStock>50 then UnitPrice*0.95
								when UnitsInStock>10 then UnitPrice*1.1
								when UnitsInStock<20 then UnitPrice*1.05
								end)
where UnitsInStock<20 or UnitsInStock>50

select*from Products where ProductID=1
update Products set UnitPrice=20,UnitsInStock=29,UnitsOnOrder=20 where ProductID=1

------------------TCL----------------------
begin tran 
commit tran
rollback tran 
------------------Delete---------
select*from Products where ProductID=80
Delete from Products where ProductID=80

-------------------DDL---------------------------
--Create , alter, drop,truncate
--Objeler için yazýlacak 

create objeTipi objeIsmi
alter objeTipi objeIsmi ( add,remove (obje olmayan alt ogeler icin),drop,modify,set) yapilacakIslem

-----------------------DB DDL -------------------

create database AlafortanfoniDB-- default ayarlar ile bir DB olusturur.

create database AlafortanfoniDB2
on --mmf dosyasi icin ozellikler gir
(
Name = 'AlafDB',
FileName='C:\Program Files\Microsoft SQL Server\MSSQL14.SQLSERVER\MSSQL\DATA\AlafDB.mdf',
Size=7MB,
MaxSize=10GB,
FileGrowth=14MB
)
log on 
(
Name = 'AlafLogDB',
FileName='C:\Program Files\Microsoft SQL Server\MSSQL14.SQLSERVER\MSSQL\DATA\AlafLogDB.ldf',
Size=7MB,
MaxSize=10GB,
FileGrowth=14MB

)

alter database AlafortanfoniDB2 set COMPATIBILITY_LEVEL=100
alter database AlafortanfoniDB2 remove file AlafLogDB
drop database AlafortanfoniDB2
--trancate database için kullanýlmaz.

------------------Table DDL----------------------

use AlafortanfoniDB


create table Bolum 
(
	ID int identity(1,1) not null,
	BolumAdi varchar(30) not null,

)

alter table Bolum add Constraint PrimaryKey_Bolum_ID primary key (ID)

create table Ogrenci
(
	ID int identity(1,1) not null,-- sadece null yazilirsa allow null anlamýna gelir.
	Ad varchar(20) not null,
	Soyad varchar(20) not null,
	Telefon char(10) null)
	alter table Ogrenci add BolumID int foreign key references Bolum(ID) default 1 
	alter table Ogrenci add MezuniyetNotu tinyint check(MezuniyetNotu>=0 and MezuniyetNotu<=100)
	alter table Ogrenci add Constraint Unique_Ogrenci_Telefon unique (Telefon)
	alter table Ogrenci	add Constraint PrimaryKey_Ogrenci_Telefon primary key (ID)
	
	alter table Ogrenci add TcKimlikNo char(11)
	alter table Ogrenci add constraint Unique_Ogrenci_TCKN unique(TcKimlikNo)
	--MezuniyetNotu sutununu silebilmek icin once iliskili olan objeler silinir .

	alter table Ogrenci drop Constraint CK__Ogrenci__Mezuniy__3D5E1FD2
	alter table Ogrenci drop column MezuniyetNotu
	alter table Ogrenci drop column BolumID


	--Scriptte asagidaki gibidir:
	--CREATE TABLE [dbo].[Bolum](
	--[ID] [int] IDENTITY(1,1) NOT NULL,
	--[BolumAdi] [varchar](30) NOT NULL,
	--CONSTRAINT [PrimaryKey_Bolum_ID] PRIMARY KEY CLUSTERED on [PRIMARY]

	--Product ,Category ve Suppliers tablolarýný içeren yeni bir DB oluþturunuz.
	create database UrunlerDB
	use UrunlerDB
	create table Product
	(
		ID int identity(1,1) not null,
		ProductName varchar(30) not null,
	
	)
	alter table Product add Constraint PrimaryKey_Product_ID primary key (ID)
	alter table Product add CategoryID int foreign key references Category(ID) default 1 
	--insert into  Northwind..Products(ProductID,ProductName)
	--select ProductID,ProductName from Northwind..Products

	create table Category
	(
		ID int identity(1,1) not null,
		CategoryName varchar(30) not null,
	)
		alter table Category add Constraint PrimaryKey_Category_ID primary key (ID)
		
	create table Suppliers
	(
		ID int identity(1,1) not null,
		SupplierName varchar(30) not null,
	)
		alter table Suppliers add Constraint PrimaryKey_Suppliers_ID primary key (ID)
		alter table Suppliers add ProductID int foreign key references Product(ID) default 1 

--Veri kopyalama.Alttaki sorgu ile kolonlarýn uymasý gerekiyor.
insert into AlafortanfoniDB..Products 
select*from Northwind..Products p 

--sadece productname ve discontinued alýnacak ise 
insert into AlafortanfoniDB..Products (ProductName,Discontinued)
select ProductName,Discontinued from Northwind..Products

--sadece productname ve discontinued farklý serverdan alýnacak ise 
insert into AlafortanfoniDB..Products (ProductName,Discontinued)
select ProductName,Discontinued from [176.43.149.228].Northwind..Products

--herhangi bir sorgu kalýbýnýn sonucu bir update datasý olarak kullanýlabilir.

update AlafortanfoniDB..Products set productname=uzakproduct.Productname
where uzakproduct.categoryID>10

--data transferi ve tablo kopyalama.. Products2 tablosu olusturur ve icine secilen kolonlara ait datalari yazar

select ProductID,ProductName,Discontinued into AlafortanfoniDB..Products2  from AlafortanfoniDB..Products
select*from Products2

---------------------------Trigger (Event)--------------------
--tabloya insert,update yapildiginda,sunu yap gibi 
create table Islemler
(
ID int identity(1,1) not null,
IslemTuru varchar(10) not null,
constraint pk_Islemler primary key (ID)
)
insert into Islemler values('Insert')
insert into Islemler values('Update')
insert into Islemler values('Delete')

create table LogTable
(
ID int identity(1,1) not null,
TabloAdi varchar(Max) not null,
	EskiDeger varchar(Max) not null,
	YeniDeger varchar(max) not null,
	YapilanIslem int not null foreign key references Islemler(ID),
	IslemTarihi DateTime not null
	--IslemYapan int not null foreign key references Users(ID)
)

ALTER TABLE LogTable
ALTER COLUMN EskiDeger  varchar(Max)  null ;
ALTER TABLE LogTable
ALTER COLUMN YeniDeger  varchar(Max)  null ;
--create trigger 
alter trigger Trigger_Insert
on Ogrenci for insert
as 
insert into LogTable(TabloAdi,YeniDeger,YapilanIslem,IslemTarihi)
values('Ogrenci',
(
select'ID='+CAST(ID as varchar(10))+
'Ad='+Ad+
',Soyad='+Soyad+
',Telefon='+Telefon+
',TCKimlikNo='+TcKimlikNo from inserted
),1, GetDate())--insert'in id'si 1 oldugu icin 1 yazildi.

insert into Ogrenci values('Osman','yazici','5059819044','11111111111')
select*from Ogrenci

alter trigger Trigger_Ogrenci_Delete
on Ogrenci for delete
as 
insert into LogTable(TabloAdi,EskiDeger,YapilanIslem,IslemTarihi)
values('Ogrenci',
(
select'ID='+CAST(ID as varchar(10))+
'Ad='+Ad+
',Soyad='+Soyad+
',Telefon='+Telefon+
',TCKimlikNo='+TcKimlikNo+
',IsDeleted='+IsDeleted from deleted
),3, GetDate())
delete from Ogrenci where Ad='Osman'


alter trigger Trigger_Ogrenci_Delete
on Ogrenci for update
as 
insert into LogTable(TabloAdi,EskiDeger,YeniDeger,YapilanIslem,IslemTarihi)
values('Ogrenci',
(
select'ID='+CAST(ID as varchar(10))+
'Ad='+Ad+
',Soyad='+Soyad+
',Telefon='+Telefon+
',TCKimlikNo='+TcKimlikNo+
',IsDeleted='+Cast(IsDeleted as varchar(10)) from deleted),
(select'ID='+CAST(ID as varchar(10))+
'Ad='+Ad+
',Soyad='+Soyad+
',Telefon='+Telefon+
',TCKimlikNo='+TcKimlikNo+
',IsDeleted='+Cast(IsDeleted as varchar(10)) from inserted
),2, GetDate())

insert into Ogrenci values ('Sinem','Ozmen','5333333333','11111111111')
update Ogrenci set Ad='Hulya' where TcKimlikNo='11111111111'
select*from Ogrenci
select*from LogTable

alter table Ogrenci add IsDeleted bit 

create trigger Trigger_Ogrenci_DeleteInsteadOf
on Ogrenci instead of Delete 
as
update Ogrenci set IsDeleted=1 where ID =(select ID from deleted )

delete from Ogrenci where ID = 3 
update Ogrenci set IsDeleted=0

-------------------------Northwind icin Sil Bastan---------------------
create table Islemler
(
ID int identity(1,1) not null,
IslemTuru varchar(10) not null,
constraint pk_Islemler primary key (ID)
)
insert into Islemler values('Insert')
insert into Islemler values('Update')
insert into Islemler values('Delete')

create table LogTable
(
ID int identity(1,1) not null,
TabloAdi varchar(Max) not null,
	EskiDeger varchar(Max) not null,
	YeniDeger varchar(max) not null,
	YapilanIslem int not null foreign key references Islemler(ID),
	IslemTarihi DateTime not null
	--IslemYapan int not null foreign key references Users(ID)
)
alter table LogTable alter column EskiDeger varchar(Max)  null
alter table LogTable alter column YeniDeger varchar(Max)  null

alter table Categories add IsDeleted bit 
update Categories set IsDeleted=0
alter table Categories alter column IsDeleted bit not null

alter trigger Trigger_Categories_Insert
on Categories for Insert
as
Insert into LogTable(TabloAdi,YeniDeger,YapilanIslem,IslemTarihi)
values
(
	'Categories',
	(select
		'CategoryID='+Cast(CategoryID as varchar(40))+
		',CategoryName='+CategoryName+
	---	',Description='+[Description]+
		--',Picture='+Cast(Picture as varchar(max))+
		',IsDeleted='+Cast(IsDeleted as varchar(max))
		from inserted),--tek string haline getirip Yeni Deger hanesine yazacak
		1,
		GETDATE()
)

select*from Categories 

insert into Categories (CategoryName,IsDeleted) values ('Alafortanfoni',0)
select*from LogTable

--update icin:---

create trigger Trigger_Categories_Update
on Categories for update
as 
insert into LogTable(TabloAdi,EskiDeger,YeniDeger,YapilanIslem,IslemTarihi)
values
(	'Categories',
	(select
		'CategoryID='+Cast(CategoryID as varchar(40))+
		',CategoryName='+CategoryName+
		',IsDeleted='+Cast(IsDeleted as varchar(10)) from deleted),
	(select
		'CategoryID='+Cast(CategoryID as varchar(40))+
		',CategoryName='+CategoryName+
	 ',IsDeleted='+Cast(IsDeleted as varchar(10)) from inserted) 
,2, GetDate())

select*from Categories
update Categories set CategoryName='HerhangiBirSey' where CategoryID=1
select*from LogTable

--Delete instead of 

Create trigger Trigger_Categories_DeleteInsteadOf
on Categories instead of Delete
as 
update Categories set IsDeleted=1 where CategoryID=(select CategoryID from deleted)

delete from Categories where CategoryID=9 --calisacak ama silmeyecek 
--Asagidaki kod calisinca northwind tablosundan artýk herhangi bir table drop edilemez: 
create Trigger Trigger_Northwind_NoTableDrop
on database for Drop_Table
as
rollback
raiserror('Tablo silme islemi yapilamaz',16,1)

Create table Deneme
(
ID int
)
drop table Deneme
--yeniden silme isleminin yapilabilmesi icin trigger disable edilebilir veya trigger objesi silinebilir.
disable trigger Trigger_Northwind_NoTableDrop on database 



-----------------------View---------------------------------------------
--Sorgunun saklanmis hali
--Raporlama icin surekli kullanilacak sorgularda
--Verinin guvenli paylasimi 
--Join yoksa insert icinde kullanilabilir
--Kolon tekrari yapilmamalidir
--Order by,top ile beraber kullanilmali
--icinde temp table kullanilmaz

create view VW_ViewIsmi
with encryption--(View i kitler.)
with schemabinding --(Sorgu icinde kullanilan tablolari korur.Schema yazilmasi zorunludur.
as
sorgu
with check option 


--Kargolanmamis urunler 

create view VW_KargoBekleyenler
with schemabinding 
as 
select OrderID,ShipCity,ShipCountry,ShipName from dbo.Orders
where ShippedDate is null 

select*from VM_KargoBekleyenler

--Uzak makinedeki server uzerinden personellerin cirolarinin cekilmesi.

create view VW_PersonelCirosu
with encryption
as 
select e.FirstName,e.LastName,sum(od.Quantity*od.UnitPrice*(1-od.Discount)) Ciro from Employees e
left join Orders o on e.EmployeeID=o.EmployeeID
join [Order Details] od on od.OrderID=o.OrderID
group by e.EmployeeID,e.FirstName,e.LastName

alter Schema Alafortanfoni Transfer dbo.VW_PersonelCirosu
--Kendi sistemine gectikten sonra ServerObjects->Linked Servives->New Linked Server-> Security -> erp olarak olusturulan 
--log in bilgilerini gir .

--Kendi sistemimizde 

select*from [176.43.149.228].Northwind.Alafortanfoni.VW_PersonelCirosu v
join Employees e on v.Ad=e.FirstName

--urunlerin cirosu 
create view Wissen_502.VW_UrunCirosu 
as
select 
	p.ProductName,
	sum(od.Quantity*od.UnitPrice*(1-od.Discount)) Ciro 
from Products p 
join [Order Details] od on p.ProductID=od.ProductID
group by p.ProductID,p.ProductName

--Kargolanmasi gecikmis siparislerin kac gün geciktikleri ile beraber listesi
create view VW_TeslimatiGecikmisler2
with schemabinding
as
select OrderID,
(case
 when ShippedDate is not null then datediff ( day, RequiredDate,ShippedDate)
 else  datediff ( day, RequiredDate,GetDate())
 end)Gecikme
 from dbo.Orders --schemabinding yapildigi icin schema(dbo) eklendi.
 where RequiredDate<ShippedDate or (RequiredDate<GetDate() and ShippedDate is null)
 
 select*from  VW_TeslimatiGecikmisler2



--En az satilan 3 urun
create view VW_EnAzSatilanUrun
as
select top  3 
od.ProductID,
sum(od.Quantity) Adet,
(select p.ProductName from Products p  where od.ProductID=p.ProductID) UrunAdi
from [Order Details] od  
group by od.ProductID
order by sum(od.Quantity) asc

select*from VW_EnAzSatilanUrun

--Kategorilerin cirolarinin dagilimini % oran olarak listeleyiniz.


create view VW_KategoriCiroOranDagilim
with schemabinding
as
Select 
c.CategoryName, 
round(sum(od.Quantity*od.UnitPrice*(1-od.Discount))/(select sum(od.Quantity*od.UnitPrice*(1-od.Discount)) from dbo.[Order Details] od)*100,2) Oran 
from
	 dbo.[Order Details] od
	join dbo.Products p on od.ProductID=p.ProductID
	right join dbo.Categories c on p.CategoryID=c.CategoryID
group by c.CategoryID,c.CategoryName

select*from VW_KategoriCiroOranDagilim


--1997 yili baz alinarak ayni satislarin 1998 yilinda da yapilacagi on gorulmustur.
--Bu durumda 1998 yilinda satislari ve stogu cikarildiginda urunlerden kacar adet daha tedarik edilmesi gerektigini listeleyiniz.
--(ilgili hedefe ulasmis olanlarin listelenmemesi gerekmektedir.)

select ProductID,Adet1997-Adet1998 SiparisAdedi from
	(select
		od.ProductID,	
		sum(od.Quantity)+
		(select UnitsinStock+UnitsOnOrder from Products where ProductID=od.ProductID) Adet1998,
		(select SatisAdedi
		from ( select
					od.ProductID,
					sum(od.Quantity) SatisAdedi
					from
					[Order Details] od 
					join Orders o on o.OrderID=od.OrderID
					where Year(o.OrderDate)='1997'
					group by od.ProductID) t 
		where ProductID=od.ProductID) Adet1997
		from [Order Details] od 
		join Orders o on o.OrderID=od.OrderID
		where Year(o.OrderDate)='1998'
		group by od.ProductID) t2
where Adet1997>Adet1998 or Adet1998 is null


--Query,Convert,Optimizer,Compile,Execute,Result
--Yorumlanan bir dilde yukaridaki adimlar izlenerek sira ile calisir.
--View'da Query,Convert,Optimizer,Compile adimlar hazir olarak bekler ve daha hizli calisir.
		

-----------------------Function-----------------------------------------
-- Geri donus zorunludur.
-- Sorgu icinde kullanilabilir.(Select clause)

create Function functionAdi
(
	@parametre1 tip,
	@parametre2 tip
)
returns donusTipi
as
begin
	kodlar
	return donusDegeri
end

--Verilen 2 metinsel ifadeyi , aralarinda 1 bosluk olacak sekilde birlestiren function yazin.

create Function Function_MetinBirlestir
(
	@Metin1 varchar(max),
	@Metin2 varchar(max)
)
returns varchar(max)
as
begin
	return  @Metin1+' '+ @Metin2
end

select dbo.Function_MetinBirlestir(FirstName,LastName) AdSoyad from Employees

--Metnin son kelimesini veren function 
select CHARINDEX('f','alafortanfoni',5)


create function Function_SonKelimeAl
(
	@Metin varchar(max)
)
returns varchar(max)
begin
	declare @Index as int = 0
	declare @TempIndex as int = 0
	set @Metin=TRIM(@Metin)
	while 5>4
	begin
		set	@TempIndex= CHARINDEX(' ',@Metin,@Index+1)--okuyamazsa temp index 0 olacak 
		if(@TempIndex>0)
			begin 
			set @Index=@TempIndex
			end
		else 
			begin
				break
			end
	end
	return substring(@Metin,@Index+1,Len(@Metin)-@Index)
end

select dbo.Function_SonKelimeAl('yeni bir hesap olustur ve sadece ilgili hesaba DB yetkisi ver.') 


-----------------------Stored Procedures--------------------------------
--Alt program gibidir.
--Geri donus sabit deger bazli olmaz.(result bazli olur.)
--Sorgu icinde kullanilmaz.

create procedure sp_ProcedureIsmi
(
	@Parameter1 Tip1,
	@Parameter2 Tip2
)
with encryption,recompile
as 
begin 
	sorgular...
end

--ID'si verilmis olan urunun toplam satis adetini veren sp

alter procedure sp_SatisAdedi
(
	 @ProductID as int
)
as
Begin
	select Sum(Quantity) SatisAdedi from [Order Details]
	where ProductID=@ProductID
	print 'Cavabi Result ekranina aktarildi.'
End

select sp_SatisAdedi(5) -- bu sekilde calistirilamaz

execute sp_SatisAdedi 5 
exec sp_SatisAdedi 5 
sp_SatisAdedi 5 


--Calisanlarin sadece ad,soyad ve yaslarini donen sp
create procedure sp_CalisanYas
as
begin
	select FirstName,LastName,DateDiff(year,Birthdate,GetDate()) Yas from Employees
end

sp_CalisanYas


--ID'si verilen kategorinin icinde bulunan urunlerin adini listeleyen sp 

create procedure sp_ProductByCategoryID
(
@categoryID int 
)
as
begin
	Select productName from Products p where p.CategoryID=@categoryID 
end

exec sp_ProductByCategoryID 1

--ProductName,UnitPrice,UnitsinStock degerlerini alýp Discontinued degerini default olarak 0 atayip insert islemi yapan sp
alter procedure sp_ProductInsert
(
	@ProductName nvarchar(40),
	@UnitPrice money,
	@UnitsinStock smallint,
	@Discontinued bit=0,
	@IslemYapanKullaniciID int = null 
)
as
begin
	insert into Products(ProductName,UnitPrice,UnitsInStock,Discontinued)
	values ( @ProductName,@UnitPrice,@UnitsinStock,@Discontinued)

	insert into LogTable(TabloAdi,YeniDeger,YapilanIslem,IslemTarihi,IslemYapanKullaniciID)
	values('Product',
	(select
		'ProductID='+CAST(ProductID as varchar(max))+
		',ProductName='+ProductName,
		',SupplierID='+Cast(SupplierID as varchar(max))+
		',CategoryID='+CAST(CategoryID as varchar(max))+
		',QuantityPerUnit='+(case when QuantityPerUnit is not null then CAST(QuantityPerUnit as varchar(max)) else 'null' end)+
		',UnitPrice='+CAST(UnitPrice as varchar(max))+
		',UnitsinStock='+CAST(UnitsinStock as varchar(max))+
		',UnitsonOrder='+CAST(UnitsOnOrder as varchar(max))+
		',ReorderLevel='+CAST(ReorderLevel as varchar(max))+
		',Discontinued='+CAST(Discontinued as varchar(max))

	from Products where ProductID=@@IDENTITY),
	1,GetDate())
end

exec sp_ProductInsert 'Domates',5,10

select*from Products
----------------------ID YAKALAMA-------------------------
@@Identity -- global degisken, sistem uzerindeki son girilen kaydin id sini verir.
scope_identity()-- scope icinde son olusan id  
ident_current('TabloIsmi')-- tabloya sorarak son olusan id 

--ID'si verilen urunu silen sp (IsDeleted True seklinde) 

alter procedure sp_DeleteByID
(
	@ProductID int
)
as
begin 
	delete from Products where ProductID=@ProductID
end

exec sp_DeletebyID 5

--CategoryName ve ProductName verilerini alip hem Categories hem de ona bagli vaziyette Products tablosuna insert yapan sp

create procedure sp_InsertCategoryandProduct
(
	 @CategoryName nvarchar(15),
	 @ProductName nvarchar(40),
	 @Discontinued bit =0
)
as
begin
	insert into Categories(CategoryName) values (@CategoryName) 
	insert into Products(ProductName,CategoryID,Discontinued) values (@ProductName,@@IDENTITY,@Discontinued)
	 --@@identity sistemde olusan son ID'yi verir 
	 -- trigger olsaydi trigger'dan gelen Id'yi vererek yanlis ID alinmis olur.
	 --Bu durumda scope_identity kullanacaktik.Eger ayni scope'ta da olmasaydi ident_current kullanilirdi.
end

exec sp_InsertCategoryandProduct 'Cikolata','Toblerone'

--CLustered index ve index arasindaki fark nedir ?
--Neden index kullaniriz ? 





























 

































