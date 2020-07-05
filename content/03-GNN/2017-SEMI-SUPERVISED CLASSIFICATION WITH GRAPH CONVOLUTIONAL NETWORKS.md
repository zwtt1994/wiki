---
title: "2017-semi-supervised classification with graph convolutional networks"
layout: page
date: 2020-07-05
---

## 总结

- 利用图谱卷积的一阶近似来作为GCN的卷积结构。
- 模型同时利用了节点特征信息和局部图结构，并利用其中有label的节点作为训练数据，再对无标签的节点进行分类，所以是半监督学习。

 
## 主要内容

- GCN卷积公式推导
    - 由信号时域和频域的卷积变换公式可以得到图结构中的卷积公式如下，其中x为图节点向量，U为拉普拉斯矩阵的向量矩阵，g是一个对角矩阵（卷积核）；缺点是计算过于复杂，卷积核选取不合适。
    <div style="text-align: center"><img src="/wiki/attach/images/GCN-01.png" style="max-width:200px"></div>
    - 利用切比雪夫多项式的截断来近似卷积核，得到新的卷积公式。
    <div style="text-align: center"><img src="/wiki/attach/images/GCN-02.png" style="max-width:200px"></div>
    <div style="text-align: center"><img src="/wiki/attach/images/GCN-03.png" style="max-width:200px"></div>
    - 进一步限制卷积结果关于拉普拉斯矩阵L是线性的（令K=1），得到卷积公式如下。
    <div style="text-align: center"><img src="/wiki/attach/images/GCN-04.png" style="max-width:500px"></div>
    - 进一步简化公式，将两个参数合并为一个参数，并对括号内做归一化，得到最终的近似卷积公式。
    <div style="text-align: center"><img src="/wiki/attach/images/GCN-05.png" style="max-width:200px"></div>
    <div style="text-align: center"><img src="/wiki/attach/images/GCN-06.png" style="max-width:200px"></div>
    
- 半监督分类任务
    - GCN模型结构定义如下，包括两个卷积层，损失函数为交叉熵，利用有标签的数据做训练并预测无标签数据的类别。
    <div style="text-align: center"><img src="/wiki/attach/images/GCN-07.png" style="max-width:400px"></div>
    <div style="text-align: center"><img src="/wiki/attach/images/GCN-08.png" style="max-width:600px"></div>
    - 在引文网络数据集和其他几个数据集中做了验证，结果证明了该网络结构的有效性。