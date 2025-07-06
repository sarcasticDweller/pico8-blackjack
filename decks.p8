pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
Deck = {}
function Deck:new(generator_func)
    local new_deck = {}
    setmetatable(new_deck, self)
    self.__index = self
    new_deck.cards = generator_func()
    return new_deck
end
-- Generators
function standard_52_card_deck_face_down()
    local cards = {}
    for suit, _ in pairs(Suits) do
        for value, _ in pairs(CardValues) do
            local card = Card:new(Suits[suit], CardValues[value], true)
            add(cards, card)
        end
    end
    return cards
end
function empty_deck()
    return {}
end

-- Deck Accessors
function Deck.__tostring(deck)
    local to_print = ""
    for i, card in ipairs(deck.cards) do
        to_print = to_print .. tostr(card) .. "\n"
    end
    return to_print
end


-- Deck Mutators
function Deck:shuffle() -- based on Fisher-Yates algorithm
    local cards_table = self.cards
    local n = #cards_table
    while n > 1 do 
        local k = flr(rnd(n)) + 1
        local temp = cards_table[n]
        cards_table[n] = cards_table[k]
        cards_table[k] = temp
        n -= 1
    end
end

function Deck:draw_card()
    c = self.cards
    return del(c, c[#c])
end
function Deck:add_card(card, flip)
    flip = flip or false
    if flip
    then
        card.face_down = not card.face_down
    end
    add(self.cards, card)
end
