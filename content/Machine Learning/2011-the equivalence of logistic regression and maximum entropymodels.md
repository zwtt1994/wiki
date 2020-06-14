---
title: "2011-the equivalence of logistic regression and maximum entropymodels "
layout: page
date: 2020-06-07
---

本文推导了lr与最大熵的一致性。


## 总结

- 本文通过推导得出softmax本质上所要拟合的函数，并在最大熵的条件下重新推导得到softmax的公式，行云流水。

## 主要内容

- lr是softmax的二类形式，通过最大似然的常规推导，可以得出softmax本质上拟合的就是一个指示函数（当对应输出与label一致的为1，其他为0），这其实也是很直觉的。
<div style="text-align: center"><img src="/wiki/attach/images/lr-01.png" style="max-width:500px"></div>
- 所以在上式的约束下，利用拉格朗日乘数法最大化条件熵，即得到了softmax的形式。
<div style="text-align: center"><img src="/wiki/attach/images/lr-02.png" style="max-width:500px"></div>
<div style="text-align: center"><img src="/wiki/attach/images/lr-03.png" style="max-width:500px"></div>
<div style="text-align: center"><img src="/wiki/attach/images/lr-04.png" style="max-width:500px"></div>

