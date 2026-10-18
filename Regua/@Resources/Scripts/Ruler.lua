-- Posiciona a faixa de luz do dia (nascer -> por do sol) na regua de 24h.
-- Le MeasureSunrise/MeasureSunset ("06:12") e define as variaveis SunA/SunB em pixels.

function Initialize()
	x0 = SKIN:ParseFormula(SKIN:ReplaceVariables('(#RulerX#)'))
	w = SKIN:ParseFormula(SKIN:ReplaceVariables('(#RulerW#)'))
end

local function frac(name)
	local m = SKIN:GetMeasure(name)
	if not m then return nil end
	local h, mi = string.match(m:GetStringValue() or '', '^(%d+):(%d+)')
	if not h then return nil end
	return (tonumber(h) * 60 + tonumber(mi)) / 1440
end

function Update()
	local a, b = frac('MeasureSunrise'), frac('MeasureSunset')
	if a and b then
		SKIN:Bang('!SetVariable', 'SunA', x0 + w * a)
		SKIN:Bang('!SetVariable', 'SunB', x0 + w * b)
		SKIN:Bang('!ShowMeterGroup', 'Sun')
	else
		SKIN:Bang('!HideMeterGroup', 'Sun')
	end
	return 0
end
