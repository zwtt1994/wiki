---
title: "2019-A Vectorized Relational Graph Convolutional Network for Multi-Relational Network Alignment"
layout: page
date: 2020-07-12
---

## 总结

- 提出了VR（vectorized relational）-GCN来同时建模图结构中的节点（实体）与边（关系），并设计了卷积计算使得模型满足TransE的假设性质。
- 基于VR-CGN增加网络对齐的目标，可以得到知识图谱对齐框架AVR-GCN。
- 得系统看下知识图谱的知识，这篇文章主要也是针对知识图谱数据。
 
## 主要内容

- VR-GCN框架和计算方式如下，在卷积中引入了"边"的表示，并区分头/尾实体来满足TransE的性质。
    <div style="text-align: center"><img src="/wiki/attach/images/VR-GCN-01.png" style="max-width:600px"></div>
    <div style="text-align: center"><img src="/wiki/attach/images/VR-GCN-02.png" style="max-width:400px"></div>

- 针对知识图谱提出了对齐框架AVR-GCN
    <div style="text-align: center"><img src="/wiki/attach/images/VR-GCN-04.png" style="max-width:600px"></div>
    - 最小化等价实体对/关系对的距离，其中还采样了负样本。
    <div style="text-align: center"><img src="/wiki/attach/images/VR-GCN-03.png" style="max-width:600px"></div>
    - 构建跨网络的三元组。