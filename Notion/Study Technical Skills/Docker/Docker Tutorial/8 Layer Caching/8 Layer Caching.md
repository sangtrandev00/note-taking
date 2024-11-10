  

Every line of dockerfile is a layer

  

![[/Untitled 7.png|Untitled 7.png]]

  

Vấn đề:  
  

- Nếu ta thay đổi version node của parent images thì docker file sẽ phải chạy lại từ đầu → lâu
- Nếu ta thay đổi code sau khi thêm docker file ?

⇒ Xin ra kỹ thuật caching layer

⇒ Sắp xếp lại thứ tự đặt từng dòng lệnh trong dockerfile

> [!important]  
> Để giúp cho việc tải docker có kỹ thuật cache → tham khảo trên internet reference và hỏi chat GPT để tối ưu (để build nhanh hơn) những lần tối ưu sau!  

[https://www.youtube.com/watch?v=_nMpndIyaBU&list=PL4cUxeGkcC9hxjeEtdHFNYMtCpjNBm3h7&index=8&ab_channel=NetNinja](https://www.youtube.com/watch?v=_nMpndIyaBU&list=PL4cUxeGkcC9hxjeEtdHFNYMtCpjNBm3h7&index=8&ab_channel=NetNinja)