---
title: "XLNet: Generalized Autoregressive Pretraining for Language Understanding"
layout: page
date: 2024-01-28
---

## 主要内容

- XLNet是一种广义的AE方法

- 无监督语言模型
    - 自回归语言模型（auto-regressive，AR）：根据上文内容预测下一个词，例如GPT和ELMo，ELMo做了两个方向但本质还是AR的思路
    - 自编码语言模型（auto-encoding，AE）：把输入序列mask一部分，通过模型进行还原，例如BERT（Mask language model）
    - AR是BERT出现以前常用的语言模型，但缺点是不能进行双向编码，因此BERT采用了AE，但同时也引入了两个缺点
        - 预训练阶段和fine-tune阶段存在差异
        - 假设mask之间相互独立
<div style="text-align: center"><img src="/wiki/attach/images/XLNet-01.png" style="max-width:400px"></div>
<div style="text-align: center"><img src="/wiki/attach/images/XLNet-02.png" style="max-width:400px"></div>

- Permutation Language Model
<div style="text-align: center"><img src="/wiki/attach/images/XLNet-03.png" style="max-width:300px"></div>
    - 本文提出PLM来解决BERT遇到的两个问题，将输入顺序打乱位不同排列方式，再按照AR的方式去学习
    - 因为对于不同的排列方式，模型参数是共享的，所以模型最终可以学习到双向的信息
    - 由于计算复杂度的限制，每个序列输入一般只采样一个排列顺序
    - 在实际训练时不会真的打乱序列，而是通过mask矩阵实现permutation，保证不会存在pretrain和finetune之间的差异


- Two-Stream Self-Attention
<div style="text-align: center"><img src="/wiki/attach/images/XLNet-04.png" style="max-width:800px"></div>
    - 具体实现中使用了双流注意力机制，来保证预估时考虑到目标的位置信息，同时能够包含双向的文本信息
    - query stream在对需要预测的位置预测的同时不会泄露当前位置的内容 
    - 预训练阶段最终预测只使用query stream，因为content stream已经见过当前token了
    - 在精调阶段使用content stream，又回到了传统的self-attention结构


- Transformer-XL
    - Transformer需要为输入序列设置一个固定长度length，来保证模型性能
    - 当输入文本序列短于length时可以进行填充，当输入序列长于length时，则将输入序列划分为多个segments
    - 多个segments在训练时并没有上下文信息，因此导致了信息割裂
    - segment状态缓存
        - 在对当前segment进行处理的时候，缓存并利用上一个segment中所有layer的隐状态序列，并且上一个segment的隐状态序列不参与反向传播，建立了segments之间的依赖关系
<div style="text-align: center"><img src="/wiki/attach/images/XLNet-05.png" style="max-width:600px"></div>
    - 相对位置编码
        - 间隔位置大小为参数，在算attention的时候，只考虑query与key的相对位置关系