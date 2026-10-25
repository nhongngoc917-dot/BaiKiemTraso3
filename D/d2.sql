-- Câu D2
-- Dự đoán: LỖI;
START TRANSACTION;
INSERT INTO PropertyForRent
VALUES ('PG99', '1 King St', 'Glasgow', 'G1 1AA', 'Flat', 2, 300,
'CO40', 'SG14', 'B009');
ROLLBACK;
-- Kết quả thực tế: "Cannot add or update a child row: a foreign key constraint fails... (0 rows affected)""
-- Ràng buộc liên quan: Lỗi khóa ngoại, tên ràng buộc là propertyforrent_ibfk_2 