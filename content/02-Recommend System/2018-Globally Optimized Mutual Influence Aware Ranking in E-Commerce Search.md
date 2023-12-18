---
title: "2018-Globally Optimized Mutual Influence Aware Ranking in E-Commerce Search"
layout: page
date: 2023-12-15
---

## 总结

- 提出了一种考虑商品相互影响的排序方法，利用RNN + bean search获取结果。


## 主要内容

- 定义出序列全局的目标，以及两个问题：如何去预估某个序列的概率，序列的组合种类较多。
  <div style="text-align: center"><img src="/wiki/attach/images/miRnn-01.png" style="max-width:800px"></div>
  <div style="text-align: center"><img src="/wiki/attach/images/miRnn-02.png" style="max-width:800px"></div>

- 全局特征扩
    - 根据候选集的价格等属性，构建归一化相对特征，标示item在当前列表中的特征分布情况

- 预估某个序列的概率
    - RNN + Attention，防止靠前的item信息丢失
  <div style="text-align: center"><img src="/wiki/attach/images/miRnn-03.png" style="max-width:800px"></div>

- 候选集排列组合
    - bean search，每次保留预估概率最大的K个序列
  <div style="text-align: center"><img src="/wiki/attach/images/miRnn-04.png" style="max-width:800px"></div>