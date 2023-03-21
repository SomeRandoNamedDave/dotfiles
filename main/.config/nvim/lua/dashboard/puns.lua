local M = {}
local puns = {
    { 54, [[[1mHow does a computer get drunk... [3;4;58:5:2mIt takes screenshots![0m]] },
    { 49, [[[1mDiarrhea is hereditary... [3;4;58:5:2mIt runs in your genes![0m]] },
    { 54, [[[1mI used to be addicted to soap... [3;4;58:5:2mBut I'm clean now![0m]] },
    { 61, [[[1mA book just fell on my head... [3;4;58:5:2mI only have my shelf to blame![0m]] },
    { 52, [[[1mBakers trade bread recipes on a [3;4;58:5:2mknead-to-know basis![0m]] },
    { 67, [[[1mA moon rock tastes better than an earthly rock [3;4;58:5:2mbecause it's meteor![0m]] },
    { 32, [[[1mA backwards poet writes [3;4;58:5:2minverse![0m]] },
    { 30, [[[1m3.14%% of sailors are [3;4;58:5:2mPi Rates![0m]] },
    { 58, [[[1mWhat did the mermaid wear to her math class? [3;4;58:5:2mAn algae bra![0m]] },
    { 44, [[[1mI tried to catch some fog earlier... [3;4;58:5:2mI mist![0m]] },
    { 66, [[[1mWhat does a pirate say while eating sushi? [3;4;58:5:2mAhoy! Pass me some soy![0m]] },
    { 65, [[[1mYou wanna hear a joke about pizza? Never mind, [3;4;58:5:2mit was too cheesy![0m]] },
    { 63, [[[1mWhy can't a nose be 12 inches? [3;4;58:5:2mBecause then it would be a foot![0m]] },
    { 51, [[[1mA boiled egg in the morning [3;4;58:5:2mis really hard to beat![0m]] },
    { 69, [[[1mI'm reading a book about anti-gravity... [3;4;58:5:2mIt's impossible to put down![0m]] },
    { 57, [[[1mI'm glad I know sign language... [3;4;58:5:2mIt's become quite handy![0m]] },
    { 60, [[[1mI forgot how to throw a boomerang... [3;4;58:5:2mBut it came back to me![0m]] },
    { 52, [[[1mWhen a clock is hungry... [3;4;58:5:2mIt goes back four seconds![0m]] },
    { 62, [[[1mI once heard a joke about amnesia... [3;4;58:5:2mBut I forget how it goes![0m]] },
    { 47, [[[1mThose fish were shy... [3;4;58:5:2mThey were obviously coy![0m]] },
    { 43, [[[1mThe frustrated cannibal [3;4;58:5:2mthrew up his hands![0m]] },
    { 58, [[[1mI didn't have the faintest idea... [3;4;58:5:2mas to why I passed out![0m]] },
    { 58, [[[1mI heard two peanuts walk into a park... [3;4;58:5:2mOne was as-salted![0m]] },
    { 47, [[[1mWhat is a pirate's favorite letter? [3;4;58:5:2mTis' the c![0m]] },
    { 57, [[[1mThose two men drinking battery acid [3;4;58:5:2mwill soon be charged![0m]] },
    { 68, [[[1mThe midget psychic escaped prison... [3;4;58:5:2mHe was a small medium at large![0m]] },
    { 31, [[[1mI'm inclined... [3;4;58:5:2mto be laid back![0m]] },
    { 52, [[[1mThe Magician got frustrated [3;4;58:5:2mand pulled his hare out![0m]] },
    { 46, [[[1mA criminal's best asset... [3;4;58:5:2mis his lie-ability![0m]] },
    { 61, [[[1mWhat did the triangle say to the circle? [3;4;58:5:2mYou're so pointless![0m]] },
    {{ 67, 32 }, {
        [[[1mI heard about the guy who got hit in the head with a can of soda...[0m]],
        [[[1;3;4;58:5:2mHe is lucky it was a soft drink![0m]]
    }},
    {{ 51, 26 }, {
        [[[1mIt doesn't matter how much you push the envelope...[0m]],
        [[[1;3;4;58:5:2mIt'll still be stationary![0m]]
    }},
    {{ 66, 52 }, {
        [[[1mWhat did the Confederate soldiers use to eat off of? [3;4;58:5:2mCivil ware...[0m]],
        [[[1mWhat did they use to drink with? Cups... [3;4;58:5:2mDixie Cups![0m]]
    }},
    {{ 54, 20 }, {
        [[[1mI walked into my sister's room and tripped on a bra...[0m]],
        [[[1;3;4;58:5:2mIt was a booby-trap![0m]]
    }},
    {{ 60, 12 }, {
        [[[1mWhat is the leading cause of divorce in long-term marriages?[0m]],
        [[[1;3;4;58:5:2mA stalemate![0m]]
    }},
    {{ 53, 21 }, {
        [[[1mI stayed up all night wondering where the sun went...[0m]],
        [[[1;3;4;58:5:2mThen it dawned on me![0m]]
    }},
    {{ 38, 32 }, {
        [[[1mWhy did the scarecrow get a promotion?[0m]],
        [[[1;3;4;58:5:2mHe was outstanding in his field![0m]]
    }},
    {{ 52, 24 }, {
        [[[1mYou know what's not right? [0;90m(Joel questions, \"[1;3;4;37;58:5:2mLeft?[0;90m\")[0m]],
        [[[90m(Ellie answers, \"[1;3;4;37;58:5:2mYeah![0;90m\")[0m]]
    }},
    {{ 62, 11 }, {
        [[[1mPeople are making apocalypse jokes [3;4;58:5:2mlike there's no tomorrow...[0m]],
        [[[3;90mToo soon...[0m]]
    }},
    {{ 49, 19 }, {
        [[[1mWhat did the green grape say to the purple grape?[0m]],
        [[[1;3;4;58:5:2mBreathe, you idiot![0m]]
    }},
    {{ 40, 32 }, {
        [[[1mWhen the power went out at the school...[0m]],
        [[[1mThe children... [3;4;58:5:2mwere de-lighted![0m]]
    }},
    {{ 55, 23 }, {
        [[[1mThere was once a crossed-eyed teacher who had issues...[0m]],
        [[[1;3;4;58:5:2mcontrolling his pupils![0m]]
    }},
    {{ 58, 20 }, {
        [[[90mNewspaper headline reads: [1;37mCartoonist found dead at home...[0m]],
        [[[1;3;4;58:5:2mdetails are sketchy![0m]]
    }},
    {{ 50, 39 }, {
        [[[1mIt's not that the guy didn't know how to juggle...[0m]],
        [[[1;3;4;58:5:2mHe just didn't have the balls to do it![0m]]
    }},
    {{ 62, 16 }, {
        [[[1mWhat did the cannibal get when he showed up to the party late?[0m]],
        [[[1;3;4;58:5:2mA cold shoulder![0m]]
    }}
}

local function pad(width, x)
    return string.rep(' ', bit.arshift((width - x), 1))
end

function M.print(width, redirect)
    math.randomseed(os.time())
    local i = math.random(1, #puns)
    local pun = puns[i]

    pcall(os.execute, [[printf '[3B']] .. redirect)
    if type(pun[1]) == 'table' then
        pcall(os.execute, [[printf "]] .. pad(width, pun[1][1]) .. pun[2][1] .. [["]] .. redirect)
        pcall(os.execute, [[printf '[B[G']] .. redirect)
        pcall(os.execute, [[printf "]] .. pad(width, pun[1][2]) .. pun[2][2] .. [["]] .. redirect)
    else
        -- pcall(os.execute, [[printf '[B']] .. redirect)
        pcall(os.execute, [[printf "]] .. pad(width, pun[1]) .. pun[2] .. [["]] .. redirect)
    end
end

return M
