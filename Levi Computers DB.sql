use master;
GO
if exists(
select *
from sys.databases
where name='Levi Computers')
drop database [Levi Computers]
GO
Create database [Levi Computers];
GO

-----Levi Computers Database------
USE [Levi Computers];
GO

-----Employees Table--------
create table Employees
(
EmployeeID	int	Primary key identity(1,1),
FirstName	Varchar(50)	Not null,
LastName	Varchar(50)	Not null,
Title	Varchar (20)	,
Gender	varchar(2)	Check (Gender in('F','M')),
Phone	Varchar(11)	Check (Phone like ('___-_______')) unique,
Address	Varchar (50)	,
City	Varchar (30),	
Country	Varchar (30),	
BirthDate	Date,	
HireDate	Date	Default getdate()
);
GO

------Categories Table-----
create table Categories
(
CategoryID	int	Primary Key	Identity(10,10),
CategoryName	Varchar(30)	Unique	
);
GO

------Suplliers Table------
create table Suppliers
(
SupplierID	int	Primary Key	Identity(1,1),
CompanyName	Varchar(50)	Not null,	
ContactName	Varchar(50),		
Address	Varchar(50)	,	
City	Varchar(30),		
Country	Varchar(30),		
Phone	Varchar(11)	Check (Phone like ('___-_______')) unique
);	
GO


------Products Table-------
create table Products
(
ProductID	int	Primary Key	Identity(1,1),
ProductName	Varchar(50)	Not null,	
CategoryID	Int	Foreign Key references Categories(CategoryID),	
SupplierID	int	Foreign Key references Suppliers(SupplierID),	
UnitPrice	Money	Default 10,	
UnitsInStock	int	Check (UnitsInStock>0)
);
GO

-----Customers Table------
create table Customers
(
CustomerID	int	Primary Key	Identity (1,1),
FirstName	Varchar(50)	Not null,	
LastName	Varchar(50)	Not null,	
Phone	Varchar(11)	Check (Phone like ('___-_______')) unique,
Address	Varchar(100),		
City	Varchar(50),		
Country	Varchar(50),		
);
GO
 
-----Shippers Table-----
create table Shippers
(ShipperID	int	Primary Key	Identity(1,1),
CompanyName	Varchar(30)	Not null,	
Phone	Varchar(11)	Check (Phone like ('___-_______')) unique
);	
GO

-----Orders Table------
create table Orders
(
OrderID	int	Primary Key	Identity(1000,1),
CustomerID	int	Foreign Key references Customers(CustomerID),	
EmployeeID	int	Foreign key references Employees(EmployeeID),	
OrderDate	Date	Default getdate(),	
ShippedDate	Date	Default dateadd(d,1,getdate()),	
ArrivalDate	Date	Default dateadd(d,10,getdate()),
ShipAddress	Varchar(100)	,	
ShipCity	Varchar(50),		
ShipCountry	Varchar(50),		
ShipperID	int	Foreign key references Shippers(ShipperID)	
);
GO
	
----Order Details Table----
create table [Order Details]
(
OrderID int foreign key references Orders(OrderID),
ProductID int foreign key references Products(ProductID),
Quantity int not null,
UnitPrice money not null,
primary key(OrderID,ProductID)
);
GO


----Insert Employee Table-----
insert into Employees values ('Shahar','Levi','Manager','M','052-3438732',null,'Haifa','Israel','1995-09-14','2021-01-01'),
                             ('Dror','Cohen','Sales Manager','M','054-1244362',null,'Haifa','Israel','1990-12-30','2021-01-01'),
							 ('Shir','Berkovich','Sales Agent','F','052-0934431',null,'Tel Aviv','Israel','1991-04-02','2021-01-19'),
							 ('Noam','Lavi','Sales Agent','M','054-7624521',null,'Tel-Aviv','Israel','1990-07-19','2021-02-01'),
							 ('Moran','Schwartz','Sales Agent','F','052-1134212',null,'Akko','Israel','1989-11-11',default),
							 ('Itzhak','Mizrahi','Sales Agent','M','050-3343221',null,'Kiryat Bialik','Israel','1980-10-10',default),
							 ('Sharon','Dvir','Sales Manager','F','053-3211643',null,'Beer Sheva','Israel','1987-10-12','2021-01-01'),
							 ('Matan','Chen','Sales Agent','M','054-7861260',null,'Dimona','Israel','1991-02-19',default),
							 ('Dvir','Bareket','Sales Agent','M','054-3222112',null,'Ramat Gan','Israel','1986-12-01',default),
							 ('Ron','Malka','Sales Manger','M','052-8874653',null,'Nahariya','Israel','1992-08-17',default),
							 ('Mirit','Ron','Sales Agent','F','050-2238847',null,'Kiryat Shmona','Israel','1990-01-30',default),
							 ('Dan','Turjeman','Sales Manager','M','053-9943882',null,'Eilat','Israel','1983-02-19',default);
