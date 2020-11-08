---
title: "2017-Attention Is All You Need"
layout: page
date: 2020-07-25
---

## 总结

- 
 
## 主要内容

- Transformer结构如下，整体框架分为encode和decode两部分，整体结构。
<div style="text-align: center"><img src="/wiki/attach/images/Transformer-03.png" style="max-width:400px"></div>

- Attention的通用结构如下，他的本质是通过计算Query和Key之间的相似程度来对Value进行加权求和。文中提到的Self-attention是指上述Q=K=V（encode部分）或者是Q=K（decode部分），本质上都是attention的简化。
<div style="text-align: center"><img src="/wiki/attach/images/Transformer-01.png" style="max-width:300px"></div>

- Self-attention再具体分析下。。

- Multi-head attention，多个Attention结构可以得到多个输出结果，这些结果中的Attention分布往往是不同的，各有侧重。
<div style="text-align: center"><img src="/wiki/attach/images/Transformer-02.png" style="max-width:300px"></div>

- Decode做Mask目的是防止label穿越，在计算Multi-head attention结构的时候，避免把还没decode出来的部分算上，实际测试的时候不需要mask。

- Positional Encoding，由于Transformer摒弃了序列信息，所以需要将这部分补充进来。文中提到了两种方法，三角函数映射和学出一份位置embedding，尝试之后发现效果差不多。

- Transformer的优点：计算复杂度较小；摒弃了时间序列，在某些计算上可以并行，且可以用窗口来降低计算复杂度；由于使用了attention结构，可结实性更强。

- Transformer的缺点：有些rnn轻易可以解决的问题（如序列复制），transformer很难实现；Positional Encoding的存在会导致在处理训练中没碰到过的句子长度（特别长）时表现很差。