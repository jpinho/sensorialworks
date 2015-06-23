dofile("lighteffects.lua")
dofile("httpserver.lua")
dofile("dht11-sensor.lua")

-- lighteffects overrides
LED_IO=0

-- httpserver overrides
netSSID="CRJP" 
netPWD="-------"

-- main program
print("Hello ElectroNinja, greetings!")

tmr.alarm(0, 5000, 1, autoConnectWifiSAP)
tmr.alarm(1,  500, 1, intermBlinkLED)
tmr.delay(5000)

createHttpServer(function(conn)
    conn:on("receive", function(conn, payload)
	    print(tmr.now() .. " :: Request received.") 

		queryWeatherSensor()

		sensorData = "<h1>Weather Sensor Data</h1><br><br>\r\n".. 
			"<p>\r\n".. 
			"Temperature: "..Temperature.."."..TemperatureDec.."<br>\r\n"..
			"Humidity: "..Humidity.."."..HumidityDec.."<br>\r\n".. 
			"ChecksumReceived: "..Checksum.."<br>\r\n"..
			"ChecksumTest: "..ChecksumTest.."<br>\r\n".. 
			"</p>"

		conn:send(sensorData)
	end)
end)
