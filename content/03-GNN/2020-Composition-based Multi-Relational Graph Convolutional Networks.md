---
title: "2020-Composition-based Multi-Relational Graph Convolutional Networks"
layout: page
date: 2020-07-12
---

## 总结

- 针对有向图提出了CompGCN，思路还是GraphSAGE的思路，只是在聚合的时候根据有向图的特点设计了特定的聚合函数。

 
## 主要内容

- 常规的GCN算法都是应用与无向图，本文针对有向图提出了CompGCN，旨在同时学习节点和边的表示。
- 经典的有向图的聚合处理是根据不同类型的关系来选取不同的聚合参数，但如果关系种类比较多就很难学习。
- 有向图GCN模型设计
    - 针对一个节点设计三套聚合权值（正向边，反向边，自连边），聚合函数和聚合示意图如下。
    <div style="text-align: center"><img src="/wiki/attach/images/CompGCN-02.png" style="max-width:300px"></div>
    <div style="text-align: center"><img src="/wiki/attach/images/CompGCN-01.png" style="max-width:600px"></div>
    - 为了能够使得运算中节点和边的embedding在统一空间，对边的embedding进行转换处理。并且为了降低边太多而带来的计算复杂度，本文设计了一组基向量来加权表示所有的边。
    <div style="text-align: center"><img src="/wiki/attach/images/CompGCN-03.png" style="max-width:200px"></div>