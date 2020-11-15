---
title: "2019-AutoInt: Automatic Feature Interaction Learning via Self-Attentive Neural Networks"
layout: page
date: 2020-11-09
---

## 总结

- 本文旨在利用Multi-head self attention结合res-net来进行自动特征交叉学习。

## 主要内容

- 为了引入特征交叉，业界相继提出了DeepFM，DCN和xDeepFM等模型结构，但上述几种模型结构都是针对与二阶特征交叉，很难学习到高阶特征交叉。

- 本文通过Multi-head self attention引入高阶特征交叉，并提高了模型解释性。

- 此外，本文为了加强信息传递引入了res-net，提升了模型表达能力。