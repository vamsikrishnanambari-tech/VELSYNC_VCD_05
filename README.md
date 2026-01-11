# VELSYNC_VCD_05
This project implements a low-power 4×4 matrix multiplier using Verilog HDL. It multiplies two 8-bit input matrices and produces a 16-bit result matrix. Clock gating reduces dynamic power, and resource sharing uses a single multiplier and adder, making the design area- and power-efficient.

## ⚙️ Key Features
- 4×4 matrix multiplication
- 8-bit input elements
- 16-bit output elements
- Clock gating for low power
- Resource sharing (single multiplier & adder)
- Synthesizable and simulation-friendly design

---

## 🔋 Low-Power Techniques Used
### 1. Clock Gating
The clock is enabled only during computation, reducing unnecessary switching activity and dynamic power consumption.

### 2. Resource Sharing
Instead of using multiple multipliers, a single multiplier and accumulator are reused sequentially, reducing hardware area and power.

---

## 🧩 Module Description
### Inputs
- `clk`   : System clock  
- `rst`   : Active-high reset  
- `enable`: Enables computation (clock gating)  
- `A_flat`: Flattened 4×4 input matrix A (128 bits)  
- `B_flat`: Flattened 4×4 input matrix B (128 bits)  

### Outputs
- `C_flat`: Flattened 4×4 output matrix C (256 bits)  
- `done`  : Indicates completion of multiplication  

---

## 🧪 Testbench
A Verilog testbench is provided to:
- Generate clock and reset
- Apply test matrices
- Enable computation
- Wait for completion
- Display the output matrix

Identity matrix is used for easy verification.

---

## ✅ Expected Output
When matrix **A** is an identity matrix, the output **C equals matrix B**.

---

## 🛠 Tools Used
- Verilog HDL
- Xilinx ISE
- ModelSim (for simulation)

---

## 📂 Project Structure
* matrix_multiplier/
* │── matrix_veri.v # Main Verilog module
* │── tb_matrix.v # Testbench

## ✅ === Matrix Multiplication Accelerator Simulation ===
* Matrix A:
* [1  2  3  4]
* [5  6  7  8]
* [9  10 11 12]
* [13 14 15 16]

* Matrix B:
[1  0  0  0]
[0  1  0  0]
[0  0  1  0]
[0  0  0  1]

 Result Matrix C = A × B:
[1  2  3  4]
[5  6  7  8]
[9 10 11 12]
[13 14 15 16]



