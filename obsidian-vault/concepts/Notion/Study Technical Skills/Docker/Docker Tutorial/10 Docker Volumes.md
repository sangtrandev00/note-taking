  

  

==Chú ý để start lại một container mới. Thì ta phải start những cái images tạo ra nó trước!==

## Docker volumes là gì ?

> Volumes để làm gì ?

  

⇒ Dùng để ánh xạ sự thay đổi của file mà không cần phải build lại một cái images mới.

  

> Khi nào cần tạo một images mới ?

⇒ Khi chúng ta thay đổi code, hoặc thay đổi các command trong dockerfile

  

### Volumes này có phải là một preview build hay không ?

  

  

> [!important]  
> volumes này đặc biệt hữu dụng trong việc phát triển, testing  

  

## 2. Làm sao để implement docker volumes ?

  

```PowerShell
B1: download nodemon and add script to package.json
```

B2: Run docker commands on terminal

```PowerShell
docker build -t myapp:nodemon .
```

```PowerShell
docker run --name myapp_c_nodemon -p 4000:4000 --rm -v /Users/trannhatsang/Documents/Programming/Docker/docker-crash-course/api:/app -v /app/node_modules myapp:nodemon
```

  

  

  

**[Q]: Còn thắc mắc chỗ ./app/node_modules. Tại sao cần phải dùng volumes chỗ này ?**

Lưu ý: Tất cả các đoạn code làm theo này đều chạy trên file docker crash course