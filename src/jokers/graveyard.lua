SMODS.Joker {
    key = 'graveyard',
    atlas = 'jokers',
    pos = {
        x = 3,
        y = 0
    },
    rarity = 2,
    cost = 6,
    config = { extra = { odds = 2 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = { set = "Other", key = "xcute_executed", vars = {} }
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'xcute_graveyard')
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.joker_executed and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if SMODS.pseudorandom_probability(card, 'xcute_graveyard', 1, card.ability.extra.odds) then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (function()
                        SMODS.add_card {
                            set = 'Spectral',
                            key_append = 'xcute_graveyard' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
                return {
                    message = localize('k_plus_spectral'),
                    colour = G.C.SECONDARY_SET.Spectral,
                }
            end
        end
    end,
    in_pool = function(self, args)
        return ExecutionerCurrentMod.config.jokers_enabled
    end,
    joker_display_def = function(JokerDisplay)
        return {
            extra = {
                {
                    { text = "(" },
                    { ref_table = "card.joker_display_values", ref_value = "odds" },
                    { text = ")" },
                }
            },
            extra_config = { colour = G.C.GREEN, scale = 0.3 },
            calc_function = function(card)
                local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'xcute_graveyard')
                card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
            end
        }
    end
}