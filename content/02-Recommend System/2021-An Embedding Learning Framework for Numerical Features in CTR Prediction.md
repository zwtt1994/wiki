---
title: "2021-An Embedding Learning Framework for Numerical Features in CTR Prediction"
layout: page
date: 2021-09-19
---

## 总结

- 对连续特征离散化端到端训练进行了优化。

## 主要内容

- 目前的模型范式都是特征Embedding+Interaction的模式，并且很多迭代工作都是集中于Interaction部分，但Embedding部分也是十分重要。

- 对于sparse特征常规的处理就是onehot+embdding，整体能够实现端到端学习。

- 对于连续特征的处理目前主要包含以下几种方式：
    - 多阶多项式转换，平方、开方等。
    - Field Embedding，同一个域中的连续特征共享一个embedding，输出结果为embedding乘以连续特征值。
    - 离散化，等距离散、等频离散、对数离散和树模型离散。
    - 上述几种离散化方式存在的问题：
        - 提前离散化，不是端到端训练。
        - 对于离散的边界值，两个较近的取值被映射到两个不同的emb。
        - 对于一个桶中的值可能差很远，但映射到一个相同的emb。
        
- AutoDis
    - 结构框架如下
    <div style="text-align: center"><img src="/wiki/attach/images/auto-dis-01.png" style="max-width:500px"></div>
    - 本质上是Field Embedding的升级版，为一个特征域设置多个embedding，并用softmax的方式生成各个embedding的权重。
    - 实验结果如下
    <div style="text-align: center"><img src="/wiki/attach/images/auto-dis-02.png" style="max-width:500px"></div>
    
- 方法分析
    - 将AutoDis结果与等距离散做对比，结果如下
    <div style="text-align: center"><img src="/wiki/attach/images/auto-dis-03.png" style="max-width:500px"></div>
    - 对比了若干个值的embedding，结果如下
    <div style="text-align: center"><img src="/wiki/attach/images/auto-dis-04.png" style="max-width:500px"></div>
    - 对比了对不同数量的连续特征处理的效果，结果如下
    <div style="text-align: center"><img src="/wiki/attach/images/auto-dis-05.png" style="max-width:500px"></div>
    - 对比了对不同聚合方法的效果，结果如下
    <div style="text-align: center"><img src="/wiki/attach/images/auto-dis-06.png" style="max-width:500px"></div>
    - 对比了对不同embdding数量的效果，结果如下
    <div style="text-align: center"><img src="/wiki/attach/images/auto-dis-07.png" style="max-width:500px"></div>



    

    