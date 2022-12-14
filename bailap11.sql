create database QLSV
GO
USE QLSV

CREATE TABLE LOP(
 MALOP varchar(10) primary key,
 TENLOP nvarchar(40) not null,
 SISO INT NOT NULL
)
GO

CREATE TABLE SINHVIEN(
 MASV VARCHAR(10) PRIMARY KEY,
 HOTEN NVARCHAR(50) NOT NULL,
 NGSINH SMALLDATETIME NOT NULL,
 MALOP VARCHAR(10) NOT NULL
)
GO

CREATE TABLE MONHOC(
 MAMH VARCHAR(10) PRIMARY KEY,
 TENMH NVARCHAR(40) NOT NULL
)
GO

CREATE TABLE KETQUA(
 MASV VARCHAR(10) NOT NULL,
 MAMH VARCHAR(10) NOT NULL,
 DIEMTHI NUMERIC(4,2) NOT NULL,
 constraint PK_KETQUA primary key (MASV,MAMH)
)
GO

ALTER TABLE SINHVIEN ADD CONSTRAINT fk_MALOP FOREIGN KEY(MALOP) REFERENCES LOP(MALOP)
GO

ALTER TABLE KETQUA ADD CONSTRAINT fk_MASV FOREIGN KEY(MASV) REFERENCES SINHVIEN(MASV)
GO

ALTER TABLE KETQUA ADD CONSTRAINT fk_MAMH FOREIGN KEY(MAMH) REFERENCES MONHOC(MAMH)
GO



INSERT INTO LOP(MALOP, TENLOP, SISO) VALUES ('ML01', N'Công nghệ thông tin 1', 6),
                                            ('ML02', N'Công nghệ thông tin 2', 7),
											('ML03', N'Công nghệ thông tin 3', 6),
											('ML04', N'Công nghệ thông tin 4', 7)

INSERT INTO SINHVIEN(MASV, HOTEN, NGSINH, MALOP) VALUES ( '0950080090', N'Nguyễn Văn A', '07-12-2002', 'ML01'),
                                                        ('0950080091', N'Nguyễn Văn B', '09-10-2002', 'ML01'),
                                                        ( '0950080092', N'Nguyễn Văn C','06-05-2002', 'ML01'),
														( '0950080093', N'Nguyễn Văn D', '01-07-2002', 'ML01'),
														( '0950080094', N'Nguyễn Văn E', '02-22-2002', 'ML01'),
														( '0950080095', N'Nguyễn Văn F', '11-08-2002', 'ML01')

INSERT INTO SINHVIEN(MASV, HOTEN, NGSINH, MALOP) VALUES ( '0950080096', N'Tần Thị Thu', '09-12-2002', 'ML02')
INSERT INTO SINHVIEN(MASV, HOTEN, NGSINH, MALOP) VALUES	( '0950080097', N'Nguyễn Văn Tin', '12-18-2002', 'ML02')
INSERT INTO SINHVIEN(MASV, HOTEN, NGSINH, MALOP) VALUES ( '0950080098', N'Nguyễn Thị Tâm', '01-10-2002', 'ML02')
INSERT INTO SINHVIEN(MASV, HOTEN, NGSINH, MALOP) VALUES ( '0950080099', N'Phan Thị Thu Thảo', '07-11-2002', 'ML02')
INSERT INTO SINHVIEN(MASV, HOTEN, NGSINH, MALOP) VALUES ( '0950080100', N'Đào Duy Thanh', '11-09-2002', 'ML02'),
														( '0950080101', N'Nguyễn Thị Bé', '07-05-2002', 'ML02'),
														( '0950080102', N'Nguyễn Văn Khánh', '09-12-2002', 'ML02')

INSERT INTO SINHVIEN(MASV, HOTEN, NGSINH, MALOP) VALUES ( '0950080103', N'Nguyễn Bá Duy', '09-04-2002', 'ML03'),
														( '0950080104', N'Nguyễn Thanh Thúy', '02-02-2002', 'ML03'),
														( '0950080105', N'Trương Hoàng Đoan Trang', '04-02-2002', 'ML03'),
														( '0950080106', N'Nguyễn Thanh Thanh ', '04-30-2002', 'ML03'),
														( '0950080107', N'Phan Quang Anh', '02-03-2002', 'ML03'),
														( '0950080108', N'Nguyễn Thị Hoài', '05-14-2002', 'ML03')

