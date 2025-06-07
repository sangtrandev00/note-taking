---
layout: post
title: "Làm sao để up file lên github khi vượt quá max"
date: 2025-11-18 10:00:00 +0700
categories: concept-base technical git
source_path: "Evergreen/concept-base/technical/git/Làm sao để up file lên github khi vượt quá max.md"
---
## Cách làm

Tham khảo chatGPT
Tải git large file storage từ nguồn: git-lfs.com
Đẩy các file >100M vào mục .gitignore
Lệnh nào để đẩy các file >100M
	find . -type f -size +100M >> .gitignore
**Clear terminal cache và làm lại** [Question] Tại sao lại phải clear cache như vậy nhỉ ?

---
## Nguồn:

https://chatgpt.com/share/6743296e-9fbc-8013-8cbd-88a2202047d4

---
*Nguồn: Evergreen/concept-base/technical/git/Làm sao để up file lên github khi vượt quá max.md*