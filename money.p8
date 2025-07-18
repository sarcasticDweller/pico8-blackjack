pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

Bet = {
    new = function(s, value, payout)
        if type(value) ~= "number" or type(payout) ~= "number" then
            printh("error: invalid bet data given")
        end
        local new_bet = {}
        setmetatable(new_bet, s)
        new_bet.__index = s
        new_bet.value = value
        new_bet.payout = payout
        return new_bet
    end,
    win = function(s)
        return s.value * s.payout
    end,
    tie = function(s)
        return s.value
    end
}