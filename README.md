# Router (Neuromorphic Processor Subsystem)

This repository contains the **router modules** for our scaled-down 8x8 neuromorphic processor project.  
The router is responsible for moving spike packets between neuron cores in a mesh network (similar to IBM TrueNorth architecture).  

---

## 📂 Repository Structure
router/

`│── src/ # Verilog source files` //
`│ ├── from_local.v # Handles packets injected from local core`
`│ ├── forward_west.v # Handles packets arriving from the west neighbor`
`│ ├── forward_north.v # Handles packets arriving from the south neighbor`
`│ └── router_partial.v # Top-level integration of submodules (WIP)`

│── tb/ # Testbenches
│ ├── tb_from_local.v
│ ├── tb_forward_west.v
│ └── tb_forward_north.v

│── docs/ # Design notes and diagrams (optional)
│ └── design_notes.md

│── README.md # Project documentation
│── .gitignore # Ignore Vivado build files

---

## 🧠 Background

In our neuromorphic chip design, computation is performed by **neurons** and **synapses**.  
To communicate spikes between cores, we use a **packet-based router network (NoC)**.

- Each **packet** is a 16-bit word, containing:
  - `dx [15:12]` → horizontal distance to target
  - `dy [11:8]`  → vertical distance to target
  - `axon_id [7:0]` → target axon/neuron identifier  

- The router decrements `dx` or `dy` as packets move across the mesh until the destination is reached.

---

## 📦 Modules Implemented

### `from_local.v`
- Injects packets from the local neuron core into the network.  
- Routes east if `dx > 0`, west if `dx < 0`, or local if `dx == 0`.

### `forward_west.v`
- Handles packets **arriving from the west neighbor**.  
- If `dx < 0`, decrements `dx` and forwards further west.  
- If `dx == 0`, passes packet to local core.  
- Error if `dx > 0` (invalid for west input).

### `forward_north.v`
- Handles packets **arriving from the south neighbor**.  
- If `dy > 0`, decrements `dy` and forwards further north.  
- If `dy == 0`, passes packet to local core.  
- Error if `dy < 0` (invalid for north input).

### `router_partial.v` (Work in Progress)
- Top-level integration of `from_local`, `forward_west`, and `forward_north`.  
- Will later be extended with `forward_east` and `forward_south` modules from teammate.  
- Future work: add arbiters to handle multiple packets contending for the same output.

---

## 🧪 Testbenches
Each module has a dedicated testbench:
- `tb_from_local.v`
- `tb_forward_west.v`
- `tb_forward_north.v`

Testbenches demonstrate:
- Routing in all valid directions
- Local delivery when dx/dy = 0
- Error handling when invalid packets are injected

---

## 🚀 Usage
1. Clone the repo:
   ```bash
   git clone https://github.com/ALONE-21/router.git
   cd router
2. Add source files (src/) and testbenches (tb/) into your Vivado project (or any simulator like Icarus Verilog / ModelSim).
3. Run simulation (example with Icarus Verilog):
        `iverilog -o tb tb/tb_forward_west.v src/forward_west.v`
        `vvp tb `





