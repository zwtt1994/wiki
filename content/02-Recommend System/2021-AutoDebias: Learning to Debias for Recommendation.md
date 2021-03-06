---
title: "2021-AutoDebias: Learning to Debias for Recommendation"
layout: page
date: 2021-06-10
---

## 总结

- 本文总结了推荐系统的偏差场景，提出了自适应去偏学习框架，并进行了实验分析。

## 主要内容

- 偏差种类可以分为
    - 选择偏差：用户倾向于和偏好相关的物品交互，而不是所有的物品。
    - 一致性偏差：用户对物品的评价受到群体意见的影响。
    - 曝光偏差：没有曝光的物品无法判断用户的交互结果。
    - 位置偏差：用户与物品的交互受物品位置的影响。

- 去偏方法主要可以分为
    - 反倾向得分（inverse propensity score）：因果推断中倾向得分是指用户在"基线因素p(x)"下达到结果的概率，反倾向得分则是将这一影响归一化。
    - 数据填充：由于观测到的数据是有偏的子集，所以可以对数据进行合理的填充。
    - 生成式模型：直接对P(y,x)进行建模，模型考虑了"基线因素p(x)"。
    
- 当前去偏方法存在的问题
    - 不具备普适性，去偏方法一般只针对某一种偏差。
    - 不具备自适应能力：偏差类型的变化，偏差本身的变化。
    
- 提出需要通用的去偏方法
    - 本文认为推荐系统中的偏差可以统一归因为经验风险的估计和理想风险函数之间的差异，换句话说是训练数据分布和真实数据分布之间存在差异。
   <div style="text-align: center"><img src="/wiki/attach/images/auto-bias-01.png" style="max-width:600px"></div>
    - 所以损失函数能够分解如下
   <div style="text-align: center"><img src="/wiki/attach/images/auto-bias-02.png" style="max-width:500px"></div>
    - 其中涉及的三个参数定义如下
   <div style="text-align: center"><img src="/wiki/attach/images/auto-bias-03.png" style="max-width:300px"></div>
    - 最后经验风险函数可以表示如下
   <div style="text-align: center"><img src="/wiki/attach/images/auto-bias-04.png" style="max-width:500px"></div>
    - 分析了上述损经验风险函数与各种去偏方法的关系，总结来说第一项的系数对应反倾向得分，第二项对应数据填充，具体见论文。
    - 定了无偏的损失函数之后，就需要学习其中的两个去偏参数。
    
- 自动去偏算法
    - 由于当前训练数据存在有偏情况，所以不可能学习到无偏的参数，所以需要新增无偏的数据：随机流量。
    - 具体的训练流程（meta learning）如下，和EM思路很像
        - Base learner：将去偏参数视作超参数，进行模型训练。
        - Meta learner：保持网络参数不变，用无偏的随机样本训练去偏参数。
    - 由于随机流量样本数量一般情况下是不足的，所以就用简单建模的方式去定义上述超参数，其中Xu是用户特征，Xi是物料特征，r是label，O是用户对item的交互信息，concat一起之后经过计算得到去偏参数。
    <div style="text-align: center"><img src="/wiki/attach/images/auto-bias-05.png" style="max-width:360px"></div>
    - 但上述人为确定的建模方式也可能造成归纳偏差（inductively bias），导致去偏参数学不好，但本文通过理论推导分析认为这种建模方式已经比较鲁棒了。
    - 在Meta训练中，如果每次都更新都重新训练一次Base网络十分耗时，所以本文提出为了简化计算，在每一次训练中同时交替更新Base和Meta部分。
    <div style="text-align: center"><img src="/wiki/attach/images/auto-bias-06.png" style="max-width:500px"></div>
    
- 实验验证
    - 在公共数据集Yahoo!R3和Coat上做了实验验证，在整体效果上本文提出的去偏方法比其他方法的效果都要更好。
    <div style="text-align: center"><img src="/wiki/attach/images/auto-bias-07.png" style="max-width:500px"></div>
    - 在推荐结果上的分析结果如下，本文的模型降低了热门物品的权重，能够曝光更多的长尾物品，并且增益也来自于此。
    <div style="text-align: center"><img src="/wiki/attach/images/auto-bias-08.png" style="max-width:700px"></div>
    - 在曝光偏差、位置偏差和选择偏差场景下与其他SOTA方法做了对比，验证了本文方法的有效性。
    <div style="text-align: center"><img src="/wiki/attach/images/auto-bias-09.png" style="max-width:600px"></div>
