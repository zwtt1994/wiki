---
title: "Leave No Context Behind:Efficient Infinite Context Transformers with Infini-attention"
layout: page
date: 2024-01-28
---

## 主要内容

- 利用infini-attention机制，在限制内存和计算的情况下将Transformer的LLM扩展到无限长的输入。

- 本文提出的方法和transformer-XL的对比，XL是在有限长segment基础上缓存上一个segment的状态，本文则是压缩缓存历史所有segments的状态。
<div style="text-align: center"><img src="/wiki/attach/images/infini-01.png" style="max-width:600px"></div>

- Infini-attention详情
<div style="text-align: center"><img src="/wiki/attach/images/infini-02.png" style="max-width:300px"></div>
    - 状态压缩，本文不是计算新的状态模块，而是复用注意力中的QKV矩阵。
    - 状态检索
<div style="text-align: center"><img src="/wiki/attach/images/infini-03.png" style="max-width:700px"></div>
    - 状态更新
<div style="text-align: center"><img src="/wiki/attach/images/infini-04.png" style="max-width:500px"></div>
    - 增量更新优化
<div style="text-align: center"><img src="/wiki/attach/images/infini-05.png" style="max-width:500px"></div>
    - 历史与当前状态合并：可学习的门控标量
<div style="text-align: center"><img src="/wiki/attach/images/infini-06.png" style="max-width:600px"></div>
    - 多头attention，并行计算


- 状态和有效窗口，复杂度对比
<div style="text-align: center"><img src="/wiki/attach/images/infini-07.png" style="max-width:700px"></div>


- 可视化分数，attention权重分布有0有1也有0.5，有长期有短期也有长短期结合。
<div style="text-align: center"><img src="/wiki/attach/images/infini-08.png" style="max-width:400px"></div>

- 实验效果，rouge-n是指n-gram的召回率
<div style="text-align: center"><img src="/wiki/attach/images/infini-09.png" style="max-width:600px"></div>