---
layout: post
title: "Cách khởi tạo SSH cho máy và kết nối với Github"
date: 2025-11-15 10:00:00 +0700
categories: concept-base technical git
source_path: "Evergreen/concept-base/technical/git/Cách khởi tạo SSH cho máy và kết nối với Github.md"
---
### **Bước 1: Tạo SSH Key trên máy Windows**

1. **Mở Git Bash**
    
    - Tìm và mở "Git Bash" (được cài đặt khi bạn cài Git trên Windows).
2. **Kiểm tra SSH key hiện có**  
    Gõ lệnh sau để kiểm tra xem bạn đã có SSH key nào chưa:
    
    bash
    
    Sao chép mã
    
    `ls -al ~/.ssh`
    
    - Nếu thư mục `~/.ssh` có file `id_rsa` và `id_rsa.pub`, bạn có thể dùng lại.
    - Nếu chưa có, tiếp tục bước sau để tạo mới.
3. **Tạo SSH key**  
    Gõ lệnh:
    
    bash
    
    Sao chép mã
    
    `ssh-keygen -t rsa -b 4096 -C "email@example.com"`
    
    - Thay `"email@example.com"` bằng email GitHub của bạn.
    - Khi được hỏi nơi lưu key, nhấn **Enter** để lưu mặc định tại `~/.ssh/id_rsa`.
    - Bạn có thể đặt mật khẩu hoặc nhấn Enter để bỏ qua.
4. **Thêm SSH key vào ssh-agent**  
    Bật ssh-agent:
    
    bash
    
    Sao chép mã
    
    `eval "$(ssh-agent -s)"`
    
    Thêm SSH key vào ssh-agent:
    
    bash
    
    Sao chép mã
    
    `ssh-add ~/.ssh/id_rsa`
    

---

### **Bước 2: Kết nối SSH Key với GitHub**

1. **Copy SSH Key**  
    Gõ lệnh để copy SSH public key vào clipboard:
    
    bash
    
    Sao chép mã
    
    `clip < ~/.ssh/id_rsa.pub`
    
    - Nếu lệnh trên không hoạt động, bạn có thể mở file `id_rsa.pub` và copy thủ công.
        
        bash
        
        Sao chép mã
        
        `cat ~/.ssh/id_rsa.pub`
        
2. **Thêm SSH Key vào GitHub**
    
    - Đăng nhập vào GitHub.
    - Vào **Settings** > **SSH and GPG keys** > **New SSH Key**.
    - Đặt tiêu đề cho SSH key (ví dụ: "Laptop Windows") và dán key vào ô **Key**.
    - Nhấn **Add SSH Key**.

---

### **Bước 3: Kiểm tra kết nối**

1. Kiểm tra bằng lệnh sau:
    
    bash
    
    Sao chép mã
    
    `ssh -T git@github.com`
    
    - Nếu thấy thông báo như sau, nghĩa là kết nối thành công:
        
        vbnet
        
        Sao chép mã
        
        `Hi <username>! You've successfully authenticated, but GitHub does not provide shell access.`
        

---

### **Bước 4: Cấu hình Git sử dụng SSH**

1. Đảm bảo URL của repository dùng SSH:  
    Gõ lệnh:
    
    bash
    
    Sao chép mã
    
    `git remote set-url origin git@github.com:<username>/<repository>.git`
    
    - Thay `<username>` và `<repository>` bằng thông tin của bạn.
2. Thử clone repository:
    
    bash
    
    Sao chép mã
    
    `git clone git@github.com:<username>/<repository>.git`
    

---

Vậy là bạn đã thiết lập thành công SSH key để kết nối với GitHub trên máy Windows! Nếu gặp vấn đề nào, hãy cho tôi biết để hỗ trợ thêm. 😊


---
## Liên quan

https://chatgpt.com/share/677d4c73-4ba0-8013-9e12-9d3e3b8c62ae

#git #github #ssh

---
*Nguồn: Evergreen/concept-base/technical/git/Cách khởi tạo SSH cho máy và kết nối với Github.md*