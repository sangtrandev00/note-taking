---
layout: post
title:  "Connect MongoDB AWS"
date:   2025-06-07 11:02:00 +0700
categories: aws mongodb database
tags: [aws, mongodb, connection, database]
---

Here are the connection commands and strings for connecting to MongoDB on AWS DocumentDB:

## Shell Connection

```shell
mongosh my-trannhatsang-mongodb.cvouqqckalp9.ap-southeast-1.docdb.amazonaws.com:27017 --tls --tlsCAFile global-bundle.pem --username trannhatsang --password
```

## Connection String

```
mongodb://trannhatsang:Phaithanhcong10**@my-trannhatsang-mongodb.cvouqqckalp9.ap-southeast-1.docdb.amazonaws.com:27017/?tls=true&tlsCAFile=global-bundle.pem&retryWrites=false
```

## Notes

- Make sure to have the `global-bundle.pem` certificate file in your working directory
- Replace the password with your actual credentials
- This configuration is for AWS DocumentDB which is MongoDB-compatible

