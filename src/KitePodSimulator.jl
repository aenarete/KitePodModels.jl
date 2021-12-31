# Module for simulating the kite control unit (KCU).

module KitePodSimulator

using KiteUtils, Parameters

export calc_alpha_depower, init_kcu, set_depower_steering, get_depower, get_steering, on_timer

if ! isfile("./data/settings.yaml")
    copy_settings()
end
const set = se()              

@with_kw mutable struct KCUState{S}
    set_depower::S =         set.depower_offset * 0.01
    set_steering::S =        0.0
    depower::S =             set.depower_offset * 0.01   #    0 .. 1.0
    steering::S =            0.0                         # -1.0 .. 1.0
end

const kcu_state = KCUState{Float64}()

# Calculate the length increase of the depower line [m] as function of the relative depower
# setting [0..1].
function calc_delta_l(rel_depower)
    u = set.depower_drum_diameter
    l_ro = 0.0
    rotations = (rel_depower - 0.01 * set.depower_offset) * 10.0 * 11.0 / 3.0 * (3918.8 - 230.8) / 4096.
    while rotations > 0.0
         l_ro += u * π    
         rotations -= 1.0
         u -= set.tape_thickness
    end
    if rotations < 0.0
         l_ro += (-(u + set.tape_thickness) * rotations + u * (rotations + 1.0)) * π * rotations
    end
    return l_ro
end


"""
    calc_alpha_depower(rel_depower)

Calculate the change of the angle between the kite and the last tether segment [rad] as function of the
actual rel_depower value. 

Returns `nothing` in case of error.
"""
function calc_alpha_depower(rel_depower)
    a   =  set.power2steer_dist
    b_0 = set.height_b + 0.5 * set.height_k
    b = b_0 + 0.5 * calc_delta_l(rel_depower) # factor 0.5 due to the pulleys

    c = sqrt(a * a + b_0 * b_0)
    # print 'a, b, c:', a, b, c, rel_depower
    if c >= a + b
         println("ERROR in calc_alpha_depower!")
         return nothing
    else
        tmp = 1/(2*a*b)*(a*a+b*b-c*c)
        if tmp > 1.0
            println("-->>> WARNING: tmp > 1.0: $tmp")
            tmp = 1.0
        elseif tmp < -1.0
            println("-->>> WARNING: tmp < 1.0: $tmp")
            tmp = -1.0
        end            
        return pi/2.0 - acos(tmp)
    end
end

"""
    init_kcu()

Inititalze the simulator. Must be called at the beginning of the simulation. The 
actual and the set values of depower are initialized to set.depower_offset * 0.01,
the actual and the set values of steering to zero. 
"""
function init_kcu()
    kcu_state.set_depower =         set.depower_offset * 0.01
    kcu_state.set_steering =        0.0
    kcu_state.depower =             set.depower_offset * 0.01   #    0 .. 1.0
    kcu_state.steering =            0.0                         # -1.0 .. 1.0
    nothing
end

"""
    set_depower_steering(depower, steering)

Set the values of depower and steering. The value for depower must be between 0.0 and 1.0,
the value for steering between -1.0 and +1.0 .
"""
function set_depower_steering(depower, steering)
    kcu_state.set_depower  = depower
    kcu_state.set_steering = steering
    nothing
end

"""
    get_depower()

Read the current depower value. Result will be between 0.0 and 1.0.
"""
function get_depower();  return kcu_state.depower;  end

"""
    get_steering()

Read the current depower value. Result will be between -1.0 and 1.0.
"""
function get_steering(); return kcu_state.steering; end

"""
    on_timer(dt = 1.0 / set.sample_freq)

Must be called at each clock tick. Parameter: Δt in seconds    
Updates the current values of steering and depower depending
on the set values and the last value.
"""
function on_timer(dt = 1.0 / set.sample_freq)
    # calculate the depower motor velocity
    vel_depower = (kcu_state.set_depower - kcu_state.depower) * set.depower_gain
    # println("vel_depower: $(vel_depower)")
    if vel_depower > set.v_depower
        vel_depower = set.v_depower
    elseif vel_depower < -set.v_depower
        vel_depower = -set.v_depower
    end
    # update the position
    kcu_state.depower += vel_depower * dt
    # calculate the steering motor velocity
    vel_steering = (kcu_state.set_steering - kcu_state.steering) * set.steering_gain
    if vel_steering > set.v_steering
        vel_steering = set.v_steering
    elseif vel_steering < -set.v_steering
        vel_steering = -set.v_steering
    end
    kcu_state.steering += vel_steering * dt
    nothing
end

end