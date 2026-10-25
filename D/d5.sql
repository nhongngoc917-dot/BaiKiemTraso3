-- Câu D5
-- Dự đoán: THÀNH CÔNG. 
USE dreamhome;
START TRANSACTION;
    DELETE FROM Client WHERE clientNo = 'CR56';
    
    -- Xem lại xem bảng con còn dòng nào của CR56 không (phải rỗng)
    SELECT * FROM Viewing WHERE clientNo = 'CR56';
    SELECT * FROM Registration WHERE clientNo = 'CR56';
ROLLBACK;
-- Kết quả thực tế: Lệnh DELETE báo 1 row affected, 2 câu SELECT bên dưới trả về Empty set (không có dòng nào)
-- Ràng buộc liên quan: Khóa ngoại có ON DELETE CASCADE.