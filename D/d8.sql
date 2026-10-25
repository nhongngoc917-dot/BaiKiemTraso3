-- Câu D8
-- Dự đoán: LỖI. 
USE dreamhome;
START TRANSACTION;
    DELETE FROM Branch WHERE branchNo = 'B004';
ROLLBACK;
-- Kết quả thực tế: Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (0 rows affected)
-- Ràng buộc liên quan: Khóa ngoại (FOREIGN KEY) chặn xóa (ON DELETE NO ACTION / RESTRICT).