GO

------Insert Categories Table--------
insert into Categories values ('PC'),
                              ('Laptops'),
                              ('TVs'),
							  ('Consoles'),
							  ('Smartphones'),
							  ('Printers'),
							  ('Video Games'),
							  ('Removable Disks'),
							  ('Headphones');
GO

------Insert Suppliers Table------
insert into Suppliers values ('Apple','Asaf David',null,'Tel Aviv','Israel','052-9863831'),
                             ('Samsung','Rotem Cohen',null,'Tel Aviv','Israel','050-2234412'),
							 ('HP','Gil Wolf',null,'Tel Aviv','Israel','052-4428732'),
							 ('Canon','Shira Ziv',null,'Tel Aviv','Israel','050-3320973'),
							 ('Brother','Ron Shalom',null,'Haifa','Israel','054-1138472'),
							 ('LG','Tamir Levi',null,'Tel Aviv','Israel','054-3349957'),
							 ('Sony','Amit Cohen',null,'Tel Aviv','Israel','053-8876652'),
							 ('Microsoft','Dvir Levin',null,'Haifa','Israel','050-9836173'),
							 ('Dell','Dana Amos',null,'Haifa','Israel','054-2245564'),
							 ('Asus','Eli Avneri',null,'Tel Aviv','Israel','052-1134429'),
							 ('Lenovo','Dafna Peretz',null,'Tel Aviv','Israel','054-9983421'),
							 ('JBL','Or Fisher',null,'Haifa','Israel','052-1337635'),
							 ('Nintendo','Snir Levi',null,'Kfar Saba','Israel','054-2238745'),
							 ('Philips','Eden Avivi',null,'Haifa','Israel','054-3321231'),
							 ('Xiaomi','Ziv Meir',null,'Tel Aviv','Israel','052-8874532'),
							 ('OnePlus','Ofri Cohen',null,'Tel Aviv','Israel','050-4329817'),
							 ('Sandisk','Meir Levi',null,'Haifa','Israel','053-9981435'),
							 ('Kingston','Adva Dadon',null,'Tel Aviv','Israel','050-9983263');
GO

