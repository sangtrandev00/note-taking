  

  

Ports ở **Local Host** không nhất thiết phải giống ở **Container Port**  
  
Cho phép ánh xạ qua  

  

**Start và stop ở docker desktop**  
  
  
**Thông qua command line interface thì sao ?**

  

### Các câu lệnh start

```PowerShell
step 1: docker images
List all the iamges
```

```PowerShell
step 2: docker run --name myapp_c1 docker_iamges_name
```

example:  
  

> docker run —name myapp_c2 test-node-app

![[/Untitled 6.png|Untitled 6.png]]

  

C2: Tạo và thay đổi port (mapping port container và port localhost)

```PowerShell
docker run --name myapp_c2 -p 4000:4000 -d docker_image_name\
```

  

### Các câu lệnh Stop

```PowerShell
docker stop docker_image_name
```

### Câu lệnh restart (cứ start lại tên container đã được tạo)

```PowerShell
docker start container_name
```

Question:

-d: Detach mode là gì ở đây ? Nếu không có detach mode trước mỗi câu lệnh docker thì sao ?

  

Link resource

[https://www.youtube.com/watch?v=ZPEpreOpqao&list=PL4cUxeGkcC9hxjeEtdHFNYMtCpjNBm3h7&index=7&ab_channel=NetNinja](https://www.youtube.com/watch?v=ZPEpreOpqao&list=PL4cUxeGkcC9hxjeEtdHFNYMtCpjNBm3h7&index=7&ab_channel=NetNinja)