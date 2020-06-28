---
title: "2018-Feature Engineering"
layout: page
date: 2020-06-28
---

## 总结

- More data beats clever algorithms, but better data beats more data.

## 主要内容

- 类别特征
    - 特点：一般都需要预先处理；高基数类别特征会很稀疏；缺失值很难处理。
    - one-hot：最基本的处理方式；易于稀疏存储；通常会删除第一列来避免共线性（特征之间高度相关，早成信息冗余，影响模型结果）；无法很好处理缺失值。
    - Hash-encoding：避免了极为稀疏的数据；可能会引起冲突；在不同hash函数下准确率是接近的；冲突会使得结果失真，但可能会提升结果；易于处理新变量。
    - Label-encoding：