--------Insert Products Table-----
insert into Products values('Airpods','90','1','600','20'),
                           ('iPhone 11','50','1','2800','10'),
						   ('Airpods Pro','90','1','750','37'),
						   ('iPhone 11 Pro','50','1','3000','13'),
						   ('iPhone 12','50','1','4500','40'),
						   ('iPhone 12 Pro','50','1','5000','21'),
						   ('iPhone 12 Pro Max','50','1','5500','7'),
						   ('MacBook Pro 2017','20','1','6500','12'),
						   ('MacBook Pro 2018','20','1','8000','8'),
						   ('MacBook Pro 2019','20','1','9800','19'),
						   ('MacBook Pro 2020','20','1','12000','23'),
						   ('Pavilion x360','20','3','3400','12'),
						   ('Spectre x360','20','3','6300','8'),
						   ('Pavilion Gaming x360','20','3','5000','4'),
						   ('Laptop 15','20','3','4300','18'),
						   ('Omen 15','20','3','5700','21'),
						   ('Notebook 15','20','3','5600','11'),
						   ('Laptop X415JA','20','10','4400','5'),
						   ('ZenBook Flip','20','10','3200','10'),
						   ('Pro X440A','20','10','2400','6'),
						   ('Vivo Book','20','10','2500','4'),
						   ('Inspiron 14','20','9','2100','9'),
						   ('Vostro 14','20','9','4000','10'),
						   ('XPS 14','20','9','7600','7'),
						   ('V14 ADA','20','11','2500','4'),
						   ('Yoga 14','20','11','4000','9'),
						   ('Thinkpad 15','20','11','4500','17'),
						   ('Galaxy S20 128 GB','50','2','4500','12'),
						   ('Galaxy S20 256 GB','50','2','5200','10'),
						   ('Galaxy S21 128 GB','50','2','5000','10'),
						   ('Galaxy S21 256 GB','50','2','5500','20'),
						   ('OnePlus 8 128 GB','50','16','3000','10'),
						   ('OnePlus 8 256 GB','50','16','3400','12'),
						   ('OnePlus 8 Pro 128 GB','50','16','4000','18'),
						   ('OnePlus 8 Pro 256 GB','50','16','4500','29'),
						   ('OnePlus Nord','50','16','1800','23'),
						   ('OnePlus Buds','90','16','400','22'),
						   ('LG G7','50','6','2800','3'),
						   ('LG V30','50','6','2900','5'),
						   ('HP DeskJet 3790','60','3','1800','9'),
						   ('HP LaserJet Pro','60','3','2400','6'),
						   ('Canon G3411','60','4','2300','11'),
						   ('Canon Pixma G6040','60','4','1500','12'),
						   ('Brother MFC-J5330DW','60','5','800','11'),
						   ('Brother MFCL2710DW','60','5','1200','14'),
						   ('Xiaomi Mi 8','50','15','1500','23'),
						   ('Xiaomi Mi 9','50','15','1700','9'),
						   ('Xiaomi Mi 10','50','15','2000','12'),
						   ('Sandisk USB 32 GB','80','17','60','12'),
						   ('Sandisk USB 64 GB','80','17','75','11'),
						   ('Sandisk USB 128 GB','80','17','100','34'),
						   ('Kingston USB 32 GB','80','18','35','12'),
						   ('Kingston USB 64 GB','80','18','55','11'),
						   ('Kingston USB 128 GB','80','18','80','20'),
						   ('Galaxy Buds','90','2','500','39'),
						   ('Xbox One X','40','8','1500','20'),
						   ('Xbox Series X','40','8','2500','12'),
						   ('Xbox Series S','40','8','1700','20'),
						   ('Playstation 4','40','7','1500','21'),
						   ('Playstation 5','40','7','2500','13'),
						   ('Nintendo Switch','40','13','1200','4'),
						   ('JBL Headphones','90','12','400','19'),
						   ('FIFA 21 XBOX','70','8','220','120'),
						   ('FIFA 21 PS5','70','7','240','130'),
						   ('GTA V XBOX','70','8','170','100'),
						   ('GTA V PS5','70','7','180','34'),
						   ('Call of Duty XBOX','70','8','200','97'),
						   ('Call of Duty PS5','70','7','220','65'),
						   ('Sony Bravia 4K 55"','30','7','2900','10'),
						   ('Sony Bravia 4K 65"','30','7','5000','18'),
						   ('Sony Bravia 4K 75"','30','7','7000','9'),
						   ('Samsung Q70T 4K 55"','30','2','4000','19'),
						   ('Samsung Q80T 4K 65"','30','2','6000','6'),
						   ('Samsung Q90T 4K 75"','30','2','7000','12'),
						   ('LG OLED 4K 55"','30','6','5000','6'),
						   ('LG OLED 4K 65"','30','6','7000','8'),
						   ('Philips LED 4K 55"','30','14','2500','12'),
						   ('Philips LED 4K 65"','30','14','3500','5'),
						   ('Philips LED 4K 75"','30','14','5000','12'),
						   ('HP PC','10','3','1900','4'),
						   ('Asus PC','10','10','2000','6'),
						   ('Lenovo PC','10','11','1800','9');
GO

