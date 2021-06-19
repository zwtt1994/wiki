---
title: "2021-DeepLight: Deep Lightweight Feature Interactions for Accelerating CTR Predictions in Ad Serving"
layout: page
date: 2021-06-18
---

## 总结

- DeepFM、xDeepFM到本文的DeepLight。

## 主要内容

- DeepFM，在FM的基础上加上了Deep部分，FM部分的sparse特征交叉可以理解为共现矩阵分解。
- xDeepFM，在向量哈达码积之后通过矩阵投影，而不是直接求和，理论上拟合能力更强，但与内积的物理含义有所偏离。
- DeepLight，在FwFM的基础上加上了Deep部分，并进行了网络简化。
    - high quality:FwFM结构在低复杂度下，具有媲美xDeepFM的效果，并且有优化空间，本文就加上了Deep部分。
    - low latency：修剪网络使得预测时延降低，提升系统性能。
    - low consumption：提升embedding稀疏性并保留有效部分，提升网络的信噪比。
    
- DeepFwFM和DeepFM的区别如下：
<div style="text-align: center"><img src="/wiki/attach/images/DeepLight-01.png" style="max-width:800px"></div>

- DeepLight的结构如下，在DeepFwFM上进行三种修剪；
    - DNN部分的网络参数修剪，使得计算复杂度大大减小；
    - FwFM中二阶交叉部分的修剪，一方面是减少计算，另一方面也减少交叉噪声，增强可解释性；
    - 修剪embedding中的参数，减少计算与缓存。

<div style="text-align: center"><img src="/wiki/attach/images/DeepLight-02.png" style="max-width:500px"></div>

- 修剪的伪代码如下：
<div style="text-align: center"><img src="/wiki/attach/images/DeepLight-03.png" style="max-width:500px"></div>

- 最终结果如下：
<div style="text-align: center"><img src="/wiki/attach/images/DeepLight-04.png" style="max-width:800px"></div>
