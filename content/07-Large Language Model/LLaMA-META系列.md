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
            - 模型样本：模型的response和prompt（包括前几轮上下文）作为输入，输出标量分数（有效性和安全性分别训练两个模型，因为会冲突）
            - 模型初始化：用LLaMA2-Chat checkpoint初始化，模型架构和超参数一致
            - 训练目标：binary ranking loss，利用了对比学习的思路。
<div style="text-align: center"><img src="/wiki/attach/images/LLaMA-02.png" style="max-width:300px"></div>
            - 训练细节：数据训练一个epoch，重复训练存在过拟合的情况，学习率70B模型5*10-6/其他1*10-5，学习率余弦衰减至10%，warm-up 3%数据（size=5），batch-size=512
        - Iterative Fine-Tuning微调
            - 真人反馈数据和奖励模型交替更新，因此奖励模型版本会随时间更新
            - RLHF最关键的两个技术是PPO和Rejection Sampling fine-tuning
        - 拒绝采样Rejection Sampling
            - 仅对的70B LLaMA2-Chat模型上执行拒绝采样，所有较小的模型都在从大模型中拒绝采样的数据上进行微调
            - 每个迭代周期，对于所有prompt从最新的模型中采样k个答案，并用最佳奖励模型评分选择最佳答案
            - 早期只用上一版模型生成答案，但通过迭代发现利用历史所有版本的模型生成答案效果更佳，直观来看不同版本模型可能会随着样本产生能力倾斜
        - PPO（Proximal Policy Optimization ）
            - 详见强化学习笔记
    - 多轮一致性的系统消息
        - 定义系统消息，例如翻译、扮演某人或者赋予爱好，并将其合并到所有用户指令中，例如原始【你今天怎么样】，合成后【扮演拿破仑：你今天怎么样】
        - 为了避免系统消息在每轮对话中重复出现导致的不匹配，我们可以在第一轮之后删除系统消息，并将前几轮的所有标记（包括助手消息）的损失设置为0
    - 发现和认知
        - 从SFT到RLHF
            - 论文表示从怀疑到真香，RLHF在效果、成本和时间效率上远超预期
            - 每个人的标注风格也存在显著差异，模型性能受限于最熟练的标注员的能力，RLHF成功的关键是它在标注过程中促进了人和LLM之间的协同，
            - 随着模型的不断迭代，奖励分布逐渐朝着高分漂移
<div style="text-align: center"><img src="/wiki/attach/images/LLaMA-03.png" style="max-width:800px"></div>
            - 更直观点说，SFT需要给出最佳答案，但RLHF只需要判断哪个答案更好，显然后者更加容易，因此论文认为RLHF是LLM在某些任务中超越人类的关键。
        - 上下文温度重缩放（In-Context Temperature Rescaling），RLHF 学会了根据 prompt 类型适应温度
<div style="text-align: center"><img src="/wiki/attach/images/LLaMA-04.png" style="max-width:800px"></div>
<div style="text-align: center"><img src="/wiki/attach/images/LLaMA-05.png" style="max-width:800px"></div>
        - 时间感知能力（Temporal Perception）
            - 收集了与特定日期相关的1,000个SFT示例，关键信息是（提问时的日期、事件日期），对时间的概念内化程度超出预期



