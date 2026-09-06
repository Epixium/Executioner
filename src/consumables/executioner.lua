local back_apply = Back.apply_to_run
function Back:apply_to_run()
    G.GAME.xcute_executed_jokers = {}
    G.GAME.xcute_executed_joker_count = 0
    back_apply(self)
end

-- gets all jokers in the booster pack
local function booster_joker_list()
    local jokers = {}
    if G.STATE == G.STATES.SMODS_BOOSTER_OPENED and G.pack_cards and G.pack_cards.cards then
        for i = 1, #G.pack_cards.cards do
            if G.pack_cards.cards[i].ability.set == 'Joker' then
                jokers[#jokers+1] = G.pack_cards.cards[i]
            end
        end
    end
    return jokers
end

SMODS.Consumable {
    key = 'executioner',
    atlas = 'tarots',
    pos = {
        x = 0,
        y = 0
    },
    config = { extra = { max = 30, money = 0, money_per = 5 } },
    set = 'Tarot',
    select_card = 'consumeables',
    loc_vars = function(self, info_queue, card)

        info_queue[#info_queue+1] = { set = "Other", key = "xcute_executed", vars = {} }

        local card_list = booster_joker_list()
        if #card_list == 0 then
            card_list = G.shop_jokers and G.shop_jokers.cards or {}
        end

        local money = 0
        for i = 1, #card_list do
            if card_list[i].ability.set == 'Joker' then
                money = money + card_list[i].sell_cost
            end
        end
        card.ability.extra.money = math.min(card.ability.extra.max, money * card.ability.extra.money_per)

        return { vars = { card.ability.extra.money_per, card.ability.extra.max, card.ability.extra.money } }

    end,
    use = function(self, card, area, copier)

        local card_list = booster_joker_list()
        if #card_list == 0 then
            card_list = G.shop_jokers.cards
        end

        -- add moolah
        local money = 0
        
        for i = 1, #card_list do
            if card_list[i].ability.set == 'Joker' then
                money = money + card_list[i].sell_cost
            end
        end
        card.ability.extra.money = math.min(card.ability.extra.max, money * card.ability.extra.money_per)

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                card:juice_up(0.3, 0.5)
                ease_dollars(card.ability.extra.money, true)
                return true
            end
        }))
        delay(0.6)

        -- remove jokers
        local destructibles = {}

        for i = 1, #card_list do
            if card_list[i].ability.set == 'Joker' then
                Executioner.execute_card(card_list[i])
                destructibles[#destructibles+1] = card_list[i]
            end
        end

        SMODS.destroy_cards(destructibles, {bypass_eternal = true})

    end,
    can_use = function(self, card)
        return #booster_joker_list() > 0 or (G.shop_jokers and G.shop_jokers.cards and (#G.shop_jokers.cards > 0))
    end
}