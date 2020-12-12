---
title: "2015-Batch Normalization: Accelerating Deep Network Training by Reducing Internal Covariate Shift"
layout: page
date: 2020-11-15
---


## 总结

- 论文利用实验得出BN与ICS无关，并且BN起作用的原因是因为它使得损失函数更加光滑。
- 其本质还是BN对网络输出进行了正则限制，规避了网络输出变化不可控的情况，同时可训练的shift&scale也能够保持模型的表达能力，使得模型自适应的权衡正则与表达能力。

## 主要内容

- internal covariate shif（ICS）：由于参数更新导致的隐藏层输出分布的变化。

- 为了提高参数分布的稳定性，可以尽量保持参数分布为标准正态分布；但由于每个mini-batch的数据分布不一致，且参数分布会随着训练调整，所以为了维持模型的表达能力，设置了可训练的归一化参数。

- 论文提出了两个问题，并做了实验验证。
    - Batch normalization是否与ICS有关？在BN后面人为加上了shift噪声，发现和不加的效果差不多，所以论文认为BN和ICS没有关系。
    - Batch normalization是否会消除或者减弱ICS？通过量化隐藏层梯度在前一层更新参数的差异来近似评估ICS，发现BN并不能减少ICS，反而还有增加。
    
- 论文认为BN起作用的原因是使得损失函数更加光滑，例如b-smoothness，即斜率绝对值不超过某个定值。
    - 更光滑的损失函数更容易训练，Visualizing the Loss Landscape of Neural Nets。
    - 附录中提到BN的作用与ResNet类似。

- 由于平滑损失函数能够带来作用，论文探究了几种L-p归一化的方式，发现虽然ICS比较严重，但训练效果都不错。

- 对上述实验结果进行了理论推导分析，得出了几个结论；加入了BN之后：
    - 损失函数对于激活输出的梯度幅值更小。
    - 损失函数对于激活输出的二阶导幅值也更小，即使得损失函数更加平滑。
    - 损失函数对于权重的梯度幅值也更小。
    - 权重初始值和最优值之间的距离也更接近。



