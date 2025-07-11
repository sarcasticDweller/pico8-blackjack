pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

Animation = {}
function Animation:new(frames_set)
    local error_frames_set = {8, 0, 18, 7, 0, 0} 
    local frames = frames_set
    if type(frames_set) ~= "table" then
        printh("error: invalid frame data passed: '" .. tostr(frames_set) .. "' frame data must be in the form of a table")
        frames = error_frames_set
    end

    local new_anim = {}
    setmetatable(new_anim, self)
    self.__index = self

    new_anim.frames = frames
    new_anim.current_frame = 1
    return new_anim
end
function Animation.__tostring(animator)
    local to_print = ""
    for _, frame in ipairs(animator.frames) do
        for _, i in ipairs(frame) do
            to_print = to_print .. tostr(i) .. "\n"
        end
    end
    return to_print
end
function Animation:play_until_done(dx, dy) -- returns done state
    self:draw_frame(self.frames[self.current_frame], dx, dy)
    self.current_frame += 1
    if (self.current_frame >= #self.frames) return true
    return false
end
function Animation:draw_frame(f, dx, dy)
    sspr(f.x, f.y, f.w, f.h, dx + f.x_m, dy + f.y_m)
end
function Animation:draw_last_frame(dx, dy)
    self:draw_frame(self.frames[self.current_frame], dx, dy)
end

Animator = {}
function Animator:new(animations)
    animation_set = animations
    if type(animations) ~= "table" then
        printh("error: invalid animation data passed: '" .. tostr(animations) .. "' animation data must be in the form of a table")
        animation_set = {}
    end


    local new_animator = {}
    setmetatable(new_animator, self)
    new_animator.__index = self

    new_animator.animations = animation_set
    new_animator.animation_playing = 1 
    return new_animator
end