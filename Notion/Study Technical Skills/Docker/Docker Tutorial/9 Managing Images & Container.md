  

### How to delete images and container ?

```PowerShell
docker image rm docker_image_name
```

  

  

Để delete images thì cần delete container trước (**Những container** chạy images đó)

```PowerShell
docker container rm app_c2
```

  

Remove all the images before

```PowerShell
docker system prune -a
```

Cách thêm tag (version) cho từng container

```PowerShell
docker build -t myapp:v1 . 
```

  

[https://www.youtube.com/watch?v=4XsjXscp70o&list=PL4cUxeGkcC9hxjeEtdHFNYMtCpjNBm3h7&index=9&ab_channel=NetNinja](https://www.youtube.com/watch?v=4XsjXscp70o&list=PL4cUxeGkcC9hxjeEtdHFNYMtCpjNBm3h7&index=9&ab_channel=NetNinja)