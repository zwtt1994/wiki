---
title: "2020-Interpretable Click-Through Rate Prediction through Hierarchical Attention"
layout: page
date: 2020-06-14
---

## 总结

- 本文提出了InterHAt模型结构，本质上是利用Transformer和AttentionalAgg层来处理数据，来捕获特征交互中的多义性，同时使得特征在模型中传递时能够保持序列关系，从而更好的进行模型解释/分析。
- 核心的思想是在提取高阶特征的同时保持特征的有序性，使得高阶特征分析成为可能。

## 主要内容

- InterHAt模型结构如下。
    <div style="text-align: center"><img src="/wiki/attach/images/InterHAt-01.png" style="max-width:500px"></div>

- 底层是一个embedding层，类别特征one-hot后映射到d维向量；数值特征也设置一个可训练的d维向量Vd，输入值为特征值*Vd；最终输入特征维度为d*m。

- 之后是Transformer层，从文中的说明来看应该是用了transformer的encode部分，并将多个输出加权求和，重新整合成d*m的维度。
    <div style="text-align: center"><img src="/wiki/attach/images/InterHAt-02.png" style="max-width:300px"></div>

- 紧接着是多个AttentionalAgg层，目的是提取高阶的交互特征，主要思路是在上一层信息上叠加和第一层信息的交互信息，思路和DCN有点像，但交互信息的提取是利用attention的方式计算的。该层输出也保持着d*m的维度。
    <div style="text-align: center"><img src="/wiki/attach/images/InterHAt-025.png" style="max-width:250px"></div>
    <div style="text-align: center"><img src="/wiki/attach/images/InterHAt-03.png" style="max-width:250px"></div>
    <div style="text-align: center"><img src="/wiki/attach/images/InterHAt-033.png" style="max-width:250px"></div>
- 最后是将多个AttentionalAgg层中的u向量聚合，并通过一个浅层dnn得到输出。
    <div style="text-align: center"><img src="/wiki/attach/images/InterHAt-04.png" style="max-width:300px"></div>

- 从模型结构中可以看出，每层的attention向量和特征都是保持着对应关系的，所以可以用其来做模型分析和解释。

- 实验验证了模型的效率和效果都是比较好的，这个其实与具体场景和基线相关。

- 用三个场景举例说明了特征可能会在不同AttentionalAgg层中表现出较强的重要性差异。
    <div style="text-align: center"><img src="/wiki/attach/images/InterHAt-05.png" style="max-width:500px"></div>
    <div style="text-align: center"><img src="/wiki/attach/images/InterHAt-06.png" style="max-width:500px"></div>

 