---
title: "LLaMA-META系列"
layout: page
date: 2024-09-28
---

## 主要内容

- LLaMA1(2022)
    - 摘要：用公开数据集就可以训练出优异的基础语言模型，特别的是LLaMA-13B与GPT3-175B表现相当
    - 数据集：1.4T个tokens（TB=10的12次方）
    - 参数范围：7B-65B（B=10的9次方），serving时小模型速度更快，LLaMA可在单GPU上运行
    - 训练成本：2048个A100/80GB/GPU上，开发和训练5个月，65B模型训练一次21天（380 tokens/second/GPU）
    - 训练数据源：使用了CommonCrawl（67%）、C4（15%）、Wikipedia（4.5%)、Books(4.5%)、ArXiv(2.5%)等，Wiki和Books质量高会训练2次
        - 数据处理：行/书级别去重、ngram语言模型过滤低质内容
    - 网络架构：基于Transformer做了一些改进  
        - pre-normalization：收敛更快但上限不如post-normalization，详见论文笔记Layer Normalization
        - SwiGLU激活函数：GLU和Swish的结合，既能够具备gate的选择性，又使得全域都具备梯度，SwiGLU(x)=x1*sigmoid(x1)*sigmoid(x2)
        - RoPE：旋转位置编码，在attention中加入位置参数，详见论文比例Position Embedding
        - 超参数数量：估算为12*Tranformer层数*隐藏层维度的平方，attention矩阵的维度=隐藏层维度/多头数
            - 6.7B的模型参数配置为：隐藏层维度4096，multi-attention多头数32，Transformer层数32，学习率0.0003，batch size=4M
    - Optimizer：AdamW优化器，并叠加10%的余弦式衰减，AdamW相比Adam解决的就是将衰减直接作用到最后的参数更新，而不参与动量的更新。
    - 优化训练速度：
        - 利用causal multi-head attention的时序特性，减少对mask部分的计算和存储
        - 利用checkpoint存储了计算成本较高的结果，用空间换时间
        - 利用model and sequence parallelism进一步提升上述优化效率
        - overlap 激活计算和 GPU 之间的网络通信，提升时分复用的效率
- 
<div style="text-align: center"><img src="/wiki/attach/images/infini-01.png" style="max-width:600px"></div>