------Insert Table Customers-----
INSERT INTO Customers([FirstName],[LastName],[Phone],[Address],[City],[Country]) VALUES('Castor','Eaton','054-6324924','P.O. Box 490, 8131 Sollicitudin Avenue','Hoorn','Sao Tome and Principe'),('Colleen','Mcneil','056-1941397','471-4819 Eleifend St.','Kamoke','Ireland'),('Kibo','Mayo','055-0137352','P.O. Box 943, 660 Adipiscing Road','Lebu','Sudan'),('Prescott','Roman','055-9186554','P.O. Box 836, 4614 Sed Rd.','El Bosque','Tonga'),('Cherokee','Finley','057-8491449','7103 Elit Street','Fraserburgh','Cuba'),('Caleb','Merrill','053-7033157','6679 Dui, Avenue','Mayerthorpe','Cocos (Keeling) Islands'),('Merritt','Horn','050-8470176','205-1188 Vivamus Rd.','Chartres','Barbados'),('Channing','Cabrera','051-0162724','Ap #124-201 Dis Rd.','Farrukhabad-cum-Fatehgarh','Togo'),('Erich','Perkins','055-2588867','P.O. Box 868, 2242 Sit Rd.','Ortonovo','Benin'),('Hope','Lowe','050-3838236','P.O. Box 273, 1771 Tellus St.','Singkawang','Uganda');
INSERT INTO Customers([FirstName],[LastName],[Phone],[Address],[City],[Country]) VALUES('Flynn','Morse','051-0030537','382-9112 Nunc Street','Attock','Poland'),('Adena','Sweeney','050-2688653','126-5346 Sed Rd.','Alexandria','Mongolia'),('Phyllis','Barker','051-7122505','Ap #451-1770 Interdum Road','La Rochelle','Albania'),('Jemima','Ramsey','051-4315738','3456 Ut Ave','Villers-lez-Heest','Guernsey'),('Lane','Hoffman','057-8987014','Ap #955-7094 Erat. Road','Cambiago','Reunion'),('Dillon','Kelley','050-2951958','P.O. Box 349, 1161 Dis Rd.','Suarlee','Turkey'),('Colton','Bruce','052-4114776','Ap #475-1733 Vivamus Rd.','Folx-les-Caves','Congo (Brazzaville)'),('Colton','Hart','053-9086949','4566 Neque Rd.','San José de Alajuela','Slovenia'),('Rae','Durham','052-9353873','P.O. Box 599, 3223 Facilisis Avenue','Uddevalla','Kazakhstan'),('Isadora','Benson','050-9468053','4043 Sociis Avenue','Offenbach am Main','Bonaire, Sint Eustatius and Saba');
INSERT INTO Customers([FirstName],[LastName],[Phone],[Address],[City],[Country]) VALUES('Cedric','Simpson','059-8423865','1865 Odio St.','Whitewater Region Township','Sao Tome and Principe'),('Sawyer','Simpson','056-2724391','P.O. Box 908, 9998 Nonummy St.','Grado','Saint Pierre and Miquelon'),('Jamal','Bridges','056-9812690','583-2387 Enim. Rd.','Yongin','Singapore'),('Martin','Montoya','052-0928303','P.O. Box 518, 8350 Nec, Av.','Arbroath','Malawi'),('Victor','Gaines','050-0607577','1914 Magna. Rd.','Ourense','Gibraltar'),('Alexander','Higgins','050-7306430','P.O. Box 803, 568 In Street','Sangju','Anguilla'),('Jemima','Brock','051-6286762','P.O. Box 886, 6985 A, Ave','Bhuj','American Samoa'),('Imogene','Porter','051-5190945','9297 Quis, Rd.','Soacha','Ecuador'),('Davis','Talley','054-2958039','Ap #495-3788 Ipsum Road','Karachi','Samoa'),('Troy','Blankenship','051-7430008','Ap #133-3877 Dignissim Road','Gasteiz','Iceland');
INSERT INTO Customers([FirstName],[LastName],[Phone],[Address],[City],[Country]) VALUES('Tate','Stevens','053-9764538','7208 Metus. Av.','Frankfurt','Oman'),('Jelani','Barry','051-8197148','Ap #603-4283 Risus Road','Matlock','Burkina Faso'),('Phillip','Brock','055-7175935','6254 Vivamus Road','Baardegem','Israel'),('Inga','Burris','055-9089050','P.O. Box 755, 2001 Nisi. St.','Oklahoma City','Saint Kitts and Nevis'),('Brennan','Hinton','052-9162978','Ap #166-9076 Nec St.','Biez','South Africa'),('Olivia','Nicholson','056-9725493','Ap #246-7857 Risus. Street','Hoogeveen','Taiwan'),('Eve','Juarez','053-2902874','194 Amet Road','Tongue','Rwanda'),('Yolanda','Marquez','054-3689385','709-3856 Ipsum Street','Watson Lake','Samoa'),('Freya','Anderson','055-0597814','980-4364 Praesent Road','Elingen','Sweden'),('Delilah','Sexton','054-3073529','Ap #264-8785 Nec Rd.','Haguenau','Mauritius');
INSERT INTO Customers([FirstName],[LastName],[Phone],[Address],[City],[Country]) VALUES('Penelope','Wells','051-4173244','Ap #839-973 Lobortis Av.','Jodoigne-Souveraine','Nepal'),('Emily','Delacruz','056-6703570','190-7341 Suspendisse St.','Silverton','Jersey'),('Stone','Goodwin','050-4327146','Ap #833-8718 Amet, St.','Huntsville','Iraq'),('Rhona','Wynn','056-0357634','Ap #431-4838 Donec Rd.','Nothomb','Afghanistan'),('Fallon','Fitzpatrick','055-4169141','851-5172 Lorem Av.','Baton Rouge','Ukraine'),('Jack','Bond','051-0324654','4698 Sapien Rd.','Davangere','Germany'),('Otto','Gill','052-3905750','P.O. Box 721, 6203 Eros Street','Talgarth','Isle of Man'),('Ebony','Rich','053-9884943','895-3406 Et Av.','Martello/Martell','Egypt'),('Denise','Noble','052-7779236','5986 Donec Ave','Lathuy','Curaçao'),('Bianca','Roberts','059-9735905','Ap #460-6935 Phasellus Av.','Tula','Seychelles');
INSERT INTO Customers([FirstName],[LastName],[Phone],[Address],[City],[Country]) VALUES('Armando','Koch','059-1000288','679-458 Vulputate Road','Pereira','Croatia'),('Hilda','Williams','055-2892526','Ap #237-729 Velit Av.','Dunbar','Suriname'),('Dalton','Leach','059-9951502','4051 Nunc Road','Waardamme','Pitcairn Islands'),('Oleg','Middleton','059-1037228','P.O. Box 508, 6782 Libero Rd.','Sabadell','Equatorial Guinea'),('Keely','Sargent','054-0428075','P.O. Box 900, 7696 Vulputate, Rd.','Villers-la-Ville','Kenya'),('Tatiana','Fleming','059-9215391','P.O. Box 734, 3561 Pede. Av.','Sankt Johann im Pongau','Antigua and Barbuda'),('Kessie','Albert','051-4181670','3437 Non Road','Cholet','Cuba'),('Chancellor','George','053-2514361','704-8571 Sollicitudin St.','Sukabumi','Solomon Islands'),('Declan','Lane','052-7744981','2868 Mauris Rd.','Portland','Namibia'),('Anne','Allen','055-2841066','562 Nulla. Street','Metz','Venezuela');
INSERT INTO Customers([FirstName],[LastName],[Phone],[Address],[City],[Country]) VALUES('Hoyt','Grant','055-1473170','285-5605 Lorem Ave','Greifswald','Cambodia'),('Hedy','Myers','059-7117298','9402 Consectetuer Rd.','La Thuile','Greenland'),('Hamish','Dodson','058-2066852','Ap #973-5577 Risus, Av.','Independencia','Lebanon'),('Travis','Romero','050-9080049','169-6482 Eu, Rd.','Quilpué','Philippines'),('Patricia','Munoz','056-3552737','155 Non, Rd.','Amravati','Suriname'),('Sybil','Vang','053-4284542','6536 Ac Road','Temse','Seychelles'),('Savannah','Bentley','059-8381518','402-379 Netus Av.','Ajax','Israel'),('Xandra','Valenzuela','054-6466090','9191 Laoreet Road','Dera Ismail Khan','Lebanon'),('Erin','Owens','051-5334262','346-2950 Mauris Road','Priero','Tuvalu'),('Fallon','Huffman','051-0763287','702-528 Lobortis Rd.','Rabbi','Burkina Faso');
INSERT INTO Customers([FirstName],[LastName],[Phone],[Address],[City],[Country]) VALUES('Chester','Dixon','058-6428045','424-7440 Semper Rd.','Levin','Bosnia and Herzegovina'),('Hanna','Mills','053-7846659','5264 Aliquam Rd.','Swindon','Bahrain'),('Candace','Peck','051-9471649','784-9807 Eu Road','Schwechat','Lesotho'),('Quin','Gregory','056-8335297','5932 Urna. Ave','White Rock','Niger'),('Thane','Odom','052-4692394','4361 Neque Av.','Cartago','Bahrain'),('Rhoda','Thomas','055-8312258','Ap #642-3495 Est. St.','Harrison Hot Springs','Barbados'),('Rigel','Gould','050-4020200','3075 Mi St.','Sprimont','Faroe Islands'),('Hakeem','Moreno','052-9295736','9091 Ligula. Rd.','Villafranca d''Asti','Puerto Rico'),('Channing','Bradley','057-9551013','P.O. Box 860, 2780 Diam. Avenue','Bournemouth','Turks and Caicos Islands'),('Jeremy','Wilkerson','053-5212703','387-4423 Erat Avenue','Massarosa','Puerto Rico');
INSERT INTO Customers([FirstName],[LastName],[Phone],[Address],[City],[Country]) VALUES('Illana','Douglas','051-7846592','Ap #264-2896 Ridiculus Road','Armstrong','British Indian Ocean Territory'),('Anastasia','Vaughn','050-4867046','Ap #953-4173 Placerat, Rd.','Vauda Canavese','Uruguay'),('Karen','Snyder','051-8576366','P.O. Box 459, 2930 Risus. Rd.','Ferrazzano','Lebanon'),('Tashya','Sims','056-4000637','993 Blandit St.','Esneux','Anguilla'),('Stuart','Valencia','057-4794270','338-1615 Aliquam Ave','Thunder Bay','Tanzania'),('Olga','Henson','053-8518947','7131 Etiam Rd.','Ettelgem','Turkmenistan'),('Dieter','Wilkinson','054-7174436','P.O. Box 740, 4974 Aenean Ave','Pembroke','Nicaragua'),('Scarlett','Johns','058-6754827','264-2759 Odio Rd.','Mesoraca','Namibia'),('Kyle','Hampton','057-9323582','P.O. Box 890, 103 Eu St.','Futrono','Bulgaria'),('Colette','Trujillo','051-6947210','854-3817 Congue, St.','Taber','Martinique');
INSERT INTO Customers([FirstName],[LastName],[Phone],[Address],[City],[Country]) VALUES('Deanna','Daugherty','053-5914025','6891 Ullamcorper, Street','Rothesay','Maldives'),('Adele','Santana','053-4581759','156-8129 Dictum Rd.','Colwood','Chile'),('Eagan','Stewart','059-4078471','Ap #548-4889 Ut Rd.','Maracalagonis','Thailand'),('Astra','Bridges','055-8836842','525-4246 Non, Ave','Sosnowiec','Lebanon'),('Sloane','Glenn','057-1485113','4583 Curabitur Av.','Zwevegem','Marshall Islands'),('Kirsten','Brock','056-7224330','4047 Malesuada Street','Leut','Indonesia'),('Vaughan','Coffey','051-2981003','962-3201 Sodales Av.','Mont','Mozambique'),('Peter','Brooks','050-0505795','144-7656 A Rd.','Milwaukee','Ireland'),('Amela','Vinson','059-1516871','6761 Adipiscing St.','Söderhamn','Korea, South'),('Caldwell','Nash','057-9581655','5535 Lectus Rd.','Quilpué','Germany');

