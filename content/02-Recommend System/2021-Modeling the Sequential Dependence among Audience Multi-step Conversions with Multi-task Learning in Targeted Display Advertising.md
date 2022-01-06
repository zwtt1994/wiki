---
title: "2021-Modeling the Sequential Dependence among Audience Multi-step Conversions with Multi-task Learning in Targeted Display Advertising"
layout: page
date: 2022-01-05
---

## 总结

- 针对长链路强依赖的多任务场景，提出了在多任务输出间添加关联结构并添加辅助loss来提升效果。

## 主要内容

- 论文中的业务场景是信用卡激活，包含"曝光-点击-申请-通过-激活"五个状态，并且这些状态从左至右属于前置逻辑，越右侧的状态越稀疏；其中通过和激活是目标任务，点击与申请是辅助任务。

- 多任务建模常用于多个目标场景的预估，为了更好地建模上述多目标情况，本文在传统目标结构上接近了优化，主要是新增了多目标输出之间的关联结构。
<div style="text-align: center"><img src="/wiki/attach/images/MT-Multi-01.png" style="max-width:800px"></div>

- 其中AIT网络结构的计算方式如下，论文认为可以根据实际场景调整。
<div style="text-align: center"><img src="/wiki/attach/images/MT-Multi-02.png" style="max-width:500px"></div>

- 损失函数如下，添加了强依赖逻辑的辅助损失函数。
<div style="text-align: center"><img src="/wiki/attach/images/MT-Multi-03.png" style="max-width:450px"></div>
<div style="text-align: center"><img src="/wiki/attach/images/MT-Multi-04.png" style="max-width:350px"></div>
<div style="text-align: center"><img src="/wiki/attach/images/MT-Multi-05.png" style="max-width:300px"></div>
