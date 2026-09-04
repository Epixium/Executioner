SMODS.Joker {
    key = 'paper_shredder',
    atlas = 'jokers',
    pos = {
        x = 2,
        y = 0
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = { set = "Other", key = "xcute_executed", vars = {} }
    end,
    calculate = function(self, card, context)
        if context.selling_card and context.card.ability.set == 'Joker' then
            Executioner.execute_card(context.card)
        end
    end,
    in_pool = function(self, args)
        return ExecutionerCurrentMod.config.jokers_enabled
    end
}