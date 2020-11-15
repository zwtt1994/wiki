---
title: "2020-ADER-Adaptively Distilled Exemplar Replay Towards Continual Learning for Session-based Recommendation"
layout: page
date: 2020-10-09
---

## 总结

- Session-based推荐系统旨在建模序列信息，在实际中较久之前的信息和最新信息的利用率难以平衡，为此本文基于continual learning提出了两种方法。

## 主要内容

- continual learning，每次模型更新时基于t-1的模型和t的数据做fine-tune。

- 筛选经典样本保留长期偏好信息，每次保留历史的一部分样本加入到最新的数据中训练，损失函数为交叉熵，t样本取真实label，老样本的label取t-1模型的预测值。

- 在loss中限制模型更新幅度，加强了模型的鲁棒性。


