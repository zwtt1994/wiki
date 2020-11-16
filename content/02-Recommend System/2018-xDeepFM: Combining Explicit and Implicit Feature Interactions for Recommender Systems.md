---
title: "2018-xDeepFM: Combining Explicit and Implicit Feature Interactions for Recommender Systems"
layout: page
date: 2020-08-20
---

## 总结

- xDeepFM借鉴了DCN的思路，每层结构在特征向量维度进行二阶交叉，多层结构得到了多阶特征交叉的信息。

## 主要内容

- 特征交叉结构如下，每对特征向量进行叉乘计算，并通过参数矩阵pooling为交叉特征向量，依次类推。
<div style="text-align: center"><img src="/wiki/attach/images/xFeepFM-01.png" style="max-width:400px"></div>

- xDeepFM在论文中的实验结果提升明显，但也极大地提升了计算复杂度。