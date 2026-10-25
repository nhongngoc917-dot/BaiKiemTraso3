-- Câu D10
-- Dự đoán: LỖI/THÀNH CÔNG? 
USE dreamhome;
START TRANSACTION;
    UPDATE Staff SET staffNo = 'SG40' WHERE staffNo = 'SG37';
    SELECT * FROM PropertyForRent WHERE staffNo = 'SG40';
ROLLBACK;
-- Kết quả thực tế: UPDATE báo 1 row affected. SELECT báo 0 row(s) returned (Không có dữ liệu ở bảng con).
-- Ràng buộc liên quan: Khóa ngoại (FOREIGN KEY) 
-- giải thích: Đề cho là ON UPDATE CASCADE. Nhưng khi chạy thử thực tế, lệnh UPDATE thành công nhưng bảng con PropertyForRent KHÔNG tự động cập nhật theo (SELECT ra 0 dòng). 