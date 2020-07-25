---
title: "2015-Neural Machine Translation by Jointly Learning to Align and Translate"
layout: page
date: 2020-07-25
---

## 总结

- 基于seq2seq结构提出了一种新的attention解码方式，提高了模型效果并解释了其合理性。
- 本质上是在解码的时候基于attention方式利用了所有的编码信息。

 
## 主要内容

- 在基础的seq2seq在解码中，输出词只依赖当前隐状态和前一个解码词，这需要将大量信息压缩到上述两个数据中，而实际上当句子较长的时候是做不到的，所以本文提出了基于attention解码方式。

- 本文使用双向RNN去做encode来更好的表达输入序列，并在解码时利用attention机制捕捉所有相关的编码信息。
<div style="text-align: center"><img src="/wiki/attach/images/Attention-01.png" style="max-width:400px"></div>

- 实验结果验证了模型的有效性，新框架在长句子上表现优异。
<div style="text-align: center"><img src="/wiki/attach/images/Attention-02.png" style="max-width:500px"></div>

- 观察了attention分布，符合正常逻辑中的"对角线分布"。
<div style="text-align: center"><img src="/wiki/attach/images/Attention-03.png" style="max-width:700px"></div>
