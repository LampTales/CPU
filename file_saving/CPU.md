# CPU大作业文档
1. 开发者说明

   - 学号， 姓名，负责工作， 贡献比

   - 

   - 

2. 版本修改记录

3. CPU架构设计说明

   - CPU特性

     - ISA 

       - 3类指令

         - R-type 
           $$
           \underbrace{opcode}_{6\ bits} \ | \ \underbrace{rs}_{5\ bits} \ | \ \underbrace{rt}_{5\ bits} \ | \ \underbrace{rd}_{5\ bits} \ | \ \underbrace{shamt}_{5\ bits} \ | \ \underbrace{funct}_{6\ bits}
           $$
   
           | 指令 | opcode | rs | rt | rd | shamt | funct |
           | ---- | ------ | ------ | ------ | ------ | ------ | ------ |
           | sll  | 000000 | 00000 | rt | rd | shamt | 000000 |
           | srl  | 000000 | 00000 | rt | rd | shamt | 000010 |
           | sllv | 000000 | rs | rt | rd | 00000 | 000100 |
           | srlv | 000000 | rs | rt | rd | 00000 | 000110 |
           | sra  | 000000 | 00000 | rt | rd | shamt | 000011 |
           | srav | 000000 | rs | rt | rd | 00000 | 000111 |
           | jr   | 000000 | rs | 00000 | 00000 | 00000 | 001000 |
           | mult | 000000 | rs | rt | rd | 00000 | 011000 |
           | div  | 000000 | rs | rt | rd | 00000 | 011010 |
           | add  | 000000 | rs | rt | rd | 00000 | 100000 |
           | addu | 000000 | rs | rt | rd | 00000 | 100001 |
           | sub  | 000000 | rs | rt | rd | 00000 | 100010 |
           | subu | 000000 | rs | rt | rd | 00000 | 100011 |
           | and  | 000000 | rs | rt | rd | 00000 | 100100 |
           | or   | 000000 | rs | rt | rd | 00000 | 100101 |
           | xor  | 000000 | rs | rt | rd | 00000 | 100110 |
           | nor  | 000000 | rs | rt | rd | 00000 | 100111 |
           | slt  | 000000 | rs | rt | rd | 00000 | 101010 |
           | sltu | 000000 | rs | rt | rd | 00000 | 101011 |
   
           - sll: 逻辑左移 (rd = rt << shamt) 空出位置补0
           - srl: 逻辑右移 (rd = rt >> shamt) 空出位置补0
           - sllv: 逻辑左移变量 (rd = rt << rs) 
           - srlv: 逻辑右移变量 (rd = rt >> rs)
           - sra: 算术右移 (rd = rt >> shamt) 空出位置补符号位
           - srav: 算术右移变量 (rd = rt >> rs) 空出位置补符号位
           - jr: 跳转到寄存器地址 (PC = rs)
           - mult: 乘法 (rd = rs * rt) (与MIPS不同)
           - div: 除法 (rd[31:16] = rs / rt, rd[15:0] = rs % rt) (与MIPS不同)
           - add: 加法 (rd = rs + rt)
           - addu: 加法无符号 (rd = rs + rt)
           - sub: 减法 (rd = rs - rt)
           - subu: 减法无符号 (rd = rs - rt)
           - and: 与 (rd = rs & rt)
           - or: 或 (rd = rs | rt)
           - xor: 异或 (rd = rs ^ rt)
           - nor: 非或 (rd = ~(rs | rt))
           - slt: 小于 (rd = (rs < rt) ? 1 : 0)
           - sltu: 小于无符号 (rd = (rs < rt) ? 1 : 0)
         - I-type
           $$
           \underbrace{opcode}_{6\ bits} \ | \ \underbrace{rs}_{5\ bits} \ | \ \underbrace{rt}_{5\ bits} \ | \  \underbrace{immediate}_{16\ bits}
           $$
   
           | 指令 | opcode | rs | rt | immediate | 
           | ---- | ------ | ------ | ------ | ------ |
           | beq  | 000100 | rs | rt | immediate |
           | bne  | 000101 | rs | rt | immediate |
           | lw   | 100011 | rs | rt | immediate |
           | sw   | 101011 | rs | rt | immediate |
           | addi | 001000 | rs | rt | immediate |
           | addiu| 001001 | rs | rt | immediate |
           | slti | 001010 | rs | rt | immediate |
           | sltiu| 001011 | rs | rt | immediate |
           | andi | 001100 | rs | rt | immediate |
           | ori  | 001101 | rs | rt | immediate |
           | xori | 001110 | rs | rt | immediate |
           | lui  | 001111 | 00000 | rt | immediate |

           - beq: 分支相等 (if rs == rt) PC += immediate
           - bne: 分支不相等 (if rs != rt) PC += immediate
           - lw: 加载word (rt = Memory[rs + immediate])
           - sw: 存储word (Memory[rs + immediate] = rt)
           - addi: 加法 (rt = rs + immediate)
           - addiu: 加法无符号 (rt = rs + immediate)
           - slti: 小于 (rt = (rs < immediate) ? 1 : 0)
           - sltiu: 小于无符号 (rt = (rs < immediate) ? 1 : 0)
           - andi: 与 (rt = rs & immediate)
           - ori: 或 (rt = rs | immediate)
           - xori: 异或 (rt = rs ^ immediate)
           - lui: 加载立即数到高位 (rt = immediate << 16)
   
         - J-type
           $$
           \underbrace{opcode}_{6\ bits} \ | \ \underbrace{address}_{26\ bits}
           $$
           | 指令 | opcode | address |
           | ---- | ------ | ------ |
           | j    | 000010 | address |
           | jal  | 000011 | address |
   
           - j: 跳转 (PC = (PC & 0xf0000000) \| (address << 2))
           - jal: 跳转并保存返回地址 (ra = PC + 4; PC = (PC & 0xf0000000) \| (address << 2))
   
     - 寻址空间设计
   
     - 对外设IO的支持
   
       - 内存映射
       - 中断？/轮询？
   
     - 单周期CPU
       - 5段流水线 (IF, ID, EX, MEM, WB)
         - IF: 取指令
         - ID: 译码
         - EX: 执行
         - MEM: 访存
         - WB: 写回
       
   
   - CPU接口
   
     - 时钟接口
   
     - 复位接口
   
     - uart接口
   
     - 
   
   - CPU内部结构
   
     - 各子模块接口关系图
     - 子模块设计说明
   
   - 问题及总结
   
     - CTRL.v中的控制信号的生成复杂，如何简化？
     - 如何实现中断？
     - 如何实现IO？
     - 如何实现乘除法？
