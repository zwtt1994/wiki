---
title: "2020-Neural Collaborative Filtering vs. Matrix Factorization Revisited"
layout: page
date: 2020-10-22
---

## 总结

- MLP很难学习到内积信息，可以通过先验知识设置内积结构来加强模型表达能力。

## 主要内容

- 基于embedding的协同过滤在近几年是SOTA的，矩阵分解用内积计算相似度，NCF用MLP计算相似度。

- 简单的内积效果基本要好于MLP计算出来的相似度；
- 虽然MLP能够学习到内积的信息，但并不是那么容易；
- 内积的效率与性价比高。