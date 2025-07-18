pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

Animation = {
    new = function(s, frames_set)
        local error_frames_set = {8, 0, 18, 7, 0, 0} 
        local frames = frames_set
        if type(frames_set) ~= "table" then
            printh("error: invalid frame data passed: '" .. tostr(frames_set) .. "' frame data must be in the form of a table")
            frames = error_frames_set
        end

        local new_anim = {}
        setmetatable(new_anim, s)
        s.__index = s

        new_anim.frames = frames
        new_anim.current_frame = 1
        return new_anim
    end,
    __tostring = function(s)
        local to_print = ""
        for _, frame in ipairs(s.frames) do
            for _, i in ipairs(frame) do
                to_print = to_print .. tostr(i) .. "\n"
            end
        end
        return to_print
    end,
    play_until_done = function(s, dx, dy) -- returns done state
        s:draw_frame(s.frames[s.current_frame], dx, dy)
        s.current_frame += 1
        if (s.current_frame >= #s.frames) return true
        return false
    end,
    draw_frame = function(f, dx, dy)
        sspr(f.x, f.y, f.w, f.h, dx + f.x_m, dy + f.y_m)
    end,
    draw_last_frame = function(s, dx, dy)
        s:draw_frame(s.frames[s.current_frame], dx, dy)
    end
}

Animator = {
    new = function(s, animations)
        animation_set = animations
        if type(animations) ~= "table" then
            printh("error: invalid animation data passed: '" .. tostr(animations) .. "' animation data must be in the form of a table")
            animation_set = {}
        end


        local new_animator = {}
        setmetatable(new_animator, s)
        new_animator.__index = s

        new_animator.animations = animation_set
        new_animator.animation_playing = 1 
        return new_animator
    end
}