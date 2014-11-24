META="Mod1+"
ALTMETA="Mod4+"

-- Some basic settings
ioncore.set{
    -- Maximum delay between clicks in milliseconds to be considered a
    -- double click.
    --dblclick_delay=250,

    mousefocus='sloppy',

    -- For keyboard resize, time (in milliseconds) to wait after latest
    -- key press before automatically leaving resize mode (and doing
    -- the resize in case of non-opaque move).
    --kbresize_delay=1500,

    -- Opaque resize?
    opaque_resize=true,

    -- Movement commands warp the pointer to frames instead of just
    -- changing focus. Enabled by default.
    --warp=true,

    -- Switch frames to display newly mapped windows
    --switchto=true,

    -- Default index for windows in frames: one of 'last', 'next' (for
    -- after current), or 'next-act' (for after current and anything with
    -- activity right after it).
    frame_default_index='next-act',

    -- Auto-unsqueeze transients/menus/queries.
    unsqueeze=false,

    -- Display notification tooltips for activity on hidden workspace.
    --screen_notify=true,
}


--
-- Ion default settings
--

dopath("mod_tiling")
dopath("mod_sp")
dopath("mod_xinerama")
dopath("mod_statusbar")
dopath("look_greenlight")


--
-- Bindings. This includes global bindings and bindings common to
-- screens and all types of frames only. See modules' configuration
-- files for other bindings.
--


-- WScreen context bindings
--
-- The bindings in this context are available all the time.
--
-- The variable META should contain a string of the form 'Mod1+'
-- where Mod1 maybe replaced with the modifier you want to use for most
-- of the bindings. Similarly ALTMETA may be redefined to add a
-- modifier to some of the F-key bindings.

function goto_left(ws, dir)
    if not ioncore.navi_next(ws, dir, {nowrap=true}) and ws:screen_of():id() ~= 0
    then
        ioncore.goto_nth_screen(ws:screen_of():id() - 1)
    else
        ioncore.goto_next(ws, dir)
    end
end

function goto_right(ws, dir)
    last = 0
    while ioncore.find_screen_id(last + 1)
    do
        last = last + 1
    end

    if not ioncore.navi_next(ws, dir, {nowrap=true}) and ws:screen_of():id() ~= last
    then
        ioncore.goto_nth_screen(ws:screen_of():id() + 1)
    else
        ioncore.goto_next(ws, dir)
    end
end

defbindings("WScreen", {
    bdoc("Base controls"),
    kpress(ALTMETA.."F1", "ioncore.exec_on(_, 'xmessage -file ~/.notion/help')"),
    kpress(ALTMETA.."F2", "ioncore.exec_on(_, '".. os.getenv("BROWSER") .."')"),
    kpress(ALTMETA.."Shift+F2", "ioncore.exec_on(_, '".. os.getenv("BROWSER") .. " --incognito')"),
    kpress(ALTMETA.."F3", "ioncore.exec_on(_, '/usr/bin/gnome-terminal')"),
    kpress(ALTMETA.."F4", "ioncore.exec_on(_, 'pavucontrol')"),
    kpress(ALTMETA.."Print", "ioncore.exec_on(_, 'scrot')"),
    kpress(ALTMETA.."L", "ioncore.exec_on(_, 'slock')"),

    bdoc("Exit ion3."),
    kpress(ALTMETA.."Escape", "ioncore.shutdown()"),
    bdoc("Restart ion3."),
    kpress(ALTMETA.."Shift+Escape", "ioncore.restart()"),

    bdoc("Switch to n:th object (workspace, full screen client window) "..
         "within current screen."),
    kpress(ALTMETA.."1", "WScreen.switch_nth(_, 0)"),
    kpress(ALTMETA.."2", "WScreen.switch_nth(_, 1)"),
    kpress(ALTMETA.."3", "WScreen.switch_nth(_, 2)"),
    kpress(ALTMETA.."4", "WScreen.switch_nth(_, 3)"),
    kpress(ALTMETA.."5", "WScreen.switch_nth(_, 4)"),

    bdoc("Go to next frame in this direction."),
    kpress(ALTMETA.."Up", "ioncore.goto_next(_chld, 'up')", "_chld:non-nil"),
    kpress(ALTMETA.."Down", "ioncore.goto_next(_chld, 'down')", "_chld:non-nil"),
    kpress(ALTMETA.."Left", "goto_left(_chld, 'left')", "_chld:non-nil"),
    kpress(ALTMETA.."Right", "goto_right(_chld, 'right')", "_chld:non-nil"),

    bdoc("Create new workspace."),
    kpress(ALTMETA.."J", "ioncore.create_ws(_)"),

    bdoc("Switch to next/previous screen."),
    kpress(ALTMETA.."Shift+Left", "ioncore.goto_prev_screen()"),
    kpress(ALTMETA.."Shift+Right", "ioncore.goto_next_screen()"),

    bdoc("Clear all tags."),
    kpress(ALTMETA.."U", "ioncore.tagged_clear()"),
})


-- Client window bindings
--
-- These bindings affect client windows directly.

defbindings("WClientWin", {
    bdoc("Kill client owning the client window."),
    kpress(ALTMETA.."K", "WClientWin.kill(_)"),
})


