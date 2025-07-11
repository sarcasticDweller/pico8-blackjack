pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

Animation = {}
function Animation:new(frames_set)
    local error_frames_set = {8, 0, 18, 7, 0, 0} 
    local frames = frames_set
    if type(frames_set) ~= "table"
    then
        printh("error: invalid frame data passed: " .. tostr(frames_set) .. "\nframe data must be in the form of a table")
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