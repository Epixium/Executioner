Executioner.execute_card = function(card)
    local key = card.config.center_key
    G.GAME.xcute_executed_jokers[key] = true
    G.GAME.xcute_executed_joker_count = G.GAME.xcute_executed_joker_count + 1
    G.GAME.banned_keys[key] = true
    SMODS.calculate_context({joker_executed = true, card = card})
end

function G.UIDEF.xcute_executed_jokers()

    local executed_joker_centers = {}
    for k, v in ipairs(G.P_CENTER_POOLS["Joker"]) do
        if G.GAME.xcute_executed_jokers[v.key] then
            executed_joker_centers[#executed_joker_centers+1] = v
        end
    end

    local silent = false

    local joker_area = CardArea(
            G.ROOM.T.x + 0.2*G.ROOM.T.w/2, G.ROOM.T.h,
            math.min(G.GAME.xcute_executed_joker_count * G.CARD_H, G.ROOM.T.w/2),
            1.07*G.CARD_H,
            {card_limit = G.GAME.xcute_executed_joker_count, type = 'joker', highlighted_limit = 0, no_card_count = true}
        )
    local joker_row = {n=G.UIT.R, config={align = "cm", padding = 0, no_fill = true}, nodes={
        {n=G.UIT.O, config={object = joker_area}}
    }}

    for k, v in ipairs(executed_joker_centers) do
        local center = G.P_CENTERS[v.key]
        local card = Card(joker_area.T.x + joker_area.T.w/2, joker_area.T.y, G.CARD_W, G.CARD_H, nil, center, {bypass_discovery_center=true,bypass_discovery_ui=true,bypass_lock=true})
        card.ability.order = v.order
        card:start_materialize(nil, silent)
        silent = true
        joker_area:emplace(card)
    end


    local t = silent and {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
        {n=G.UIT.R, config={align = "cm"}, nodes={
        {n=G.UIT.O, config={object = DynaText({string = {localize('xcute_jokers_executed')}, colours = {G.C.UI.TEXT_LIGHT}, bump = true, scale = 0.6})}}
        }},
        {n=G.UIT.R, config={align = "cm", minh = 0.5}, nodes={
        }},
        {n=G.UIT.R, config={align = "cm", colour = G.C.BLACK, r = 1, padding = 0.15, emboss = 0.05}, nodes={
        joker_row,
        }}
    }} or
    {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
        {n=G.UIT.O, config={object = DynaText({string = {localize('xcute_no_jokers_executed')}, colours = {G.C.UI.TEXT_LIGHT}, bump = true, scale = 0.6})}}
    }}
    return t

end