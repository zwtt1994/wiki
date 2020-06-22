---
title: "2020-Soft Gradient Boosting Machine"
layout: page
date: 2020-06-07
---


## 总结

- Soft GBM本质上和多目标学习没有区别，只是在多目标之间加上了残差的限制。
- Soft GBM和普通GBM的区别是同时训练/逐个训练，除了提升训练效率之外，低阶的弱学习器会在整个训练过程中做调整，而不是固定不动。

## 主要内容

- 下图对比了普通的GBM和Soft GMB的区别。Soft GMB假设弱学习器都是可微的前提下，同时训练所有的弱学习器。
<div style="text-align: center"><img src="/wiki/attach/images/Sgbm-01.png" style="max-width:500px"></div>

- 将软决策树作为弱学习器，构建了Soft GBDT，我理解这边用软决策树还是其他模型对整体思路影响不大，可能是为了和GBDT做对比所以用的软决策树。
<div style="text-align: center"><img src="/wiki/attach/images/Sgbm-02.png" style="max-width:500px"></div>