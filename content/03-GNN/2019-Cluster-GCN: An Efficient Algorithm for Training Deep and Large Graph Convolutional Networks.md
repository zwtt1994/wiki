---
title: "2019-Cluster-GCN: An Efficient Algorithm for Training Deep and Large Graph Convolutional Networks "
layout: page
date: 2020-07-05
---

## 总结

- 为了提高GCN的训练效率，提出了Cluster-GCN，本质上是先对图结构进行cluster再分别进行训练。

## 主要内容

- 原始GCN在落地上有下列缺点：1.占用内存大，2.耗时长，3.收敛速度慢；GraphSAGE提出了逐节点的前向计算，但增加了时间复杂度；也有论文提出过用batch的方式，但都没解决上述3个问题。

- 本文将图结构先进行聚类，再分别对各个簇按batch进行训练。具体的，利用谱聚类进行图的划分，再别分进行训练。
    - 谱聚类：将图结构的拉普拉斯矩阵做特征分解，并取前k个特征向量作为样本向量，再做k-means聚类。（METIS：图分割的一个软件包）

- Cluster-GCN算法的流程如下，由于分簇进行训练，训练过程中需要做一些改变。
    <div style="text-align: center"><img src="/wiki/attach/images/Cluster-GCN-01.png" style="max-width:500px"></div>
    - 训练方式需要改变,需要按簇的维度计算损失函数。
    - 同一个batch内标签的熵较小，影响收敛，所以每次随机选择n个簇进行训练。
    - 计算效率提高后可以加深GCN，但深度模型信息训练困难（信息很难从浅层传到深层），所以在计算时放大卷积核的对角元素的权重。
  
- 实验验证了Cluster-GCN的有效性，在模型效果与性能方便都优于其他类似的方法。
    - 在准确率和收敛时间上的比较结果。
    <div style="text-align: center"><img src="/wiki/attach/images/Cluster-GCN-02.png" style="max-width:500px"></div>
    - 在内存占用上的比较结果。
    <div style="text-align: center"><img src="/wiki/attach/images/Cluster-GCN-03.png" style="max-width:500px"></div>
    - 同时本文还在卷积层更多的情况下做了实验，结论也是Cluster-GCN有着较好的效果与性能。