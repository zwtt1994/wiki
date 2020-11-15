---
title: "2015-Deep Residual Learning for Image Recognition"
layout: page
date: 2020-11-15
---

## 总结

- 提出了ResNet结构，使得神经网络能够学习到恒等变换，解决深层神经网络的训练问题。

## 主要内容

- 理论上网络深度越深，模型表达能力越强，但梯度消失/爆炸问题对深度模型训练产生了阻碍。应对上述问题常见的有两种方式，参数初始化、中间层参数规范化。

- 当较深的网络能够收敛时，发现存在网络越深效果反而更差的现象（why？），并且这种现象并不是过拟合导致的，因为训练集的误差也变大了。
<div style="text-align: center"><img src="/wiki/attach/images/Res-01.png" style="max-width:400px"></div>

- 如果深层网络可以学习到恒等变换，那么至少他的效果不会比只有浅层网络更差，所以论文推测mlp很难学习到恒等变换。

- 本文引入ResNet结构，使得网络能够较为容易的学到恒等变换。
<div style="text-align: center"><img src="/wiki/attach/images/Res-02.png" style="max-width:400px"></div>

- 实验表明ResNet结构可以训练更深的网络，得到更好的结果。
<div style="text-align: center"><img src="/wiki/attach/images/Res-03.png" style="max-width:400px"></div>

- 对比了三种短链接，效果依次提升：
    - 直接短接，size不够用0补充；
    - 直接短接，size不够用投影变换；
    - 每个短接都是一个投影变换。

- 作者在下一篇论文Identity mapping in Deep Residual Networks深入探讨了res-net结构，并做了优化。
    - 去掉了res-net输出的relu激活函数，使得恒等变换更为直接。
    <div style="text-align: center"><img src="/wiki/attach/images/Res-04.png" style="max-width:400px"></div>
    - 由于恒等变换短接的存在，基本不可能出现梯度消失的情况。
    - 实验对比了各种短接结构，结果证明了恒等变换是最好的。
    <div style="text-align: center"><img src="/wiki/attach/images/Res-05.png" style="max-width:400px"></div>
    - 实验对比了激活函数的影响，得到了一个效果最好的结构。
    <div style="text-align: center"><img src="/wiki/attach/images/Res-06.png" style="max-width:400px"></div>
