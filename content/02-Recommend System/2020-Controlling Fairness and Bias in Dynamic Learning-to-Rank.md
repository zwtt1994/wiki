---
title: "2020-Controlling Fairness and Bias in Dynamic Learning-to-Rank"
layout: page
date: 2021-02-16
---

## 总结

- 

## 主要内容

- 问题定义
    - 推荐系统中的排序模型是基于曝光样本来学习的，其物料分布与真实物料分布不同，会造成偏差效应。
    - 所以我们需要排序算法具备无偏性（用户偏好定义的准确性）和公平性（对曝光进行合理的分配）。
    - 文中针对的是动态排序：将用户的反馈信息实时的用于计算排序得分上，可以理解为排序模型包含反馈的实时特征。
    
- 符号说明
    - 用户信息:x
    - 时间因子:t
    - 待排序物料:d
    - 物料是否曝光:e
    - 物料曝光概率:p
    - 用户与物料相关性:r
    - 用户对物料偏好:R
    - 排序规则:π
    - 排序得分:σ
    - 用户正反馈(用户偏好):c
    
- 动态排序
    - 用户偏好c的描述如下，用户偏好定义为曝光物料与用户的相关性。
    <div style="text-align: center"><img src="/wiki/attach/images/fair-01.png" style="max-width:300px"></div>
    - 由于在排序的时候无法直接获取物料是否曝光，所以可以利用排序得分来估计曝光概率。
    <div style="text-align: center"><img src="/wiki/attach/images/fair-02.png" style="max-width:150px"></div>
    - 排序逻辑如下，即利用利用用户特征x计算用户与文档d的相似度，并进行排序；对于动态排序，相似度R与用户反馈c随时间相关即可。
    <div style="text-align: center"><img src="/wiki/attach/images/fair-03.png" style="max-width:250px"></div>
    
- 公平性
    - 公平性是指：如何公平合理地对物料进行曝光；本文对"判断是否曝光"与"衡量用户对物料的偏好"进行了建模。
    - 定义曝光概率为排序得分、用户信息和用户与物料相关性的边缘分布；
    <div style="text-align: center"><img src="/wiki/attach/images/fair-04.png" style="max-width:250px"></div>
    - 对同一类型的物料进行聚合，得到某类物料的平均曝光度量；
    <div style="text-align: center"><img src="/wiki/attach/images/fair-05.png" style="max-width:250px"></div>
    - 同时定义了用户对整类物料的偏好度量；
    <div style="text-align: center"><img src="/wiki/attach/images/fair-06.png" style="max-width:250px"></div>
    - 由上述两式可以定义出公平性的度量，即某一类物料单位偏好下的期望曝光；此外可以定义类似的公平性度量，如单位偏好下的期望点击。
    <div style="text-align: center"><img src="/wiki/attach/images/fair-07.png" style="max-width:450px"></div>

- 无偏性
    - 无偏性是指用户偏好定义的准确性，文中共涉及到三个变量：位置偏差p，用户对物料的平均相关性R(d|x)，物料全局的期望相关性R(d)；
    - 作者认为位置偏差p的预估不是动态排序中存在的问题，最简单的做法是利用排序得分σ来确定，也可以加入其他更多的特征。
    - 对R(d|x)的预估类似于我们平常预估的ctr，但由于用户反馈对用户物料相关性的估计不是无偏的，所以需要进行调整，本质上是利用曝光概率p和用户反馈c来无偏估计相关度r。
    <div style="text-align: center"><img src="/wiki/attach/images/fair-08.png" style="max-width:550px"></div>
    <div style="text-align: center"><img src="/wiki/attach/images/fair-09.png" style="max-width:350px"></div>
    - 所以可以通过下面这个损失函数来无偏估计用户和物料的相关度，实现无偏排序。
    <div style="text-align: center"><img src="/wiki/attach/images/fair-10.png" style="max-width:400px"></div>
    - 物料全局相关性的无偏估计如下，即用户反馈c/曝光概率p，其证明也是直觉的。
    <div style="text-align: center"><img src="/wiki/attach/images/fair-11.png" style="max-width:250px"></div>

- 公平性动态控制
    - 上文已经提到不公平性的平均度量为两个类目之间的不公平度，全局不公平度则是所有类目见不公平度的均值。
    <div style="text-align: center"><img src="/wiki/attach/images/fair-12.png" style="max-width:300px"></div>
    - 为了降低上述不公平度，本文提出计算如下误差，并利用误差对排序得分进行调整。同时，根据线上新的实验结果重新计算上述不公平度对误差进行更新，直到收敛为止。
    <div style="text-align: center"><img src="/wiki/attach/images/fair-13.png" style="max-width:400px"></div>
    <div style="text-align: center"><img src="/wiki/attach/images/fair-14.png" style="max-width:300px"></div>
    