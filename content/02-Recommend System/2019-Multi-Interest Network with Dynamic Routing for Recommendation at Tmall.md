---
title: "2019-Multi-Interest Network with Dynamic Routing for Recommendation at Tmall"
layout: page
date: 2024-02-04
---

## 总结

- 提出动态路由的多兴趣网络（MIND）来学习用户的多兴趣表示


## 主要内容

- 背景
    - 常用的用户兴趣表示方法
        - 基于协同过滤，历史交互物品或隐藏因子来表示用户兴趣
        - 基于深度学习用低维emb向量表示用户兴趣
        - 基于预估目标的attention机制，需要user和item塔之间有交互，不适合用在双塔召回场景
    - 胶囊网络
        - vector in vector out，具体计算公式如下
<div style="text-align: center"><img src="/wiki/attach/images/MIND-01.png" style="max-width:300px"></div>
        - 输出层向量是输入层的加权求和，权重是输入向量和输出向量的内积相关性归一化，并额外做了一层squash归一化
        - 动态路由求解，输出的表达式包含输出，则类似EM的思路交替更新
        - 基于当前参数计算输出，并将计算结果作为下一次交替计算的输入
        - squash操作可以理解为向量维护的激活函数，胶囊网络的输入向量和输出向量的相关性越强权重越高，旨在强化某个输出维度的刻画
<div style="text-align: center"><img src="/wiki/attach/images/MIND-02.png" style="max-width:600px"></div>


- MIND Net

<div style="text-align: center"><img src="/wiki/attach/images/MIND-03.png" style="max-width:800px"></div>


- Multi-Interest Extractor Layer

<div style="text-align: center"><img src="/wiki/attach/images/MIND-04.png" style="max-width:600px"></div>

- 训练和预估
    - 离线训练：多个胶囊输出向量通过Label-aware Attention辅助训练
    - 在线使用：根据多个兴趣向量检索相似的item