SMODS.Joker {
    key = 'paper_shredder',
    atlas = 'jokers',
    pos = {
        x = 2,
        y = 0
    },
    rarity = 2,
    cost = 6,
    config = { extra = { price = 2 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = { set = "Other", key = "xcute_executed", vars = {} }
        return { vars = { card.ability.extra.price } }
    end,
    calculate = function(self, card, context)
        if context.selling_card and context.card.ability.set == 'Joker' and not context.blueprint then
            Executioner.execute_card(context.card)
        end
        if context.joker_executed then
            card.ability.extra_value = card.ability.extra_value + card.ability.extra.price
            card:set_cost()
            return {
                message = localize('k_val_up'),
                colour = G.C.MONEY
            }
        end
    end,
    in_pool = function(self, args)
        return ExecutionerCurrentMod.config.jokers_enabled
    end,
    joker_display_def = function(JokerDisplay)
        return {
            reminder_text = {
                { text = "(" },
                { text = "$",         colour = G.C.GOLD },
                { ref_table = "card", ref_value = "sell_cost", colour = G.C.GOLD },
                { text = ")" },
            },
            reminder_text_config = { scale = 0.35 }
        }
    end
}