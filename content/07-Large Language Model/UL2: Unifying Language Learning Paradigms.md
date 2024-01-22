---
title: "UL2: Unifying Language Learning Paradigms"
layout: page
date: 2024-01-21
---

## 主要内容

- 背景：预训练大模型存在各种各样的训练范式，需要根据下游任务选用特定的范式，已经潜移默化的把LM变成了task-specific的LM。统一的大模型范式有助于资源和精力
- Structure和Pre-train范式
    - bert（自编码，encode-only，双向文本建模，更擅长做判别/自然语言理解类任务）
    - gpt（自回归，decode-only）
    - UniLM（prefix LM，encode+decode共用参数，通过transfomer的mask矩阵来同时训练双向/单向/seq2seq）
- learning范式：监督任务，in-context learning / few-shot，Zero-Shot 
- 目标任务：语言生成，语言理解，reasoning

<div style="text-align: center"><img src="/wiki/attach/images/UL2-01.png" style="max-width:500px"></div>

- XLNet（MS2019）
  - AE的问题（预训练和fine-tune存在mask的差异；假设mask相互独立）
  - 提出了Permutation Language Model，在预训练阶段采用了基于AR的双向编码机制，从而解决了BERT遇到的两个痛点
  - XLNet实现AR和AE融合的主要思路为，对输入文本进行排列组合，然后对于每个排列组合使用AR的方式训练，不同排列组合使每个token都能和其他token进行信息交互，同时每次训练又都是AR的。

<div style="text-align: center"><img src="/wiki/attach/images/UL2-02.png" style="max-width:500px"></div>

- MPNet（MS2022）
  - MLM可以看到全句的位置信息，但不能对预测token之间的依赖关系进行建模，不能很好地学习复杂的语义关系
  - PLM可以通过自回归预测对predicted tokens之间的依赖关系进行建模，但不能看到全句的位置信息，会造成预训练和微调的不匹配。
  - MLM和PLM中的非预测部分是相同的，而预测部分是不同的，MLM的优势在于通过引入mask及其在非预测部分的位置信息，可以看到全句的位置信息，而PLM的优势在于可以在预测部分用自回归生成来模拟预测标记之间的依赖关系

<div style="text-align: center"><img src="/wiki/attach/images/UL2-03.png" style="max-width:500px"></div>

- UniLM（2019）
  - 模型结构的统一，Encoder-only，采用BERT的模型，使用三种特殊的Mask的预训练目标，双向、单向、seq2seq，交替训练
<div style="text-align: center"><img src="/wiki/attach/images/UL2-04.png" style="max-width:500px"></div>


- T5
  - 目标任务统一，encoder-decoder，把所有的NLP问题都可以定义成text-to-text问题，即输入text，输出text
  - 使用同样的模型，同样的损失函数，同样的训练过程，同样的解码过程来完成所有 NLP 任务


- UL2
  - 提出Mixture-of-Denoisers (MoD)融合了Prefix LM/span corruption/CLM不同的模型能力
  - 无论是CausalLM，span corruption或者PrefixLM，都可以视为span corruption
<div style="text-align: center"><img src="/wiki/attach/images/UL2-05.png" style="max-width:500px"></div>