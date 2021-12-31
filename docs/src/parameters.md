```@meta
CurrentModule = KitePodSimulator
```
## Configuration
To configure the parameters of the KitePodSimulator, edit the file data/settings.yaml , or create
a copy under a different name and change the name of the active configuration in the file data/system.yaml .

## Parameters
The following parameters are used by this package:
```md
kcu:
    mass: 8.4                    # mass of the kite control unit   [kg]
    power2steer_dist: 1.3        #                                 [m]
    depower_drum_diameter: 0.069 #                                 [m]
    tape_thickness: 0.0006       #                                 [m]
    v_depower: 0.075             # max velocity of depowering in units per second (full range: 1 unit)
    v_steering: 0.2              # max velocity of steering in units per second   (full range: 2 units)
    depower_gain: 3.0            # 3.0 means: more than 33% error -> full speed
    steering_gain: 3.0

depower:
    depower_offset: 23.6         # at rel_depower=0.236 the kite is fully powered [%]
```