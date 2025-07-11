pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

BettingPool = {}
function BettingPool:new()
    local new_betting_pool = {}
    setmetatable(new_betting_pool, self)
    new_betting_pool.__index = self

    new_betting_pool.bets = {}
    return new_betting_pool 
end

function BettingPool:add_bet(value, payout)
    add(self.bets, {value, payout})
end