-- Câu D6
-- Dự đoán: THÀNH CÔNG. 
START TRANSACTION;
    DELETE FROM Staff WHERE staffNo = 'SG14';
    
    -- Check bảng con xem thằng staffNo có bị NULL không
    SELECT * FROM PropertyForRent WHERE staffNo IS NULL; 
ROLLBACK;
-- Kết quả thực tế: Lệnh DELETE báo 1 row affected
-- Ràng buộc liên quan: Khóa ngoại (Foreign key) có thuộc tính ON DELETE SET NULL.