GO

---------Insert Table Shippers------
insert into Shippers values('DHL','054-9932231'),
                           ('UPS','052-3321134'),
						   ('Fed-Ex','052-8837352'),
						   ('E-post','050-2238754');

GO

--------Insert Orders Table---------
insert into Orders values (5,4,'2021-01-02','2021-01-03','2021-01-12','7103 Elit Street','Fraserburgh','Cuba',1),
                          (30,6,default,default,default,'Ap #133-3877 Dignissim Road','Gasteiz','Iceland',2),
						  (12,9,default,default,default,'126-5346 Sed Rd.','Alexandria','Mongolia',1),
						  (56,3,default,default,default,'P.O. Box 734, 3561 Pede. Av.','Sankt Johann im Pongau','Antigua and Barbuda',4),
						  (19,1,'2021-02-01','2021-02-02','2021-02-11','P.O. Box 599, 3223 Facilisis Avenue','Uddevalla','Kazakhstan',2),
						  (80,7,default,default,default,'387-4423 Erat Avenue','Massarosa','Puerto Rico',3),
						  (92,12,default,default,default,'156-8129 Dictum Rd.','Colwood','Chile',1),
						  (43,1,'2021-01-20','2021-01-21','2021-02-13','Ap #833-8718 Amet St.','Huntsville','Iraq',2),
						  (65,4,default,default,default,'155 Non, Rd.','Amravati','Suriname',1),
						  (5,9,default,default,default,'7103 Elit Street','Fraserburgh','Cuba',2),
						  (15,12,default,default,'2021-02-20','Ap #955-7094 Erat. Road','Cambiago','Reunion',3),
						  (44,11,default,default,default,'Ap #431-4838 Donec Rd.','Nothomb','Afghanistan',4),
						  (41,1,'2021-01-10','2021-01-13','2021-01-28','Ap #839-973 Lobortis Av.','Jodoigne-Souveraine','Nepal',1),
						  (19,8,default,default,default,'P.O. Box 599, 3223 Facilisis Avenue','Uddevalla','Kazakhstan',2),
				          (22,9,default,default,default,'P.O. Box 908, 9998 Nonummy St.','Grado','Saint Pierre and Miquelon',4),
						  (76,6,default,default,'2021-03-01','Ap #642-3495 Est. St.','Harrison Hot Springs','Barbados',2),
						  (69,3,default,default,default,'346-2950 Mauris Road','Tuvalu','Priero',1),
						  (99,7,default,default,'2021-02-20','6761 Adipiscing St.','Söderhamn','Korea, South',3),
						  (84,2,default,default,default,'993 Blandit St.','Esneux','Anguilla',1),
						  (40,6,default,default,default,'Ap #264-8785 Nec Rd.','Haguenau','Mauritius',2),
						  (11,4,default,'2021-02-09','2021-03-01','382-9112 Nunc Street','Attock','Poland',4),
						  (23,8,default,default,default,'583-2387 Enim. Rd.','Yongin','Singapore',1),
						  (39,9,default,default,default,'980-4364 Praesent Road','Elingen','Sweden',2),
						  (53,2,default,default,default,'4051 Nunc Road','Waardamme','Pitcairn Islands',3),
						  (59,6,'2021-01-19','2021-01-22','2021-02-09','2868 Mauris Rd.','Portland','Namibia',4),
						  (70,11,default,default,default,'702-528 Lobortis Rd.','Rabbi','Burkina Faso',1),
				          (81,10,'2021-01-03','2021-01-04','2021-01-22','Ap #264-2896 Ridiculus Road','Armstrong','British Indian Ocean Territory',4),
						  (85,7,default,default,default,'338-1615 Aliquam Ave','Thunder Bay','Tanzania',1),
						  (8,8,default,default,default,'Ap #124-201 Dis Rd.','Farrukhabad-cum-Fatehgarh','Togo',3),
						  (43,4,default,default,default,'Ap #833-8718 Amet, St.','Huntsville','Iraq',2),
						  (14,2,default,default,default,'3456 Ut Ave','Villers-lez-Heest','Guernsey',4),
						  (42,4,'2021-02-01','2021-02-03','2021-02-19','190-7341 Suspendisse St.','Silverton','Jersey',2),
						  (33,7,'2021-02-01','2021-02-03','2021-02-19','6254 Vivamus Road','Baardegem','Israel',4),
						  (30,8,'2021-01-03','2021-01-04','2021-01-22','Ap #133-3877 Dignissim Road','Gasteiz','Iceland',1),
						  (3,3,default,default,default,'P.O. Box 943, 660 Adipiscing Road','Lebu','Sudan',1),
						  (36,12,default,default,default,'Ap #246-7857 Risus. Street','Hoogeveen','Taiwan',4),
						  (6,2,default,default,default,'6679 Dui, Avenue','Mayerthorpe','Cocos (Keeling) Islands',2),
						  (61,4,'2021-02-01','2021-02-03','2021-02-19','285-5605 Lorem Ave','Greifswald','Cambodia',3),
						  (14,9,'2021-02-01','2021-02-03','2021-02-19','3456 Ut Ave','Villers-lez-Heest','Guernsey',1),
						  (9,5,'2021-01-03','2021-01-04','2021-01-22','P.O. Box 868, 2242 Sit Rd.','Ortonovo','Benin',4),
						  (97,1,default,default,default,'962-3201 Sodales Av.','Mont','Mozambique',3),
						  (24,7,default,default,default,'P.O. Box 518, 8350 Nec, Av.','Arbroath','Malawi',4),
						  (2,2,'2021-01-03','2021-01-04','2021-01-22','471-4819 Eleifend St.','Kamoke','Ireland',2),
						  (8,10,'2021-01-03','2021-01-04','2021-01-22','Ap #124-201 Dis Rd.','Farrukhabad-cum-Fatehgarh','Togo',1),
					      (12,2,default,default,default,'126-5346 Sed Rd.','Alexandria','Mongolia',2),
						  (17,4,default,default,default,'Ap #475-1733 Vivamus Rd.','Folx-les-Caves','Congo (Brazzaville)',4),
						  (50,1,default,default,default,'Ap #460-6935 Phasellus Av.','Tula','Seychelles',4),
						  (51,6,default,default,default,'679-458 Vulputate Road','Pereira','Croatia',1),
						  (58,9,default,default,default,'704-8571 Sollicitudin St.','Sukabumi','Solomon Islands',1),
						  (63,11,'2021-01-03','2021-01-04','2021-01-22','Ap #973-5577 Risus, Av.','Independencia','Lebanon',3),
						  (65,10,'2021-01-03','2021-01-04','2021-01-22','155 Non, Rd.','Amravati','Suriname',4),
						  (74,3,default,default,default,'5932 Urna. Ave','White Rock','Niger',2);
						 
