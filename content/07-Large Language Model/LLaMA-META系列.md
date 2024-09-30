---
title: "LLaMA-META系列"
layout: page
date: 2024-09-28
---

## 主要内容

- LLaMA1(2022)
    - 摘要：用公开数据集就可以训练出优异的基础语言模型，特别的是LLaMA-13B与GPT3-175B表现相当
    - 参数范围：7B-65B（B=10的9次方），serving时小模型速度更快，LLaMA可在单GPU上运行
    - 训练数据：1.4T个tokens（T=10的12次方），使用了CommonCrawl（67%）、C4（15%）、Wikipedia（4.5%)、Books(4.5%)、ArXiv(2.5%)等，Wiki和Books质量高会训练2次
        - 数据处理：行/书级别去重、ngram语言模型过滤低质内容
    - 网络架构：基于Transformer做了一些改进，上下文长度2k
        - pre-normalization：收敛更快但上限不如post-normalization，详见论文笔记Layer Normalization
        - SwiGLU激活函数：GLU和Swish的结合，既能够具备gate的选择性，又使得全域都具备梯度，SwiGLU(x)=x1*sigmoid(x1)*sigmoid(x2)
        - RoPE：旋转位置编码，在attention中加入位置参数，详见论文比例Position Embedding
        - 超参数：估算为12*Tranformer层数*隐藏层维度的平方，attention矩阵的维度=隐藏层维度/多头数
            - 6.7B的模型参数配置为：隐藏层维度4096，multi-attention多头数32，Transformer层数32，学习率0.0003，batch size=4M
    - Optimizer：AdamW优化器，并叠加10%的余弦式衰减，AdamW相比Adam解决的就是将衰减直接作用到最后的参数更新，而不参与动量的更新
        - 使用0.1的权重衰减和1.0的梯度裁剪
    - 优化训练速度：
        - 利用causal multi-head attention的时序特性，减少对mask部分的计算和存储
        - 利用checkpoint存储了计算成本较高的结果，用空间换时间
        - 利用model and sequence parallelism进一步提升上述优化效率
        - overlap 激活计算和 GPU 之间的网络通信，提升时分复用的效率
        - 65B模型训练速度为380 tokens/second/GPU，因此在2048个A100/80GB/GPU上，训练一次1.4T数据需要21天
    - 模型效果，测试了zero-shot和few-shot（1-64个示例）两种任务，共计20个基准测试
        - 尝试推理、闭卷问答、阅读理解、数学推理、代码生成、大规模多任务语言理解（MMLU）
        - 在训练过程中模型性能的变化，大部分都是随着训练数据的增加而逐步提升
- LLaMA2(2023)
    - 摘要：在预训练大语言模型的基础上，针对对话场景进行了微调优化，可作为闭源模型代替方案
    - 背景：没有能与ChatGPT匹敌的开源大模型，开源LLaMA2/LLaMA2-Chat填补空白
    - 训练数据：2T个tokens（T=10的12次方），组合了公开可用的数据源，去掉了个人信息，对事实类数据源进行上采样
    - 参数范围：LLaMA2和LLaMA2-Chat都是7B-70B（B=10的9次方），上下文长度4k
    - 模型架构：与LLaMA基本类似，改进部分为上下文长度提升至4k，并利用了GQA
        - QGA（grouped-query attention）：通过将attention矩阵分组来降低计算复杂度，同时保持注意力机制的表达能力
        - 超参数：AdamW（β1 = 0.9，β2 = 0.95，eps = 10-5），余弦学习率10%衰减，使用0.1的权重衰减和1.0的梯度裁剪。
        - 分词器（Tokenizer）：字节对编码（bytepair encoding），vocabulary size为32k tokens。
    - 训练速度：
        - RSC集群（200Gbps InfiniBand + 400W GPU），生产集群（200Gbps RoCE + 350W GPU；RoCE成本更低）
        - RoCE + 350W GPU 的集群，经过优化的代码能达到 IB + 400W GPU 集群性能的 90%
        - A100-80GB（400W/350W TDP）机器，总共耗费了 3.3M GPU-hour
    - 预训练模型效果：LLaMA2 70B 在 MMLU 和 GSM8K 上与 GPT-3.5（OpenAI，2023）接近，与 PaLM（540B）相当，与 GPT-4/PaLM-2-L 存在较大差距
    - 训练框架：
        - 使用公开数据预训练LLaMA2
        - 对LLaMA2进行监督微调（SFT），得到初版LLaMA2-Chat
        - 真人对LLaMA2-Chat的回答进行标注，得到有用性和安全性两个奖励模型
        - 通过RLHF/rejection sampling/PPO，对LLaMA2-Chat进行进一步训练
<div style="text-align: center"><img src="/wiki/attach/images/LLaMA-01.png" style="max-width:800px"></div>
    - 微调（Fine-tuning），包括指令微调（instruction tuning）和 RLHF，需要大量的计算和标注资源。
        - 监督式微调（SFT）：只需少量（几万个）高质量 SFT 标注数据就能显著提升结果质量，因此质量相比数量更关键。
        - 微调细节：初始学习率0.00002，权重衰减0.1，batch size=64，上下文长度为4096 tokens，
        - 微调样本：每个样本由一个提示（prompt）和一个回答（answer）组成，为了确保模型序列长度正确填充，将prompt和answer用特殊的token连起来
        - 微调训练：使用自回归目标，并 zero-out the loss on tokens from the user prompt， 因此只在 answer token 上进行反向传播
    - 基于人类反馈的强化学习（RLHF），应用在微调模型之上， 使模型行为与人类偏好和指令进一步对齐。
        - 人类偏好数据收集：两两对比做程度判断，明显更好/更好/略微好/几乎无差别/不确定，结果会从不同阶段的模型得到确保多样性
        - 安全性数据收集：选中的回答是安全的，另一个回答不安全；两个回答都是安全的；两个回答都不安全
        - 交替更新：LLaMA2-Chat利用标注数据改进的同时，奖励模型需要随着同步更新，否则准确性会迅速下降
        - 奖励模型：
            - 模型的response和prompt（包括前几轮上下文）作为输入，输出标量分数（有效性和安全性分别训练两个模型，因为会冲突）
            - 用LLaMA2-Chat checkpoint初始化，模型架构和超参数一致
        - 训练目标





