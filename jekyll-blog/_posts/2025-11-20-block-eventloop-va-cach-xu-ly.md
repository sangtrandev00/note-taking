---
layout: post
title: "Block Eventloop và cách xử lý"
date: 2025-11-20 10:00:00 +0700
categories: concept-base technical interview
tags: ["nodejs", "database", "api"]
source_path: "Evergreen/concept-base/technical/interview/Block Eventloop và cách xử lý.md"
---
#### **Tình huống thực tế:**

Bạn có một endpoint API xử lý yêu cầu xuất danh sách 1 triệu bản ghi từ cơ sở dữ liệu và thực hiện tính toán phức tạp trên mỗi bản ghi. Dưới đây là đoạn mã minh họa cách làm sai có thể gây block event loop:

```js
app.get('/process-data', async (req, res) => {
  const data = await getDataFromDatabase(); // Lấy 1 triệu bản ghi

  // Xử lý dữ liệu theo từng phần nhỏ để tránh block
  const batchSize = 1000;
  for (let i = 0; i < data.length; i += batchSize) {
    const batch = data.slice(i, i + batchSize);

    // Chờ xử lý từng batch nhỏ
    await Promise.all(
      batch.map(async (record) => {
        record.result = await heavyComputationAsync(record);
      })
    );
  }

  res.send(data);
});

async function heavyComputationAsync(record) {
  return new Promise((resolve) => {
    setTimeout(() => {
      // Giả lập công việc nặng được chuyển sang thread pool hoặc chia nhỏ
      let value = 0;
      for (let i = 0; i < 1e7; i++) {
        value += i;
      }
      record.value = value;
      resolve(record.value);
    }, 0); // Sử dụng setTimeout để tránh block event loop
  });
}


```


#### **Vấn đề:**

- **Block event loop:** Hàm `heavyComputation` thực hiện một vòng lặp lớn (1e7), gây ra việc Node.js không thể xử lý các yêu cầu khác trong khi xử lý logic này.
- Người dùng sẽ gặp tình trạng **chậm hoặc treo toàn bộ server**, vì Node.js không thể xử lý song song các yêu cầu.

---

#### **Cách xử lý đúng:**

1. **Sử dụng kỹ thuật xử lý bất đồng bộ (Async Processing):** Thay vì xử lý tất cả 1 triệu bản ghi ngay lập tức, bạn có thể sử dụng các kỹ thuật chia nhỏ dữ liệu hoặc xử lý theo từng phần.

Ví dụ:


```js

app.get('/process-data', async (req, res) => {
  const data = await getDataFromDatabase(); // Lấy 1 triệu bản ghi

  // Xử lý dữ liệu theo từng phần nhỏ để tránh block
  const batchSize = 1000;
  for (let i = 0; i < data.length; i += batchSize) {
    const batch = data.slice(i, i + batchSize);

    // Chờ xử lý từng batch nhỏ
    await Promise.all(
      batch.map(async (record) => {
        record.result = await heavyComputationAsync(record);
      })
    );
  }

  res.send(data);
});

async function heavyComputationAsync(record) {
  return new Promise((resolve) => {
    setTimeout(() => {
      // Giả lập công việc nặng được chuyển sang thread pool hoặc chia nhỏ
      let value = 0;
      for (let i = 0; i < 1e7; i++) {
        value += i;
      }
      record.value = value;
      resolve(record.value);
    }, 0); // Sử dụng setTimeout để tránh block event loop
  });
}


```

2. **Sử dụng Worker Threads (hoặc Child Processes):** Nếu cần xử lý các tác vụ rất nặng, bạn có thể sử dụng `worker_threads` để chuyển tính toán nặng sang một thread khác thay vì block event loop chính.


```js

const { Worker } = require('worker_threads');

app.get('/process-data', async (req, res) => {
  const data = await getDataFromDatabase(); // Lấy 1 triệu bản ghi

  // Xử lý nặng trong worker
  const results = await Promise.all(
    data.map((record) => runWorker(record))
  );

  res.send(results);
});

function runWorker(record) {
  return new Promise((resolve, reject) => {
    const worker = new Worker('./worker.js', { workerData: record });
    worker.on('message', (result) => resolve(result));
    worker.on('error', (err) => reject(err));
    worker.on('exit', (code) => {
      if (code !== 0) reject(new Error(`Worker stopped with code ${code}`));
    });
  });
}


```


**`worker.js`** (File riêng để xử lý tác vụ nặng):

```js

const { parentPort, workerData } = require('worker_threads');

// Xử lý tác vụ nặng
let value = 0;
for (let i = 0; i < 1e7; i++) {
  value += i;
}

workerData.result = value;

// Gửi kết quả lại cho main thread
parentPort.postMessage(workerData);


```


---

#### **Lợi ích:**

- Bằng cách chia nhỏ hoặc đưa logic nặng ra khỏi main thread (event loop), bạn đảm bảo server có thể tiếp tục xử lý các yêu cầu khác.
- **Hiệu suất** và **trải nghiệm người dùng** được cải thiện rõ rệt.

Nếu có phần nào chưa rõ, bạn cứ hỏi thêm!

---
## Liên quan

https://chatgpt.com/share/676a73b7-2398-8013-aaa1-36f103cb6c5f


#nodejs #eventloop

---
*Nguồn: Evergreen/concept-base/technical/interview/Block Eventloop và cách xử lý.md*