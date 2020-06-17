---
title: "2018-MMoE(Modeling Task Relationships in Multi-task Learning with Multi-gate Mixture-of-Experts)"
layout: page
date: 2020-06-15
---


## 总结

- 本文提出并实验证明了MMOE结构在多目标学习中的有效性。

## 主要内容

- 介绍了多目标学习中的shared-bottom，MOE，并提出了MMoE。
<div style="text-align: center"><img src="/wiki/attach/images/mmoe-01.png" style="max-width:600px"></div>

- 利用人工合成数据控制label之间的相关性，并在上述三个结构上做了实验。实验结果表明MMOE结构在不同相关性的多任务学习中表现既好又稳定。
<div style="text-align: center"><img src="/wiki/attach/images/mmoe-02.png" style="max-width:600px"></div>

- 通过随机采样多组数据，随机初始化模型参数进行多次实验，进一步评估了三种结构的训练鲁棒性。
实验结果表明shared-bottom结构表现最差，结果分布方差较大；OMoE在两个任务相关性较强时和MMoE结果接近，但在任务相关性较低时性能较差；总体上也是证明了MMoE结构的在训练中的鲁棒性。
<div style="text-align: center"><img src="/wiki/attach/images/mmoe-03.png" style="max-width:700px"></div>

- 用真实数据对比了MMoE和其他几种比较新的多目标学习方法的效果。
    - L2-Constrained：多目标模型参数加上L2的正则限制，即在损失函数中加上两个参数矩阵的L2范数。
    - Cross-Stitch：引入cross-unit结构，多目标模型的下一个隐层与所有的模型隐层都相关。
    <div style="text-align: center"><img src="/wiki/attach/images/mmoe-04.png" style="max-width:300px"></div>
    - Tensor-Factorization：将隐层之间的参数按多目标数量扩充，并将其分解为矩阵乘积，多目标之间的相关性由矩阵分解引入。
    <div style="text-align: center"><img src="/wiki/attach/images/mmoe-05.png" style="max-width:400px"></div>
    - 实验数据多目标label：收入/婚否（皮尔森相关系数0.1768），教育水平/婚否（皮尔森相关系数0.2373）
    - 实验结果主要体现了MMoE的效果，作者也说明了Tensor-Factorization较差的原因是在浅层隐层就限制多目标间的参数，当多目标间相关度不大时会产生负向效果。
    <div style="text-align: center"><img src="/wiki/attach/images/mmoe-06.png" style="max-width:500px"></div>
    - 在Google的推荐系统上进行了离线实验，包括两类label，互动型（如点击）label和满意型（如收藏）label，实验结果同样显示了MMoE结构的效果。
    <div style="text-align: center"><img src="/wiki/attach/images/mmoe-08.png" style="max-width:500px"></div>
    - 在实验中分析了gate的分布，显示了满意型的label的expert更集中，这也说明了label给MMoE结构较强的label信息。
    <div style="text-align: center"><img src="/wiki/attach/images/mmoe-07.png" style="max-width:500px"></div>
    - 给出了线上实验结果，shared-bottom相比与基线，在参与度label下表现又略微下降（这个在实际种比较重要），满意度label有较大提升；MMoE相比与shared-bottom有一定的提升，综合来看MMoE相比于基线是两种label都有提升。
    <div style="text-align: center"><img src="/wiki/attach/images/mmoe-09.png" style="max-width:500px"></div>

