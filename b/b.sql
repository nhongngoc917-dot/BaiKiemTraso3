-- ==========================================
-- CÂU B1: TẠO VÀ CHỌN CSDL
-- ==========================================
-- Xóa CSDL cũ nếu tồn tại để script có thể chạy lại nhiều lần
DROP DATABASE IF EXISTS DREAMHOME;
CREATE DATABASE DREAMHOME;
USE DREAMHOME;

-- ==========================================
-- CÂU B2: TẠO 7 BẢNG VÀ ĐẶT TÊN RÀNG BUỘC
-- ==========================================

-- 1. Bảng Branch
CREATE TABLE Branch (
    branchNo CHAR(4) NOT NULL,
    street VARCHAR(50) NOT NULL,
    city VARCHAR(30) NOT NULL,
    postcode VARCHAR(10),
    CONSTRAINT PK_Branch PRIMARY KEY (branchNo)
);

-- 2. Bảng Staff
CREATE TABLE Staff (
    staffNo CHAR(5) NOT NULL,
    fName VARCHAR(30) NOT NULL,
    lName VARCHAR(30) NOT NULL,
    position VARCHAR(15) NOT NULL,
    sex CHAR(1),
    DOB DATE,
    salary DECIMAL(9,2) NOT NULL,
    branchNo CHAR(4) NOT NULL,
    CONSTRAINT PK_Staff PRIMARY KEY (staffNo),
    CONSTRAINT CK_Staff_position CHECK (position IN ('Manager', 'Supervisor', 'Assistant')),
    CONSTRAINT CK_Staff_sex CHECK (sex IN ('M', 'F')),
    CONSTRAINT CK_Staff_salary CHECK (salary > 0),
    CONSTRAINT FK_Staff_Branch FOREIGN KEY (branchNo) REFERENCES Branch(branchNo) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- 3. Bảng PrivateOwner
CREATE TABLE PrivateOwner (
    ownerNo CHAR(5) NOT NULL,
    fName VARCHAR(30) NOT NULL,
    lName VARCHAR(30) NOT NULL,
    address VARCHAR(60) NOT NULL,
    telNo VARCHAR(15),
    eMail VARCHAR(50),
    CONSTRAINT PK_PrivateOwner PRIMARY KEY (ownerNo)
);

-- 4. Bảng PropertyForRent
CREATE TABLE PropertyForRent (
    propertyNo CHAR(5) NOT NULL,
    street VARCHAR(50) NOT NULL,
    city VARCHAR(30) NOT NULL,
    postcode VARCHAR(10),
    type VARCHAR(10) NOT NULL,
    rooms INT NOT NULL,
    rent DECIMAL(9,2) NOT NULL,
    ownerNo CHAR(5) NOT NULL,
    staffNo CHAR(5),
    branchNo CHAR(4) NOT NULL,
    CONSTRAINT PK_PropertyForRent PRIMARY KEY (propertyNo),
    CONSTRAINT CK_Property_type CHECK (type IN ('House', 'Flat')),
    CONSTRAINT CK_Property_rooms CHECK (rooms BETWEEN 1 AND 15),
    CONSTRAINT CK_Property_rent CHECK (rent > 0),
    CONSTRAINT FK_Property_Owner FOREIGN KEY (ownerNo) REFERENCES PrivateOwner(ownerNo) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Property_Staff FOREIGN KEY (staffNo) REFERENCES Staff(staffNo) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT FK_Property_Branch FOREIGN KEY (branchNo) REFERENCES Branch(branchNo) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- 5. Bảng Client
CREATE TABLE Client (
    clientNo CHAR(5) NOT NULL,
    fName VARCHAR(30) NOT NULL,
    lName VARCHAR(30) NOT NULL,
    telNo VARCHAR(15) NOT NULL,
    prefType VARCHAR(10),
    maxRent DECIMAL(9,2),
    eMail VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Client PRIMARY KEY (clientNo),
    CONSTRAINT UQ_Client_eMail UNIQUE (eMail),
    CONSTRAINT CK_Client_prefType CHECK (prefType IN ('House', 'Flat')),
    CONSTRAINT CK_Client_maxRent CHECK (maxRent > 0)
);

-- 6. Bảng Viewing
CREATE TABLE Viewing (
    clientNo CHAR(5) NOT NULL,
    propertyNo CHAR(5) NOT NULL,
    viewDate DATE NOT NULL,
    comment VARCHAR(100),
    CONSTRAINT PK_Viewing PRIMARY KEY (clientNo, propertyNo),
    CONSTRAINT FK_Viewing_Client FOREIGN KEY (clientNo) REFERENCES Client(clientNo) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Viewing_Property FOREIGN KEY (propertyNo) REFERENCES PropertyForRent(propertyNo) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 7. Bảng Registration
CREATE TABLE Registration (
    clientNo CHAR(5) NOT NULL,
    branchNo CHAR(4) NOT NULL,
    staffNo CHAR(5) NOT NULL,
    dateJoined DATE NOT NULL DEFAULT (CURRENT_DATE), -- MySQL dùng CURRENT_DATE thay cho GETDATE() của SQL Server
    CONSTRAINT PK_Registration PRIMARY KEY (clientNo, branchNo),
    CONSTRAINT FK_Registration_Client FOREIGN KEY (clientNo) REFERENCES Client(clientNo) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Registration_Branch FOREIGN KEY (branchNo) REFERENCES Branch(branchNo) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_Registration_Staff FOREIGN KEY (staffNo) REFERENCES Staff(staffNo) ON DELETE NO ACTION ON UPDATE CASCADE
);

-- ==========================================
-- CÂU B3: GIẢI THÍCH (CHÚ THÍCH)
-- ==========================================
-- (a) Vì sao FK_Property_Staff chọn ON DELETE SET NULL:
-- Vì một căn nhà (Property) có thể chưa được phân công cho nhân viên nào quản lý (staffNo = NULL). 
-- Khi nhân viên đó nghỉ việc (bị xóa khỏi bảng Staff), căn nhà vẫn phải tồn tại để tiếp tục cho thuê, 
-- do đó chỉ cần set staffNo của căn nhà đó thành NULL (chưa có người quản lý) chứ không được xóa luôn căn nhà.

-- (b) Vì sao mọi khóa ngoại đến Branch đều là NO ACTION cho cả xóa và sửa:
-- (Theo lý thuyết SQL Server về "Multiple Cascade Paths" - Nhiều đường lan truyền).
-- Nếu ta đặt CASCADE cho các bảng cùng trỏ đến Branch, việc xóa/sửa một Branch có thể kích hoạt 
-- việc xóa/sửa lan truyền đồng thời qua nhiều đường (ví dụ: xóa Branch -> xóa Staff -> xóa Property). 
-- Điều này gây ra lỗi vòng lặp hoặc xung đột đường dẫn (Multiple Cascade Paths) trong SQL Server. 
-- Do đó, SQL Server bắt buộc các FK đến cùng một bảng cha phải là NO ACTION.