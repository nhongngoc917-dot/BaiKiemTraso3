-- Câu D1
-- Dự đoán: LỖI. Lệnh INSERT vi phạm ràng buộc CHECK (vì 'Director' không nằm trong danh sách cho phép). Số dòng bị thay đổi: 0.
START TRANSACTION;
    INSERT INTO Staff
    VALUES ('SG99', 'Tom', 'Daly', 'Director', 'M', '1980-01-01', 20000, 'B003');
ROLLBACK;
-- Kết quả thực tế: Error Code: 3819. Check constraint 'staff_chk_1' is violated. (0 rows affected)
-- Ràng buộc liên quan: Ràng buộc CHECK (staff_chk_1) trên cột position.