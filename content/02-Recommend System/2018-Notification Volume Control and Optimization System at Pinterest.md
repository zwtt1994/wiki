---
title: "2018-Notification Volume Control and Optimization System at Pinterest"
layout: page
date: 2020-07-09
---

## 总结

- 在优化目标为dau的基础上，对推送的长期影响进行建模，并通过模型反馈搜索用户最佳频次。
- 在频次搜索上，文中没有给出用户频次的分布，比较好奇的是这种搜索方式是否真的有效，或者说和认为直接设置频次相比带来的收益有多少。
 
## 主要内容

- 背景
    - 推送存在以下问题：什么时候推送,什么渠道推送,怎样的推送频率。
    - 优化目标应该是长期收益，模型需要学到容量与效益间的非线性关系。
    
- 系统设计
    - Weekly Notification Budget：对用户的推送预算按周来计算。
    - Notification Service：决定是否推送，什么时候推送
        - Budget Pacer：决定用户当天是否推送，策略/模型都可以。
        - Ranker：推送内容排序，选择最优的。
        - Delivery：确定投放时间，投放并回收数据。
        
- 目标函数
    - 优化目标确定为DAU，这是比推送点击量更合理的目标。
    - 用户活跃概率可以建模为下式，并且从下图可以看到，推送的效益对于适度活跃的人是最高的，这也符合正常逻辑。
     <div style="text-align: center"><img src="/wiki/attach/images/Pinterest-01.png" style="max-width:300px"></div>
     <div style="text-align: center"><img src="/wiki/attach/images/Pinterest-02.png" style="max-width:300px"></div>
    - 在给定用户推送数量下，预估用户活跃的概率。
     <div style="text-align: center"><img src="/wiki/attach/images/Pinterest-03.png" style="max-width:300px"></div>
    - 对长期影响进行建模，优化目标是用户不退订情况下的活跃概率 + 用户退订后稳定下来的活跃概率
     <div style="text-align: center"><img src="/wiki/attach/images/Pinterest-04.png" style="max-width:300px"></div>

- 模型和算法
    - 一共三个模型，分别预测"用户活跃度"，"退订概率"和"退订后稳定下来的活跃概率"。
    - 一个推送频次估计算法，计算用户每周的推送次数。本质上就是在"推送频次"上对活跃度模型输出做搜索，选取活跃概率最大的频次。但由于限制了总推送量，所以每个用户的推送量应该是越小越好，所以本文在最大活跃度放宽的条件下搜索最小的频次。
     <div style="text-align: center"><img src="/wiki/attach/images/Pinterest-05.png" style="max-width:300px"></div>
    - 其中放宽条件是通过总推送量的限制搜索得到。
     <div style="text-align: center"><img src="/wiki/attach/images/Pinterest-06.png" style="max-width:300px"></div>

- 实验结果
    - 在push和email渠道的ctr都有了较大提升（减少了推送量），两个渠道的dau提升最大，说明模型学到了不同渠道的影响。
     <div style="text-align: center"><img src="/wiki/attach/images/Pinterest-07.png" style="max-width:300px"></div>
    - 优化后的推送量和之前的对比，这其实和之前提到的推送效益图是一样的。
     <div style="text-align: center"><img src="/wiki/attach/images/Pinterest-08.png" style="max-width:300px"></div>
