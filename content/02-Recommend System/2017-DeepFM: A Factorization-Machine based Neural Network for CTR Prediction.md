---
title: "2017-DeepFM: A Factorization-Machine based Neural Network for CTR Prediction"
layout: page
date: 2020-06-17
---

## 总结

- 针对许多模型结构需要专门设计特征工程的情况，本文提出了DeepFM结构，结合了FM特征低阶交叉和Deep高阶交叉的优点，并简化了特征工程。
- 从另一个角度看，DeepFM也利用特征embedding解决了稀疏特征的参数维度问题。


## 主要内容

- 提出了DeepFM结构，在模型主体是常规FM部分和Deep部分。在输入部分对特征进行了处理，离散特征onehot，连续特征离散后onehot或者直接为dense特征，并将每个特征作为一个field，每一个field embedding成相同维度的向量。
<div style="text-align: center"><img src="/wiki/attach/images/deepFm-01.png" style="max-width:500px"></div>

- 和其他类似的网络结构做了对比，deepFM同时满足1.无预训练，2.同时包含高低阶特征，3.无特殊的特征工程。
<div style="text-align: center"><img src="/wiki/attach/images/deepFm-02.png" style="max-width:700px"></div>

- 实验比对了各模型之间的效果，并对超参的选取进行了实验。
<div style="text-align: center"><img src="/wiki/attach/images/deepFm-03.png" style="max-width:400px"></div>