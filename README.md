# L2B5A2-PostgreSQL-Assignment

## PostgreSQL Questions & Answers
---

### 1. What is PostgreSQL?
- Answer - PostgreSQL একটি উন্মুক্ত ও শক্তিশালী ডাটাবেস ম্যানেজমেন্ট সিস্টেম যাকে অবজেক্ট রিলেশনাল ডাটাবেস ম্যানেজমেন্ট সিস্টেম (ORDBMS) বলা হয়। PostgreSQL বিস্তর ভাবে SQL এর মান অনুযায়ী অনেক গুলো নতুন ফিচারস কাজ করতে সাহায্য করে। যেমন: কমপ্লেক্স কুয়েরি, ফরেইন কী, ট্রিগার্স, আপডেটেবল ভিউ, ট্রান্সেকশনাল ইন্টেগ্রিটি ইত্যাদি।


### 3. Explain the **Primary Key** and **Foreign Key** concepts in PostgreSQL.
- Answer - Primary Key হলো একটি কন্সট্রেইন যা টেবিলের একটি কলামের রেকর্ডকে অনন্য(ইউনিক) ভাবে সারির জন্য শনাক্ত করন করে। প্রাইমারি কী এর কলাম খালি(NOT NULL) থাকা যাবে না কোন মান অবশ্যই দিতে হবে। উদাহরন:

```sql
CREATE TABLE rangers(
    ranger_id INT PRIMARY KEY,
    name TEXT NOT NULL,
    region TEXT
);
```

Foreign Key - হলো একটি কন্সট্রেইন যা টেবিলের একটি কলামের মান অন্য একটি টেবিলের প্রাইমারি কী এর মানের সাথে মিলিয়ে দুই টেবিলের সাথে সম্পর্ক স্থাপন করে তাই ফরেইন কী। দুটি টেবিলের ডাটা গুলোর মধ্যে সম্পর্ক তৈরী এবং দুটি টেবিলের ডাটা একত্র করার জন্য ব্যবহার করা হয়।

```sql
CREATE TABLE sightings(
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT,
    FOREIGN KEY(ranger_id) REFERENCES rangers(ranger_id),
    notes TEXT
);
```


### 4. What is the difference between the `VARCHAR` and `CHAR` data types?
- Answer - `VARCHAR` ও `CHAR` ডাটা টাইপ যা টেক্সট টাইপ ডাটা রাখার জন্য ব্যবহৃত হয়।
`VARCHAR` - VARCHAR এ যত মান দেয়া হয় সেখানে সর্রব্বোচ্চ সে সংখ্যক অক্ষর লিখতে পারবে কিন্তু যে কয়টি অক্ষর লিখা হবে সেটুকু জায়গা ব্যবহার করবে।
```sql
CREATE TABLE user1(
    user_id INT PRIMARY KEY,
    name VARCHAR(20)
);
```
এখানে name VARCHAR(20) দেয়া কিন্তু নাম যত অক্ষরে লিখা হবে ততটুকু জায়গা নিবে।

`CHAR` - CHAR এ যত মান দেয়া হয় সেখানে সর্রব্বোচ্চ সে সংখ্যক অক্ষর লিখতে পারবে তবে অক্ষর কম লিখা হলেও মান যত দেয়া থাকবে সেটুকু জায়গা ব্যবহার করবে।

```sql
CREATE TABLE user2(
    user_id INT PRIMARY KEY,
    name CHAR(20)
);
```
এখানে name CHAR(20) দেয়া তবে নাম যদি 10 অক্ষরে লিখা হয় তবুও ২০ অক্ষরের জায়গা নিবে।

### 5. Explain the purpose of the `WHERE` clause in a `SELECT` statement.
- Answer - `WHERE` সাধারনত `SELECT` স্টেটমেন্টে ডাটা ফিল্টার করার জন্য ব্যবহার করা হয়। `SELECT` স্টেটমেন্টের কোন ডাটাকে শর্ত অনুযায়ী বাছাই করার জন্য `WHERE` ব্যবহৃত হয়।
```sql
SELECT * FROM user WHERE city = 'Dhaka'
```


### 6. What are the `LIMIT` and `OFFSET` clauses used for?
- Answer - `LIMIT` কোন ডাটা এর কয়টি প্রদর্শন করবে তার সীমা নির্ধারন করার জন্য ব্যবহৃত হয়। 
`OFFSET` কোন ডাটা এর কয়টি ডাটা বাদ দিয়ে প্রদর্শন করবে তা নির্ধারন করে। OFFSET এ যে মান দেয়া হয় সে কয়টি ডাটা প্রথমে বাদ দিয়ে রেজাল্ট দিয়ে থাকে।
```sql
SELECT * FROM user WHERE city = 'Dhaka'
LIMIT 5
OFFSET 3
```

এখানে LIMIT দ্বারা সবকয়টি ডাটা থেকে কয়টি ডাটা রেজাল্টে আসবে তা নির্ধারন করা হয়েছে।
OFFSET দিয়ে কয়টি ডাটা বাদ দিয়ে রেজাল্ট দিবে তা নির্ধারন করা হয়েছে।
