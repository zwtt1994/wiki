---
title: "2020-Improving Deep Learning For Airbnb Search"
layout: page
date: 2021-06-15
---

## 总结

- 阐述了Airbnb房源预定场景在三个方向上的探索：网络结构、冷启动和位置偏置。

## 主要内容

- 网络结构
    - 通过统计被预定的房源价格，发现客人倾向于预定更低的价格，文章就想加强上述规律。
    - 在预测值和模型结构上，将价格特征分离开，并强行使得价格越低预测得分越高，最后效果下降。如果模型拟合较好，肯定已经学习到了价格的影响因素，强行加入人为限制肯定会导致效果下降。
    - 文章进一步根据数据分析负向的原因，发现不同城市价格的波动比较大，所以综合来看并不是简单的价格负相关。上述结论是很直观的，文章根据数据分析得出了结论，并且文章人为价格负相关+城市影响导致现在的模拟合不好。
    - 根据之前的一系列分析，文章又进行了一系列逻辑分析，我没看懂。但总之是提出双塔结构，用户+Query一个塔/房源一个塔，余弦相似度作为预测得分。
    - 从我自己角度理解迭代的思路可能是这样的：单拎出价格负相关是不起作用的，所以把所有房源相关特征都拎出来，包括之前提到的城市等位置信息。
    - 这部分的结尾，文章又对价格的影响做了分析，我又没看懂；最后还将房源embedding进行了可视化，再加了一顿分析，我还是没看懂。
    - 我自己的理解总结这部分工作：用了双塔模型拿到效果，可视化简单验证合理性。
    - 我自己对价格特征相关工作的理解：从价格特征角度做了数据分析，其实用其他特征分析也一样，结论就是需要综合考虑房源侧的特征，引出双塔。

- 冷启动
    - 由于房源冷启动的问题是没有历史的参与特征，所以论文将EE问题转换为预估房源的参与特征，如预定数、浏览数和评论数，也算是常规操作。
    - 预估方式有两种，一种是基于全局的默认值，另一种是基于和新房源类似的房源的参与特征均值。
    - 预估结果的评估方式，线上抽样排名靠前的样本，实际参与特征计算得到排名结果和预估参与特征得到的预估结果之间的diff越小，预估方式越准。

- 位置偏差
    - 将偏好特征和位置偏置特征分开建模，在线预估时将位置特征统一设置。
    - 为了避免位置特征过于强势导致模型没能学好用户偏好，离线训练时在位置特征部分加入了dropout。
    - 整体上和微软、华为的思路一致。
 <div style="text-align: center"><img src="/wiki/attach/images/airbnb-bias-01.png" style="max-width:500px"></div>