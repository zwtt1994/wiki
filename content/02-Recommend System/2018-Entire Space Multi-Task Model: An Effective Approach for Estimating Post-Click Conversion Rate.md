---
title: "2018-Entire Space Multi-Task Model: An Effective Approach for Estimating Post-Click Conversion Rate"
layout: page
date: 2020-06-22
---

## 总结

- 本文利用多目标学习解决了pCVR预测任务中的样本有偏问题。

## 主要内容

- 对于pCVR预估任务，实际中有意义的样本为"点击样本"（当用户点击后有下单行为则label为1，否则为0），但预测时却要对所有"曝光样本"进行预测，使得训练和预测时样本分布不一致。
<div style="text-align: center"><img src="/wiki/attach/images/cvr-00.png" style="max-width:500px"></div>

- 利用多目标学习预测pCTR与pCTRCVR来解决样本有偏问题，本质上是利用了pCTRCVR = pCTR * pCVR 的关系，且pCTRCVR和pCTR的训练中不存在上述有偏问题。
<div style="text-align: center"><img src="/wiki/attach/images/cvr-01.png" style="max-width:500px"></div>

