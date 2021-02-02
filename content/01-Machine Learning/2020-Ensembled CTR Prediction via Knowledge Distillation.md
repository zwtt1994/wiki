---
title: "2020-Ensembled CTR Prediction via Knowledge Distillation"
layout: page
date: 2021-01-30
---


## 总结

- 知识蒸馏是在基本保留模型效果下，减小模型复杂度。

## 主要内容

- 目前推荐系统里的模型越来越复杂，虽然能够带来一定增益，但同时也对预估性能带来了很大的挑战；知识蒸馏则能够基本保持效果的同时降低模型复杂度。

- "机器学习最根本的目的在于训练出在某个问题上泛化能力强的模型"，知识蒸馏的学习模式中，s模型学到的信息比传统的学习方式更丰富（因为学习的是个分布），这提高了负样本的权重。

- 单teacher网络结构如下：
<div style="text-align: center"><img src="/wiki/attach/images/kd-01.png" style="max-width:500px"></div>
    - t模型可以预先训练完成，也可以和s模型一起训练；
    - 损失函数一般包括两部分，s模型常规的损失函数，以及s和t模型的kd损失；
    <div style="text-align: center"><img src="/wiki/attach/images/kd-03.png" style="max-width:300px"></div>
    - 上述两个损失函数占比的超参可以控制s模型从真实label和t模型学习的比重；
    - kd损失可以用交叉熵，也可以用平方差；交叉熵中的tau可以控制模型学习分布的陡峭程度。
    <div style="text-align: center"><img src="/wiki/attach/images/kd-04.png" style="max-width:300px"></div>
    <div style="text-align: center"><img src="/wiki/attach/images/kd-05.png" style="max-width:300px"></div>

- 多teacher网络结构如下：
<div style="text-align: center"><img src="/wiki/attach/images/kd-02.png" style="max-width:500px"></div>
    - 多t模型可以看作是多模型融合下的单teacher蒸馏；
    - 多t模型同样可以预先训练完成，也可以和s模型一起训练；
    - 多t模型最终按attention方式融合，具体方式可以根据具体场景设计。
    
- 一些实验结果如下：
    - 不同的训练设置；
    <div style="text-align: center"><img src="/wiki/attach/images/kd-06.png" style="max-width:500px"></div>
    - 不同的st组合；
    <div style="text-align: center"><img src="/wiki/attach/images/kd-07.png" style="max-width:800px"></div>
    - 不同的模型融合；
    <div style="text-align: center"><img src="/wiki/attach/images/kd-08.png" style="max-width:500px"></div>
