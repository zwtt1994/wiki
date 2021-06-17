---
title: "2021-Field-matrixed Factorization Machines for Recommender Systems"
layout: page
date: 2021-05-23
---

## 总结

- FM、FFM、FwFM到本文的FmFM。

## 主要内容

- Poly2，二阶多项式。
- FM，二阶多项式参数通过矩阵分解减少了参数数量，每个参数对应一个向量，并可以简化为O(n)的计算复杂度，详情见FM分析wiki。
- FFM，将特征分为多个field，特征和不同field交叉时采用不同的向量，共n*f个隐向量。
- FwFM，同样将特征分为多个field，在FM基础上不同field间特征交互时会有不同的系数，共f(f-1)/2个系数。
- FmFM，每个field在与其他field交互时，向量用不同的矩阵做投影，这也可以使得之前的向量不是同一维度的。

- FmFM和FFM的区别是，FFM是对于不同的field生成不同的隐向量，FmFM则是将lookup隐向量映射得到不同field的隐向量。

- 对于稀疏特征的交叉，FM可以理解为二阶的特征间的共现信息，但一个稀疏特征只有一组字典；FFM则是针对不同field设置了不同的字典，但参数太多；FmFM则通过映射的方式，在参数可接受的范围内有效提升了表达能力。
