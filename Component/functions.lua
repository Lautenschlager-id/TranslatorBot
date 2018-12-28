--[[ Improvements ]]--
do
	local concat = table.concat
	table.concat = function(list, sep, f, i, j, iterator)
		if type(f) == "boolean" and f then
			return concat(list, sep)
		end
	
		iterator = iterator or function() return next, list end
	
		local txt = ""
		
		sep = sep or ""
		
		i, j = i or 1, j or #list
		
		for k, v in iterator(list) do
			if (type(k) ~= "number" and true) or (k >= i and k <= j) then
				txt = txt .. tostring((not f and v or f(k, v))) .. sep
			end
		end
		
		return string.sub(txt, 1, -1-#sep)
	end
end

--[[ Codification ]]--
URLEncoded = function(u)
	local out = {}
	for letter in u:gmatch(".") do
		out[#out + 1] = string.format("%x", letter:byte()):upper()
	end
	return "%" .. table.concat(out, "%")
end
do
	local chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	encodeBase64 = function(code)
		return ((code:gsub('.', function(x)
			local r, b = '', x:byte()
			
			for i = 8, 1, -1 do
				r = r .. (b%2^i - b%2^(i-1) > 0 and '1' or '0')
			end
			
			return r
		end) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
			if (#x < 6) then
				return ''
			end
			
			local c = 0
			
			for i = 1, 6 do
				c = c + (x:sub(i,i)=='1' and 2^(6-i) or 0)
			end
			
			return chars:sub(c+1, c+1)
		end) .. ({'', '==', '='})[#code%3 + 1])
	end
	decodeBase64 = function(code)
		code = string.gsub(code, "[^" .. chars .. "=]", '')
		
		return (code:gsub('.', function(x)
			if (x == '=') then
				return ''
			end
			
			local r, f = '', (chars:find(x) - 1)
			
			for i = 6, 1, -1 do
				r = r .. (f%2^i - f%2^(i-1) > 0 and '1' or '0')
			end
			
			return r
		end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
			if (#x ~= 8) then
				return ''
			end
			
			local c = 0
			
			for i = 1, 8 do
				c = c + (x:sub(i,i) == '1' and 2^(8-i) or 0)
			end
			
			return string.char(c)
		end))
	end
end

--[[ Math ]]--
math.percent = function(x, y, v)
	v = v or 100
	local m = x/y * v
	return math.min(m, v)
end

--[[ Table ]]--
table.clone = function(list, ignoreList)
	local out = {}
	
	for k, v in next, list do
		if not table.find(ignoreList, k) then
			out[k] = v
		end
	end
	
	return out
end
table.find = function(list, value, index, f)
	for k, v in next,list do
		local i = (type(v) == "table" and index) and v[index] or v
		if (not f and i or f(i, index)) == value then
			return true, k
		end
	end
	return false
end
table.loadTable = function(s)
	-- "a.b.c.1" returns a[b][c][1]
	local list
	local sequence = {}
	
	local splitted = string.split(s, "[^%.]+", function(x)
		return tonumber(x) or x
	end)
	
	for i = 1, #splitted do
		list = (list and list[splitted[i]] or _G[splitted[i]])
		sequence[#sequence + 1] = splitted[i]
		if type(list) ~= "table" and splitted[i + 1] then
			return nil, sequence
		end
	end
	return list, sequence
end
table.map = function(list, f)
	local out = {}
	for k, v in next, list do
		out[k] = f(v)
	end
	return out
end
table.merge = function(this, src, log, index)
	index = index or tostring(this)

	for k, v in next, src do
		if this[k] then
			if type(v) == "table" then
				this[k] = table.turnTable(this[k])
				table.merge(this[k], v, log, index .. '.' .. tostring(k))
			else				
				this[k] = this[k] or v
			end
		else
			if log then
				print("\27[1;41m[TRANSLATION]\27[0m [" .. index .. "] [" .. tostring(k) .. "]")
			end
		
			this[k] = v
		end
	end
end
table.random = function(list)
	return list[math.random(#list)]
end
table.tostring = function(list, depth, stop)
	depth = depth or 1
	stop = stop or 0

	local out = {}
	
	for k, v in next, list do
		out[#out + 1] = string.rep("\t", depth) .. ("["..(type(k) == "number" and k or "'" .. k .. "'").."]") .. "="
		local t = type(v)
		if t == "table" then
			out[#out] = out[#out] .. ((stop > 0 and depth > stop) and tostring(v) or table.tostring(v, depth + 1, stop - 1))
		elseif t == "number" or t == "boolean" then
			out[#out] = out[#out] .. tostring(v)
		elseif t == "string" then
			out[#out] = out[#out] .. string.format("%q", v)
		else
			out[#out] = out[#out] .. "nil"
		end
	end
	
	return "{\r\n" .. table.concat(out, ",\r\n") .. "\r\n" .. string.rep("\t", depth - 1) .. "}"
end
table.turnTable = function(x)
	return (type(x)=="table" and x or {x})
end

--[[ String ]]--
string.split = function(value, pattern, f)
	local out = {}
	for v in string.gmatch(value, pattern) do
		out[#out + 1] = (not f and v or f(v))
	end
	return out
end

--[[ Os ]]--
os.transformTime = function(time)
	return math.floor(time / 86400), math.floor((time % 86400) / 3600), math.floor((time % 3600) / 60)
end

--[[ Others ]]--
deactivateAccents = function(str)
	local letters = {
		["a"] = {"á","à","â","ä","ã","å"},
		["e"] = {"é","è","ê","ë"},
		["i"] = {"í","ì","î","ï"},
		["o"] = {"ó","ò","ô","ö","õ"},
		["u"] = {"ú","ù","û","ü"},
		["c"] = {"ç"},
		["n"] = {"ñ"},
		["y"] = {"ý","ÿ"},
	}
	for k, v in next,letters do
		for i = 1, #v do
			str = string.gsub(str, v[i], tostring(k))
		end
	end
	return str
end
pairsByIndexes = function(list, f)
	local out = {}
	for index in next, list do
		out[#out + 1] = index
	end
	table.sort(out, f)
	
	local i = 0
	return function()
		i = i + 1
		if out[i] ~= nil then
			return out[i], list[out[i]]
		end
	end
end