# Red Pitaya Tutorials

This repository is a companion to an ongoing series of posts on [my blog](https://www.electrickoala.dev/) about developing on the Xilinx Zynq-7000 SoCs, using the Red Pitaya STEMLab 125-14 as the main development platform. This repository contains the code and scripts necessary to build the examples that are shown on the blog.

## Getting Started
To be to run the TCL scripts in this repository you first have to install Vivado, which can be downloaded from Xilinx' website. The SoC on the Red Pitaya is covered by the Vivado ML Standard Edition, which is available for free.

Most of the examples are structured in a similar way, with one script to create the project (*mk_proj.tcl*) and a second to build the project (*build.tcl*). I normally build the project in-tree, using subdirectory named `vivado` as the build directory. As an example, the following commands can be used to clone the repository and build the `blink-led` project. A more detailed explanation can be found in [this blog post](https://www.electrickoala.dev/posts/zynq-7000-command-line/).
```bash
source /opt/Xilinx/Vivado/2021.1/settings64.sh
git clone https://github.com/vvvverre/red-pitaya-tutorials.git
cd red-pitaya-tutorials/blink-led
mkdir vivado && cd vivado
vivado -mode batch -source ../mk_proj.tcl
vivado -mode batch -source ../build.tcl
```

## Contents
The repo contains the following example projects.

### blink-led
This project is set up to make an LED blink at a rate of approximately 1 Hz, using a few built-in IP blocks provided by Xilinx. An in-depth explanation of this project can be found in [this blog post](https://www.electrickoala.dev/posts/zynq-7000-getting-started/), and an explanation of the command-line workflow in [this blog post](https://www.electrickoala.dev/posts/zynq-7000-command-line/).

### axi-gpio
This project allows the LEDs to be controlled from the ARM core, using Xilinx' AXI GPIO block.. An in-depth explanation of this project can be found in [this blog post](https://www.electrickoala.dev/posts/zynq-7000-next-steps/), and an explanation of the command-line workflow in [this blog post](https://www.electrickoala.dev/posts/zynq-7000-command-line/).

### blink-led-rtl
This project repeats the `blink-led` project, but in this project the Xilinx IP cores have been replaced with some bespoke RTL code. This project is explained further in [this blog post](https://www.electrickoala.dev/posts/zynq-7000-custom-blocks/).

