
Key Aggregation Pipeline Stages (80% of common operations):

1. `$match`: Filters documents (like WHERE in SQL)


```ts

db.orders.aggregate([
   { $match: { status: "active", total: { $gte: 100 } } }
])

```


2. `$group`: Groups documents by a key and performs calculations


```ts

db.sales.aggregate([
   { $group: {
      _id: "$product",
      totalSales: { $sum: "$amount" },
      avgPrice: { $avg: "$price" }
   }}
])

```


3. `$project`: Shapes the output documents (select/rename fields)

```ts

db.users.aggregate([
   { $project: {
      fullName: { $concat: ["$firstName", " ", "$lastName"] },
      age: 1,
      _id: 0
   }}
])

```

4. `$sort`: Orders the documents

```ts

db.posts.aggregate([
   { $sort: { createdAt: -1, likes: -1 } }
])

```



5. `$lookup`: Performs left outer joins with other collections


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

Most Common Query Operators (80% of usage):

1. Comparison:

```ts

db.products.find({
   price: { $gt: 100, $lt: 200 },  // Greater than, Less than
   stock: { $gte: 10 },            // Greater than or equal
   category: { $in: ["A", "B"] }   // In array
})

```

2. Logical:

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

3. Array:


```ts

db.posts.find({
   tags: { $all: ["mongodb", "database"] },  // Contains all elements
   comments: { $size: 5 },                   // Array size
   "ratings.0": { $gte: 4 }                 // First element >= 4
})

```


4. Element:

```ts

db.customers.find({
   phoneNumber: { $exists: true },    // Field exists
   age: { $type: "number" }          // Field type check
})

```


Pro Tips for Optimization:

5. Always start with `$match` early in your pipeline to reduce documents being processed
6. Use indexes to support your common query patterns
7. Use `$project` to remove unnecessary fields when working with large documents
8. Consider using `$limit` after `$sort` to improve performance
9. Use `$unwind` carefully as it can explode document size


---
## liên quan

https://claude.ai/chat/c17566d6-d56f-41c3-b5e5-7f0ce869fc76

#mongodb #nosql