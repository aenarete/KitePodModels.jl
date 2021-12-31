```@meta
CurrentModule = KitePodSimulator
```

## Initialization and update
```@docs
init_kcu()
on_timer(dt = 1.0 / set.sample_freq)
```

## Input and Output
```@docs
set_depower_steering(depower, steering)
get_depower()
get_steering()
```

## Conversions
```@docs
calc_alpha_depower(rel_depower)
```
