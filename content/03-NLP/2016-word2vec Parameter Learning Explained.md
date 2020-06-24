---
title: "2016-word2vec Parameter Learning Explained"
layout: page
date: 2020-06-24
---

## 总结

- 介绍了word2vec的细节。
 
## 主要内容

- 利用三层神经网络，将输入单词映射到输出单词，根据单词间的相关性来训练，隐层权值就是embedding结果。
- one-word模型，输入输出都是一个单词。CBOW（continuous bag of words）是多个词输入，单个词输出。Skip-Gram单个词输入，多个词输出。
- 输入层到中间层的参数训练计算比较简单，因为输入层是one-hot编码结果，只有一个神经元是激活的。
- 输出层由于需要计算所有单词的输出概率（softmax），如果不做处理的话计算量会很大，所以需要进行负采样（文中提到的负采样的方法，根据单词在词汇库中的出现次数的3/4次方做加权采样）。
- 另一种减少计算量的方法是Hierarchical Softmax，他为所有单词构建霍夫曼树，并用lr作为树节点的路由，使得softmax概率计算结果为根节点到叶子节点路径上节点值的乘积，简化计算量v->log2 v。