INSERT INTO SINHVIEN(MASV, HOTEN, NGSINH, MALOP) VALUES ( '0950080109', N'Thân Trọng Khôi', '12-12-2002', 'ML04'),
														( '0950080110', N'Phan Văn G', '05-04-2002', 'ML04'),
														( '0950080111', N'Phan Văn H', '05-09-2002', 'ML04'),
														( '0950080112', N'Trần Thị Loan', '05-08-2002', 'ML04'),
														( '0950080113', N'Lê Thị Hoài Thương', '09-17-2002', 'ML04'),
														( '0950080114', N'Nguyễn Ngọc Ngân', '07-22-2002', 'ML04'),
														( '0950080115', N'Huỳnh Thị Kim Ngân', '03-26-2002', 'ML04')

INSERT INTO MONHOC(MAMH, TENMH) VALUES ('MH01', N'Cấu trúc dữ liệu'),
                                       ('MH02', N'Bigdata'),
									   ('MH03', N'Viễn Thám cơ bản'),
									   ('MH04', N'Công nghệ Java'),
									   ('MH05', N'Cơ sở nâng cao')

INSERT INTO KETQUA(MASV, MAMH,DIEMTHI) VALUES ('0950080090','MH01', 7),
                                              ('0950080091','MH01', 4),
											  ('0950080092','MH01', 5),
											  ('0950080114','MH04', 5),
											  ('0950080106','MH05', 8)
INSERT INTO KETQUA(MASV, MAMH,DIEMTHI) VALUES ('0950080106','MH04', 9),
											  ('0950080114','MH05', 7),
											  ('0950080114','MH01', 10),
											  ('0950080106','MH02', 9),
											  ('0950080091','MH02', 9),
											  ('0950080091','MH04', 7)
											  

											  
go
--Câu 1

create function diemtb (@msv varchar(10))
returns float
as
begin
 declare @tb float
 set @tb = (select avg(DIEMTHI)
 from KETQUA
where MaSV=@msv) 
 return @tb
end
go
select dbo.diemtb ('0950080106')

/*Câu 2: Viết hàm bằng 2 cách (table – value fuction và multistatement value function) tính điểm trung bình của 
cả lớp, thông tin gồm MaSV, Hoten, ĐiemTB, sử dụng hàm diemtb ở câu 1*/
go
create function trbinhlop(@malop varchar(10))
returns table
as
return
 select S.MASV, HOTEN, trungbinh=dbo.diemtb(S.MaSV)
 from SINHVIEN S join KETQUA K on S.MASV=K.MASV
 where MALOP=@malop
 group by S.MASV, HOTEN
/*Câu 3.Viết một thủ tục kiểm tra một sinh viên đã thi bao nhiêu môn, tham số là MaSV, (VD sinh viên có MaSV=01
thi 3 môn) kết quả trả về chuỗi thông báo “Sinh viên 01 thi 3 môn” hoặc “Sinh viên 01 không thi môn nào”*/

go
create proc ktra @msv varchar(10)
as
begin 
 declare @L int
 set @L=(select count(*) from KETQUA where MASV=@msv)
 if @L=0 
 print 'sinh vien '+@msv + 'khong thi mon nao'
 else
 print 'sinh vien '+ @msv+ 'thi '+ cast(@L as char(2)) + ' mon '
end 
go
exec ktra '0950080090'

/*Câu 4.Viết một trigger kiểm tra sỉ số lớp khi thêm một sinh viên mới vào danh sách sinh viên thì hệ thống cập
nhật lại siso của lớp, mỗi lớp tối đa 10SV, nếu thêm vào >10 thì thông báo lớp đầy và hủy giao dịch*/

go
create trigger CapNhatLop
on SINHVIEN
for insert
as
begin
 declare @siso int
 set @siso=(select count(*) from SINHVIEN S 
 where MALOP in(select MALOP from inserted))
 if @siso>10
   begin
      print 'Lop day'
      rollback tran
   end
 else
   begin
     update LOP
     set SiSo=@siso
     where MALOP in (select MALOP from inserted)
   end
end

