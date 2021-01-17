---
title: "2020-Multi-Interactive Attention Network for Fine-grained Feature Learning in CTR Prediction"
layout: page
date: 2021-01-16
---

## 总结

- 推荐系统中为了更好建模用户偏好，可以添加目标item与其他各类特征的交叉信息，本文用的是transformer与self-attention，如果考虑性能问题的话哈达玛积的性价比较高。

## 主要内容

- 推荐系统常用用户历史行为序列来挖掘用户兴趣，建模的方式一般是引入历史item与目标item的相关性。

- 但目标item与用户与环境的关系也十分重要，通过多塔建模并且添加目标item和用户特征以及环境特征的交叉信息是十分有效的。

- 网络结构如下，在网络交叉部分，历史item与目标item利用了Pre—LN Transformer，其余两个则利用了self-attention。
<div style="text-align: center"><img src="/wiki/attach/images/Multi-Interactive-01.png" style="max-width:700px"></div>

- 实验证明了网络的有效性，结果如下；同时做了线上abtest实验，对ctr带来了0.41%的增益。
<div style="text-align: center"><img src="/wiki/attach/images/Multi-Interactive-02.png" style="max-width:700px"></div>

- 验证了Pre-LN Transformer的有效性；同时选取了14个case可视化了global attention层分布，验证了新增交叉部分的有效性。
<div style="text-align: center"><img src="/wiki/attach/images/Multi-Interactive-02.png" style="max-width:500px"></div>
