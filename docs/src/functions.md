```@meta
CurrentModule = KitePodModels
```

## Initialization and update
```@docs
init_kcu(kcu::KCU, set::KiteUtils.Settings)
on_timer(kcu::KCU, dt = 0.0)
```

## Input and Output
```@docs
set_depower_steering(kcu::KCU, depower, steering)
get_depower(kcu::KCU)
get_steering(kcu::KCU)
```

## Conversions
```@docs
calc_alpha_depower(kcu::KCU, rel_depower)
```
