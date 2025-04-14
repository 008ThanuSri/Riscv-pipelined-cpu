`timescale 1ns / 1ps

module riscv_simple_cpu (
    input clk,
    input reset
);

    // === Registers and wires ===
    reg [31:0] pc;
    wire [31:0] instr;

    wire [4:0] rs1 = instr[19:15];
    wire [4:0] rs2 = instr[24:20];
    wire [4:0] rd  = instr[11:7];
    wire [6:0] opcode = instr[6:0];
    wire [2:0] funct3 = instr[14:12];
    wire [6:0] funct7 = instr[31:25];

    wire [31:0] rd1, rd2;
    wire [31:0] imm;
    wire [31:0] alu_result;
    wire [3:0] alu_ctrl;
    wire [31:0] write_data;

    reg [31:0] regfile [0:31];
    reg [31:0] instr_mem [0:255];

    initial begin
        // Example instructions (addi x1, x0, 5), (addi x2, x0, 10), (add x3, x1, x2)
        instr_mem[0] = 32'h00500093; // addi x1, x0, 5
        instr_mem[1] = 32'h00a00113; // addi x2, x0, 10
        instr_mem[2] = 32'h002081b3; // add x3, x1, x2
    end

    assign instr = instr_mem[pc[9:2]];

    // === Immediate generator (only I-type for now) ===
    assign imm = {{20{instr[31]}}, instr[31:20]};

    // === Register read ===
    assign rd1 = (rs1 != 0) ? regfile[rs1] : 0;
    assign rd2 = (rs2 != 0) ? regfile[rs2] : 0;

    // === ALU control (simplified) ===
    assign alu_ctrl = (opcode == 7'b0110011) ? 4'b0010 : // add
                      (opcode == 7'b0010011) ? 4'b0010 : // addi
                      4'b0000;

    // === ALU ===
    assign alu_result = rd1 + ((opcode == 7'b0010011) ? imm : rd2);  // only add/addi

    // === Write back ===
    assign write_data = alu_result;

    // === Clocked logic ===
    always @(posedge clk) begin
        if (reset) begin
            pc <= 0;
        end else begin
            pc <= pc + 4;

            if (opcode == 7'b0110011 || opcode == 7'b0010011) begin
                if (rd != 0)
                    regfile[rd] <= write_data;
            end
        end
    end

endmodule
