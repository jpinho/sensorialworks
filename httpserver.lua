-- globals
netSSID="SSID" 
netPWD="SSID-NET-PASSWORD"
httpPort=80

-- locals
local connReset=true

-- functions
function createHttpServer(httpRequestsHandler)
    print("Creating HTTP server at port " .. httpPort)
    srv=net.createServer(net.TCP)
    srv:listen(httpPort, httpRequestsHandler)
end

function autoConnectWifiSAP() 
    if wifi.sta.getip() == nil then
        if not connReset then
            print("Connection to " .. netSSID .. ": OFFLINE")
            print("Attempting reconnection... please wait.")
        end
    
        wifi.setmode(wifi.STATION)
        wifi.sta.config(netSSID, netPWD)
        print("Connecting to " .. netSSID .. "...")
        connReset=true
    else
        if connReset then
            print("Connection to " .. netSSID .. ": ESTABLISHED")
            print("MCU assigned IP Address: " .. wifi.sta.getip())
            connReset=false
        end
    end
end