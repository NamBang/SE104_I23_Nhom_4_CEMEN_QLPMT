CREATE DATABASE QLPM4
USE QLPM4
SET DATEFORMAT DMY
/*
BENHNHAN(mabn, mapkb, hoten, gtinh, nsinh, dchi)
THUOC(mathuoc, tenthuoc, donvi, gia, cachdung)
PHIEUKB(mapkb, mabn, mahd, mabenh, trieuchung, ngaykham, tienkham)
HOADON(mahd, mapkb, tienthuoc, tienkham, tongtien)
CTPHIEUKB(mact, mapkb, mathuoc, sluong, cachdung, donvi)
BENH(mabenh, tenbenh)
*/
CREATE TABLE TaiKhoan(
	username	NVARCHAR(50) PRIMARY KEY NOT NULL,
	tenhienthi	NVARCHAR(50) NOT NULL,
	password	NVARCHAR(50) NOT NULL,
	TYPE INT NOT NULL
)  
CREATE TABLE BenhNhan(
	mabn		NVARCHAR(4) PRIMARY KEY NOT NULL,
	mapkb		NVARCHAR(4) NOT NULL,
	hoten		NVARCHAR(50) NOT NULL,
	gioitinh	NVARCHAR(3) NOT NULL,
	namsinh		INT NOT NULL,
	diachi		NVARCHAR(100) NOT NULL,
)
CREATE TABLE Thuoc(
	mathuoc		NVARCHAR(4) PRIMARY KEY NOT NULL,
	tenthuoc	NVARCHAR(50) NOT NULL,--30loai
	cachdung	NVARCHAR(100) NOT NULL,
	donvi		NVARCHAR(50) NOT NULL,--2 loai
	dongia		FLOAT NOT NULL DEFAULT 0,
)
CREATE TABLE Benh(
	mabenh		NVARCHAR(4) PRIMARY KEY NOT NULL,
	tenbenh		NVARCHAR(50) NOT NULL,
)
CREATE TABLE PhieuKB(
	mapkb		NVARCHAR(4) PRIMARY KEY NOT NULL,
	mabn		NVARCHAR(4) NOT NULL,
	mabenh		NVARCHAR(4) NOT NULL,
	mahd		NVARCHAR(4) NOT NULL,
	trieuchung	NVARCHAR(100) NOT NULL,--4cach
	ngaykham	DATE,
	tienkham	FLOAT,
	FOREIGN KEY (mabenh) REFERENCES Benh(mabenh),
	FOREIGN KEY (mabn) REFERENCES BenhNhan(mabn),
)  
CREATE TABLE CTPhieuKB(
	mact		NVARCHAR(4) PRIMARY KEY NOT NULL,
	mapkb		NVARCHAR(4) NOT NULL,
	mathuoc		NVARCHAR(4) NOT NULL,
	soluong		INT,
	cachdung	NVARCHAR(100) NOT NULL,
	donvi		NVARCHAR(10) NOT NULL,
	gia			FLOAT DEFAULT 0,
	FOREIGN KEY (mapkb) REFERENCES PhieuKB(mapkb),
	FOREIGN KEY (mathuoc) REFERENCES Thuoc(mathuoc),
)  
CREATE TABLE HoaDon(
	mahd		NVARCHAR(4) PRIMARY KEY NOT NULL,
	mapkb		NVARCHAR(4) NOT NULL,
	tienkham	FLOAT NOT NULL DEFAULT 0,
	tienthuoc	FLOAT NOT NULL DEFAULT 0,
	tongtien	FLOAT NOT NULL DEFAULT 0,
	FOREIGN KEY (mapkb) REFERENCES PhieuKB(mapkb),
--	FOREIGN KEY (mabn) REFERENCES BenhNhan(mabn)
)

--CONSTRAINT------------------------------------------------------------------------------
ALTER TABLE BenhNhan
ADD  CONSTRAINT cont1
CHECK(gioitinh IN (N'Nam',N'Nữ'))

ALTER TABLE Thuoc
ADD  CONSTRAINT Cont2
CHECK(donvi IN (N'Chai',N'Viên'))

ALTER TABLE PhieuKB
ADD  CONSTRAINT Cont3
FOREIGN KEY (mahd) REFERENCES HoaDon(mahd),
--ADD DATA--------------------------------------------------------------------------------
--Benh Nhan
INSERT INTO BenhNhan VALUES('BN01',N'Phạm Hoài Phương',	N'Nam',1997,N'Thủ Đức')
INSERT INTO BenhNhan VALUES('BN02',N'Trần Nam Bàng',	N'Nam',1997,N'Bình Thạnh')
INSERT INTO BenhNhan VALUES('BN03',N'Lê Vũ Trùng Dương',N'Nam',1997,N'Bình Tân')
--Thuoc
INSERT INTO Thuoc VALUES('Th01',N'',N'Uống',N'Viên',69000)
--Benh
INSERT INTO Benh VALUES('B01',N'Sốt')
INSERT INTO Benh VALUES('B02',N'Dị ứng')
INSERT INTO Benh VALUES('B03',N'Đau dạ dày')
INSERT INTO Benh VALUES('B04',N'Viêm họng')
--Phieu Kham Benh
INSERT INTO PhieuKB VALUES('PK01','BN04','B01','HD01', N'Buồn nôn','19/4/2018', 30000)
--CTPhieuKB
INSERT INTO CTPhieuKB VALUES('CT01','PK01','Th01',10, N'',N'',6000)
--HoaDon
INSERT INTO HoaDon VALUES('HD01','PK01',30000,0,30000)