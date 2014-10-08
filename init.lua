local unpack = unpack
local aw_button = require( "awful.button"    )
local aw_util   = require( "awful.util"      )
local aw_key    = require( "awful.key"       )
local tag       = require( "awful.tag"       )
local macro     = require( "repetitive.macro")

local capi = {timer = timer,root=root,client=client,mouse=mouse}

local module = {}
local fav = {}
local already_set = {}

-- Add a new keybinding to 'key' if not already set
local function hook_key(key)
    if not already_set[key] then
        capi.root.keys(aw_util.table.join(capi.root.keys(),aw_key({}, "F"..key, function ()
            fav[key]()
        end)))
        already_set[key] = true
    end
end

-- Generate setters keybindings
local function generate_key_binding()
    local bindings = {}
    for i=1,12 do
        -- Bind clients
        bindings[#bindings+1] = aw_key({ "Mod4" }, "F"..i, function ()
            hook_key(i)
            local c = capi.client.focus --TODO manage "unmanage" signal
            -- Try to get a favorite tag
            local fav_tag = setmetatable({}, { __mode = 'v' })
            local c_tags = c:tags()
            for k,t in ipairs(c_tags) do
                if t.selected then
                    fav_tag[#fav_tag+1] = t
                end
            end
            fav[i] = function()
                local tags = c:tags()
                -- Check if one of the tag is not already selected
                local selected = false
                for k,t in ipairs(tags) do
                    for k2,t2 in ipairs(tag.selectedlist(c.screen)) do
                        selected = t==t2
                        if selected then break end
                    end
                    if selected then break end
                end
                if not selected then
                    -- Try to see if the favorite tag(s) is still available
                    if fav_tag[1] then
                        tag.viewonly(fav_tag[1])
                    else
                        -- Too bad, history is not accessible from here anyway
                        tag.viewonly(tags[1])
                    end
                end
                capi.client.focus = c
            end
        end)

        -- Bind tags
        bindings[#bindings+1] = aw_key({ "Mod1" }, "F"..i, function ()
            hook_key(i)
            local t = tag.selected(capi.client.focus and capi.client.focus.screen or capi.mouse.screen)
            fav[i] = function() --TODO manage "deleted" signal
                tag.viewonly(t)
            end
        end)

        -- Bind macros TODO
        bindings[#bindings+1] = aw_key({ "Control" }, "F"..i, function ()
            hook_key(i)
            print("Set Macro")
            local m = nil
            macro.record(function(aMacro) m = aMacro; print("setting macro") end)
            fav[i] = function()
                if m then
                    macro.play(m)
                else
                    print("Nothing to playback")
                end
            end
        end)
    end
    return bindings
end


-- This will ensure this code is executed after rc.lua is fully parsed
local t = capi.timer({timeout=0})
t:connect_signal("timeout",function()
    capi.root.keys(aw_util.table.join(capi.root.keys(),unpack(generate_key_binding())))
    t:stop()
end)
t:start()

return module