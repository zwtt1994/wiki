---
title: "2023-PIER: Permutation-Level Interest-Based End-to-End Re-ranking Framework in E-commerce"
layout: page
date: 2024-01-08
---

## 总结

- 提出了两阶段的端到端的重排解决方案。

## 主要内容

- 整体流程：暴力生成序列、FPSM选择tok-k的序列、OCPM选择最优序列
<div style="text-align: center"><img src="/wiki/attach/images/PIER-01.png" style="max-width:600px"></div>

- 模型结构
<div style="text-align: center"><img src="/wiki/attach/images/PIER-02.png" style="max-width:800px"></div>

- 序列推荐中的sideinfo
    - side info+id直接融合+self-attention（信息侵入，id信息不再准确）
    - id和side info分开self-attention建模最后合并（id和side info缺乏交互）
    - id仅作为self-attention的value，特征和id作为q、k（解决信息侵入问题，但所有side info重要性一致）
    - 每个side info单独的k和q再融合（特征之间没有交互）
    - 二维的transfomer，每个特征+item_id都会和其他所有特征+item_id 计算attention（复杂度高）


- simhash
    - ann相似度搜索方法（树、lsh、矢量量化）
    - simhash是lsh的一种，步骤为（分词、hash、加权、合并、降维），包含类似item的情况下最后hash的结果相似


- 对比学习（无监督或者自监督学习方法）
    - positive pair特征相似度高loss小，negative pair特征相似度低loss大
    - Triplet loss，query和正负样本
    - (N+1)-tuplet loss，扩充为N个负样本
    - N-pair loss，把其他正样本当成该正样本的负样本，batch内负采样，减少计算量

<div style="text-align: center"><img src="/wiki/attach/images/PIER-03.png" style="max-width:800px"></div>
<div style="text-align: center"><img src="/wiki/attach/images/PIER-04.png" style="max-width:800px"></div>