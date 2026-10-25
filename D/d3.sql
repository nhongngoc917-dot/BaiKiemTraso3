-- Câu D3
-- Dự đoán: LỖI. 

USE dreamhome;
START TRANSACTION;
    INSERT INTO Viewing
    VALUES ('CR56', 'PA14', '2013-06-01', 'second visit');
ROLLBACK;
-- Kết quả thực tế: Error Code: 1062. Duplicate entry 'CR56-PA14-2013-06-01' for key 'viewing.PRIMARY' (0 rows affected)
-- Ràng buộc liên quan: Khóa chính (Primary key) của bảng Viewing.