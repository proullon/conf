--
-- Ion statusbar module configuration file
-- 

-- Create a statusbar
mod_statusbar.create{
    template="[ %my_date | %my_load | %my_battery ] %filler %systray",
    pos='bl',
    screen=0,
    fullsize=true,
    systray=true,
}
