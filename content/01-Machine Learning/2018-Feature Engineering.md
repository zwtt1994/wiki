---
title: "2018-Feature Engineering"
layout: page
date: 2020-06-28
---

## 总结

- More data beats clever algorithms, but better data beats more data.

## 主要内容

- 类别特征
    - 特点：一般都需要预先处理；高基数类别特征会很稀疏；缺失值很难处理。
    - One-hot：最基本的处理方式；易于稀疏存储；通常会删除第一列来避免共线性（特征之间高度相关，早成信息冗余，影响模型结果）；无法很好处理缺失值。
    - Hash-encoding：避免了极为稀疏的数据；可能会引起冲突；在不同hash函数下准确率是接近的；冲突会使得结果失真，但可能会提升结果；易于处理新变量。
    - Label-encoding：每个类别对应一个数字id；对非线性的树模型有效；不增加维度；随机化id映射并重新训练会产生一些波动。
    - Count-encoding：以类别出现次数来编码；线性与非线性都适合；对异常值敏感；可以尝试做log变换；缺失值用1来编码；会产生冲突。
    - LabelCount encoding：对训练集中类别出现次数排序并依次编码；线性与非线性都适合；对异常值敏感；不会产生冲突。
    - Target encoding：利用类别对应label的平均值来编码；注意过拟合问题，添加随机噪声；加平滑处理避免编码为0；如果用的合适则是最佳编码。
    - Category embedding：类别查表，本质上与onehot后embedding是一样的。
    - NaN encoding：对缺失值赋予新的类别编码；缺失也是一种信息；注意过拟合问题；训练和预测时应该一致。
    - Polynomial encoding：特征交叉组合之后进行onehot；可以处理类似抑或的逻辑。
    - Expansion encoding：对单个复杂变量构建多个类别变量。
    - Consolidation encoding：对多个类别变量合并为一个类别变量，减少信息冗余。