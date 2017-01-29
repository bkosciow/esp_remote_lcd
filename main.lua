print ("core ready")

network_message = require "network_message"
i2c_driver = require("lcd_hd44780_i2c")
hd44780 = require("lcd_hd44780")
server_listener = require "server_listener"
hd44780_handler = require "lcd_hd44780_handler"

--setup LCD
pins = {
    RS= 4,
    E1= 5,
    E2= 6,
    DB4= 0,
    DB5= 1,
    DB6= 2,
    DB7= 3,
}

drv = i2c_driver(0x20, 4, 5, pins)
lcd = hd44780(40, 4, drv, 'buffered', 0, 0)
lcd:init()

lcd:set_xy(10,1)
lcd:write('Awaiting content')
lcd:set_xy(10,3)
lcd:write('> Ready')
lcd:set_xy(33, 0)
lcd:write('-(=^_^)')
lcd:flush()

--attach lcd to handler
lcd_handler = hd44780_handler(lcd)

-- add handlers to listener
server_listener.add("lcd", lcd_handler)

print("ok")

-- run server
server_listener.start(PORT)
