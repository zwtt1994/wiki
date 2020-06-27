---
title: "2017-Deep Interest Network"
layout: page
date: 2020-06-26
---

## 总结

- 


## 主要内容

- 用户在电商场景的兴趣是多样化的，并且当前用户想看的东西只和部分历史数据相关。

- 常规的历史行为是通过multi-hot的形式引入的，但这种embedding+pooling的方式很容易很难从历史行为中提取出和当前强相关的item信息。
<div style="text-align: center"><img src="/wiki/attach/images/DIN-01.png" style="max-width:500px"></div>

- 本文提出将当前预测的item和历史行为item的"相关性"来作为attention的权值，更准确的利用用户历史行为中的特征。上文提到的"相关性"就是通过激活单元来获取。

- 本文训练中的一些trick
    - 频次正则化，思想是在一个batch中频次越高的特征惩罚越弱，即减弱重要特征的正则力度，以应对推荐场景下"头重，尾长"的特征现象。
    <div style="text-align: center"><img src="/wiki/attach/images/DIN-02.png" style="max-width:500px"></div>
    
    - Dice激活函数，全域梯度都大于0，梯度曲线随batch均值方差变化。
    <div style="text-align: center"><img src="/wiki/attach/images/DIN-03.png" style="max-width:500px"></div>
    <div style="text-align: center"><img src="/wiki/attach/images/DIN-04.png" style="max-width:500px"></div>