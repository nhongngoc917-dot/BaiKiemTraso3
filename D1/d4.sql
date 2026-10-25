-- Câu D4
-- Dự đoán: THÀNH CÔNG. 
START TRANSACTION;
    INSERT INTO Registration (clientNo, branchNo, staffNo)
    VALUES ('CR74', 'B005', 'SL41');
    
    -- Xem lại kết quả sau khi chèn
    SELECT * FROM Registration WHERE clientNo = 'CR74';
ROLLBACK;
-- Kết quả thực tế: 1 row affected. Bảng kết quả select hiện ra 1 dòng của CR74, cột dateRegister tự động có ngày tháng năm hiện tại.
-- Ràng buộc liên quan: Ràng buộc default trên cột DateRegister.