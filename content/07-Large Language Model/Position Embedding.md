---
title: "Position Embedding"
layout: page
date: 2024-01-14
---

## 主要内容

- sinusoidal，三角函数位置编码
    - 每个位置编码是独特的
    - 周期性确保了编码的连续和平滑
    - 随着位置距离的增大，向量内积有趋近于0的趋势
<div style="text-align: center"><img src="/wiki/attach/images/POS-01.png" style="max-width:600px"></div>

- RoPE(Rotary Position Embedding)，旋转位置编码
    - 更直接地表示相对位置关系
    - 在attention计算的内积操作中加入相对位置信息，即实现下列表达式
<div style="text-align: center"><img src="/wiki/attach/images/POS-02.png" style="max-width:400px"></div>
    - 论文找到一个表达式满足上述关系
<div style="text-align: center"><img src="/wiki/attach/images/POS-03.png" style="max-width:200px"></div>
    - 假设是2维的情况，f函数进行推导后可以得到
<div style="text-align: center"><img src="/wiki/attach/images/POS-04.png" style="max-width:500px"></div>
    - 再进行推导就得到了如下表达式
<div style="text-align: center"><img src="/wiki/attach/images/POS-05.png" style="max-width:600px"></div>
    - 扩展到多维的情况，表达式如下
<div style="text-align: center"><img src="/wiki/attach/images/POS-06.png" style="max-width:400px"></div>
<div style="text-align: center"><img src="/wiki/attach/images/POS-07.png" style="max-width:600px"></div>
    - 因为矩阵很稀疏，所以可以简化为
<div style="text-align: center"><img src="/wiki/attach/images/POS-08.png" style="max-width:600px"></div>
    - 逻辑简单可以如下理解
<div style="text-align: center"><img src="/wiki/attach/images/POS-09.png" style="max-width:700px"></div>
    - RoPE 形式上和Sinusoidal类似，Sinusoidal是加性的，RoPE是乘性的
    - RoPE沿用了Sinusoidal中theta的定义，即\theta_i = 10000^{-2i/d}，它可以带来一定的远程衰减性。

- ALiBi
    - 使用sinusoidal的transformer的外推能力较弱，虽然RoPE有所改进，但也没有达到预期。
    - 为了有效地实现外推，ALiBi不向单词embedding中添加位置embedding，而是根据token之间的距离给attention score加上一个预设好的偏置矩阵
<div style="text-align: center"><img src="/wiki/attach/images/POS-010.png" style="max-width:600px"></div>
    - ALiBi不需要对原始网络进行改动，允许在较短的输入序列上训练模型，同时在推理时能够有效地外推到较长的序列，从而实现了更高的效率和性能。