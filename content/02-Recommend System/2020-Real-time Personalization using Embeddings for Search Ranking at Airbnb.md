---
title: "2020-Real-time Personalization using Embeddings for Search Ranking at Airbnb"
layout: page
date: 2021-01-24
---

## 总结

- Airbnb针对其业务，在房源的embedding中进行了独特的设计，包括:
    - Type embedding：针对稀疏的情况进行分桶聚合成type再进行embedding，与协同过滤的思想类似。
    - Embedding损失函数优化：同时考虑正负反馈信息（预定与拒绝），将预定的item设置为global context。
    - 负样本优化：随机采样的负样本（弱负样本）和同一market的负样本（强负样本）。

## 主要内容

- Embdding方法在推荐系统中用于表征item的信息，主要分为监督与无监督两类，本文使用了word2vec方法来对房源进行embedding。

- 数据集由用户的点击session组成，当用户点击间隔超过30分钟则记为两个session，embedding维度设置为32。

<div style="text-align: center"><img src="/wiki/attach/images/airbnb-01.png" style="max-width:600px"></div>

- 根据airbnb的场景业务，对word2vec的损失函数进行了以下优化：
    - 最终预定的item将作为该session内所有窗口内的context item。
    - 负采样时，除了全局负样本之外，再添加若干个同一个market的负样本，本质上是弱负样本+强负样本的组合。
    
<div style="text-align: center"><img src="/wiki/attach/images/airbnb-02.png" style="max-width:400px"></div>
    
- 冷启动时，将3个地理位置、房源类别和价格区间最接近的房源embedding均值作为新房源的embedding。

- 对房源进行了聚类来评估embedding的效果，发现embedding能够学到距离、类型和价格的信息。

- Type Embedding，将user和item聚合成type进行embedding，有点类似于协同过滤的思想，但先验设置过多。

- 离线评估，利用用户近17次点击的房源和最后下单的房源，计算最后下单房源的排序位置。
<div style="text-align: center"><img src="/wiki/attach/images/airbnb-03.png" style="max-width:500px"></div>

- 在相似房源模块，利用knn来搜索最相似的12个房源进行展示，"A/B 测试显示，基于嵌入的解决方案使「相似房源」点击率增加了21％，最终通过「相似房源」产生的预订增加了 4.9％"。

- 在搜索排序中，利用embedding来进行个性化推送，目的是"向用户更多展示他们喜欢的房源，更少展示他们不喜欢的房源"。
    - 以城市维度，对用户点击过的房源和跳过（浏览未点击）的房源embedding求均值。
    - 计算候选房源与上述两个向量的相似度作为排序模型输入特征。
    - 利用单特征搜索的方式校验了上述两个特征的重要性。
    <div style="text-align: center"><img src="/wiki/attach/images/airbnb-04.png" style="max-width:600px"></div>

