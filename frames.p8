pico-8 cartridge // http://www.pico-8.com
version 42
__lua__


--[[
framerate
1: full rate
2: half rate
3: every 3rd frame
4: every 4th frame
]]

CardFlipBackFront = {
    {framerate = 2},
    {x = 0, y = 32, w = 10, h = 12, x_m = 0, y_m = 0},
    {x = 10, y = 32, w = 8, h = 13, x_m = 0, y_m = -1},
    {x = 18, y = 32, w = 7, h = 13, x_m = 0, y_m = -2},
    {x = 25, y = 32, w = 4, h = 13, x_m = 0, y_m = -3},
    {x = 29, y = 32, w = 4, h = 13, x_m = 0, y_m = -2},
    {x = 33, y = 32, w = 7, h = 13, x_m = 0, y_m = -1},
    {x = 41, y = 32, w = 10, h = 12, x_m = 0, y_m = 0}
}
CardFlipFrontBack = {
    {framerate = 2},
    {x = 41, y = 32, w = 10, h = 12, x_m = 0, y_m = 0},
    {x = 33, y = 32, w = 7, h = 13, x_m = 0, y_m = -1},
    {x = 29, y = 32, w = 4, h = 13, x_m = 0, y_m = -2},
    {x = 25, y = 32, w = 4, h = 13, x_m = 0, y_m = -3},
    {x = 18, y = 32, w = 7, h = 13, x_m = 0, y_m = -2},
    {x = 10, y = 32, w = 8, h = 13, x_m = 0, y_m = -1},
    {x = 0, y = 32, w = 10, h = 12, x_m = 0, y_m = 0},
}
CardFront = {
    {framerate = 30},
    {x = 41, y = 32, w = 10, h = 12, x_m = 0, y_m = 0},
}
CardBack = {
    {framerate = 30},
    {x = 0, y = 32, w = 10, h = 12, x_m = 0, y_m = 0},
}