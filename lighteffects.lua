-- locals
local lighton=0

-- functions
function intermBlinkLED()
	gpio.mode(LED_IO, gpio.OUTPUT)

    if lighton==0 then 
        lighton=1 
        gpio.write(LED_IO, 1);
    else 
        lighton=0 
        gpio.write(LED_IO, 0);
    end 
end