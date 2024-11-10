  

  

Vấn đề xảy ra với các tình huống cần copy

Khi ta dùng lệnh

```PowerShell
COPY . .
```

Ta sẽ copy luôn cả node_modules (nếu chưa có ignorefile trong .dockeerignore)

  

Để giải quyết vấn đề ta cần

```PowerShell
Create new .dockerignore
ignore: node_modules
```

  

Trong file .dockerignore sẽ xảy ra khi copy