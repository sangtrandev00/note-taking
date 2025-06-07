---
layout: post
title: "Javascript excecution context là gì ?"
date: 2026-01-08 10:00:00 +0700
categories: concept-base technical programming Javascript
tags: ["javascript"]
source_path: "Evergreen/concept-base/technical/programming/Javascript/Javascript excecution context là gì ?.md"
---
```js
function greetings() {
  console.log("Welcome to the JS world!");
}

greetings();

var number1 = 10;
var number2 = 5;

function add(number1, number2) {
  return number1 + number2;
}

function addExtra(number1, number2) {
  var extra = 15;
  return number1 + number2 + extra;
}

var result1 = add(number1, number2);
var result2 = addExtra(number1, number2);

console.log(result1);
console.log(result2);

```


Có đoạn code như trên. Trình bày cách chạy bên dưới của JS liên quan đến khái niệm Excecution context










---

## Liên quan

https://dev.to/jahid6597/javascript-execution-context-a-deep-dive-4kno (Bài viết khá hay, trình bày theo tuần tự)
https://www.youtube.com/watch?v=yRPhqCM-3Rk&ab_channel=JustinNguyen (Xem thêm video có vẻ hay!)
https://viblo.asia/p/call-stack-va-execution-context-trong-javascript-Yym40zZWL91

#javascript

---
*Nguồn: Evergreen/concept-base/technical/programming/Javascript/Javascript excecution context là gì ?.md*