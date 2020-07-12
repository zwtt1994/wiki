---
title: "2017-Inductive Representation Learning on Large Graphs"
layout: page
date: 2020-07-12
---

## 总结

- 提出了GraphSAGE算法，本质上是基于组合的空间GCN，通过叠加邻居节点的信息来更新节点的表示，目的是得到更高阶的领域信息。

## 主要内容

- 常规的图神经网络都是对固定的图结构进行学习，泛化能力较差；本文的主要思想是直接学习节点的表示方法，而不受图结构的影响。
    <div style="text-align: center"><img src="/wiki/attach/images/GraphSAGE-01.png" style="max-width:600px"></div>
    
- GraphSAGE算法本质上是通过一个"Aggregate函数"来表示目标节点的邻居信息，并将该目标节点与邻居信息拼接后计算得到下一层的输出，可以看到整个算法是逐层逐节点计算的。

- 邻居节点选择
    - 如果邻居节点较多可以进行采样，由于算法是逐层计算的，所以也采用基于层的采样方式。
    - 文中提到了一些超参的选择，在层数取2，邻居采样为20个左右时，效果已经不错了。

- Aggregate函数
    - 由于图结构中节点的邻居是无序的，所以聚合函数最好对输入顺序是不敏感的（或者说输出不随输入顺序改变），并且具有较好的表示能力。
    - Mean aggregator：均值聚合，将所有邻居向量取均值。
    - LSTM aggregator：LSTM聚合，由于LSTM对顺序敏感，所以在输入之前对邻居节点进行乱序。
    - Pooling aggregator：Pooling聚合，对邻居节点进行非线性变换之后，取向量max/mean操作。

- 损失函数
    - Graph embedding，在无监督学习下，由于GraphSAGE是由邻居聚合的形式前向计算的，会导致间隔较远的节点embedding相差较大，所以负样本的采样方式是在正样本节点附近进行随机游走，一定程度上解决了上述问题。
    - 有监督任务按正常的损失函数定义即可。
    
- 实验验证了GraphSAGE的效果
    <div style="text-align: center"><img src="/wiki/attach/images/GraphSAGE-02.png" style="max-width:600px"></div>
    - Pooling或LSTM效果较好，LSTM的效果比较出人意料。
    - 有监督结果好于无监督，但无监督效果也不差，所以可以在特定场景下作为预训练。
    - 训练时间并DeepWalk长，但预测时间更短（未知节点可以直接计算）。
    - 在邻居数量和训练时间之间做了权衡。
    - 层数取2层相比与1层有10～15%的提升，但超过3层则进一步的提升小于5%，预测计算量则成倍增长（逐节点逐层）。