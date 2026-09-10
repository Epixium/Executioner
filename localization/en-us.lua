return {
    descriptions = {
        Joker = {
            j_xcute_undertaker = {
                name = "Undertaker",
                text = {
                    "{C:chips}+#1#{} Chips per Joker",
                    "{C:attention}executed{} this run",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
                }
            },
            j_xcute_paper_shredder = {
                name = "Paper Shredder",
                text = {
                    "Jokers are {C:attention}executed{}",
                    "after being {C:attention}sold{}",
                    "Gains {C:money}$#1#{} of {C:attention}sell value{} for",
                    "each Joker executed"
                }
            },  
            j_xcute_graveyard = {
                name = "Graveyard",
                text = {
                    "{C:green}#1# in #2#{} chance to create",
                    "a {C:spectral}Spectral{} card when",
                    "any Joker is {C:attention}executed{}",
                    "{C:inactive}(Must have room)",
                }
            }
        },
        Tarot = {
            c_xcute_executioner = {
                name = "The Executioner",
                text = {
                    "{C:attention}Executes{} all Jokers in",
                    "the shop or {C:attention}Booster Pack{}",
                    "Gives {C:attention}#1#{}x the sell value of",
                    "executed Jokers {C:inactive}(Max {C:money}$#2#{C:inactive})",
                    "{C:inactive}(Currently {C:money}$#3#{C:inactive})"
                }
            }
        },
        Other = {
            xcute_executed = {
                name = "Executed",
                text = {
                    "Will {C:red}not{} appear",
                    "for the rest",
                    "of the run"
                },
            },
        }
    },
    misc = {
        dictionary = {
            xcute_jokers_executed_title = 'Executions',
            xcute_jokers_executed = 'Jokers executed this run',
            xcute_no_jokers_executed = 'No Jokers executed this run',
        }
    }
}