local rgbstr = {}

-- Ported from https://stackoverflow.com/a/9493060
local function huetorgb(p, q, t)
	if (t < 0) then
		t = t + 1
	elseif (t > 1) then
		t = t - 1
	end

	if (t < 1/6) then
		return p + (q - p) * 6 * t
	elseif (t < 1/2) then
		return q;
	elseif (t < 2/3) then
		return p + (q - p) * (2/3 - t) * 6;
	end

	return p;
end

--- Converts an HSL colour to RGB
-- Ported from https://stackoverflow.com/a/9493060
local function hsltorgb(h, s, l)
	local r, g, b

	if (s == 0) then
		r, g, b = l, l, l -- achromatic
	else
		local q = (l < 0.5)
			and l * (1 + s)
			or l + s - l * s
		local p = 2 * l - q

		r = huetorgb(p, q, h + 1/3)
		g = huetorgb(p, q, h)
		b = huetorgb(p, q, h - 1/3)
	end

	return r, g, b
end

local function hash(str)
	local n = 0
	for i=1, #str do
		n = (n + string.byte(str, i) * i) % 255
	end

	-- Dumb on-the-spot hashing:
	-- * Generate some decimals by modulo with almost-one
	-- * Chop off some leading decimals so we really get a 0-1 range
	return (n % 0.98156548168 * 100) % 1
end

local function discrete(s, num)
	return math.floor(num * s) / s
end

--- Returns a random angle
-- @tparam string Input
function rgbstr.angle(input, steps)
	if steps then
		return discrete(steps, hash(input)) * 360
	else
		return hash(input) * 360
	end
end

--- Generates a pseudo-random colour from a string by hashing it.
-- @tparam string text The input string that the colour should be derived from.
-- @tparam number steps The number of discrete steps to clamp the hue to or nil for continuous.
-- @tparam[opt=1] saturation The saturation of the resulting colour in HSL space
-- @tparam[opt=.5] lightness The lightness of the resulting colour in HSL space
-- @treturn number Red
-- @treturn number Green
-- @treturn number Blue
function rgbstr.floats(text, steps, saturation, lightness)
	saturation = saturation or 1
	lightness = lightness or .5
	if steps then
		return hsltorgb(discrete(steps, hash(text)), saturation, lightness)
	else
		return hsltorgb(hash(text), saturation, lightness)
	end
end

--- Same as the floats function, except it converts the returned values
-- to integers from 0 to 255
function rgbstr.bytes(...)
	local r, g, b = rgbstr.floats(...)
	return math.floor(r*255), math.floor(g*255), math.floor(b*255)
end

return rgbstr
