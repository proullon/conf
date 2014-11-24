local battery_timer = statusd.create_timer()
local function battery()
   local f = io.popen('acpi -b 2> /dev/null', 'r')
   local output = f:read('*all')
   f:close()

   if output == "" or output == "\n" then
      statusd.inform("my_battery", "?")
      statusd.inform("my_battery_hint", "normal")
      return
   end

   local _, _, state, charge = string.find(output, "Battery 0: ([a-zA-Z]*), ([0-9]*).*\n")

   if state == "Charging" then
      state = "+"
      hint = "important"
   elseif state == "Discharging" then
      state = "-"
      hint = "important"
   else
      state = ""
      hint = "normal"
   end

   if tonumber(charge) < 25 then
      hint = "critical"
   end

   statusd.inform("my_battery", charge.."%"..state)
   statusd.inform("my_battery_hint", hint)

   battery_timer:set(10000, battery)
end
battery()

--

local myload_timer = statusd.create_timer()
local function myload()
   local f = io.open('/proc/loadavg', 'r')
   local output = f:read('*line')
   f:close()

   local _, _, curload = string.find(output, "([0-9.]*).*")

   local f = io.popen('cat /proc/cpuinfo | grep "siblings"', 'r')
   local output = f:read('*all')
   f:close()

   if output == "" or output == "\n" then
     corenb = "1"
   else
     _, _, corenb = string.find(output, ".*: ([0-9.]*)")
   end

   if tonumber(curload) >= 2 * tonumber(corenb) then -- >= 200%
      statusd.inform("my_load_hint", "critical")
   elseif tonumber(curload) >= tonumber(corenb) then -- >= 100%
      statusd.inform("my_load_hint", "important")
   else -- < 100%
      statusd.inform("my_load_hint", "normal")
   end

   statusd.inform("my_load", curload)

   myload_timer:set(1000, myload)
end
myload()

--

local mytime_timer = statusd.create_timer()
local function mytime()
   local output = os.date("%a %b %d %T")
   statusd.inform("my_date", output)
   mytime_timer:set(1000, mytime)
end
mytime()
