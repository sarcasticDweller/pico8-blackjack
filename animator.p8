pico-8 cartridge // http://www.pico-8.com
version 42
__lua__


Animator = {}
function Animator:new(frames_set)
    -- frames set is gotten from frames.p8 which holds a bunch of tables containing tables that look something like this:
    -- {x, y, w, h, travel_x, travel_y}
    -- the animator is responsible for actually animating these
    local error_frames_set = {8, 0, 18, 7, 0, 0} 
    local frames = frames_set
    if type(frames_set) != "frames"
    then
        printh("error: invalid frame data passed: " .. tostr(frames_set) .. "\nframe data must be in the form of a table")
        frames = error_frames_set
    end

    local new_animator = {}
    setmetatable(new_animator, self)
    new_animator.frames = frames
    return new_animator
end

function Animator.__tostring(animator)
    local to_print = ""
    for _, frame in ipairs(animator.frames) do 
        to_print = to_print .. tostr(card) .. "\n"
    end
    return to_print
end