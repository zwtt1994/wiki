---
title: "2018-Visualizing the Loss Landscape of Neural Nets"
layout: page
date: 2020-11-27
---



## 总结

- 优化了神经网络损失函数空间可视化的方法，并借此探究模了型训练的难易程度的依赖因素。

## 主要内容

- 神经网络损失函数的可视化比较困难，主要体现在将高维的神经网络空间映射到低维空间上。常用的损失函数可视化方法为插值法，插值法又包括一维插值和多维插值。

- 文中提出普通的插值法很难捕获到损失函数suface的本质信息，例如BN结构具有参数尺度不变性。为了避免上述情况，本文提出了Filter-wise Normalization方法来选取探索方向。

- Filter-wise Normalization的本质是指将探索方向长度乘以参数的范数，避免了上述情况的同时，也使得探索方向的长度更具有意义。下面论文做了一系列实验，并对实验结果做了可视化。

- 分别利用插值法和本文提出的方法，在VGG-9网络上对大/小batch的损失函数进行了可视化，验证了本文可视化方法表现更佳。
    - 普通的插值法可视化，其结论为在1D可视化空间上，模型泛化能力与曲线分布没有直接关系。
    <div style="text-align: center"><img src="/wiki/attach/images/Vis-01.png" style="max-width:800px"></div>
    - 本文提出的可视化方法则可以得到曲线平滑程度与模型泛化能力存在对应关系。
    <div style="text-align: center"><img src="/wiki/attach/images/Vis-02.png" style="max-width:800px"></div>

- 基于VGG网络结构，利用本文提出的可视化方法探究模型训练的难易程度的依赖因素，得出了一系列结论。
    <div style="text-align: center"><img src="/wiki/attach/images/Vis-05.png" style="max-width:800px"></div>
    - 网络越深，非凸性越强，网络越难训练。
    - 添加了residual结构之后，随着网络深度的增加，损失函数空间不再混沌，更容易训练。
    <div style="text-align: center"><img src="/wiki/attach/images/Vis-06.png" style="max-width:800px"></div>
    - 卷积核数目越多，损失函数空间越平滑，泛化性越好；但计算复杂度也随之成倍增长。
    - 神经网络的初始化也十分重要，如果初始化的不够好，很难通过训练得到最优解。
    - 可视化的损失函数越平滑错误率越低，反之越混沌错误率越高。
    - 可视化空间的hessian矩阵能够一定程度的表示网络的凹凸程度；但毕竟是近似的低维空间，准确性不可估计。
    
- 利用可视化追踪训练中loss的变化。
    - 如果直接用随机产生的向量做可视化，会出现下图的情况，因为两个随机的二维向量在高维几乎是正交的。
    <div style="text-align: center"><img src="/wiki/attach/images/Vis-07.png" style="max-width:800px"></div>
    - 为了更好地得到训练中loss的变化，构造了参数差矩阵，并用pca得到特征值最大的两个特征向量做投影，得到结果如下。
    <div style="text-align: center"><img src="/wiki/attach/images/Vis-08.png" style="max-width:800px"></div>


