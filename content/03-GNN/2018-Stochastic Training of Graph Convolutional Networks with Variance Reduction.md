---
title: "2018-Stochastic Training of Graph Convolutional Networks with Variance Reduction"
layout: page
date: 2020-07-15
---

## 总结

- 在卷积计算中，通过记录节点历史向量的方法来提高计算效率，并通过邻居采样法计算残差。
- 常规方法是整个向量都通过采样来计算，而本文的方法是只有残差是采样计算得到的，所以不仅提升了计算效率，模型方差也更小了。

## 主要内容

- 根据GraphSAGE的计算方式，如果每次计算卷积时需要聚合所有邻居信息，每个batch的计算时间和内存的风险是无法保证的。
- 本文提出记录节点向量的历史向量，将卷积计算进行如下简化
<div style="text-align: center"><img src="/wiki/attach/images/VRCGN-True-01.png" style="max-width:400px"></div>
- 其中节点的历史向量可以记录下来而不需要重复计算，所以在计算卷积时能够不递归的考虑所有邻居的向量；而残差向量则依旧通过邻居采样来获得。
- 相比于常规的邻居采样，残差的方差明显比原始向量要更小一些。
