# 🏢 Cơ Sở Dữ Liệu Quản Lý Bất Động Sản DreamHome

Dự án này chứa các câu lệnh SQL phục vụ cho bài tập / đồ án môn học Cơ sở dữ liệu, thao tác trên cơ sở dữ liệu quản lý cho thuê nhà **DreamHome**. 

Dự án tập trung vào việc thực thi các truy vấn SQL, kiểm tra các **ràng buộc toàn vẹn (Integrity Constraints)**, xử lý giao dịch (**Transactions**) và kiểm thử các lỗi vi phạm dữ liệu (Khóa chính, Khóa ngoại,...).

---

## 📌 Nội Dung Dự Án

* **Khởi tạo & Dữ liệu:** Tạo các bảng chính (`Branch`, `Staff`, `PropertyForRent`, `Client`, `PrivateOwner`, `Viewing`, `Registration`) và chèn dữ liệu mẫu.
* **Truy vấn tổng hợp & Đếm số lượng:** Sử dụng `COUNT()`, `UNION ALL` để thống kê số lượng bản ghi trên từng bảng.
* **Kiểm thử Ràng buộc Toàn vẹn (Integrity Constraints Test):**
  * Vi phạm ràng buộc Khóa ngoại (`FOREIGN KEY`) - Ví dụ: Chèn nhà thuộc chi nhánh không tồn tại (`Error 1452`).
  * Vi phạm ràng buộc Khóa chính (`PRIMARY KEY`) - Ví dụ: Chèn trùng lịch xem nhà `Viewing` (`Error 1062`).
* **Quản lý Giao dịch:** Sử dụng `START TRANSACTION`, `COMMIT` và `ROLLBACK` để đảm bảo tính an toàn dữ liệu khi thử nghiệm.

---

## 🛠️ Công Nghệ Sử Dụng

* **Hệ quản trị CSDL:** MySQL / MariaDB (hoặc MySQL Workbench)
* **Công cụ lập trình:** Visual Studio Code (VS Code)
* **Quản lý phiên bản:** Git & GitHub

---

## 🚀 Hướng Dẫn Chạy Dự Án

### 1. Chuẩn bị Cơ sở dữ liệu
Đảm bảo bạn đã khởi chạy dịch vụ MySQL và chọn đúng CSDL `dreamhome`:
```sql
USE dreamhome;