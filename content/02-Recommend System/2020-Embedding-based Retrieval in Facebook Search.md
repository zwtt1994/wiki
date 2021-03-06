---
title: "2020-Embedding-based Retrieval in Facebook Search"
layout: page
date: 2020-08-18
---

## 总结

- 召回模型的关键是负样本选择，easy负样本保证了离线训练中和线上数据分布的一致性，hard负样本能够提高模型精度。

## 主要内容

- 双塔模型，user向量实时计算，item向量离线存储。

- 损失函数，hinge损失函数，含义是user与正样本/负样本的距离差应该大于某个阈值，pair-wise思想。

- 样本选取，排序中样本是直观的，但召回中负样本定义并不是明确的，目的是要让离线数据分布与线上一致。
    - positive，正样本的选取是很直观的。
    - easy negative，随机选取，和正样本差别比较大的负样本。
    - hard negative，和正样本在某个逻辑上类似的负样本。
        - 业务逻辑，如选取某个特征属性相同的负样本，例如地理位置。
        - 模型挖掘，上一版召回结果排序后的中部样本。

- 特征工程，文本、地理位置和社交关系。

- 离线评估，用户点击在topK的召回率（hint@topK），用户点击在召回中的平均位置；上述指标与实际线上效果还是会有gap。

- Serving，用PQ量化加速ANN。

- Hard Mining，本文的样本选取方法，每个样本pair为(query, doc)
    - Hard negative mining
        - online，用同一个mini-batch内其他正样本pair的doc作为负样本pair；如果数量太多可以选取相似度topK。
        - offline，在原本的基础上添加hard negative即可；利用ann生成有效的k个hard负样本即可，重在速度。
        - 如果只用hard negative的效果是不如只用easy negative的效果，因为在实际召回中easy negative还是占大部分。
        - 取相对hard负样本效果优于hardest负样本，因为匹配度适中的负样本，可以使得正负样本边界更加清晰，而hardest负样本无法取得上述效果。
        - 文中提到easy/hard=100/1的负样本比例是比较合适的；从hard负样本模型迁移到easy负样本模型可以效果。
        - 特别的，文中提到用曝光未点击作为hard样本做来训练是没有效果的；因为这些样本在当前模型上和正样本是相似的，不然也不会曝光，类似于hardest负样本。
    - Hard positive mining
        - 本质上是寻找和正样本相似的样本，例如在电商场景中，点击、收藏、加购物车、下单和支付这几种行为都代表了用户的偏好。
    
- 模型组合
    - 当召回数量k很大时，easy model topK的效果较好；当召回数量k较小时，只用hard model topK的效果较好。所以可以进行模型组合。
    - 并行融合，最终分数是多个模型的打分的加权和。
    - 串行融合，先后经过easy model和hard model的两次筛选。
    
        
     
 