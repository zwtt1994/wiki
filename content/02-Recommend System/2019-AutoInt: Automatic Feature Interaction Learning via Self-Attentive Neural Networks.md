---
title: "2019-AutoInt: Automatic Feature Interaction Learning via Self-Attentive Neural Networks"
layout: page
date: 2020-11-09
---

## 总结

- 本文旨在利用Multi-head self attention结合res-net来进行自动特征交叉学习。

## 主要内容

- 为了引入特征交叉，业界相继提出了DeepFM，DCN和xDeepFM等模型结构，但上述几种模型结构都是针对与二阶特征交叉，很难学习到高阶特征交叉。
<div style="text-align: center"><img src="/wiki/attach/images/AutoInt-01.png" style="max-width:700px"></div>

- 本文通过Multi-head self attention引入高阶特征交叉，并提高了模型解释性。
<div style="text-align: center"><img src="/wiki/attach/images/AutoInt-02.png" style="max-width:700px"></div>

- 从逻辑上看，self attention是将相似的embedding进行组合，但也仅仅是组合了相似的embedding，如果后面再补充上FM结构，可能会有更好的效果。
<div style="text-align: center"><img src="/wiki/attach/images/AutoInt-03.png" style="max-width:700px"></div>

- 此外，本文为了加强信息传递引入了res-net，提升了模型表达能力。