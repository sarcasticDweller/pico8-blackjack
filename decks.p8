pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
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

Deck = {
    new = function(s, generator_func)
        local new_deck = {}
        setmetatable(new_deck, s)
        s.__index = s
        new_deck.cards = generator_func()
        return new_deck
    end,
    get_value = function(s)
        value = 0
        foreach(s.cards, function(card) value += card.value end)
        return value 
    end,
    __tostring = function(deck)
        local to_print = ""
        for i, card in ipairs(deck.cards) do
            to_print = to_print .. tostr(card) .. "\n"
        end
        return to_print
    end,
    __eq = function(deck1, deck2)
        return deck1:get_value() == deck2:get_value()
    end,
    __gt = function(deck1, deck2)
        return deck1:get_value() > deck2:get_value()
    end,
    __lt = function(deck1, deck2)
        return deck1:get_value() < deck2:get_value()
    end,
    shuffle = function(s) -- based on Fisher-Yates algorithm
        local cards_table = s.cards
        local n = #cards_table
        while n > 1 do 
            local k = flr(rnd(n)) + 1
            local temp = cards_table[n]
            cards_table[n] = cards_table[k]
            cards_table[k] = temp
            n -= 1
        end
    end,
    draw_card = function(s)
        c = s.cards
        return del(c, c[#c])
    end,
    add_card = function(s, card, flip)
        flip = flip or false
        if flip
        then
            card.face_down = not card.face_down
        end
        add(s.cards, card)
    end
}
