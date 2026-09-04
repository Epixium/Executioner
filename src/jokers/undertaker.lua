SMODS.Joker {
    key = 'undertaker',
    atlas = 'jokers',
    pos = {
        x = 1,
        y = 0
    },
    config = { extra = { chips = 9 } },
    rarity = 1,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = { set = "Other", key = "xcute_executed", vars = {} }
        return { vars = { 
            card.ability.extra.chips,
            G.GAME.xcute_executed_joker_count and card.ability.extra.chips * G.GAME.xcute_executed_joker_count or 0
        } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips * G.GAME.xcute_executed_joker_count
            }
        end
    end,
    in_pool = function(self, args)
        return ExecutionerCurrentMod.config.jokers_enabled
    end
}