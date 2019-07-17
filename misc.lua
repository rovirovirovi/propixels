function rgb2hsv(rgb)
    local r = 0
    local g = 0
    local b = 0
    local a = 0 -- unused

    r, g, b, a = unpack(rgb)

    local min = math.min(r, g)
    min = math.min(min, b)

    local max = math.max(r, g)
    max = math.max(max, b)

    local V = max

    local S = 0
    if V == 0 then
        S = 0
    else
        S = (max - min) / max
    end

    local H = 0

    if max == r then
        H = (g - b)/(max - min)
    elseif max == g then
        H = 2 + (b - r)/(max - min)
    elseif max == b then
        H = 4 + (r - g)/(max - min)
    end

    H = H * 60

    if H < 0 then
        H = H + 360
    end

    return {H,S,V, a}

end

function hsv2rgb(hsva)
    local h = 0
    local s = 0
    local v = 0
    local a = 0

    h, s, v, a = unpack(hsva)

    local c = v * s
    local k = h / 60
    local x = c*(1- math.abs( k%2-1 ))

    local r1 = 0
    local g1 = 0
    local b1 = 0

    if k >= 0 and k <= 1 then
        r1 = c
        g1 = x
    end
    if k > 1 and k <= 2 then
        r1 = x
        g1 = c
    end
    if k > 2 and k <= 3 then
        g1 = c
        b1 = x
    end
    if k > 3 and k <= 4 then
        g1 = x
        b1 = c
    end
    if k > 4 and k <= 5 then
        r1 = x
        b1 = c
    end
    if k > 5 and k <= 6 then
        r1 = c
        b1 = x
    end

    local m = v - c

    return {r1+m, g1+m, b1+m, a}
    
end 

function rgbToHex(rgb)
	local hexadecimal = '0x'

	for key, value in pairs(rgb) do
		local hex = ''

		while(value > 0)do
			local index = math.fmod(value, 16) + 1
			value = math.floor(value / 16)
			hex = string.sub('0123456789ABCDEF', index, index) .. hex			
		end

		if(string.len(hex) == 0)then
			hex = '00'

		elseif(string.len(hex) == 1)then
			hex = '0' .. hex
		end

		hexadecimal = hexadecimal .. hex
	end

	return hexadecimal
end

function hex2rgb(hex)
    hex = hex:gsub("0x","")
    return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6)), tonumber("0x"..hex:sub(7,8))
end

function Hex3ToRgb(hex)
    hex = hex:gsub("0x","")
    --print(tonumber("0x"..hex:sub(1,2)).. " " .. tonumber("0x"..hex:sub(3,4)) .. " " .. tonumber("0x"..hex:sub(5,6)))
    return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end

function sign(value)
    if value > 0 then
        return 1
    elseif value < 0 then
        return -1
    else
        return 0
    end
end