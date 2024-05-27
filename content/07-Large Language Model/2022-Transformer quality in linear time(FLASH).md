---
title: "Transformer quality in linear time(FLASH)"
layout: page
date: 2024-05-20
---

## 主要内容

- 原始多头注意力机制（MHSA+FFN）
<div style="text-align: center"><img src="/wiki/attach/images/FLASH-01.png" style="max-width:400px"></div>


- 改进全链接层（MHSA+GLU），两条支路都是全连接层加激活函数。
    - 两条支路的激活函数可以不同,最后两路的结果会做element-wise相乘，得到的结果会再经过一个全连接层进行处理，有效提升模型性能.
<div style="text-align: center"><img src="/wiki/attach/images/FLASH-02.png" style="max-width:400px"></div>


- GAU（Gated Attention Unit），将MHSA和GLU融合，是NAS搜索出来的；
    - 只有一个多头，参数量是之前的一半，效果反而微正，但本质上训练计算复杂度还是T方，后续优化思路是先计算QK矩阵，复杂度是d方；
    - 推理阶段可以缓存上次结果，复杂度优化为d方，但训练无法并行。
<div style="text-align: center"><img src="/wiki/attach/images/FLASH-03.png" style="max-width:400px"></div>


- 为解决训练无法使用上述技巧的问题，本文将Partial Attention和Linear Attention融合提出了Mixed Chunk Attention。
- 即将句子切分为G个chunk，计算local和global两个attention。本质上是将并行效率和时序计算做了分段权衡。
<div style="text-align: center"><img src="/wiki/attach/images/FLASH-04.png" style="max-width:600px"></div>
<div style="text-align: center"><img src="/wiki/attach/images/FLASH-05.png" style="max-width:400px"></div>

- Chunk是否需要overlap：提升模型性能，但也增加计算量，还不入多加几层不overlap的GAU
- 局部和全局注意力的消融实验：显示相对来说局部注意力比全局注意力更重要，而混合式的效果最好。
- Chunk大小该如何选择：实验搜索，256对于论文中数据效果最佳；C=T时并行度最高，计算复杂度最高，C=1时等价于Linear Attention计算复杂度最低，但也缺乏了并行度。
