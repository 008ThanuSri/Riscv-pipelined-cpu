# Riscv-pipelined-cpu
A 5-stage pipelined RISCV_CPU core with basic instruction support, which is written in Verilog. This includes a testbench and simulation setup.

# RISC-V Simple CPU (Verilog)

This project is a minimal implementation of a basic single-cycle RISC-V CPU using Verilog. It supports simple instructions like `addi` and `add`, with a corresponding testbench to verify functionality through waveform analysis.

---

## Files Included

| File                      | Description                                      |
|---------------------------|--------------------------------------------------|
| `riscv_simple_cpu.v`      | The main Verilog module implementing the CPU     |
| `testbench.v`             | Testbench to simulate and verify the CPU         |
| `testbench_behav.wcfg`    | GTKWave waveform configuration file              |
| `waveform.png`            | Waveform output screenshot for simulation        |

---

##  Features

- 32-bit instruction and data handling
- Simple RISC-V instruction memory (preloaded)
- Register file with 32 registers
- ALU supporting only addition (`add`, `addi`)
- Immediate generator for I-type instructions
- Write-back stage to update registers

---

## Instructions Simulated

The instruction memory is preloaded with 3 RISC-V instructions:

assembly
addi x1, x0, 5     // instr_mem[0]
addi x2, x0, 10    // instr_mem[1]
add  x3, x1, x2    // instr_mem[2]

** Simulation Timeline: 0–10 ns: reset = 1

After 10 ns: CPU begins execution

Every 10 ns: One clock cycle (clock toggles every 5 ns)

200 ns: Simulation finishes

Each instruction executes per cycle with PC incremented by 4.

RESULT  WAVEFORM:
![image](https://github.com/user-attachments/assets/cf18b6c3-cb28-42ea-b8fe-b35dec90b246)



