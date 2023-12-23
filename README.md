# Overview

This repository contains an adaptive control system implementation designed for enhancing the performance of dynamic systems. The adaptive control algorithm included in this project is capable of adjusting control parameters in real-time based on the system's dynamics, allowing for improved and more robust control.

![](https://github.com/ATLED-3301/RRR-adaptive-control/blob/main/screenhot.png)

# Folder Structure

generics: Contains matrices describing the dynamics of the robot.
RRR_id_par.m: Main file to initiate the simulation.
Y.m: Refresher file.
J_pi.m: Jacobian of the parameters.
J.m: Jacobian of the joints.
## Installation

Clone the repository:
bash
Copy code
git clone https://github.com/lucaricciatl/adaptive-control.git
Navigate to the project directory:
bash
Copy code
cd adaptive-control
Review and modify parameters in the generics folder to match your specific robot dynamics.
Usage

Run the simulation using RRR_id_par.m:
  matlab RRR_id_par.m
  
Adjust and customize the control parameters using the provided files (Y.m, J_pi.m, J.m) based on your requirements.

# Contributing

Contributions are encouraged! If you'd like to contribute, please check out the CONTRIBUTING.md file for guidelines.

# License

This project is licensed under the MIT License. See the LICENSE file for details.

