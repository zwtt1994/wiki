---
title: "2021-Contrastive Learning for Debiased Candidate Generation in Large-Scale Recommender Systems"
layout: page
date: 2021-09-30
---

## 总结

- 分析了对比学习和反倾向得分去偏之间的关系，并提出了一个去偏的对比学习框架。

## 主要内容

- 海量候选集召回中的对比学习
    - 对比学习：关注正负样本特征的差异，而不是每次只关注单样本特征与label的关系。
    <div style="text-align: center"><img src="/wiki/attach/images/CLR-02.png" style="max-width:350px"></div>
    - 所以对比学习的损失函数如下，和sample softmax很相似
    <div style="text-align: center"><img src="/wiki/attach/images/CLR-04.png" style="max-width:450px"></div>
    - sample softmax的损失函数如下，他的含义是用q(y|x)来采样负样本，收敛得到的参数和常规的softmax最大似然估计是一样的。
    <div style="text-align: center"><img src="/wiki/attach/images/CLR-06.png" style="max-width:500px"></div>
    <div style="text-align: center"><img src="/wiki/attach/images/CLR-03.png" style="max-width:500px"></div>

- 对比学习和反倾向得分去偏的关系
    - 反倾向得分去偏的损失函数如下
    <div style="text-align: center"><img src="/wiki/attach/images/CLR-05.png" style="max-width:300px"></div>
    - 文章得出的结论如下，证明见论文
    <div style="text-align: center"><img src="/wiki/attach/images/CLR-08.png" style="max-width:800px"></div>
    - 因此对比学习的损失函数能够达到和反倾向得分去偏一样的效果，所以现在的问题就是确定q(y|x)。
    - 几个概率定义如下
        - q(y|x)：在给定条件下y物品给用户推荐的概率；
        - q(y)：y物品给用户推荐的概率；
        - pdata(y):y物品给用户推荐并被点击的概率；
        - q(y|x)难以预估，并且"高准确高方差"的系数并不一定好于"平滑低方差"的系数，所以可以使得q(y)近似表示q(y|x)，q(y)又和pdata(y)高度相关。
    - 因此从点击样本中采样负样本就可以近似实现对比损失的效果，从而实现反倾向得分去偏的效果。
    
- 队列采样方法
    - 为了减少采样带来的计算以及分布式通信成本，提出在local缓存一个FIFO队列记录历史的正样本。
    - 当队列大小和batch大小一样时，bc方法和a方法一致，为提升泛化性则选择较大的队列长度=2560和较小的batch size=256。
    - b和c的区别是缓存特征还是缓存计算好的embedding，c方法训练时因为梯度回传不到负样本所以收敛需要更多step，但由于他减少了计算量整体训练效率是提升的。
    <div style="text-align: center"><img src="/wiki/attach/images/CLR-07.png" style="max-width:600px"></div>

- 实验结果
    - item的多样性提升了，并且效果也提升了。
    <div style="text-align: center"><img src="/wiki/attach/images/CLR-01.png" style="max-width:700px"></div>