---
title: "2020-CAN: Revisiting Feature Co-Action for Click-Through Rate Prediction"
layout: page
date: 2021-02-08
---

## 总结

- 在item交叉特征场景中，本文发现笛卡尔积效果好于常规的交叉方式，认为常规的交叉方式表达能力不足。

- 在FM结构基础上，本文将其中一侧embedding扩充为多个，进一步提升了网络对交叉信息的表达能力。

## 主要内容

- 本文是DIN/DIEN作者的续作，工作重点是在用户历史行为item和目标item之间的特征交互。

- 在特征交叉中，目前常用的做法有FM/Attention等方式，本文尝试利用笛卡尔积来引入item之间的交互信息，发现效果比embedding之后做pooling更好（？？）。

- 笛卡尔积是纯显式地引入交叉信息，其信息具有很强的独立性，但会极大的提高特征维度，所以需要进行简化。

- 本文早期的思路是增加embedding的数量，在交叉中两边的向量相互交叉，提升item表达的独立性。

- 但最终简化为一侧增加多embedding向量，另一侧保持不变，也等同于一层产生的向量作为参数，另一侧作为输入的效果。

<div style="text-align: center"><img src="/wiki/attach/images/CAN-01.png" style="max-width:800px"></div>