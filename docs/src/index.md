```@meta
CurrentModule = KitePodSimulator
```

# KitePodSimulator

Documentation for [KitePodSimulator](https://github.com/ufechner7/KitePodSimulator.jl).

## Background
A kite pod or kite control unit consists of one or two electric miniatur winches, that pull on two or three lines (attached to the kite) and allow to steer the kite and to change the angle of attack and thus the lift.

This software acts as controller: It has two inputs, the set values, and two outputs, the actual values.

Two P controllers are used. 

The geometric nonlinearity due to the change of the effectiv drum diameter of the drum with the depower tape is taken into account.

## Provides

- functions to initialize the simulator, to update the set values and to read the actual values
- a function on_timer() that needs to be called once per time step
- a function to convert the actual depower value into change of angle of attack

Click on **Functions** on the left to see the exported functions.

Author: Uwe Fechner (uwe.fechner.msc@gmail.com)
