---
title: "GLM报告"
layout: page
date: 2024-01-14
---

## 主要内容

- 模型架构 
    - 训练范式：单向、双向（词、句子、文档mask、混合去噪器UL2）
    - layerNorm：post-LN、pre-LN、sandwich-LN、deepNet 
    - position embbeding：三角、可学习、相对位置编码(ALiBi、RoPE)

- 模型训练 
    - 成本高：GPT3成本1200万美元，GPU 
    - 内存占用：激活函数占大部分内存（在forward中保存，用于反向传播），其次是optimizer【todo】和model
    - 混合精度：梯度更新【todo】时用更高精度 
    - 激活函数重演，时间换空间，前向计算时不保留激活函数结果，反向传播时重新计算，可以选择性使用 
    - 数据并行：Param Server（负载均衡问题），All-Reduce分布式随机梯度下降【todo】，ZeRO（拆分optimizer states，gradients，model weight） 
    - 模型并行：模型放不下一张显卡，张量并行（分模块拆卡），流水线并行（分阶段拆卡）（GPipe，1F1B）【todo】 
    - 175B参数需要2.8TB显存【todo】，单卡40GB；张量并行+流水线并行+ZeRO-3 
    - 训练稳定性：
        - 权衡利弊（高精度低效、低精度高效）；OPT-175B训练崩溃时反复调整学习率，跳过数据
        - BLOOM 176B，emb norm和BF16；
        - GLM-130B，softmax in 32 避免上下溢出，利用DeepNorm，调小emb层梯度 

- 模型量化
    - 模型量化是指将神经网络的浮点算法转换为定点
    - 模型规模超过10B时候，activation中会出现outlier异常值（似乎是softmax机制的关键）
    - GLM-130B，GeGLU激活函数使得关键特性失效，30%左右的维度会出现outlier； Vector-wise对称PTQ量化，INT8几乎不损失，INT4极小损失但显存下降75%

- GLM-130B到chatGLM 
    - prompt提示：模型对其很敏感，chat类模型主要为了降低prompt难度，基座模型很难直观理解输入要干什么 
    - RLHF【todo】：互联网预料质量并非符合人类偏好，通过人类反馈将模型分布调整到人类偏好的高质量数据分布上；Learning to summarize from human feedback(2020)；不仅仅是生成，还有评估和推理能力。 
    - chatGLM：对话能力，【todo下载下来看看】