-- Client window group bindings

defbindings("WGroupCW", {
    bdoc("Toggle client window group full-screen mode"),
    kpress(ALTMETA.."Return", "WGroup.set_fullscreen(_, 'toggle')"),
})


-- WMPlex context bindings
--
-- These bindings work in frames and on screens. The innermost of such
-- contexts/objects always gets to handle the key press.

defbindings("WMPlex", {
    bdoc("Close current object."),
    kpress(ALTMETA.."G", "WRegion.rqclose_propagate(_, _sub)"),
})

-- Frames for transient windows ignore this bindmap
defbindings("WMPlex.toplevel", {
    bdoc("Switch to next/previous tab."),
    kpress(ALTMETA.."Tab", "WFrame.switch_next(_)"),
    kpress(ALTMETA.."Shift+".."Tab", "WFrame.switch_prev(_)"),

    bdoc("Attach tagged objects to this frame."),
    kpress(ALTMETA.."R", "ioncore.tagged_attach(_)"),

    bdoc("Toggle tag of current object."),
    kpress(ALTMETA.."T", "WRegion.set_tagged(_sub, 'toggle')", "_sub:non-nil"),

    bdoc("Detach (float) or reattach an object to its previous location."),
    -- By using _chld instead of _sub, we can detach/reattach queries
    -- attached to a group. The detach code checks if the parameter
    -- (_chld) is a group 'bottom' and detaches the whole group in that
    -- case.
    kpress(ALTMETA.."E", "ioncore.detach(_chld, 'toggle')", "_chld:non-nil"),
})


-- WFrame context bindings
--
-- These bindings are common to all types of frames. Some additional
-- frame bindings are found in some modules' configuration files.

defbindings("WFrame", {
    bdoc("Begin move/resize mode."),
    kpress(ALTMETA.."F", "WFrame.begin_kbresize(_)"),
})

-- Bindings for floating frames.

defbindings("WFrame.floating", {
    bdoc("Tile frame, if no tiling exists on the workspace"),
    kpress(ALTMETA.."Y", "mod_tiling.mkbottom(_)"),
})


-- WMoveresMode context bindings
--
-- These bindings are available keyboard move/resize mode. The mode
-- is activated on frames with the command begin_kbresize (bound to
-- META.."R" above by default).

defbindings("WMoveresMode", {
    bdoc("Grow in specified direction."),
    kpress("Left",  "WMoveresMode.resize(_, 1, 0, 0, 0)"),
    kpress("Right", "WMoveresMode.resize(_, 0, 1, 0, 0)"),
    kpress("Up",    "WMoveresMode.resize(_, 0, 0, 1, 0)"),
    kpress("Down",  "WMoveresMode.resize(_, 0, 0, 0, 1)"),

    bdoc("Shrink in specified direction."),
    kpress(ALTMETA.."Left",  "WMoveresMode.resize(_,-1, 0, 0, 0)"),
    kpress(ALTMETA.."Right", "WMoveresMode.resize(_, 0,-1, 0, 0)"),
    kpress(ALTMETA.."Up",    "WMoveresMode.resize(_, 0, 0,-1, 0)"),
    kpress(ALTMETA.."Down",  "WMoveresMode.resize(_, 0, 0, 0,-1)"),

    bdoc("Move in specified direction."),
    kpress(ALTMETA.."Shift+Left",  "WMoveresMode.move(_,-1, 0)"),
    kpress(ALTMETA.."Shift+Right", "WMoveresMode.move(_, 1, 0)"),
    kpress(ALTMETA.."Shift+Up",    "WMoveresMode.move(_, 0,-1)"),
    kpress(ALTMETA.."Shift+Down",  "WMoveresMode.move(_, 0, 1)"),
})

-- Bindings for the tilings.

defbindings("WTiling", {
    bdoc("Split current frame vertically."),
    kpress(ALTMETA.."S", "WTiling.split_at(_, _sub, 'bottom', false)"),

    bdoc("Split current frame horizontally."),
    kpress(ALTMETA.."D", "WTiling.split_at(_, _sub, 'right', false)"),

    bdoc("Destroy current frame."),
    kpress(ALTMETA.."H", "WTiling.unsplit_at(_, _sub)"),
})


-- Put all dockapps in the statusbar's systray, also adding the missing
-- size hints necessary for this to work.
defwinprop{
    is_dockapp = true,
    statusbar = "systray",
}

-- Define some additional title shortening rules to use when the full
-- title doesn't fit in the available space. The first-defined matching
-- rule that succeeds in making the title short enough is used.
ioncore.defshortening("(.*) - Mozilla(<[0-9]+>)", "$1$2$|$1$<...$2")
ioncore.defshortening("(.*) - Mozilla", "$1$|$1$<...")
ioncore.defshortening("XMMS - (.*)", "$1$|...$>$1")
ioncore.defshortening("[^:]+: (.*)(<[0-9]+>)", "$1$2$|$1$<...$2")
ioncore.defshortening("[^:]+: (.*)", "$1$|$1$<...")
ioncore.defshortening("(.*)(<[0-9]+>)", "$1$2$|$1$<...$2")
ioncore.defshortening("(.*)", "$1$|$1$<...")
