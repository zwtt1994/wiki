---
title: "2019-A Deep Learning Framework Distilled by GBDT for Online Prediction Tasks"
layout: page
date: 2020-11-07
---

## 主要内容

- 在线预估的两个重要的任务
    - 1. tabular input space
    - 2. online data generation
- GBDT和NN都有自己的弱点
    - GBDT弱点在于sparse特征
    - NN弱点在于dense特征
- DeepGBM两个模块
    - CatNN 处理sparse特征的NN
    - GBDT2NN 处理dense特征, 将GBDT中学到的知识、特征重要性、特征分割点等知识蒸馏到NN中
- GBDT的两个问题
    - 不能做online learning, 也意味着难以处理极大规模的训练数据
    - 对(高度)稀疏特征难以拟合得很好。因为分裂是根据特征的统计信息,而稀疏特征onehot之后,分裂对单个特征的统计信息的变化很小,所以难以拟合的很好。一些解决的方法,将sparse特征通过一些编码方法变成连续特征。但每一种编码方法都有其局限性,无法充分表示原有特征中的信息量。
        - sklearn的一个编码库 https://github.com/scikit-learn-contrib/categorical-encoding
        - onehot之后的统计信息还有偏? LightGBM
- NN的问题
    - dense特征拟合效果通常不如GBDT,原因是局部最优。我认为还有模型结构的限制也是一个原因,因为dense特征要拟合好需要高度非线性,那么需要很深的NN,而这导致优化更加困难

- GBDT在线学习方法
    - XGBoost、LightGBM 固定树结构,改变叶子节点的权重
- GBDT处理sparse特征
    - CatBoost, 通过target statistic信息将sparse特征编码成连续值特征
- 深度GBDT
    - 周志华的两篇文章,DeepForest和mGBDT,将树模型多层堆叠起来
- DNN处理连续特征
    - 归一化、正则
    - 离散化: Supervised and unsupervised discretization of continuous features
- DNN与GBDT结合的工作
    - Facebook将GBDT的叶子节点作为sparse特征
    - Microsoft用GBDT学习NN的残差