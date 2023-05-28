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
           | eret | 010000 | 10000 | 00000 | 00000 | 00000 | 011000 |
           | add.s | 000000 | rs | rt | rd | 00000 | 001010 |
           | mul.s | 000000 | rs | rt | rd | 00000 | 001011 |
           
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
           - eret: 中断处理后返回到中断前的地址
           - add.s: simd128的add，同时读取后四个连续寄存器内容，计算后保存到后四个连续寄存器中去
           - mul.s: simd128的mul，同时读取后四个连续寄存器内容，计算后保存到后四个连续寄存器中去
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
   
     - 寻址空间设计：采用哈佛结构，用ROM和RAM分别存储指令和数据
   
     - 对外设IO的支持
       - 内存映射：
         - board_input_data: `0x3FF0`
         - board_input_case: `0x3FF4`
         - board_output_data: `0x3FF8`
         - board_output_sig: `0x3FFC`
       - IO确认两种方案
         - 软件方案（最终选择）:
         
           ​	在需要读取数据时进行bne循环，然后在板子按下按钮触发按钮中断，在软件的中断处理代码中破坏循环条件，eret返回原来地址，跳出循环，并读取数据；
         
         - 硬件方案 (弃用) ：
         
           ​	在需要读取数据时进行bne循环，然后在板子按下按钮时直接在bne条件的其中一个寄存器上加1，由硬件直接破坏循环条件，软件跳出循环，并读取数据，该方法硬件会改变reg_file的值，因此软硬件分离上不如上一个方案，因此弃用，但我们的CPU仍然能用该方法进行IO。
       
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
       - ALU.v
         - 功能: 根据CTRL信号进行，算术逻辑运算
           - 输入:
             - 12位 alu_op: ALU操作码， 高6位为opcode，低6位为func_code
             - 5位 shamt: 移位位数
             - 32位 in0: 第一个操作数
             - 32位 in1: 第二个操作数
           - 输出:
             - 32位 out: 运算结果
             - 1位 equal: in0 和 in1 是否相等
             - 8位 error_code: 错误码 (0: 正常，1:溢出错误，2: 除零错误)
       - button.v
         - 功能: 按键消抖
         - 输入:
           - 1位 clk: 时钟信号
           - 1位 rst_n: 复位信号
           - 1位 input_button: 原始按钮信号
         - 输出:
           - 1位 output_button: 消抖按钮信号
       - CTRL.v
         - 功能: 生成总控制信号，传送给其他模块
         - 输入:
          - 6位 opcode: 指令操作码
          - 5位 shamt_in: 指令移位位数
          - 6位 func_code: 指令功能码
         - 输出
          - 12位 alu_op: ALU操作码， 高6位为opcode，低6位为func_code （传给ALU.v）
          - 5位 shamt_out: 移位位数
          - 1位 reg_dst: 寄存器目标选择信号
          - 1位 branch: beq分支信号
          - 1位 nbranch: bne分支信号
          - 1位 mem_read: 读存储器信号
          - 1位 mem_write: 写存储器信号
          - 1位 mem_to_reg: 存储器数据写回寄存器信号
          - 1位 alu_src: ALU第二个操作数选择信号
          - 1位 reg_write: 寄存器写使能信号
          - 1位 ignore
          - 1位 simd: simd指令信号
          - 1位 j: j指令信号
          - 1位 jr: jr指令信号
          - 1位 jal: jal指令信号
          - 1位 eret: eret指令信号
       - CXK.v
         - 功能: 分频器
          - 输入:
            - 1位 clk: 时钟信号
            - 1位 rst: 复位信号
            - 2位 mode: 工作模式选择信号
            - 1位 switch_clk: debug模式下使用该switch作为单步调试的下一步切换
          - 输出:
            - 1位 rom_clock: ROM时钟信号
            - 1位 ram_clock: RAM时钟信号
            - 1位 reg_clock: 寄存器时钟信号
            - 1位 pc_clock: PC时钟信号
            - 1位 seg_clock: 七段数码管时钟信号
            - 1位 uart_clock: UART时钟信号
            - 1位 icu_clock: ICU时钟信号
       - Expander.v
         - 功能: 立即数扩展器
           - 输入:
             - 16位 imme: 待扩展立即数
             - 1位 ignore: 忽略信号
           - 输出:
             - 32位 expand_imme: 扩展后立即数
       - ICU.v
         - 功能: 中断控制器
           - 输入:
             - 1位 clk: 时钟信号
             - 1位 rst: 复位信号
             - 1位 irq: 中断请求信号
             - 1位 eret: eret指令信号
             - 32位 pc: pc寄存器
             - 1位 button: 中断按键信号
           - 输出:
             - 32位 out: 中断处理指令地址
       - IO_block.v
         - 功能: IO处理器
          - 输入:
            - 24位 switch_in: 24位拨码开关输入
            - 1位 pc_clk: PC时钟信号
            - 1位 seg_clk: 七段数码管时钟信号
            - 1位 rst: 复位信号
            - 1位 cpu_rst_butt: CPU重置按钮
            - 1位 mode_butt: 工作模式选择按钮
            - 1位 ack_butt: 中断确认按钮
            - 1位 intr_butt: 中断按钮
            - 32位 board_output_data: 板上七段数码管需输出的数据
            - 8位 board_output_sig: 板上led灯需输出的信号
            - 8位 errorcode: 错误码
          - 输出:
            - 24位 led_out: 24位LED输出
            - 8位 seg_op: 七段数码管使能信号
            - 8位 seg_out: 七段数码管输出
            - 1位 interrupt: 中断信号
            - 1位 cpu_rst: CPU重置信号
            - 2位 mode: 工作模式选择信号
            - 1位 ack: 中断确认信号
            - 1位 switch_clk: debug模式时钟信号
            - 8位 board_input_data: 板上输入的数据
            - 8位 board_input_case: 板上输入的测试样例编号
         - led_block.v
           - 功能: LED显示模块
             - 输入:
               - 24位 led_in: LED输入
             - 输出:
               - 24位 led_out: LED输出
         - MUX.v
           - 功能: 2路选择器
             - 输入:
               - 32位 in0: 选择信号为0时的输入
               - 32位 in1: 选择信号为1时的输入
               - 1位 select: 选择信号
             - 输出:
               - 32位 out: 选择后的输出
         - PC.v
           - 功能: PC寄存器更新模块
             - 输入:
               - 1位 clk: 时钟信号
               - 1位 rst: 复位信号
               - 32位 next: 下一条指令地址
             - 输出:
               - 32位 out: 输出下一条指令地址
         - PCctrl.v
           - 功能: PC寄存器控制模块
             - 输入:
               - 32位 pc: PC当前地址
               - 1位 j: j指令信号
               - 1位 jal: jal指令信号
               - 26位 j_inst: J指令地址
               - 1位 branch: beq分支信号
               - 1位 nbranch: bne分支信号
               - 32位 expand_imme: 扩展后立即数
               - 1位 jr: jr指令信号
               - 32位 ra: jr时从寄存器读取的地址
               - 2位 mode: 工作模式选择信号
               - 1位 clk: 时钟信号
               - 32位 interrupt_handler: 中断处理指令地址
             - 输出:
               - 32位 link_addr: jal时要link的地址
               - 32位 next: 下一条指令地址
         - RAM.v
           - 功能: RAM模块，用于存储数据
             - 输入:
               - 1位 clk: 时钟信号
               - 1位 rst: 复位信号
               - 1位 mem_read: 读使能信号
               - 1位 mem_write: 写使能信号
               - 32位 addr: 写入地址
               - 32位 write_data: 写入数据
               - 8位 in_num: 样例内数据输入
               - 4位 in_case: 样例序号输入
             - 输出:
               - 32位 read_data: 读出数据
               - 32位 out_num: 需要板子七段数码管显示的数据
               - 8位 out_sig: 需要板子led灯显示的信号
         - ROM.v
           - 功能: ROM模块，用于读取指令
             - 输入:
               - 1位 clk: 时钟信号
               - 1位 rst: 复位信号
               - 32位 addr: 读取地址
             - 输出:
               - 32位 instruction: 读出指令
         - seg_block.v
           - 功能: 七段数码管显示模块
             - 输入:
               - 1位 clk: 时钟信号
               - 1位 rst: 复位信号
               - 32位 seg_in: 七段数码管待输出数据
             - 输出:
               - 8位 seg_op: 七段数码管使能信号
               - 8位 seg_out: 七段数码管输出
         - SIMD_ALU.v
           - 功能: SIMD_ALU模块，用于SIMD指令运算
             - 输入:
               - 12位 alu_op: 运算类型，同ALU
               - 128位 in0: 运算数0
               - 128位 in1: 运算数1
             - 输出:
               - 128位 out: 运算结果
   
   
   - 问题及总结
   
     - CTRL.v中的控制信号的生成复杂，如何简化？
       - 将opcode和funct都传入ALU中方便ALU判断指令类别
     - 如何实现中断？
   
     - 如何实现IO？
     - 如何实现乘除法？
       - 由于我们只需要用到8 bit的乘法运算，于是不引入lo, hi寄存器，只需直接将结果存入存储结果的寄存器中
       - 除法计算我们将用于存入存储结果的32位寄存器分高16位和低16位中，高十六位存商，低十六位存余数
     - 如何实现模式切换
