---
profileName: sangtrandev00
postId: 3608
postType: post
categories:
  - 39
---

1. `$match`: Lọc tài liệu (giống `WHERE` trong SQL)

```ts

db.orders.aggregate([
   { $match: { status: "active", total: { $gte: 100 } } }
])

```

2. `$group`: Nhóm các tài liệu theo một khoá chính và thực hiện tính toán
    

```ts

db.sales.aggregate([
   { $group: {
      _id: "$product",
      totalSales: { $sum: "$amount" },
      avgPrice: { $avg: "$price" }
   }}
])
```

1. `$project`: Định dạng lại các tài liệu kết quả (giống `SELECT` trong SQL)
    

```ts

db.users.aggregate([
   { $project: {
      fullName: { $concat: ["$firstName", " ", "$lastName"] },
      age: 1,
      _id: 0
   }}
])
```

2. `$sort`: Sắp xếp các tài liệu
    

```ts

db.posts.aggregate([
   { $sort: { createdAt: -1, likes: -1 } }
])
```

3. `$lookup`: Thực hiện left outer join với collection khác
    

```ts

db.orders.aggregate([
   { $lookup: {
      from: "products",
      localField: "productId",
      foreignField: "_id",
      as: "productDetails"
   }}
])

```

---

## Các Toán Tử Truy Vấn Phổ Biến Nhất (80% các trường hợp sử dụng)

4. Toán tử So sánh:
    

```ts

db.products.find({
   price: { $gt: 100, $lt: 200 },  // Lớn hơn, Nhỏ hơn
   stock: { $gte: 10 },            // Lớn hơn hoặc bằng
   category: { $in: ["A", "B"] } // Thuộc một trong các giá trị
})
```

5. Toán tử Logic:
    

```ts

db.users.find({
   $and: [
      { age: { $gte: 18 } },
      { status: "active" }
   ],
   $or: [
      { role: "admin" },
      { permissions: "manage" }
   ]
})
```

6. Toán tử Mảng:
    

```ts

db.posts.find({
   tags: { $all: ["mongodb", "database"] },  // Chứa tất cả các phần tử
   comments: { $size: 5 },                    // Kích thước mảng
   "ratings.0": { $gte: 4 }                  // Phần tử đầu tiên >= 4
})
```

7. Toán tử Phần tử:
    

```ts

db.customers.find({
   phoneNumber: { $exists: true },   // Trường tồn tại
   age: { $type: "number" }         // Kiểu dữ liệu là số
})

```

---

## Một Số Tips Tối Ưu Hóa

8. Luôn đặt `$match` sớm trong pipeline để giảm số lượng tài liệu xử lý.
    
9. Sử dụng index hỗ trợ các mẫu truy vấn phổ biến.
    
10. Sử dụng `$project` để loại bỏ các trường không cần thiết khi làm việc với tài liệu lớn.
    
11. Xem xét việc sử dụng `$limit` sau `$sort` để tăng hiệu năng.
    
12. Cẩn thận với `$unwind` vì nó có thể làm tăng kích thước tài liệu đốt biến.
    

---
## Liên quan
Hi vọng bài viết giúp bạn nắm vững các thao tác Aggregation trong MongoDB một cách dễ dàng và hiệu quả nhất! Hãy thữ nghịch ngay và chia sẻ trải nghiệm của bạn nhé! #mongodb #nosql

https://chatgpt.com/canvas/shared/67b152adde2c8191a867baa0659dc347
