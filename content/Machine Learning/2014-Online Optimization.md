---
title: "2011-the equivalence of logistic regression and maximum entropymodels "
layout: page
date: 2020-06-20
---



## 总结

- 总结

## 主要内容

- L1正则化由于次梯度的原因会对特征产生稀疏的情况，稀疏的好处就是进行特征选择，简化模型复杂度，提高训练效率。但在batch的模式下，单batch的SGD优化往往由于随机性而达不到稀疏的效果，但这在离线训练中可以通过所有样本以及多个epoch的方式来解决，因为用的只是最后训练完的模型。
- 在线学习中一般也是利用batch的形式来训练，但线上使用的就是单batch训练完之后的模型，此时就无法达到理想中L1的稀疏效果。
- 为了在在线学习中引入稀疏，提出了下面几个方法
    - 简单截断，每训练T次才做一次截断（避免随机性导致的错误截断）,在训练中对参数小于某个阈值的直接截断为0，简单粗暴。
    - Truncated Gradient（TG），与简单截断类似，是指在其中加上了对参数的微调。
    <div style="text-align: center"><img src="/wiki/attach/images/onlinTrain-01.png" style="max-width:500px"></div>

    - Forward-Backward Splitting（FOBOS），前向后向切分，本质上是指当样本训练中某次更新后的参数绝对值不够大时令其为0，和TG其实是差不多的。
    <div style="text-align: center"><img src="/wiki/attach/images/onlinTrain-02.png" style="max-width:500px"></div>
    
    - Regularized Dual Averaging（RDA），正则对偶平均，本质上是当某个参数维度累计梯度小某个值时令其为0。
    <div style="text-align: center"><img src="/wiki/attach/images/onlinTrain-03.png" style="max-width:500px"></div>
    
    - FOBOS是batch维度做调整，训练精度较高，RDA则更容易产生稀疏性，所以结合上述两者提出了Follow the Regularized Leader（FTRL）。
    
    - 