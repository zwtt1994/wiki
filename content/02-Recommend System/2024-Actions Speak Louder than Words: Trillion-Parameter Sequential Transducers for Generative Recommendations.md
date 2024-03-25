---
title: "2023-Actions Speak Louder than Words: Trillion-Parameter Sequential Transducers for Generative Recommendations"
layout: page
date: 2024-03-23
---


## 主要内容

- 摘要
    - 大规模推荐系统依赖高基数、异构特征并且用户数量庞大，大多数深度学习推荐模型（DLRM）都无法通过计算进行扩展，论文将推荐问题重新表述为生成推荐器内的顺序转换任务，并专为高基数、非平稳流推荐数据提出了一种新的架构HSTU。
    - HSTU 的效果更好，比FlashAttention2速度更快，1.5 万亿个参数，并且可以对参数数量级进行拓展。 

- 背景
    - DLRM 的特点是使用异构特征（连续和稀疏特征），内容更新快，特征空间具有极高的基数。为了利用这些特征，DLRM 使用各种神经网络来做特征交叉和转换。
    - 尽管利用了广泛的人工设计的功能集并对大量数据进行了训练，但行业中的大多数 DLRM 的计算扩展性都很差。
    - 受到transformer的启发，论文观察到想替换现有模式需要克服三个挑战。
        - 首先，推荐系统中的特征缺乏明确的结构，包括高基数的id类特征，交叉特征，计数特征和比率特征等。
        - 其次，推荐系统中使用不断变化的数十亿级别的候选集合，这比10万规模的词汇相比是一个巨大挑战。
        - 最后是计算成本，用户行为数据也是十分庞大的。
    - 论文将用户行为视为生成建模中的一种新模式
        - a）在给定适当的新特征空间的情况下，推荐系统中核心的排序和检索任务可以转化为生成建模问题； 
        - b）这种范式能够系统地利用特征、训练和推理方面的冗余来提高效率。在这种范式下部署的模型在计算复杂上比之前最先进的技术高了三个数量级，但将顶线指标提高了 12.4%

- 论文的贡献
    - 首先提出了生成推荐系统（GR），这是一种取代 DLRM 的新范式。
        - 论文对 DLRM 中的异构特征空间进行序列化和统一，随着序列长度趋于无穷大，新方法近似完整的 DLRM 特征空间。
        - 借此能够将主要推荐问题、排序和检索重新表述为 GR 中的纯顺序转导任务。
        - 重要的是，这进一步使得模型训练能够以序列生成的方式完成，这使得我们能够使用相同的计算量训练更多数量级的数据。
    - 其次，解决了整个训练和推理过程中的计算成本挑战。
        - 论文提出了一种新的序列转导架构，分层顺序转导单元（HSTU）。
        - HSTU 修改了大型非平稳词汇的注意力机制，并利用推荐数据集的特性，与基于 FlashAttention2 的 Transformer 在 8192 长度序列上实现了 5.3 倍到 15.2 倍的加速。
        - 此外通过一种新算法 M-FALCON来较少计算成本。
    - 最后，通过合成数据集、公共数据集以及在拥有数十亿日常活跃用户的大型互联网平台的多个服务上的部署来验证所提出的技术，并得到了指标提升。
        - 这表明纯粹基于序列转导的架构（如 HSTU）在生成环境（GR）中优于大规模工业环境中的 DLRM。
        - 值得注意的是，论文不仅克服了传统 DLRM 中已知的扩展瓶颈，还成功地证明了扩展定律适用于推荐，代表了推荐系统的潜在 ChatGPT 时刻。

- 从 DLRM 到 GR
    - 统一 DLRM 中的异构特征空间，将稀疏和稠密特征整合编码为一个统一的时间序列。
<div style="text-align: center"><img src="/wiki/attach/images/GR-01.png" style="max-width:900px"></div>
        - 在稀疏特征的处理中，通过合并代表用户参与的项目的特征作为主要时间序列，然后将变化不大的用户特征等信息集中到最早中出现的时间点进行添加。
        - 连续特征丢弃，论文认为稀疏特征序列已经包含相关信息 
    - 把召回和排序重新定义为序列transduction任务 
        - 检索任务：目标是为每个用户学习一个概率分布 p(xi+1|ui)，其中 xi+1 是候选项目集中的一个项目，而 ui 是用户在步骤 i 的表示。检索任务的一个典型目标是选择 argmax_x∈Xc p(x|ui) 来最大化某个特定的奖励。
            - 和自监督任务有2个区别，xi+1有正负反馈，并不是确定的序列；之前定义的序列中可能存在非候选集的节点，这种情况跳过预测和评估。 
        - 排序任务：在传统的自回归模型中，候选集x之间的交互往往在最后的softmax实现，但在推荐系统中希望强化x之间的交互，在每一个x后面加入了用户行为a序列，即在序列中引入用户的反馈信息。


- 用于生成推荐的高性能自注意力编码器
    - 新的GR编码器设计，称为分层顺序转换单元Hierarchical Sequential Transduction Unit（HSTU）。
<div style="text-align: center"><img src="/wiki/attach/images/GR-02.png" style="max-width:600px"></div>
    - HSTU 采用了一种新的逐点聚合注意力机制来代替原来的softmax，一个原因是softmax会弱化某些强特征，另一个原因是虽然softmax对噪声有鲁棒性但也不适合状态随时间变化的候选集。
    - HSTU的设计显著提高了计算效率，特别是在长序列处理上。去除Softmax函数后，HSTU避免了昂贵的指数运算和归一化步骤，使得自注意力机制的计算复杂度从二次降低到线性。
    - HSTU 采用简化且完全融合的设计，可显着减少激活内存的使用；HSTU 将注意力之外的线性层数量从 6 个减少到 2 个，并积极地将计算融合到单个算子中，比如融合两个激活函数，层归一化，可选的dropout
    - 通过成本摊销扩大推理规模，最后一个挑战是推荐系统需要处理大量的用户，提出了一种算法 M-FALCON（Microbatched-Fast Attention Leveraging Cacheable OperatioNs）来对输入序列大小为 n 的 m 个候选者进行推理，使模型复杂度能够随着传统 DL-RM 排名阶段的候选者数量线性增加。