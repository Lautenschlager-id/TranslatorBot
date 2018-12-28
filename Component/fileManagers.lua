return {
	getFile=function(file, format)
		file = io.open(file, "r")
		format = format or "*a"
		local _file = file:read(format)
		file:close()		
		return _file
	end,
	editFile = function(file, format, edition)
		file = io.open(file, format)
		file:write(edition)
		file:flush()
		file:close()
	end
}