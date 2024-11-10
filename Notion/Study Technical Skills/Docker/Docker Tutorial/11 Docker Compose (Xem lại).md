  

> Vấn đề mỗi lần chạy docker, muốn chạy preview phải gõ rất nhiều câu lệnh vài dài dòng

> Muốn chạy nhiều container cùng lúc ví dụ một container backend, frontend, database thì phải làm sao ?

  

### Các bước để tạo một docker compose

  

B1: Tạo một file docer-compose.yaml

B2: Định nghĩa các dòng lệnh

```PowerShell
version: "3.8"
services: 
  api:
    build: ./api
    container_name: api_c
    ports:
      - "4000:4000"
    volumes:
      - ./api:/app
      - ./app/node_modules
```

B3: Chạy lệnh để run các services trong docker

```PowerShell
docker-compose up
```

  

  

> Các dòng lệnh liên quan phải nhớ

Xoá các container đang chạy bởi docker compose

```PowerShell
docker-compose down
```

Xoá các images và volumes chạy bởi docker compose

```PowerShell
docker-compose down --rmi all -v
```