# KitePodSimulator

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://ufechner7.github.io/KitePodSimulator.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://ufechner7.github.io/KitePodSimulator.jl/dev)
[![Build Status](https://github.com/ufechner7/KitePodSimulator.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/ufechner7/KitePodSimulator.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/ufechner7/KitePodSimulator.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/ufechner7/KitePodSimulator.jl)

## Background
A kite pod or kite control unit consists of one or two electric miniatur winches, that pull on two or three lines (attached to the kite) and allow to steer the kite and to change the angle of attack and thus the lift.

This software acts as controller: It has two inputs, the set values, and two outputs, the actual values.

Two P controllers are used. 

The geometric nonlinearity due to the change of the effectiv drum diameter of the drum with the depower tape is taken into account.

## Provides

- functions to initialize the simulator, to update the set values and to read the actual values
- a function on_timer() that needs to be called once per time step
- a function to convert the actual depower value into change of angle of attack is provided.

## Related
- The application [KiteViewer](https://github.com/ufechner7/KiteViewer)
- the package [KiteUtils](https://github.com/ufechner7/KiteUtils.jl)

Author: Uwe Fechner (uwe.fechner.msc@gmail.com)