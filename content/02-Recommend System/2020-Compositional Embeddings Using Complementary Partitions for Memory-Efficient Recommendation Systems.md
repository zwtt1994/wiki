---
title: "2020-Compositional Embeddings Using Complementary Partitions for Memory-Efficient Recommendation Systems"
layout: page
date: 2020-11-08
---

## 总结

- 对特征embedding做了trick处理，提出一种无冲突并能减少存储的方法。

## 主要内容

- Sparse特征embedding会占用大量的存储空间，简单的hash会导致冲突，本文提出一种无冲突并能减少存储的方法。

- 简单的hash（如余数）会产生冲突，本文利用（整数商+余数，商余技巧）两个hash表的方式解决冲突。

- 互补分区，上述商余技巧可以推广到其他多个分区，本文称之为互补分区，即多个embedding来表示一个索引。

- 多个embedding整合成一个的方法：拼接、求和、元素乘积。
<div style="text-align: center"><img src="/wiki/attach/images/C-embbeding-01.png" style="max-width:300px"></div>

- 可以底层设置一套embedding但不同分区根据不同path路径计算。
<div style="text-align: center"><img src="/wiki/attach/images/C-embbeding-02.png" style="max-width:300px"></div>