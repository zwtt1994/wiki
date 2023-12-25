---
title: "2017-Attention Is All You Need"
layout: page
date: 2020-07-25，update on 2023-12-24
---

## 总结

- rnn的方法存在长度处理限制，时间顺序规则导致计算效率较低，同时注意力机制也被引入到各模型中来提升模型表达能力。
- 一些工作利用cnn来并行计算不同位置间的相关信息，但往往计算复杂度和输入长度呈线性或者指数增长关系。
- 本文提出transformer结构，利用self-attention来解决并行计算和长度限制的问题。
 
## 主要内容

- 模型结构
<div style="text-align: center"><img src="/wiki/attach/images/Transformer-01.png" style="max-width:400px"></div>
    - 编码器由多个子层堆叠而成，每个子层包含两部分，一部分是multi-head attention，一部分是两层全链接FFN，两个部分都加入了残差链接和layer normalization，因此所有子层输出维度一致。
    - 为什么要用残差网络：网络很难学习到恒等映射，而容易学习残差，解决梯度消失问题
    - Layer normalization：层神经元维度的归一化；Batch normalization：样本维度的归一化
    - 解码器：Masked multi-head attention + multi-head attention +FFN，mask的目的是并行计算时不让时序前面的建模看到后面的信息

- multi-head attention
<div style="text-align: center"><img src="/wiki/attach/images/Transformer-02.png" style="max-width:600px"></div>
<div style="text-align: center"><img src="/wiki/attach/images/Transformer-03.png" style="max-width:200px"></div>
<div style="text-align: center"><img src="/wiki/attach/images/Transformer-04.png" style="max-width:300px"></div>

- FFN：两层全链接，relu+无激活函数

- 输入和输出embedding和softmax用同一套，在embedding层对向量乘以维度的开方

- Positional Encoding，位置编码：由于模型不含递归和卷积，需要加入额外标记让模型学习到位置信息；论文尝试了可学习的和三角函数，发现两者效果类似，因此选择了更鲁棒的三角函数

- Transformer的优点：self-attention和rnn/cnn的对比，计算量更小，并行度更高

- 正则化：dropout（子层和embedding），label smothing

- Transformer的缺点：有些rnn轻易可以解决的问题（如序列复制），transformer很难实现；Positional Encoding的存在会导致在处理训练中没碰到过的句子长度（特别长）时表现很差。