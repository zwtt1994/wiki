---
title: "2014-Sequence to Sequence Learning with Neural Networks"
layout: page
date: 2020-06-24
---

## 总结

- 由于dnn需要足够的样本，所以不适合去学习序列映射任务（样本分布稀疏），因此提出了seq2seq的经典模型结构。
 
## 主要内容

- seq2seq的结构是encoder+decoder，分别用两个多层lstm来实现。
<div style="text-align: center"><img src="/wiki/attach/images/seq2seq-01.png" style="max-width:800px"></div>

- 训练的用softmax候选集是所有语料库，预测的时候用了beam search方法，每次保留概率最高的n个候选集。

- 文中发现模型对单词输入顺序很敏感，并且倒序能提升模型效果，对长句子的效果表现出乎意料的好。
<div style="text-align: center"><img src="/wiki/attach/images/seq2seq-02.png" style="max-width:800px"></div>