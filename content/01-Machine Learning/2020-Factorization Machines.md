---
title: "2010-Factorization Machines"
layout: page
date: 2020-06-18
---

本文提出了Factorization Machines（因子分解机）方法来学习特征（特别是稀疏特征）之间的交叉信息。


## 总结

- 本文提出了FM模型，能够在特征及其稀疏的情况下学习特征的交叉信息，并能够在线性时间进行serving，整个模型结构简单易学。
- FM在稀疏特征上能取得更好效果的原因：本质是矩阵分解的原理去建模共现信息，这也使得只要稀疏特征取值出现，即能够学到向量，从而泛化至共现。

## 主要内容

- FM的模型定义，以二维交叉为例（一般来说二维就够了，多维计算量剧增，性价比低）。他的本质是对每个输入定义一个可训练的向量，并通过向量内积来表示特征之间的相关性。
<div style="text-align: center"><img src="/wiki/attach/images/FM-01.png" style="max-width:500px"></div>

- 从上式可以看到计算复杂度是O(n2)，但由于对称性，可以将上式简化为O(n)的计算复杂度。这个简化本质上就是利用了先求和再平方来代替挨个计算。
<div style="text-align: center"><img src="/wiki/attach/images/FM-02.png" style="max-width:500px"></div>

- FM的训练，从上述简化后的式子即可简单的计算出各个参数的导数。
<div style="text-align: center"><img src="/wiki/attach/images/FM-03.png" style="max-width:400px"></div>

- 与SVM进行了对比，并实验证明了在数据比较稀疏的情况下，FM的效果优于SVM；FM可以直接学习，而非线性核SVM需要转换为对偶形式；FM模型型式与样本无关，而SVM则与支持向量相关。

- 与其他因子分解模型进行对比，结论是FM模型通用且有效。
    - 常规的MF是直接对用户/item构建向量，这等价于单特征（是否共现1/0）的FM。
    - SVD++引入了隐式的信息（评分是显式的，隐式的包括点击/收藏等），但交叉信息没有FM完备。
    - 还对比了PITF（对用户+item打Tag的场景，三个向量相互交叉），FPMC（基于用户+上一个购买，预测物品得分，也是三个向量交叉，只是物品向量在同一个特征空间），结论是利用FM都能模拟出近似的效果。
    
