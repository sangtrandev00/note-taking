
**Đặt câu hỏi quan trọng**:

- Thông tin này thuộc về thực thể nào hay thuộc về mối quan hệ?
- Có phải thông tin này chỉ tồn tại khi có mối liên kết giữa hai thực thể?

## Ví dụ quy trình phân tích cho mối quan hệ "HUONG_DAN"

1. **Phân tích nghiệp vụ**: Giáo viên hướng dẫn đề tài và phải chấm điểm cho từng sinh viên
2. **Xác định thông tin liên kết**: Cần lưu điểm giáo viên hướng dẫn chấm
3. **Đặt câu hỏi về vị trí lưu trữ**:
    - Điểm này thuộc về giáo viên? Không, vì một giáo viên có thể chấm nhiều điểm khác nhau
    - Điểm này thuộc về đề tài? Không, vì đề tài có thể có nhiều điểm từ nhiều người chấm
    - → Điểm này thuộc về mối quan hệ HUONG_DAN
4. **Quyết định tạo bảng**: Cần bảng riêng vì có thuộc tính quan hệ, mặc dù bản số là (0,n)-(1,1)

---
## Liên quan

https://claude.ai/chat/312e0d97-eb3f-4ad6-9ba9-fbfcf6685b93