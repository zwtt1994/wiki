---
title: "2010-From RankNet to LambdaRank to LambdaMART: An Overview"
layout: page
date: 2021-02-11
---

## 总结

- 

## 主要内容

- RankNet：pair-wise的基础思想
    - 在两个item通过排序模型计算出得分之后，通过sigmoid函数近似计算得这两个item排序的概率。
    <div style="text-align: center"><img src="/wiki/attach/images/pairwise-01.png" style="max-width:300px"></div>
    - 根据上述近似概率与真实概率，得到交叉熵损失函数；当个item分数相同时，损失函数为log2，这会使得模型计算得分趋向于分散。
    <div style="text-align: center"><img src="/wiki/attach/images/pairwise-02.png" style="max-width:300px"></div>
    - 对真实概率进行了重新定义，得到损失函数新的写法。
    <div style="text-align: center"><img src="/wiki/attach/images/pairwise-03.png" style="max-width:300px"></div>
    - 计算损失函数对得分的导数，并得到梯度下降中参数的更新计算。
    <div style="text-align: center"><img src="/wiki/attach/images/pairwise-04.png" style="max-width:400px"></div>
    <div style="text-align: center"><img src="/wiki/attach/images/pairwise-05.png" style="max-width:400px"></div>
    - 论文强调了学习率是正数，但这个应该是直观的，不然不就往反方向更新了。
    <div style="text-align: center"><img src="/wiki/attach/images/pairwise-06.png" style="max-width:450px"></div>

- 加速RankNet的训练
    - 根据上文，可以得到损失函数对参数的导数。
    <div style="text-align: center"><img src="/wiki/attach/images/pairwise-07.png" style="max-width:450px"></div>
    <div style="text-align: center"><img src="/wiki/attach/images/pairwise-08.png" style="max-width:400px"></div>
    - 避免两个item重复计算，将n方次计算简化为一半；并将每个item的lambda聚合，其含义近似为文档排在前面的倾向系数。
    <div style="text-align: center"><img src="/wiki/attach/images/pairwise-09.png" style="max-width:400px"></div>
    <div style="text-align: center"><img src="/wiki/attach/images/pairwise-10.png" style="max-width:300px"></div>

- 信息检索的评分标准
    - MRR(Mean Reciprocal Rank)，平均倒数排名，其中Q是查询数量，ranki是相关结果所在位置，只能度量每次只有一个相关结果的情况。
    <div style="text-align: center"><img src="/wiki/attach/images/pairwise-11.png" style="max-width:300px"></div>
    - MAP(Mean Average Precision)，平均正确率均值，计算所有相关结果的准确率之和。
    <div style="text-align: center"><img src="/wiki/attach/images/pairwise-12.png" style="max-width:300px"></div>
    - NDCG(Normalized Discounted Cumulative Gain)，归一化折损累积增益，其中li为相关程度（文中举例取值范围为0～4），maxDCG即是最佳排序的DCG值。
    <div style="text-align: center"><img src="/wiki/attach/images/pairwise-13.png" style="max-width:300px"></div>
    <div style="text-align: center"><img src="/wiki/attach/images/pairwise-14.png" style="max-width:300px"></div>
    - ERR(Expected Reciprocal Rank)，预期倒数排名，目的是改善NDCG计算当前位置得分未考虑前面item的情况。
    <div style="text-align: center"><img src="/wiki/attach/images/pairwise-15.png" style="max-width:300px"></div>
    <div style="text-align: center"><img src="/wiki/attach/images/pairwise-16.png" style="max-width:300px"></div>

- LambdaRank
    - 在排序中，我们在大部分情况下应该是更希望下图左边的情况，而下图两种情况只有NDCG和ERR才能区分出来，但这两种评分标准是不可导的，所以就有了LambdaRank。
    <div style="text-align: center"><img src="/wiki/attach/images/pairwise-17.png" style="max-width:300px"></div>
    - 
