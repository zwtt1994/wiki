---
title: "SSM(State Space Model)"
layout: page
date: 2024-06-30
---

## 主要内容

- Transformer架构中注意力机制计算复杂度是输入序列长度的二次方，不适合处理超长的序列数据。
- rnn，形式和ssm基本相同，但由于非线性激活函数的存在，导致2个问题，一是梯度消失，实际应用中rnn一般会遗忘很早之前的信息，二是无法通过卷积直接计算出结果导致无法并行训练。
- SSM，和rnn的思路一样，但隐藏状态部分的计算没有非线形变换，而是多个矩阵运算，同时直接依赖了当前的输入。
<div style="text-align: center"><img src="/wiki/attach/images/SSM-01.png" style="max-width:800px"></div>
<div style="text-align: center"><img src="/wiki/attach/images/SSM-02.png" style="max-width:800px"></div>

- 从SSM到S4的升级
    - 离散化，SSM对于连续和离散信号都成立，仅是从隐藏状态的更新中的求导变成了序列计算
<div style="text-align: center"><img src="/wiki/attach/images/SSM-03.png" style="max-width:800px"></div>
    - 循环结构表示，方便快速推理，每次只需要计算最新隐藏状态和输入的结果
<div style="text-align: center"><img src="/wiki/attach/images/SSM-04.png" style="max-width:800px"></div>
<div style="text-align: center"><img src="/wiki/attach/images/SSM-05.png" style="max-width:600px"></div>
    - 卷积结构表示，方便并行训练，由于没有非线形变化，可以直接通过矩阵计算出输出结果，但卷积肯定存在有限窗口
<div style="text-align: center"><img src="/wiki/attach/images/SSM-06.png" style="max-width:600px"></div>
    - 在训练中使用CNN，在预估中使用RNN，在序列长度上具有线性或者近线性的复杂度（Transformre是二次复杂度）
<div style="text-align: center"><img src="/wiki/attach/images/SSM-07.png" style="max-width:600px"></div>

- HiPPO，长距离依赖问题，关键在于矩阵A如何保留较长的记忆；HiPPO通过函数逼近产生矩阵A的最优解HiPPO矩阵。
<div style="text-align: center"><img src="/wiki/attach/images/SSM-08.png" style="max-width:600px"></div>
<div style="text-align: center"><img src="/wiki/attach/images/SSM-09.png" style="max-width:400px"></div>

- S4的定义，序列的结构化状态空间 Structured State Space for Sequences = Continuous SSM + HiPPO + discrete Representations
<div style="text-align: center"><img src="/wiki/attach/images/SSM-10.png" style="max-width:800px"></div>

- HiPPO推导和S4的一个应用示例
    - 现实生活中一般都是离散数据，但存在连续数据，例如视音频（还是可以看作是离散的），她们的context window非常长，而trasformer或者注意力机制不擅长上下文超长的任务，但S4擅长这类任务。
    - 例如股票价格波动，在指数衰减评估中（EMA），计算逻辑是过去所有信号的加权平均，这时候transformer和卷积就因为存在有限窗口长度而无法计算。但这种计算可以通过常数时间快速计算得到，仅通过一个简单的状态数据存储之前的信息。
<div style="text-align: center"><img src="/wiki/attach/images/SSM-11.png" style="max-width:600px"></div>


- HiPPO推导，如何定义一个好的隐藏状态，能够记忆更长的序列。 
    - 假设对于某个时刻之前的信号，希望利用一个多项式去近似，在接收到更多信号之后，则去更新多项式的系数。
<div style="text-align: center"><img src="/wiki/attach/images/SSM-12.png" style="max-width:600px"></div>
    - 在这个假设下需要解决2个问题，如何寻找最优的近似，如何快速更新多项式参数。
    - 先定义一个描述近似好坏的程度，例如EDM；然后选择一个初始化状态；最后通过求导得出最后HiPPO定义。
<div style="text-align: center"><img src="/wiki/attach/images/SSM-13.png" style="max-width:600px"></div>
    - 之前的例子，利用64维的隐藏状态就可以对1万长度的数据进行压缩。
<div style="text-align: center"><img src="/wiki/attach/images/SSM-14.png" style="max-width:600px"></div>
    - 同时论文推导得出，HiPPO不仅在EDM，在其他measure下也都是成立的。
    - HiPPO的高阶化，公用隐藏状态，线性组合得到输出，1960年就有人提出过类似的SSM。
<div style="text-align: center"><img src="/wiki/attach/images/SSM-15.png" style="max-width:600px"></div>
    - S4 = SSM + HiPPO + stuctured matrices
    - 3个性质，连续表示，循环表示，卷积表示，上文提过，最终SSM作为深度学习中的一个模块。
<div style="text-align: center"><img src="/wiki/attach/images/SSM-16.png" style="max-width:600px"></div>
    - ABCD矩阵参数都是训练得到（A用HiPPO矩阵初始化），通常有d个这样的SSM并行存在，每个对应一个隐藏维度。
    - SSM的问题，ABC矩阵不会因输入的变化而变化（推理的时候），但实际上需要针对输入的不同做权重调整，而Mamba则在训练时针对不同的数据给予不同处理，来实现即使推理时参数不变也会存在输入权重，这种改变引来的坏处就是训练时无法并行了。
<div style="text-align: center"><img src="/wiki/attach/images/SSM-17.png" style="max-width:400px"></div>   
    - Mamba = 有选择处理信息 + 硬件感知算法 + 更简单的SSM架构

