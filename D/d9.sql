-- Câu D9
-- Dự đoán: THÀNH CÔNG. 
USE dreamhome;
START TRANSACTION;
    UPDATE PropertyForRent SET rent = rent * 1.1 WHERE branchNo = 'B003';
    
    -- Xem lại xem tiền đã tăng chưa
    SELECT propertyNo, rent FROM PropertyForRent WHERE branchNo = 'B003';
ROLLBACK;
-- Kết quả thực tế: Báo 1 row affected
-- Ràng buộc liên quan: Không vi phạm ràng buộc nào.