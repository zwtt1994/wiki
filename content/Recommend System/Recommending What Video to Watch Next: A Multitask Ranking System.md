---
title: "Recommending What Video to Watch Next: A Multitask Ranking System"
layout: page
date: 2020-06-14
---

Google发表的一篇预测用户下一个观看视频的文章，用YouTube做了在线的实验。

## 总结

- 本文提的比较多的一点是推荐系统中的"选择偏差"，因为所有的训练样本都是基于目前的推荐系统，所以用户反馈和用户实际意图之间存在差异；但文中详细介绍和实验提及的只是众所周知的"位置偏差"。
- 本文通过利用用户的各种行为（多目标优化）并引入"选择偏差"模块，近似的去解决上述的"选择偏差"问题，整体结构有一定的参考意义。
- 利用YouTube做了实验，证明了多目标优化与"位置偏差"模块的效果。


## 主要内容

- 目标是根据目前所观看的视频，预测下一个观看的视频；使用召回-排序的常规模式；特征一笔带过，主要包括视频的各种embedding，用户的常规特征。
- 利用MMOE做多目标优化，并将label分为用户"交互行为"与"兴趣行为"；其中"交互行为"包括点击，观看等常规行为；"兴趣行为"包括收藏，反感等表达兴趣的行为；类别label用二分类，数值label用回归。
- 特别的是，本文将MoE结构搭建在底层共享部分的最后一个隐层之上，目的是为了简化模型，并在实验中证明了和直接在输入层上搭建基本没有区别。
- 为了解决"选择偏差"问题，本文将"选择偏差"相关的特征（如视频位置特征，设备信息等，文中只提到这两个）经过一个dnn结构预测输出一个logit，并和"交互行为"的label求和，这边文中并没有提及模型结构/特征的细节，但应该可以根据具体推荐场景来设计。
<img src="/wiki/attach/images/next-watch-01.png" style="max-width:500px">
## 具体实验

- 在YouTube上做了实验，给出了实验结果。
<img src="/wiki/attach/images/next-watch-02.png" style="max-width:500px">
- 实验证明了将MoE结构搭建在隐层上和输入层上的结果是差不多的，并分析了gate输出的分布。"交互行为"往往共享多个expert，"兴趣行为"则集中依赖于较少的expert。（看着不是很特别明显）
<img src="/wiki/attach/images/next-watch-03.png" style="max-width:500px">
- 实验中由于分布式训练的原因，导致gate网络中20%的Relu值为0，所以加了10%的dropout。
- 以"位置偏差"为例，验证了本文解决偏差方法的有效性。
<img src="/wiki/attach/images/next-watch-04.png" style="max-width:400px">
<img src="/wiki/attach/images/next-watch-05.png" style="max-width:400px">
    


