---
title: "2015-Batch Normalization: Accelerating Deep Network Training by Reducing Internal Covariate Shift"
layout: page
date: 2020-11-15
---


## 总结

- Batch normalization通过对中间结果进行标准化，并加以自适应的scale&shift，使得损失函数变得平滑。

## 主要内容

- 由于梯度消失/梯度爆炸的存在，神经网络越深会导致网络更难训练。同时在前向传播时底层的轻微扰动可能会使得深层的网络输出发生比较大的变化。

- internal covariate shif（ICS）：由于参数更新导致的隐藏层输出分布的变化。

- 为了提高参数分布的稳定性，可以尽量保持参数分布为标准正态分布；但由于每个mini-batch的数据分布不一致，且参数分布会随着训练调整，所以为了维持模型的表达能力，设置了可训练的归一化参数。

- BN的转换方式如下：
<div style="text-align: center"><img src="/wiki/attach/images/BN-01.png" style="max-width:500px"></div>

- 训练阶段，均值和方差由mini-batch中的样本计算所得，scale&shift参数参与训练。

- 预测阶段，均值和方差是训练样本总的均值与方差，整个过程保持不变。
<div style="text-align: center"><img src="/wiki/attach/images/BN-02.png" style="max-width:500px"></div>

- 预测时归一化中使用的均值方差理论上是训练集所有batch期望的无偏估计，但tensorflow的更新方式如下，少了一个存储，多了一个超参，弱化了训练过的数据的影响。
<div style="text-align: center"><img src="/wiki/attach/images/BN-03.png" style="max-width:500px"></div>

- 论文讨论了BN的位置，认为放在线性层和激活层之间最好，这个也是很直观的，最大化BN自适应权衡模型表达和正则的能力。

- 由于BN能够大程度地避免梯度爆炸和消失问题，可以使用较大的学习率，论文用三个公式做了表述。
    - 公式一表达了BN输出的尺度不变性，能够提升模型的稳定性；
    <div style="text-align: center"><img src="/wiki/attach/images/BN-04.png" style="max-width:500px"></div>
    - 公式二表达了BN对输入梯度的尺度不变性，提升模型训练的稳定性；
    <div style="text-align: center"><img src="/wiki/attach/images/BN-05.png" style="max-width:400px"></div>
    - 公式三表达了BN参数越大，反而输出对其梯度更小，更新越平滑。
    <div style="text-align: center"><img src="/wiki/attach/images/BN-06.png" style="max-width:700px"></div>
    
- 由于BN是对整体训练样本起作用，所以论文建议弃用dropout。