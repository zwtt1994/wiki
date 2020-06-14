---
title: "2016-Deep Neural Networks for YouTube Recommendations"
layout: page
date: 2020-06-14
---

回顾YouTube推荐系统。


## 总结

- 本文系统的介绍了工业级推荐系统中可能遇到的问题和解决方法，值得多次阅读。

## 召回部分

<div style="text-align: center"><img src="/wiki/attach/images/youtube-01.png" style="max-width:500px"></div>
- 目的是在训练中产生user向量和item向量，在预测时做knn搜索做召回。
- 选择"观看完整个视频"为正样本，并利用重要性采样方法采样得到负样本，做softmax训练。
- 单塔模式，user向量是一系列特征经过dnn的embedding（其中包括预先word2vec训练的embbeding特征），item向量是user embedding到softmax的权值。
- 和DSSM不同，本文召回中用的是softmax做训练，原因是要产生item embedding向量；不能直接用word2vec的item向量是因为不在一个向量空间（可以用于i2i，或者以另一种方式用于u2i）。
- 引入样本日志距训练的时间特征（并在预测时置零），来表示视频新老程度。
- 尽量多的利用所有的样本，而不是由该推荐系统产生的样本，否则系统会大程度的偏向exploit。
- 为了防止活跃用户的影响太大，本文对每个用户的样本数量进行了限制。
- 为了防止搜索行为对下一个视频预测的影响，本文摒弃了时序信息，并用词袋方法来表示搜索词。
- 为了防止时间穿越，本文只利用label发生之前的特征。

## 排序部分

<div style="text-align: center"><img src="/wiki/attach/images/youtube-02.png" style="max-width:500px"></div>
- 目的是预测用户对视频的观看时长，这是一个综合性选择的label，避免了由于用户因为视频标题/缩略图等点击但又不喜欢看的情况。
- 特征工程，sparse特征做embedding（对出现次数少的做截断），dense特征做归一化（并引入平方/开放）。
- 为了将观看时长作为label，本文采用了weighted lr（两种方法，样本重复/更新权值），所以预测值的时候exp(wx+b)近似于观看时长（其原理和采样之后预测值的矫正一致）。

