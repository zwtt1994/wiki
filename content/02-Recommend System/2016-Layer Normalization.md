---
title: "2016-Layer Normalization"
layout: page
date: 2024-02-21
---

## 总结

- 提出Layer Normalization，相比于Batch能够应用到流式数据场景。


## 主要内容

- 将网络中的输入分布归一化，能够使得损失函数更加光滑，并显著减少模型的训练时间。

- Batch Normalization，是常用的方法之一，详见对应wiki，但BN的效果和batch的大小息息相关，并不适合用于流式数据的处理（变长、分布和时间相关）

- Layer Normalization
    - 和Batch Normalization类似，但归一化的维度是网络各层内部的神经元

<div style="text-align: center"><img src="/wiki/attach/images/LAYERNORM-01.png" style="max-width:400px"></div>

- RMS Norm
    - 对Layer Norm进行简化，去掉了均值归一化部分，即提高了计算速度，也缓解了异常值的影响
    - 和BN生效原因探究的论文结论类似，并不是ICS的原因，而是让损失函数更加光滑

<div style="text-align: center"><img src="/wiki/attach/images/LAYERNORM-02.png" style="max-width:400px"></div>

- 2020-On Layer Normalization in the Transformer Architecture
    - post/pre/sandwich-LN
    - post-LN，在每一层的计算之后进行LN
    - pre-LN，在每一层计算之前计算LN
<div style="text-align: center"><img src="/wiki/attach/images/LAYERNORM-03.png" style="max-width:400px"></div>
    - 训练Transformer时,预热过程对于Post-LN是有必要的
        - 预热过程是指先用极小的学习率训练一段时间
        - Post-LN训练时FNN的参数梯度较大，如果学习率也很大的话会不稳定
<div style="text-align: center"><img src="/wiki/attach/images/LAYERNORM-05.png" style="max-width:400px"></div>
    - 当使用Pre-LN结构时，warm-up阶段已不再是必需，并且Pre-LN结构可以大幅提升Transformer的收敛速度
        - 类似于resnet的操作，网络学习的是残差，使得损失函数更加平滑

<div style="text-align: center"><img src="/wiki/attach/images/LAYERNORM-04.png" style="max-width:800px"></div>

- 2022-DeepNet: Scaling Transformers to 1,000 Layers
    - pre-LN的性能优于post-LN，但其底层的梯度往往大于顶层，导致其性能不及Post-LN
    - pre-LN层数加深的作用与拓宽差不多，这样导致训练更稳定，但结果效果不够好。
    - Post-Norm每一层都能对输出进行norm变化，导致训练不够稳定，但是模型效果更好。
    - Deep Norm, DeepNorm结合了Post-LN的良好性能以及Pre-LN的训练稳定性
<div style="text-align: center"><img src="/wiki/attach/images/LAYERNORM-06.png" style="max-width:300px"></div>
<div style="text-align: center"><img src="/wiki/attach/images/LAYERNORM-07.png" style="max-width:600px"></div>