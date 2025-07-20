pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

Animation = {
    new = function(s, frames_set)
        if type(frames_set) ~= "table" then
            printh("error: invalid frame data passed: '" .. tostr(frames_set) .. "' frame data must be in the form of a table")
            return
        end
        if frames_set[1].framerate == nil then
            printh("error: missing animation metadata")
            return
        end

        local metadata = frames_set[1]
        deli(frames_set, 1)

        local new_anim = {}
        setmetatable(new_anim, s)
        s.__index = s

        new_anim.frames = frames_set
        new_anim.framerate = metadata.framerate
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
    play_until_done = function(s, dt, dx, dy) -- returns playing state
        s:draw_frame(s.frames[s.current_frame], dx, dy)
        if (dt % s.framerate == 0) s.current_frame += 1
        return s.current_frame <= #s.frames
    end,
    draw_frame = function(s, f, dx, dy)
        sspr(f.x, f.y, f.w, f.h, dx + f.x_m, dy + f.y_m)
    end,
    draw_last_frame = function(s, dx, dy)
        s:draw_frame(s.frames[s.current_frame], dx, dy)
    end
}

AnimatorController = {
    -- holds a collection of animations and monitors the state of them
    new = function(s)
        local controller = {}
        setmetatable(controller, s)
        s.__index = s

        s.anim_currently_playing = nil 

        return controller
    end,
    add_anim = function(s, key, value)
        s[key] = value
    end,

    start_anim = function(s, key)
        if s[key] == nil or s.anim_currently_playing ~= nil then
            printh("warning: animation blocked from starting")
            return -- do not start an animation
        end
        s.anim_currently_playing = s[key]
        s.anim_currently_playing.current_frame = 1 -- restart animation
    end,
    play_anim = function(s, dt, dx, dy)
        if s.anim_currently_playing ~= nil then
            local playing = s.anim_currently_playing:play_until_done(dt, dx, dy)
            if (not playing) s.anim_currently_playing = nil
        else
            -- play default animation
        end
    end
}



function draw_deck(card_frame, dx, dy)
    f = card_frame
    sspr(f.x, f.y, f.w, f.h, dx, dy + 2)
    sspr(f.x, f.y, f.w, f.h, dx, dy + 1)
    sspr(f.x, f.y, f.w, f.h, dx, dy)

end