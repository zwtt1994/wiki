---
title: "1991-Adaptive Mixtures of Local Experts "
layout: page
date: 2020-06-21
---

本文主要讨论了MoE结构中的Experts在训练中强耦合的缺点，提出了竞争网络的方式来选取一个Experts的输出作为最终输出。
本质上是给每个Expert提供较强的学习目标来解除Experts之间耦合，这个信息可以从label获取（多目标），或者是直接在gate上加入较强的先验信息（如本文的只依赖一个Expert）。

## 总结

- 提出竞争学习版本的MoE结构，每个Experts学习一部分数据集，本文将其称之为模块化学习或者是竞争学习的联合版本。

## 主要内容

- 本文将一个监督任务进行拆解。普通的MoE结构多个Experts的输出是线性加权求和，这就会使得这些Experts之间是强耦合的，导致多个experts学到的东西是一样的。所以本文提出对于一个样本最后只利用一个Expert的输出，选择方式是利用gate权值做softmax来作为选择概率。
<div style="text-align: center"><img src="/wiki/attach/images/MoE-01.png" style="max-width:500px"></div>
- 其损失函数就可以转化成下式，使得Experts之间的参数不再直接耦合，但其实通过gate还存在比较弱的间接关系。
<div style="text-align: center"><img src="/wiki/attach/images/MoE-02.png" style="max-width:350px"></div>


- 利用上式进行SGD训练时，对于某个样本误差较小的Expert选择的概率会被增强，反之则会减小。为了加速模型训练，将误差函数改为下式。
<div style="text-align: center"><img src="/wiki/attach/images/MoE-03.png" style="max-width:330px"></div>
- 对比两个梯度可以发现，这么修改本质上是提高了误差较小的Expert的权重。
<div style="text-align: center"><img src="/wiki/attach/images/MoE-04.png" style="max-width:300px"></div>
<div style="text-align: center"><img src="/wiki/attach/images/MoE-05.png" style="max-width:330px"></div>

- 在多人说话的人声识别场景中进行了实验，证明了上述模型的效果。