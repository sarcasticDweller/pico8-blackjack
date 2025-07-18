pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

-- Enums
Suits = {
    heart = "heart",
    diamond = "diamond",
    club = "club",
    spade = "spade"
}

CardValues = {
    ace = 1,
    two = 2,
    three = 3,
    four = 4,
    five = 5,
    six = 6,
    seven = 7,
    eight = 8,
    nine = 9,
    ten = 10,
    jack = 10,
    queen = 10,
    king = 10
}

-- error catching values
local bad_suit = "error"
local bad_value = 0

-- Constructor for Card class
Card = {
    new = function(s, suit_enum, value_enum, face_down)
        local suit = suit_enum
        local value = value_enum
        local new_card = {}

        -- data validation
        local is_valid_suit = false
        local is_valid_value = false

        for key, _ in pairs(Suits) do
            if Suits[key] == suit_enum then
                is_valid_suit = true
                break
            end
        end
        for key, _ in pairs(CardValues) do
            if CardValues[key] == value_enum then
                is_valid_value = true
                break
            end
        end


        if not is_valid_suit then
            printh("error: card " .. tostr(new_card) .. " given bad suit: " .. suit_enum)
            suit = bad_suit
        end
        if not is_valid_value then
            printh("error: card " .. tostr(new_card) .. " given bad value: " .. value_enum)
            value = bad_value
        end

        setmetatable(new_card, s)
        s.__index = s
        new_card.suit = suit
        new_card.value = value
        new_card.face_down = face_down
        return new_card

    end,

    -- Card Operator Overloading
    __eq = function(card1, card2) -- ==
        if getmetatable(card1) ~= Card or getmetatable(card2) ~= Card then
            return false
        end
        return card1.value == card2.value
    end,
    __lt = function(card1, card2) -- <
        if getmetatable(card1) ~= Card or getmetatable(card2) ~= Card then
            return false
        end
        return card1.value < card2.value
    end,
    __gt = function(card1, card2) -- >
        if getmetatable(card1) ~= Card or getmetatable(card2) ~= Card then
            return false
        end
        return card1.value > card2.value
    end,
    __tostring = function(card)
        if card.face_down then
            return "Back of card"
        end
        return "Card(" .. card.suit .. ", " .. card.value .. ")" 
    end
}
