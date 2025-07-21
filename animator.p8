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
    play_until_done = function(s, dt, dx, dy) -- returns playing state
        if (s.current_frame > #s.frames) return false -- she's done
        s:draw_frame(s.frames[s.current_frame], dx, dy)
        if (dt % s.framerate == 0) s.current_frame += 1
        return s.current_frame < #s.frames
    end,
    draw_frame = function(s, f, dx, dy)
        sspr(f.x, f.y, f.w, f.h, dx + f.x_m, dy + f.y_m)
    end,
}

AnimatorController = {
    -- holds a collection of animations and monitors the state of them
    new = function(s)
        local controller = {}
        setmetatable(controller, s)
        s.__index = s

        default_anim = nil
        anim_currently_playing = default_anim

        return controller
    end,
    add_anim = function(s, key, value)
        s[key] = value
    end,
    set_default_anim = function(s, key)
        if s[key] == nil then
            printh("error: attempted to set default animation to invalid animation")
            return
        end
        s.default_anim = key
    end,

    start_anim = function(s, key)
        if s[key] == nil then
            printh("error: tried to start invalid animation")
            return
        end
        if s.anim_currently_playing ~= nil and s.anim_currently_playing ~= s[s.default_anim] then
            printh("warning: tried to start animation while other is playing")
            return
        end
        s.anim_currently_playing = s[key]
        s.anim_currently_playing.current_frame = 1
    end,
    play_anim = function(s, dt, dx, dy)
        local playing = false
        if (s.anim_currently_playing ~= nil) playing = s.anim_currently_playing:play_until_done(dt, dx, dy)
        if (not playing) then
            s.anim_currently_playing = nil
            s:start_anim(s.default_anim)
        end
    end
}



function draw_deck(card_frame, dx, dy)
    f = card_frame
    sspr(f.x, f.y, f.w, f.h, dx, dy + 2)
    sspr(f.x, f.y, f.w, f.h, dx, dy + 1)
    sspr(f.x, f.y, f.w, f.h, dx, dy)

end