GO						 
						 
						


-------Insert Order Details Table-------
insert into [Order Details] values(1000,62,1,400),(1001,19,1,3200),(1002,25,1,2500),(1003,24,1,7600),
                                  (1003,63,1,220),(1004,63,1,220),(1005,74,1,7000),(1006,36,1,1800),(1006,68,2,220),
								  (1007,59,1,1500),(1008,62,1,400),(1009,28,1,4500),(1009,55,1,500),(1010,70,1,5000),
								  (1011,1,1,600),(1012,21,1,2500),(1013,10,1,9800),(1014,24,1,7600),(1015,10,1,9800),
								  (1016,2,1,2800),(1017,26,1,4000),(1018,25,1,2500),(1018,1,1,600),(1019,12,1,3400),
								  (1020,19,1,3200),(1021,38,2,2800),(1022,52,3,35),(1022,46,1,1500),(1023,20,1,2400),
								  (1024,19,1,3200),(1025,15,1,4300),(1026,7,1,5500),(1027,44,1,800),(1028,44,1,800),
								  (1029,48,1,2000),(1030,37,1,400),(1031,15,1,4300),(1032,25,1,2500),(1032,19,1,3200),
								  (1033,13,1,6300),(1034,22,2,2100),(1035,15,1,4300),(1036,55,1,500),(1037,44,1,800),
								  (1038,2,1,2800),(1039,1,1,600),(1040,1,1,600),(1040,25,1,2500),(1041,5,1,4500),
								  (1042,5,1,4500),(1043,5,1,4500),(1044,1,1,600),(1045,5,1,4500),(1046,5,1,4500),
								  (1047,16,1,5700),(1048,20,1,2400),(1049,10,1,9800),(1050,10,1,9800),(1051,23,1,4000);
							

	GO							  
