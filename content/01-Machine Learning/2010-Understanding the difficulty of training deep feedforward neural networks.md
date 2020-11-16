---
title: "2010-Understanding the difficulty of training deep feedforward neural networks"
layout: page
date: 2020-11-15
---

## 总结

- 本文基于"隐藏层的输入方差应该与输出方差应该尽量相等"的先验，假设参数初始化为均匀分布，得到了Xavier初始化方法。

## 主要内容

- 为了让网络中的信息更容易传递（不会出现梯度爆炸或者梯度消失的现象），隐藏层的输入方差应该与输出方差应该尽量相等。

- 前向传播和反向传播时，尽量保证每一层的方差是一致的，所以参数方差=1/（n1+n2)。

- 再次假设网络参数初始化为均匀分布，则可以得到参数的初始化分布如下：
<div style="text-align: center"><img src="/wiki/attach/images/Xavier-01.png" style="max-width:400px"></div>