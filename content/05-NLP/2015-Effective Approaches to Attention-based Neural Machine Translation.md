---
title: "2015-Neural Machine Translation by Jointly Learning to Align and Translate"
layout: page
date: 2020-07-25
---

## 总结

- 对基于attention的seq2seq进行了改进。

 
## 主要内容

- Global attention机制
    <div style="text-align: center"><img src="/wiki/attach/images/AttentionV2-01.png" style="max-width:400px"></div>
    - 重新定义了encode信息聚合结构的计算方式，新的decode向量由context向量和decode输出的非线性变化得到。
    <div style="text-align: center"><img src="/wiki/attach/images/AttentionV2-00.png" style="max-width:200px"></div>
    - 尝试了多种attention权值计算方式。
    <div style="text-align: center"><img src="/wiki/attach/images/AttentionV2-02.png" style="max-width:200px"></div>
    
- Local attention机制
    <div style="text-align: center"><img src="/wiki/attach/images/AttentionV2-04.png" style="max-width:400px"></div>
    - 全局计算代价太高，例如翻译全篇文章，所以只选择一部分进行计算。
    - 尝试了两种位置选择方式，一种是直接选择decode相应位置的encode位置为中心位置，另一种是通过参数预测对齐。
    
- Input-feeding Approach，将t时刻decode的输出+隐层状态一起输入到t+1的decode，之前的模型只使用了decode的输出。
    <div style="text-align: center"><img src="/wiki/attach/images/AttentionV2-05.png" style="max-width:400px"></div>
    
