print ("core ready")

network_message = require "network_message"
gpio_driver = require "lcd_hd44780_gpio"
hd44780 = require("lcd_hd44780")
server_listener = require "server_listener"
hd44780_handler = require "lcd_hd44780_handler"

drv = gpio_driver()
lcd = hd44780(16, 2, drv, 'buffered', 0, 0)
lcd:init()

lcd:set_xy(0, 1)
lcd:write("Awaiting content")
lcd:set_xy(9, 0)
lcd:write("-(=^_^)")
lcd:flush()

--attach lcd to handler
lcd_handler = hd44780_handler(lcd)

-- add handlers to listener
server_listener.add("lcd", lcd_handler)

print("ok")

-- run server
server_listener.start(5053)
