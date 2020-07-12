---
title: "2018-Graph Convolutional Neural Networks for Web-Scale Recommender Systems"
layout: page
date: 2020-07-05
---

## 总结

- 在大规模数据中落地的GCN应用，本质上还是GraphSAGE的思想，在具体训练中做了一些加速操作。

 
## 主要内容

<div style="text-align: center"><img src="/wiki/attach/images/GCN-RS-00.png" style="max-width:700px"></div>

- 思路和GraphSAGE一样，是将邻居节点的信息进行聚合。
<div style="text-align: center"><img src="/wiki/attach/images/GCN-RS-01.png" style="max-width:500px"></div>
- 聚合方法本质是GraphSAGE中提到的pooling方法，先对邻居节点进行非线性变换，再利用加权pooling的方式统一维度，与本节点的向量concat之后，再进行一次非线性变换，最后做归一化。
- 邻居节点的选择是先通过随机游走生成领域，并将游走中对节点的访问次数的归一化值来定义邻居的重要性，并取前K个。
- 每个节点（mini-batch）邻居搜索和卷积计算整体流程如下。
<div style="text-align: center"><img src="/wiki/attach/images/GCN-RS-02.png" style="max-width:500px"></div>
- 模型训练细节
    - 目的是生成pins的embedding表示，数据是一个无向图数据，如果两个pin之间有board则认为是相关的。
    - hinge损失函数，利用了相关向量内积与非相关向量内积的差，负样本通过负采样得到。
    - 对mini-batch的计算结构进行了GPU分布式操作，训练时的batch size范围是512-4096。
    - 训练时每次只加载对应mini-batch的数据内存。
    - 负采样方面，每个mini-batch用一组负样本，并对每组相关的pins加入了"hard"负样本，这些样本和当前mini-batch节点不相关，但与改正样本组中另一个节点相关。