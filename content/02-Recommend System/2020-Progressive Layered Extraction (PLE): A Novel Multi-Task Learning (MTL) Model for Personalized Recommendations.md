---
title: "2020-Progressive Layered Extraction (PLE): A Novel Multi-Task Learning (MTL) Model for Personalized Recommendations"
layout: page
date: 2021-01-10
---

## 总结

- 论文针对多目标优化中跷跷板现象，提出了PLE网络结构，并验证了其有效性。

## 主要内容

- 总结了目前多任务学习的网络结构模式。
<div style="text-align: center"><img src="/wiki/attach/images/PLE-01.png" style="max-width:850px"></div>
    -a)Hard sharing：在多目标相关性低的情况下，模型为了同时学习到两个目标，可能因为顾此失彼而造成负向效果。
    -b)Asymmetry sharing：不同任务前向传播结构是不一致的，需要利用一些先验知识，例如ESSM。
    -c)Customized sharing：自定义的底层结构，前向传播中有各自也有共享的。
    -d)MMOE：详见MMOE论文笔记。
    -e)CGC：本文提出的模型结构，相比MMOE添加了共享的Expert，并且将每个Expert优化为多个子Expert+gate向量。
    -f)Cross-Stitch（十字绣）网络：底层共享部分隐层向前传播时，下一层channels的输入值是上一层channels的线性组合。
    -g)Sluice Network：结合了多种底层结构，使得模型自己学习结构共享的方式。
    -h)ML-MMOE：多层MMOE堆叠的结构。
    -i)PLE:多层CGC堆叠的结构。
    
    
- CGC的结构如下，上文已经提到，它相比MMOE添加了共享的Expert，并且将每个Expert优化为多个子Expert+gate向量。
<div style="text-align: center"><img src="/wiki/attach/images/PLE-02.png" style="max-width:500px"></div>

- PLE的网络结构如下，是多层CGC堆叠的结构。
<div style="text-align: center"><img src="/wiki/attach/images/PLE-03.png" style="max-width:500px"></div>

- 多任务损失函数根据样本空间计算。
<div style="text-align: center"><img src="/wiki/attach/images/PLE-04.png" style="max-width:500px"></div>
<div style="text-align: center"><img src="/wiki/attach/images/PLE-05.png" style="max-width:300px"></div>

- 论文验证了PLE模型的有效性，并探究其有效的原因。PLE模型的Gate向量在不同任务间差异较大，说明了该模型在不同任务下的表达能力更强，同时也有shared部分来共享相同信息，可以说权衡了单独任务和共享任务之间的依赖关系。
<div style="text-align: center"><img src="/wiki/attach/images/PLE-06.png" style="max-width:500px"></div>
