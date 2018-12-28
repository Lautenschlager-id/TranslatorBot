--[[ Discordia ]]--
local discordia = require('discordia')
discordia.extensions()

local client = discordia.Client({
	cacheAllMembers = true
})
client._options.routeDelay = 0

local clock = discordia.Clock()
local enum = discordia.enums.enum

--[[ Serialization ]]--
local json = require("json")
local xml = require("Component/xml")

--[[ Libs ]]--
local http = require("coro-http")

--[[ System Libs ]]--
require("Component/functions")
local file = require("Component/fileManagers")
_G.tfm = require("Component/tfm") -- loadTable uses _G

--[[ Translations ]]--
local translations = require("Component/translations")
for k, v in next, translations do
	if k ~= "en" then
		table.merge(v, translations.en, true)
	end
end

--[[ Data ]]--
local translationMessages, data = {}, {
	available_languages = {
		AR = "\xF0\x9F\x87\xB8\xF0\x9F\x87\xA6",
		BR = "\xF0\x9F\x87\xA7\xF0\x9F\x87\xB7",
		CN = "\xF0\x9F\x87\xA8\xF0\x9F\x87\xB3",
		EE = "\xF0\x9F\x87\xAA\xF0\x9F\x87\xAA",
		EN = "\xF0\x9F\x87\xAC\xF0\x9F\x87\xA7",
		ES = "\xF0\x9F\x87\xAA\xF0\x9F\x87\xB8",
		FR = "\xF0\x9F\x87\xAB\xF0\x9F\x87\xB7",
		HE = "\xF0\x9F\x87\xAE\xF0\x9F\x87\xB1",
		HR = "\xF0\x9F\x87\xAD\xF0\x9F\x87\xB7",
		HU = "\xF0\x9F\x87\xAD\xF0\x9F\x87\xBA",
		IT = "\xF0\x9F\x87\xAE\xF0\x9F\x87\xB9",
		JP = "\xF0\x9F\x87\xAF\xF0\x9F\x87\xB5",
		LV = "\xF0\x9F\x87\xB1\xF0\x9F\x87\xBB",
		NL = "\xF0\x9F\x87\xB3\xF0\x9F\x87\xB1",
		PL = "\xF0\x9F\x87\xB5\xF0\x9F\x87\xB1",
		RO = "\xF0\x9F\x87\xB7\xF0\x9F\x87\xB4",
		RU = "\xF0\x9F\x87\xB7\xF0\x9F\x87\xBA",
		TR = "\xF0\x9F\x87\xB9\xF0\x9F\x87\xB7",
	},
	roles = setmetatable({}, {
		__newindex = function(list, index, value)
			rawset(list, index, value)
			rawset(list, tostring(value), index)
		end
	}),
	freeaccess = {
		['399727277744848907'] = true,
		['285878295759814656'] = true
	}
}
do
	-- Ranks
	data.roles['364097472932478976'] = "International Leader"
	data.roles['418484385139130380'] = "Bot"
	data.roles['354403373975601154'] = "International Subleader"
	data.roles['354403380644282368'] = "Leader"
	data.roles['481178811774533663'] = "Subleader"
	data.roles['418441543867957259'] = "Module Team Leader"
	data.roles['418532317447847947'] = "Module"
	data.roles['509823887345975296'] = "Grammar"
	data.roles['354403747981557761'] = "Translator"
	data.roles['409506300100214795'] = "Special Guest"
	data.roles['411944994937765891'] = "Punished"

	-- Communities
	data.roles['364097476439048195'] = "AR"
	data.roles['364490174366744577'] = "BR"
	data.roles['421412481122959370'] = "CN"
	data.roles['446727734794911744'] = "EE"
	data.roles['364093828321378305'] = "EN"
	data.roles['364490170101137408'] = "ES"
	data.roles['366512408421859329'] = "FR"
	data.roles['366537008803348481'] = "HE"
	data.roles['397006805101838337'] = "HR"
	data.roles['366512424922382336'] = "HU"
	data.roles['369916914060754944'] = "IT"
	data.roles['455408930995306516'] = "JP"
	data.roles['364490183569309708'] = "LV"
	data.roles['504628374040477697'] = "NL"
	data.roles['368106506920394753'] = "PL"
	data.roles['366536949529444374'] = "RO"
	data.roles['433012406973759488'] = "RU"
	data.roles['366512478248632320'] = "TR"

	-- Public
	data.roles['409506300100214795'] = "Special Guest"
	data.roles['418492163815505920'] = "public-ar"
	data.roles['418492207759097878'] = "public-br"
	data.roles['423061319965474819'] = "public-cn"
	data.roles['446727744622166027'] = "public-ee"
	data.roles['418514961233608705'] = "public-en"
	data.roles['418492204814827551'] = "public-es"
	data.roles['418492198741475331'] = "public-fr"
	data.roles['418492226121891855'] = "public-he"
	data.roles['418492563834535946'] = "public-hr"
	data.roles['418492216756142090'] = "public-hu"
	data.roles['418492219440365608'] = "public-it"
	data.roles['455408940750995466'] = "public-jp"
	data.roles['418495910440468481'] = "public-lv"
	data.roles['504628376502272020'] = "public-nl"
	data.roles['418492211013877760'] = "public-pl"
	data.roles['418495946503225355'] = "public-ro"
	data.roles['433012793575473163'] = "public-ru"
	data.roles['418492213522071553'] = "public-tr"

	-- Random
	data.roles['472468796284600321'] = "Ex-International Leader"
	data.roles['468512297854435330'] = "Ex-translator"
end

local database, blacklist, suggestions

--[[ Enums ]]--
-- Some of them are not enums because of the pairs != next or overrides
local banConsts = enum({
	warning_for_kick = 3,
	kick_for_ban = 2
})
local channels = {
	-- The following indexes may not be the same in the server.
	['welcome'] = '418482737272324096',

	['ban-log'] = '426828498297159681',
	['deleted-messages'] = '432216311188291594',
	['member-log'] = '421757044085751810',
	['bot-discussion'] = '421409443599876127',

	['announcements'] = '354402019458547713',
	['public-announcements'] = '422024576357105664',

	['discussions'] = '357512092833808385',
	['beginners'] = '484421781071855616',

	['public-translations'] = '418541145795198976',
	['public-requests'] = '418532130369568780',
	['requests-log'] = '418836567025516554',

	['suggestions'] = '418931162413531147',
	['suggestion-logs'] = '450441305693224960',

	['public-channel'] = {'504628378591035412', '455408950158819329', '446727754952474634', '418494249663856650', '418494300268265492', '418494400734298147', '431555090269077527', '418494340239851521', '423215775621447697', '418494327589961728', '418494417259855892', '418494279938211851', '418494380442386452', '418494206060003332', '418494220924616704', '418494313237053460'},

	['off-topic'] = {'411905476159340574', '371290714253950986', '376767654024708098', '364870355975798785'},
	['chat'] = {'418541132809502730', '430037257571794944', '393122876972335104', '405847864191746048', '428626213284872202'},

	['system'] = {'354402019458547713', '422024576357105664', '418541145795198976', '418532130369568780', '418931162413531147'},

	['delete-content'] = {'450441305693224960', '418836567025516554', '426828498297159681', '418482737272324096', '418887154408882176', '428636288665780234', '421757044085751810', '432216311188291594'},
}
local color = {
	error = 0xE74C3C,
	message = 0x6A7495,
	translation = 0x3498DB,
	help = 0xE67E22,
	profile = 0x17AC86,
	system = 0x00F0F0,
	leaderboard = 0xF1C40F,
	lua = 0x9B59B6,
	luaerr = 0xC45273,
	interaction = 0x8083ED,
}
local databaseFiles = {
	'team',
	'data',
	'blacklist',
	'user',
	'suggestions'
}
local eChannels = enum({
	all = 0,
	translations = 1,
	chat = 2,
	private_message = 3,
	not_system = 4
})
local ePermissions = enum({
	all = 0,
	team = 1,
	module = 2,
	leader = 3,
	admin = 4,
	freeaccess = 5
})
local HTTP_headers = {
	github = {
		{"User-Agent", "lit"},
		{"Authorization", "Token " .. decodeBase64(file.getFile("Database/github_token.txt", "*l"))},
	},
	mashape = {
		{"X-Mashape-Key", file.getFile("Database/mashape_token.txt", "*l")},
	},
	mice_clan = file.getFile("Database/miceclan_token.txt", "*l"),
	fixer = file.getFile("Database/fixer_token.txt", "*l"),
	open_weather = file.getFile("Database/openweathermap_token.txt", "*l"),
}
local perms = enum({
	admin = {'International Leader', 'International Subleader', 'Module Team Leader'},
	leader = { 'International Leader', 'International Subleader', 'Module Team Leader', 'Leader' },
	module = {'International Leader', 'International Subleader', 'Module Team Leader', 'Module'},
	member = {'Translator', 'Special Guest', 'Ex-translator', 'Ex-International Leader'},
})
local requestsSize = enum({
	module = 1200,
	regular = 1000,
})
local sourceFiles = {
	-- Ordered by relevance
	'bot.lua',
	'Component/fileManagers.lua',
	'Component/translations.lua',
	'Component/functions.lua',
	'Component/xml.lua',
	'Component/tfm.lua'
}
local suggestionReactions = enum({
	[0] = {"In discussion", {"\xF0\x9F\xA4\x94", "\xF0\x9F\x92\xA9"}},
	[1] = {"Approved", {"\xE2\x9C\x85"}},
	[2] = {"Denied", {"\xE2\x9D\x8C"}},
	[3] = {"Implemented", {"\xF0\x9F\x92\xAA\xF0\x9F\x8F\xBB"}}
})
local forumThreads = {
	AR = "887435",
	BR = "903244",
	CN = "903428",
	EN = "909899",
	ES = "898280",
	FR = "888666",
	HR = "896300",
	HU = "888669",
	NL = "878212",
	PL = "909817",
	TR = "888726"
}
local warningReasons = {
	[1] = "Flood / Spam",
	[2] = "Insults",
	[3] = "Inappropriate content",
	[4] = "Toxicity",
	[5] = "Suspicious link",
	[6] = "Bad public requests",
}

--[[ Lists ]]--
local birthday = {
	"efa4f383",	"ef24f383",	"eea4f383",
	"ee24f383",	"eda4f383",	"ed24f383",
	"eca4f383",	"ec24f383",	"e3a4f383",
}
local currency = {}
local devENV, ENVrestrictions = {}, {"_G", "error", "getfenv", "setfenv"}
local memes = {
	"7f24f385",	"7d24f385",	"70a4f385",	"7524f385",	"e724f383",
	"7ea4f385",	"7ca4f385",	"77a4f385",	"7424f385",
	"7e24f385",	"7324f385",	"7124f385",	"3ca4f386",
	{"7da4f385", "**Galaktine:** I don't have patience and I can't put up with it anymore."},
	{"7c24f385", "Trying to read me doing the Dead Maze's chicken onomatopoeia"},
	{"72a4f385", "**Ikkemon:** Nowadays we (brazilians) hit the keyboard to laugh\n**Galaktine:** Did it!"},
	{"7224f385", "For those that don't want to participate, just do not go! ;-)"},
	{"71a4f385", "Are you kidding with me?? Take this ass off here!"},
	{"7624f385", "_When Meli wants to put new events_\n**Tig:** Stop!!!! You crazy?!"},
	{"75a4f385", "Why are you always wearing a mask?\n\n*Café is Chernobyl (toxic)*\n\nOooh, got it..."},
	{"3d24f386", "If `fraise123` is too easy for a password, then put `fraise321` instead!"},
	{"69a4f387", "**Tips to be a good company**\n1. Care about the users"},
	{"e6a4f383", "**My biggest dreams**"},
	{"51a4f3bc", "Fuck it = I don't give a shit"},
	{"cb24f3bd", "We need to innovate..."},
	{"8724f3b1", "You little naughty"},
	{"86a4f3b1", "Straight?! #no"},
	{"8624f3b1", "What the fuck is this music?"},
}
local moduleENV, moduleENVrestrictions = {}, {"debug", "dofile", "io", "load", "loadfile", "loadstring", "jit", "module", "p", "package", "pcall", "process", "require", "tfm", "os", "xpcall"}
local weatherIcon = {
	[1] = "sunny",
	[2] = "partly_sunny",
	[3] = "white_sun_cloud",
	[4] = "cloud",
	[9] = "cloud_rain",
	[10] = "white_sun_rain_cloud",
	[11] = "cloud_lightning",
	[13] = "cloud_snow",
	[50] = "mountain"
}

--[[ System ]]--
local commands = {}

local databases = #databaseFiles

local messageTimer = 0
local meta = {
	__add = function(this, new)
		if type(new) ~= "table" then return this end
		for k, v in next, new do
			this[k] = v
		end
		return this
	end
}
local playingAkinator = {
	__REACTIONS = {"\x31\xE2\x83\xA3", "\x32\xE2\x83\xA3", "\x33\xE2\x83\xA3", "\x34\xE2\x83\xA3", "\x35\xE2\x83\xA3", "\xE2\x8F\xAA", ok = "\xF0\x9F\x86\x97"}
}
local polls = {
	__REACTIONS = {"\x31\xE2\x83\xA3", "\x32\xE2\x83\xA3"}
}
local toDelete = setmetatable({}, {
	__newindex = function(list, index, value)
		if value then
			if value.channel then value = {value} end

			value = table.map(value, function(l) return l.id end)
			rawset(list, index, value)
		end
	end,
	__call = function(list, message)
		local msg
		for i = 1, #list[message.id] do
			msg = message.channel:getMessage(list[message.id][i])
			if msg then
				msg:delete()
			end
		end
		list[message.id] = nil
	end
})

--[[ Main functions ]]--
	--[[ Database ]]--
local save = function(fileName, db, append)
	local head, body = http.request("PUT", "http://miceclan.com/translators/set?k=" .. HTTP_headers.mice_clan .. "&f=" .. fileName .. (append and "&a=a" or ""), nil, "d=" .. (append and tostring(db) or json.encode(db)))

	return body == "true"
end
local getDatabase = function(fileName, raw)
	local head, body = http.request("GET", "http://miceclan.com/translators/get?k=" .. HTTP_headers.mice_clan .. "&f=" .. fileName)

	if not body then
		error("Database issue -> " .. tostring(fileName))
	end

	databases = databases - 1
	return (raw and body or json.decode(body))
end
local githubFile = function(fileName)
	local head, body = http.request("GET", "https://api.github.com/repos/Lautenschlager-id/TranslatorBot/contents/" .. fileName, HTTP_headers.github)

	return json.decode(tostring(body))
end
local githubCommit = function(fileName, data)
	local fileContent = encodeBase64(data or file.getFile(fileName, "*a"))

	local fileSha = githubFile(fileName)
	if fileSha and type(fileSha) == "table" and fileSha.sha then
		fileSha = fileSha.sha
		http.request("PUT", "https://api.github.com/repos/Lautenschlager-id/TranslatorBot/contents/" .. fileName, HTTP_headers.github, '{"message": "Updated via Bot request at ' .. os.date("%c") ..'","sha": "' .. fileSha .. '","content": "' .. fileContent .. '"')

		return true
	end
	return false
end
local addLog = function(info, ...)
	info = "[" .. os.date("%x %X") .. "] " .. info .. "\r\n"
	save("log", info, true)

	local c = {36, table.unpack({...})} 

	local current = 0
	info = info:gsub("%[(.-)%]", function(text)
		current = current + 1
		return string.format('\27[%i;%im%s\27[0m', 1, c[current] or 0, "[" .. text .. "]")
	end)
	print(info)
end
local saveDatabases = function()
	for i = 1, #databaseFiles do
		local s = false

		if databaseFiles[i] == "team" then
			s = save("team", data.team)
		elseif databaseFiles[i] == "data" then
			s = save("data", database)
		elseif databaseFiles[i] == "blacklist" then
			s = save("blacklist", blacklist)
		elseif databaseFiles[i] == "user" then
			s = save("user", data.user)
		elseif databaseFiles[i] == "suggestions" then
			s = save("suggestions", suggestions)
		end

		if not s then
			addLog("[DB_SAVE] [Error] SAVE didn't work as expected in [" .. tostring(databaseFiles[i]) .. "]", 42, 41, 40)
		end
	end
end

	--[[ Esthetics ]]--
local getRandomSkinTone = function(emoji)
	return ":" .. emoji .. "::skin-tone-" .. math.random(1, 5) .. ":"
end
local getRandomEarth = function()
	return ":earth_" .. table.random({"africa", "americas", "asia"}) .. ":"
end
local getIcon = function(id)
	local icon = "bulb"

	if data.team[id] then
		if table.find(data.team[id].rank, data.roles['International Leader']) then
			icon = "rose"
		elseif table.find(data.team[id].rank, data.roles['International Subleader']) then
			icon = "star2"
		elseif table.find(data.team[id].rank, data.roles['Leader']) then
			icon = "dizzy"
		end
		if table.find(data.team[id].rank, data.roles['Module']) then
			icon = "gear: :" .. icon
		end
		if table.find(data.team[id].rank, data.roles['Grammar']) then
			icon = "notebook"
		end
	end

	return ":" .. icon .. ":"
end
local getYear = function(date)
	if date == "" then return "" end

    local day, month = date:match("(%d%d)/(%d%d)")
    day, month = tonumber(day), tonumber(month)

    local currentDay, currentMonth = tonumber(os.date("%d")), tonumber(os.date("%m"))

    local nextYear = (currentMonth > month) or (month == currentMonth and day < currentDay)
    return tostring(tonumber(os.date("%y")) + (nextYear and 1 or 0))
end

	--[[ Server system ]]--
local getTranslatorPerm = function(id, ranks)
	if not data.team[id] then
		return false
	end

	local found = false
	for i = 1, #ranks do
		found = table.find(data.team[id].rank, data.roles[ranks[i]])
		if found then
			return found
		end
	end
	return found
end
local getUserPerm = function(permission, userID)
	local out = true

	-- User Level
	if permission == ePermissions.team then
		out = not not data.team[userID]
	elseif permission == ePermissions.module then
		out = getTranslatorPerm(userID, perms.module)
	elseif permission == ePermissions.leader then
		out = getTranslatorPerm(userID, perms.leader)
	elseif permission == ePermissions.admin then
		out = getTranslatorPerm(userID, perms.admin)
	elseif permission == ePermissions.freeaccess then
		out = data.freeaccess[userID]
	end

	return out
end
local generateMember = function(message, user)
	if user.bot then return end

	local issuesMessage = "\n\nIssues? Contact `Bolodefchoco`"

	if data.team[user.id] then
		message.author:send({
			embed = {
				color = color.error,
				description = ":skull: |#genmem_ismem| `" .. data.team[user.id].user .. "` is already a member." .. issuesMessage
			}
		})
		return
	end

	local member = message.guild:getMember(user.id)
	if not member then
		message.author:send({
			embed = {
				color = color.error,
				description = ":skull: |#genmem_!mem| `" .. user.name .. "` is not a member of this server." .. issuesMessage
			}
		})
	end

	data.team[user.id] = {
		user = member.name,
		translations = 0,
		cookies = 0,
		team = {

		},
		rank = {

		},
		status = "",
		isActive = false,
		birthdayDate = { "", "" },
		gender = 0
	}

	for role in member.roles:iter() do
		if data.roles[role.name] then
			if not role.name:find("public") then
				local p = #role.name > 2 and 'rank' or 'team'

				data.team[user.id][p][#data.team[user.id][p] + 1] = data.roles[role.name]
			end
		else
			message:reply({
				embed = {
					color = color.error,
					description = ":skull: |#genmem_!role| The role `" .. role.name .. "<" .. role .. ">` is not hosted in the bot. Request for `" .. data.team[user.id].user .. "` denied!" .. issuesMessage
				}
			})

			data.team[user.id] = nil

			return
		end
	end

	if not member:hasRole(data.roles["Translator"]) then
		data.team[user.id].rank[#data.team[user.id].rank + 1] = data.roles["Translator"]
		member:addRole(data.roles["Translator"])
	end

	local hireMessage = {
		embed = {
			color = color.system,
			description = getRandomSkinTone("muscle") .. " YAY!\n\n<@" .. user.id .. "> is now a member of the Translators Team!",
		}
	}

	client:getChannel(channels['announcements']):send(hireMessage)
	client:getChannel(channels['public-announcements']):send(hireMessage)
	client:getChannel(channels['discussions']):send("Welcome <@!" .. user.id .. ">. Before starting your journey in the team, please read the channel <#" .. channels['beginners'] .. ">!")

	save("team", data.team)

	commands["profile"].exe(message, user.id, translations.en, channels['discussions'])
end
local getRate = function(value, max)
	max = max or 10
	local points = math.min(math.floor(value) / 10, max)

	return string.format("`[%s%s]` %d%%", string.rep("|", math.floor(points)), string.rep(" ", max - math.floor(points)), value)
end

	--[[ Script System ]]--
local requestID = coroutine.wrap(function()
	local id = database.currentID
	while true do
		id = id + 1
		coroutine.yield(id)
	end
end)
local updateRequestMessage = function(id)
	local message = client:getChannel(channels['requests-log']):getMessage(database.unhandledRequests[id].referenceMessage)

	if table.count(database.unhandledRequests[id].languages) == 0 then
		if message then
			message:delete()
		end
		database.unhandledRequests[id] = nil
	elseif message then
		local info = commands["list"].exe(message, "#" .. id, nil, true)
		if info then
			message:setContent(info.content)
			message:setEmbed(info.embed)
		end
	end

	return listID
end
local splitByChar = function(content)
	local data = {}

	if content == "" or content == "\n" then return end

	local current = 0
	while #content > current do
		current = current + 1901
		data[#data + 1] = content:sub(current - 1900, current)
	end

	return data
end
local splitByLine = function(content)
	local data = {}

	if content == "" or content == "\n" then return data end

	local current, tmp = 1, ""
	for line in content:gmatch("([^\n]*)[\n]?") do
		tmp = tmp .. line .. "\n"

		if #tmp > 1850 then
			data[current] = tmp
			tmp = ""
			current = current + 1
		end
	end
	if #tmp > 0 then data[current] = tmp end

	return data
end
local printf = function(...)
	local out = { }
	for arg = 1, select('#', ...) do
		out[arg] = tostring(select(arg, ...))
	end
	return table.concat(out, "\t")
end
local updateCurrency = function()
	local head, body = http.request("GET", "http://data.fixer.io/api/latest?access_key=" .. HTTP_headers.fixer) -- Free plan = http
	body = json.decode(tostring(body))

	if body and body.rates then
		-- base will always be EUR (Free plan)
		currency = table.map(body.rates, function(value)
			-- curreny from EUR to USD
			return value * (body.rates.USD or 0)
		end)
	end
end
local getUserLanguage = function(message, private, id, skip)
	local userLanguage = translations.en

	if not skip and data.user[id or message.author.id] then
		-- The set language
		userLanguage = data.user[id or message.author.id].language
		userLanguage = translations[userLanguage] or translations.en
	else
		if not id and not private then
			-- Channel and category
			local lang = message.channel.name:match("^(%a%a)%-") -- public channel
			lang = lang or message.channel.category and message.channel.category.name or "" -- public category

			userLanguage = translations[lang:lower()] or translations.en
		end
	end

	return userLanguage
end
local getLuaEnv = function()
	return {
		banConsts = banConsts,
		bit32 = table.copy(bit),

		color = table.copy(color),

		databaseFiles = table.copy(databaseFiles),

		eChannels = eChannels,
		enum = enum,
		ENVrestrictions = table.copy(ENVrestrictions),
		ePermissions = ePermissions,

		getChannel = function(id)
			return client:getChannel(id)
		end,
		getIcon = getIcon,
		getRandomEarth = getRandomEarth,
		getRandomSkinTone = getRandomSkinTone,
		getRate = getRate,
		getTranslatorPerm = getTranslatorPerm,
		getUser = function(id)
			return client:getUser(id)
		end,
		getYear = getYear,

		json = json,

		math = table.copy(math),
		meta = meta,
		moduleENVrestrictions = table.copy(moduleENVrestrictions),

		perms = perms,

		requestsSize = requestsSize,

		sourceFiles = table.copy(sourceFiles),
		splitByChar = splitByChar,
		splitByLine = splitByLine,
		string = table.copy(string),
		suggestionReactions = suggestionReactions,

		table = table.copy(table),

		xml = xml
	}
end

--[[ Commands ]]--
	--[[ All ]]--
commands["a801"] = {
	permission = ePermissions.all,
	channel = eChannels.chat,
	log = false,
	allowPrivateMessage = true,
	exe = function(message, parameters, userLanguage)
		if parameters and #parameters > 2 then
			local role = ""

			local tag = parameters:match("#(%d+)")

			if not tag then
				parameters = parameters .. "#0000"
			else
				tag = tonumber(tag)
				if tag == 95 then
					role = "```Python\n#" .. userLanguage.atelier.roles.ex .. "```\n"
				elseif tag == 1 then
					role = "```Haskell\n#" .. userLanguage.atelier.roles.adm .. "```\n"
				elseif tag == 10 then
					role = "```CSS\n\"" .. userLanguage.atelier.roles.mod .. "\"```\n"
				elseif tag == 15 then
					role = "```C\n\"" .. userLanguage.atelier.roles.sent .. "\"```\n"
				elseif tag == 20 then
					role = "```HTML\n<" .. userLanguage.atelier.roles.mc .. ">```\n"
				end
			end
			parameters = parameters:lower():gsub('%a', string.upper, 1)

			local href = "https://atelier801.com/profile?pr=" .. URLEncoded(parameters)
			local head, body = http.request("GET", href)

			if body then
				if body:find("La requête contient un ou plusieurs paramètres invalides") then
					toDelete[message.id] = message:reply({
						embed = {
							color = color.message,
							title = "<:atelier:458403092417740824> Atelier801 -> Error",
							description = userLanguage.atelier.not_found:format(parameters),
						}
					})
				else
					local gender = ""
					if body:find("Féminin") then
						gender = "<:female:456193579308679169> "
					elseif body:find("Masculin") then
						gender = "<:male:456193580155928588> "
					end

					local avatar = body:match("http://avatars%.atelier801%.com/%d+/%d+%.jpg")
					if not avatar then
						avatar = "https://i.imgur.com/dkhvbrg.png"
					end

					local community = body:match("Communauté :</span> <img src=\"/img/pays/(.-)%.png\"")
					if not community or community == "xx" then
						community = "<:international:458411936892190720>"
					else
						community = ":flag_" .. community .. ":"
					end

					local fields = {
						[1] = {
							name = userLanguage.atelier.registration,
							value = ":calendar: " .. tostring(body:match("Date d'inscription</span> : (.-)</span>")),
							inline = true,
						},
						[2] = {
							name = userLanguage.atelier.community,
							value = community,
							inline = true,
						},
						[3] = {
							name = userLanguage.atelier.messages,
							value = ":speech_balloon: " .. tostring(body:match("Messages : </span>(%d+)")),
							inline = true,
						},
						[4] = {
							name = userLanguage.atelier.prestige,
							value = ":hearts: " .. tostring(body:match("Prestige : </span>(%d+)")),
							inline = true,
						},
						[5] = {
							name = userLanguage.atelier.title,
							value = "« " .. tostring(body:match("&laquo; (.-) &raquo;")) .. " »",
							inline = true,
						}
					}

					local tribe = body:match("cadre%-tribu%-nom\">(.-)</span>")
					if tribe then
						tribe = tribe:gsub("&#(%d+);", string.char)

						local tribeId = body:match("tribe%?tr=%d+")

						fields[#fields + 1] = {
							name = userLanguage.atelier.tribe,
							value = "<:tribe:458407729736974357> [" .. tribe .. "](https://atelier801.com/" .. tostring(tribeId) .. ")",
							inline = true,
						}
					end

					local soulmate, id = body:match("alt=\"\">  ([%w+_]+)<span class=\"font%-s couleur%-hashtag%-pseudo\"> (#%d+)</span>")
					if soulmate and id then
						soulmate = soulmate .. id

						fields[#fields + 1] = {
							name = userLanguage.atelier.sm,
							value = ":revolving_hearts: [" .. soulmate .. "](https://atelier801.com/profile?pr=" .. URLEncoded(soulmate) .. ")",
							inline = true
						}
					end

					toDelete[message.id] = message:reply({
						embed = {
							color = color.message,
							title = "<:atelier:458403092417740824> " .. gender .. parameters,
							description = role .. "<:tfm_cheese:458404666926039053> [" .. userLanguage.atelier.visit .."](" .. href .. ")",
							thumbnail = { url = avatar },
							fields = fields,
						}
					})
				end
			end
		end
	end
}
commands["akinator"] = {
	permission = ePermissions.all,
	channel = eChannels.chat,
	log = false,
	allowPrivateMessage = false,
	exe = function(message, parameters, userLanguage)
		parameters = math.clamp(tonumber(parameters) or 97, 70, 97)

		local langs = {
			ar = "62.210.100.133:8155",
			br = "62.4.22.192:8166",
			cn = "158.69.225.49:8150",
			en = "62.210.100.133:8157",
			es = "62.210.100.133:8160",
			fr = "62.4.22.192:8165",
			il = "178.33.63.63:8006",
			it = "62.210.100.133:8159",
			jp = "178.33.63.63:8012",
			pl = "37.187.149.213:8143",
			ru = "62.4.22.192:8169",
			tr = "62.4.22.192:8164",
		}

		local lang = langs[tostring(userLanguage)] or langs.en

		local head, body = http.request("GET", "http://" .. lang .. "/ws/new_session.php?base=0&partner=410&premium=0&player=Android-Phone&uid=6fe3a92130c49446&do_geoloc=1&prio=0&constraint=ETAT%3C%3E'AV'&channel=0&only_minibase=0", HTTP_headers.Akinator)
		body = xml:ParseXmlText(tostring(body))

		if body then
			local numbers = {"one", "two", "three", "four", "five"}

			local cmds = table.concat(body.RESULT.PARAMETERS.STEP_INFORMATION.ANSWERS.ANSWER, "\n", function(index, value)
				return ":" .. tostring(numbers[index]) .. ": " .. tostring(value:value())
			end)

			local msg = message:reply({
				embed = {
					color = color.message,
					title =  "<:akinator:456196251743027200> Akinator vs. " .. message.member.name,
					thumbnail = { url = "https://loritta.website/assets/img/akinator_embed.png" },
					description = string.format("```%s```\n%s", body.RESULT.PARAMETERS.STEP_INFORMATION.QUESTION:value(), cmds),
					footer = {
						text = userLanguage.akinator_system.step:format(1)
					}
				}
			})

			if msg then
				for i = 1, #playingAkinator.__REACTIONS - 1 do
					msg:addReaction(playingAkinator.__REACTIONS[i])
				end

				toDelete[message.id] = msg
			end

			playingAkinator[message.author.id] = {
				canExe = true,
				message = msg,
				cmds = cmds,
				ratio = parameters,
				currentRatio = nil,
				lang = lang,
				textLang = tostring(userLanguage),
				data = {
					channel = body.RESULT.PARAMETERS.IDENTIFICATION.CHANNEL:value(),
					session = body.RESULT.PARAMETERS.IDENTIFICATION.SESSION:value(),
					signature = body.RESULT.PARAMETERS.IDENTIFICATION.SIGNATURE:value(),
					step = body.RESULT.PARAMETERS.STEP_INFORMATION.STEP:value(),
				},
				lastBody = body
			}
		end
	end
}
commands["animal"] = {
	permission = ePermissions.all,
	channel = eChannels.chat,
	log = false,
	allowPrivateMessage = true,
	exe = function(message)
		local head, body = http.request("GET", "https://www.randomlists.com/data/animals.json")
		body = json.decode(tostring(body))

		if body and body.RandL then
			local animal = tostring(table.random(body.RandL.items))

			toDelete[message.id] = message:reply({
				embed = {
					color = color.message,
					title = animal:gsub("%a", string.upper, 1),
					image = { url = "https://www.randomlists.com/img/animals/" .. (animal:gsub(" ", "_")) .. ".jpg" }
				}
			})
		end
	end
}
commands["avatar"] = {
	permission = ePermissions.all,
	channel = eChannels.chat,
	log = false,
	allowPrivateMessage = true,
	exe = function(message, parameters, userLanguage)
		parameters = not parameters and message.author.id or parameters:match("<@!?(%d+)>")
		parameters = parameters and client:getUser(parameters)

		if parameters then
			local url = parameters.avatarURL .. "?size=2048"

			toDelete[message.id] = message:reply({
				embed = {
					color = color.message,
					description = "**" .. string.format(userLanguage.avatar, parameters.fullname, url) .. "**",
					image = { url = url }
				}
			})
		end
	end
}
commands["coin"] = {
	permission = ePermissions.all,
	channel = eChannels.chat,
	log = false,
	allowPrivateMessage = true,
	exe = function(message, parameters)
		if currency.USD and parameters and #parameters > 2 then
			local from, to, amount

			to = parameters:match("^...")
			if to then
				to = to:upper()
				if currency[to] then
					from = parameters:match("[ \n]+(...)[ \n]*")
					if from then
						from = from:upper()
						if not currency[from] then
							message.author:send({
								embed = {
									color = color.error,
									description = ":fire: | Invalid currency `" .. from .. "`!\nThe available currencies are:\n```\n" .. table.concat(currency, ", ", tostring, nil, nil, pairsByIndexes) .. "```"
								}
							})

							message:delete()
							return
						end
					end

					local randomEmoji = ":" .. table.random({"money_mouth", "money_with_wings", "moneybag"}) .. ":"

					amount = parameters:match("(%d+%.?%d*)$")
					amount = tonumber(amount) or 1
					amount = (amount * currency[to]) / (currency[from] or currency.USD)

					toDelete[message.id] = message:reply({
						embed = {
							color = color.message,
							title = randomEmoji .. " " .. (from or "USD") .. " -> " .. to,
							description = string.format("$ %.2f", amount)
						}
					})
				else
					message.author:send({
						embed = {
							color = color.error,
							description = ":fire: | Invalid currency `" .. to .. "`!\nThe available currencies are:\n```\n" .. table.concat(currency, ", ", tostring, nil, nil, pairsByIndexes) .. "```"
						}
					})

					message:delete()
				end
			end
		end
	end
}
commands["color"] = {
	permission = ePermissions.all,
	channel = eChannels.chat,
	log = false,
	allowPrivateMessage = true,
	exe = function(message, parameters)
		parameters = parameters and parameters:match("#(%x+)")
		if parameters then
			local image = "https://www.colorhexa.com/" .. parameters .. ".png"

			local dec = tonumber(parameters, 16)
			toDelete[message.id] = message:reply({
				embed = {
					color = dec,
					author = {
						name = "#" .. parameters:upper() .. " <" .. dec .. ">",
						icon_url = image
					},
					image = {
						url = image
					}
				}
			})
		end
	end
}
commands["define"] = {
	permission = ePermissions.all,
	channel = eChannels.chat,
	log = false,
	allowPrivateMessage = true,
	exe = function(message, parameters)
		if parameters and #parameters > 0 then
			local head, body = http.request("GET", "https://wordsapiv1.p.mashape.com/words/" .. URLEncoded(parameters), HTTP_headers.mashape)
			body = json.decode(tostring(body))

			local msgID
			if body and body.results then
				local data = {
					definition = {},
					synonyms = {},
					antonyms = {},
					examples = {},
					partOfSpeech = {}
				}

				for i = 1, 5 do
					if body.results[i] then
						for k, v in next, data do
							if body.results[i][k] then
								v[#v + 1] = body.results[i][k]
							end
						end
					end
				end

				msgID = message:reply({
					content = "<@!" .. message.author.id .. ">",
					embed = {
						color = color.message,
						title = ":mag_right: Definition", 
						description = string.format("**Word** => %s `(%s)`\n\n**Pronunciation** => `%s`\n\n**Definitions** => ```%s```\n**Synonyms** => ```%s```\n**Antonyms** => ```%s```\n**Examples** => ```%s```", parameters, (#data.partOfSpeech > 0 and table.concat(data.partOfSpeech, ", ", function(index, value)
							return value
						end, 1, 3) or "-"), tostring(body.pronunciation and body.pronunciation.all or "-"), (#data.definition > 0 and table.concat(data.definition, "\n", function(index, value)
							return index .. ". " .. value
						end) or "-"), (#data.synonyms > 0 and table.concat(data.synonyms, "\n", function(index, value)
							return index .. ". " .. table.concat(value, ", ", nil, 1, 4)
						end) or "-"), (#data.antonyms > 0 and table.concat(data.antonyms, "\n", function(index, value)
							return index .. ". " .. table.concat(value, ", ", nil, 1, 2)
						end) or "-"), (#data.examples > 0 and table.concat(data.examples, "\n", function(index, value)
							return index .. ". " .. table.concat(value, "", nil, 1, 1)
						end) or "-"))
					}
				})
			else
				msgID = message:reply({
					content = "<@!" .. message.author.id .. ">",
					embed = {
						color = color.error,
						description = ":fire: | Word `" .. parameters .. "` not found! :confused:"
					}
				})
			end

			toDelete[message.id] = msgID
		end
	end
}
commands["fact"] = {
	permission = ePermissions.all,
	channel = eChannels.chat,
	log = false,
	allowPrivateMessage = true,
	exe = function(message)
		local head, body = http.request("GET", "http://miceclan.com/api/facts/randomfact?k=" .. HTTP_headers.mice_clan)
		body = json.decode(tostring(body))

		if body and body.fact then
			toDelete[message.id] = message:reply({
				embed = {
					color = color.message,
					title = ":" .. table.random({"astonished", "thinking", "hushed", "scream"}) .. ": @MiceClan Random Facts",
					description = body.fact
				}
			})
		end
	end
}
commands["help"] = {
	permission = ePermissions.all,
	channel = eChannels.not_system,
	log = false,
	allowPrivateMessage = true,
	exe = function(message, _, userLanguage, member)
		local cmds = {}

		local msg = member or message.author

		local totalCommands = 0
		for k, v in next, commands do
			if getUserPerm(v.permission, msg.id) then
				totalCommands = totalCommands + 1
				local id = v.permission + 1

				if not cmds[id] then
					cmds[id] = {}
				end

				cmds[id][#cmds[id] + 1] = string.format("```Python\n!%s = \"%s\"```", k, (userLanguage.command_descriptions[k] or v.description)[1])
			end
		end

		msg:send({
			embed = {
				color = color.help,
				description = string.format(userLanguage.help_message .. "\n\n" .. userLanguage.command_quantity, msg.id, (member and userLanguage.help_welcome .. "\n" or ""), totalCommands)
			}
		})

		local permissions = userLanguage.help_permissions
		for i = 1, #cmds do
			msg:send({
				embed = {
					color = color.help,
					description = ":gem: " .. string.format(userLanguage.help_commands, permissions[i]) .. " :gem:\n" .. table.concat(cmds[i]) .. "\n"
				}
			})
		end
	end
}
commands["invite"] = {
	permission = ePermissions.all,
	channel = eChannels.all,
	log = false,
	allowPrivateMessage = true,
	exe = function(message, _, userLanguage)
		toDelete[message.id] = message:reply({
			embed = {
				color = color.message,
				description = string.format(userLanguage.invite_link, "https://discord.gg/mMre2Dz")
			}
		})
	end
}
commands["lang"] = {
	permission = ePermissions.all,
	channel = eChannels.all,
	log = false,
	allowPrivateMessage = true,
	exe = function(message, parameters, userLanguage)
		message:delete()

		if parameters and #parameters == 2 then
			parameters = parameters:lower()

			local languageReplace = {
				{"br", "pt"},
				{"he", "il"},
			}

			for k, v in next, languageReplace do
				parameters = parameters:gsub(v[2], v[1])
			end

			if translations[parameters] then
				if not data.user[message.author.id] then
					data.user[message.author.id] = {
						language = "en"
					}
				end

				if data.user[message.author.id].language ~= parameters then
					data.user[message.author.id].language = parameters
					userLanguage = translations[parameters]
					save("user", data.user)
				end

				parameters = parameters:upper()
				message.author:send({
					embed = {
						color = color.system,
						description = data.available_languages[parameters] .. " " .. string.format(userLanguage.standard_language, parameters)
					}
				})
				return
			end
		end

		message.author:send({
			embed = {
				color = color.error,
				description = ":fire: | " .. string.format(userLanguage.available_languages, table.concat(translations, " - ", function(index, value)
					return index:upper()
				end, nil, nil, pairsByIndexes))
			}
		})
	end
}
commands["languages"] = {
	permission = ePermissions.all,
	channel = eChannels.all,
	log = false,
	allowPrivateMessage = true,
	exe = function(message, _, userLanguage)
		toDelete[message.id] = message:reply({
			embed = {
				color = color.translation,
				title = string.format(userLanguage.available_languages, "#" .. table.count(data.available_languages)),
				description = table.concat(data.available_languages, "\n", function(index, value)
					return value .. " " .. index
				end, nil, nil, pairsByIndexes)
			}
		})
	end
}
commands["leaderboard"] = {
	permission = ePermissions.all,
	channel = eChannels.chat,
	log = false,
	allowPrivateMessage = true,
	exe = function(message, parameters, userLanguage)
		parameters = parameters or '* 3'

		local check = false
		local role = (parameters:match("%D+") or ""):lower()
		role = string.trim(role)

		for k, v in next, data.roles do
			if k:lower() == role then
				check = tonumber(k) and k or v
				break
			end
		end

		local title = check and role:upper() or userLanguage.global

		local positions = parameters:match("[ \n]+(%d+)")
		positions = math.clamp(tonumber(positions) or 0, 3, 6)

		local _L = {{}, {}} -- Translations, Cookies
		for k, v in next, data.team do
			if not check or (table.find(v.team, check) or table.find(v.rank, check)) then
				if v.translations > 0 then
					_L[1][#_L[1] + 1] = {name = v.user, translations = v.translations}
				end

				if v.cookies > 0 then
					_L[2][#_L[2] + 1] = {name = v.user, cookies = v.cookies}
				end
			end
		end

		local text, place = "", {"first", "second", "third"}

		for i = 1, 2 do
			local str = i == 1 and "translations" or "cookies"
			table.sort(_L[i], function(a, b) return a[str] > b[str] end)

			text = text .. (i == 1 and getRandomEarth() or ":cookie:") .. "\t**Top " .. userLanguage.leaderboard_stats[i] .. "**\n\n" .. (#_L[i] > 0 and (table.concat(_L[i], "\n", function(index, value)
				return (index < 4 and ":" .. place[index] .. "_place: " or ":medal:") .. " `" .. value.name .. "` (**".. value[str] .."**)"
			end, 1, positions)) or "?") .. "\n\n"
		end

		local msg = message:reply({
			embed = {
				color = color.leaderboard,
				title = userLanguage.leaderboard .. " -> " .. title,
				description = text
			}
		})
		toDelete[message.id] = msg
		msg:addReaction("\xF0\x9F\x8F\x86")
	end
}
commands["meme"] = {
	permission = ePermissions.all,
	channel = eChannels.chat,
	log = false,
	allowPrivateMessage = true,
	exe = function(message)
		local meme = table.random(memes)

		local e = {
			color = color.message,
			title = "Atelier801 Meme",
			image = {
				url = "http://img.atelier801.com/"
			}
		}

		if type(meme) == "table" then
			e.description = meme[2]
			e.image.url = e.image.url .. meme[1]
		else
			e.image.url = e.image.url .. meme
		end
		e.image.url = e.image.url .. ".png"

		toDelete[message.id] = message:reply({embed = e})
	end
}
commands["message"] = {
	permission = ePermissions.all,
	channel = eChannels.all,
	log = false,
	allowPrivateMessage = true,
	exe = function(message, _, userLanguage)
		message.author:send({
			embed = {
				color = color.message,
				description = string.format(userLanguage.message_message, message.author.name)
			}
		})
		message:delete()
	end
}
commands["momma"] = {
	permission = ePermissions.all,
	channel = eChannels.chat,
	log = false,
	allowPrivateMessage = true,
	exe = function(message)
		local head, body = http.request("GET", "http://miceclan.com/api/jokes/momma?k=" .. HTTP_headers.mice_clan)
		body = json.decode(tostring(body))

		if body and body.joke then
			toDelete[message.id] = message:reply({
				embed = {
					color = color.message,
					title = ":" .. table.random({"laughing", "rofl", "joy"}) .. ": @MiceClan Momma Jokes",
					description = body.joke
				}
			})
		end
	end
}
commands["poll"] = {
	permission = ePermissions.all,
	channel = eChannels.all,
	log = false,
	allowPrivateMessage = false,
	exe = function(message, parameters, userLanguage)
		if table.find(polls, message.author.id, "authorID") then
			toDelete[message.id] = message:reply({
				embed = {
					color = color.error,
					description = ":skull: | " .. userLanguage.poll.already_exists
				}
			})
			return
		end

		if parameters and #parameters > 0 then
			local time, option, question = 10, userLanguage.poll.option
			local isMember = getTranslatorPerm(message.author.id, perms.member)

			local ping = isMember and parameters:find("`")

			if ping then
				local output, options
				output, question, time, options = parameters:match("`(`?`?)(.*)%1`[ \n]+(%d+)[ \n]+(.+)")

				if not question then return end
				time = math.clamp(tonumber(time), 5, 60)
				if not time then return end

				option = string.split(options, options:find("`") and "`(.-)`" or "%S+")
				if not option[2] then return end
			else
				question = parameters:sub(1, 250)
			end

			local poll = message:reply({
				content = ping and "@here",
				embed = {
					color = color.interaction,
					author = {
						name = message.member.name .. " - " .. userLanguage.poll.poll,
						icon_url = message.author.avatarURL
					},
					description = "```\n" .. question .. "```\n:one: " .. option[1] .. "\n:two: " .. option[2],
					footer = {
						text = userLanguage.poll.ends:format(time)
					}
				}
			})
			for i = 1, #polls.__REACTIONS do
				poll:addReaction(polls.__REACTIONS[i])
			end

			polls[poll.id] = {
				channel = message.channel.id,
				authorID = message.author.id,
				data = {0, 0},
				time = os.time() + (time * 60),
				textLang = tostring(userLanguage),
				option = option
			}

			message:delete()
		end
	end
}
commands["profile"] = {
	permission = ePermissions.all,
	channel = eChannels.not_system,
	log = false,
	allowPrivateMessage = true,
	exe = function(message, parameters, userLanguage, channel)
		local user = nil
		parameters = string.match(tostring(parameters), "<@!?(%d+)>") or string.lower(parameters or message.author.id)

		for k, v in next, data.team do
			local nameInLower = v.user:lower()
			if parameters == nameInLower:match("(.-)#") or parameters == nameInLower or parameters == k then
				user = { discord = client:getUser(k), fromData = v }
				break
			end
		end

		if user then
			local icon = getIcon(user.discord.id)

			local birthdayField = user.fromData.birthdayDate[1] ~= "" and {
				name = userLanguage.profile_fields.birthday,
				value = ":tada: " .. user.fromData.birthdayDate[1],
				inline = true
			} or nil

			local genders = { "<:male:456193580155928588> ", "<:female:456193579308679169> " }

			local msg = channel and client:getChannel(channel) or message.channel
			local profileMsg = msg:send({
				embed = {
					color = color.profile,
					thumbnail = { url = user.discord.avatarURL },
					title = string.format("%s%s %s", (user.fromData.gender > 0 and genders[user.fromData.gender] or ""), icon, user.fromData.user),
					description = string.format("[`“%s”`](https://atelier801.com/profile?pr=%s)", ((user.fromData.status ~= "" and user.fromData.status) or "Hey there! I am a Translator!"), URLEncoded(user.fromData.user)),
					fields = {
						[1] = {
							name = userLanguage.profile_fields.role,
							value = #user.fromData.rank > 0 and (table.concat(user.fromData.rank, "\n", function(index, value)
								return data.roles[value]
							end)) or "-",
							inline = true
						},
						[2] = {
							name = userLanguage.profile_fields.language,
							value = #user.fromData.team > 0 and (table.concat(user.fromData.team, " ", function(index, value)
								return data.available_languages[data.roles[value]]
							end)) or "-",
							inline = true
						},
						[3] = {
							name = userLanguage.profile_fields.translations,
							value = getRandomEarth() .. " `" .. user.fromData.translations .. "`",
							inline = true
						},
						[4] = {
							name = "Cookies",
							value = ":cookie: `" .. user.fromData.cookies .. "`",
							inline = true
						},
						[5] = {
							name = userLanguage.profile_fields.state,
							value = userLanguage.profile_fields.states[(data.team[user.discord.id].isActive and 1 or 2)],
							inline = true
						},
						[6] = birthdayField,
					},
				}
			})
			profileMsg:addReaction("\xE2\x9D\xA4")
			toDelete[message.id] = profileMsg
		else
			parameters = tonumber(parameters) and (client:getUser(parameters) or {}).fullname or parameters or "-"

			toDelete[message.id] = message:reply({
				embed = {
					color = color.profile,
					description = ":fire: | " .. string.format(userLanguage.not_translator, parameters) .. " :(\n\n:clipboard: | " .. userLanguage.available_translators
				}
			})
		end
	end
}
commands["quote"] = {
	permission = ePermissions.all,
	channel = eChannels.all,
	log = false,
	allowPrivateMessage = false,
	exe = function(message, parameters)
		message:delete()

		if parameters and #parameters > 2 then
			local msgID, msgChannel = parameters:match("(%d+)[ \n]+(%d+)")
			msgID = msgID or parameters:match("%d+")

			if msgID then
				local msg = client:getChannel(msgChannel or message.channel)
				if msg then
					msg = msg:getMessage(msgID)

					if msg then
						local embed = {
							color = color.message,
							author = {
								name = (msg.member and msg.name or msg.author.fullname),
								icon_url = msg.author.avatarURL
							},
							footer = {
								text = "In #" .. msg.channel.name,
								icon_url = message.author.avatarURL
							},
							timestamp = msg.timestamp:gsub(" ", ""),
							description = (msg.embed and msg.embed.description) or msg.content,
						}
						local img = (msg.attachment and msg.attachment.url) or (msg.embed and msg.embed.image and msg.embed.image.url)

						if img then
							embed.image = {
								url = img
							}
						end

						message:reply({embed = embed})
					end
				end
			end
		end
	end
}
commands["request"] = {
	permission = ePermissions.all,
	channel = 'public-requests',
	log = true,
	allowPrivateMessage = true,
	exe = function(message, parameters, userLanguage)
		local helpMessage = "\n" .. userLanguage.request_help
		if parameters then
			local currentLanguage, languages, content

			currentLanguage = parameters:match("(%S+)")
			if currentLanguage then
				currentLanguage = currentLanguage:upper()

				if data.available_languages[currentLanguage] then

					languages = parameters:match("[ \n]+[%[{](.-)[%]}]")
					if languages then
						local unavailable_languages, repeated_flags, special = {}, {}, false

						if languages:lower() == "xx" and getTranslatorPerm(message.author.id, perms.member) then
							special = true
							languages = {}
							for flag in next, data.available_languages do
								if flag ~= currentLanguage then
									languages[#languages + 1] = flag
								end
							end
						else
							repeated_flags[currentLanguage] = true

							languages = string.split(languages, "[^, *]+", function(flag)
								flag = flag:upper()

								if not data.available_languages[flag] then
									unavailable_languages[#unavailable_languages + 1] = "`" .. flag .. "`"
									return nil
								end

								if repeated_flags[flag] then
									return nil
								end
								repeated_flags[flag] = true
								return flag
							end)
						end

						if #languages > 0 then
							if #unavailable_languages > 0 then
								message.author:send({
									embed = {
										color = color.error,
										description = ":fire: | " .. string.format(userLanguage.request_error.unavailable_language, table.concat(unavailable_languages, ", ")) .. "\n" .. string.format(userLanguage.available_languages, table.concat(data.available_languages, " - ", tostring, nil, nil, pairsByIndexes))
									}
								})
							end

							local output, isModule
							output, content = parameters:match("[ \n]+`(`?`?)(.*)%1`")

							if content and #content > 1 then
								isModule = output == '``' and content:lower():find("^lua\n")

								content = content:gsub('```', "´´´")

								local size = requestsSize[isModule and "module" or "regular"]
								if #content > size then
									message.author:send({
										embed = {
											color = color.error,
											description = ":skull: | " .. string.format(userLanguage.exceeded_char_request, size)
										}
									})
									return
								end

								local currentTime = os.time()

								local member_name = (message.member and message.member.name or message.author.fullname)

								database.currentID = requestID()
								database.unhandledRequests[tostring(database.currentID)] = {
									author = { id = message.author.id, name = member_name }, -- author.name in !list
									currentLanguage = currentLanguage,
									languages = languages,
									content = content,
									requestTime = currentTime,
									module = isModule,
									--referenceMessage = below
								}

								local requestMessageInfo = client:getChannel(channels['requests-log']):send(commands["list"].exe(message, "#" .. database.currentID, nil, true))
								database.unhandledRequests[tostring(database.currentID)].referenceMessage = requestMessageInfo.id

								save("data", database)

								message.author:send({
									embed = {
										color = color.translation,
										description = data.available_languages[currentLanguage] .. " " .. string.format(userLanguage.request[1], table.count(database.unhandledRequests)) .. ". `[ID:" .. database.currentID .. "]`\n\n" .. string.format(userLanguage.request[2], table.concat(languages, ", ", function(index, value)
											return data.available_languages[value] .. " `" .. value .. "`"
										end)) .. "\n```" .. (isModule and "" or "\n") .. content .. "```" .. (isModule and "\n:gear: Lua Script" or "")
									}
								})

								client:getChannel(channels['public-translations']):send({
									content = "From language: " .. data.available_languages[currentLanguage] .. " " .. (currentLanguage == "EN" and "EN" or "<@&" .. data.roles[currentLanguage] .. ">") .. "\n\nTranslate to: " .. table.concat(languages, ", ", function(index, value)
										return data.available_languages[value] .. " " .. (value == "EN" and "EN" or "<@&" .. data.roles[value] .. ">")
									end),
									embed = {
										color = color.translation,
										description = ":calendar_spiral: " .. os.date("%Y-%m-%d", currentTime) .. "\n\n:" .. (special and "star" or "mailbox") .. ": New request (**#" .. database.currentID .. "**)" .. (isModule and "\n:gear: <@&" .. data.roles['Module'] .. "> Lua script " or "") .. "\n\nRequest from **" .. tostring(member_name) .. "**\n\nContent: ```" .. (isModule and "" or "\n") .. content .. "```"
									}
								})
							else
								message.author:send({
									embed = {
										color = color.error,
										description = ":skull: | " .. userLanguage.request_error.no_content .. helpMessage
									}
								})
							end
						else
							message.author:send({
								embed = {
									color = color.error,
									description = ":skull: | " .. userLanguage.request_error.no_language .. helpMessage
								}
							})
						end
					else
						message.author:send({
							embed = {
								color = color.error,
								description = ":skull: | " .. userLanguage.request_error.no_language .. helpMessage
							}
						})
					end

				else
					message.author:send({
						embed = {
							color = color.error,
							description = ":skull: | " .. string.format(userLanguage.request_error.unavailable_language, "`" .. currentLanguage .. "`") .. "\n" .. string.format(userLanguage.available_languages, table.concat(data.available_languages, " - ", tostring, nil, nil, pairsByIndexes))
						}
					})
				end
			else
				message.author:send({
					embed = {
						color = color.error,
						description = ":skull: | " .. userLanguage.request_error.no_content_language .. helpMessage
					}
				})
			end

		else
			message.author:send({
				embed = {
					color = color.error,
					description = ":skull: | " .. userLanguage.no_parameters .. helpMessage
				}
			})
		end
	end
}
commands["serverinfo"] = {
	permission = ePermissions.all,
	channel = eChannels.not_system,
	log = false,
	allowPrivateMessage = false,
	exe = function(message, _, userLanguage)
		local members = message.guild.members
		toDelete[message.id] = message:reply({
			content = "<@" .. message.author.id .. ">",
			embed = {
				color = color.translation,

				author = {
					name = message.guild.name,
					icon_url = message.guild.iconURL
				},

				thumbnail = { url = "https://i.imgur.com/Lvlrhot.png" },

				fields = {
					[1] = {
						name = ":computer: ID",
						value = message.guild.id,
						inline = true
					},
					[2] = {
						name = ":crown: " .. userLanguage.server.owner,
						value = "<@" .. message.guild.ownerId .. ">",
						inline = true
					},
					[3] = {
						name = ":speech_balloon: " .. userLanguage.server.channels,
						value = ":pencil2: Text: " .. #message.guild.textChannels .. "\n:speaker: Voice: " .. #message.guild.voiceChannels .. "\n:card_box: Category: " .. #message.guild.categories,
						inline = true
					},
					[4] = {
						name = ":calendar: " .. userLanguage.server.creation,
						value = os.date("%Y-%m-%d %I:%M%p", message.guild.createdAt),
						inline = true
					},
					[5] = {
						name = ":family_mmgb: " .. userLanguage.server.members,
						value = string.format("<:online:456197711356755980> Online: %s | <:idle:456197711830581249> %s: %s | <:dnd:456197711251636235> %s: %s | <:offline:456197711457419276> Offline: %s\n:raising_hand: **%s:** %s\n%s **%s:** %s\n:robot: **Bots**: 1", members:count(function(member)
							return member.status == "online"
						end), userLanguage.server.away, members:count(function(member)
							return member.status == "idle"
						end), userLanguage.server.busy, members:count(function(member)
							return member.status == "dnd"
						end), members:count(function(member)
							return member.status == "offline"
						end), userLanguage.server.people, message.guild.totalMemberCount - 1, getRandomEarth(), userLanguage.server.translators, table.count(data.team)), -- 1 bot
						inline = false
					},
				},
			}
		})
	end
}
commands["spell"] = {
	permission = ePermissions.all,
	channel = eChannels.chat,
	log = false,
	allowPrivateMessage = true,
	exe = function(message, parameters)
		if parameters and #parameters > 0 then
			local head, body = http.request("GET", "https://montanaflynn-spellcheck.p.mashape.com/check/?text=" .. URLEncoded(parameters), HTTP_headers.mashape)
			body = json.decode(tostring(body))

			if body and body.corrections then
				if table.count(body.corrections) > 0 then
					for k, v in next, body.corrections do
						parameters = parameters:gsub(k, function(word)
							return "<" .. word .. "/" .. tostring(v[1]) .. ">"
						end)
					end

					toDelete[message.id] = message:reply({
						content = "<@!" .. message.author.id .. ">",
						embed = {
							color = color.message,
							title = "Spell Check",
							description = "```HTML\n" .. parameters .. "```\n\nFixed words => ```Haskell\n" .. table.concat(body.corrections, "\n", function(index, value)
								return index .. " => " .. tostring(value[1])
							end) .. "```\n\nSuggestion => ```" .. tostring(body.suggestion) .. "```"
						}
					})
				else
					toDelete[message.id] = message:reply({
						content = "<@!" .. message.author.id .. ">",
						embed = {
							color = color.message,
							description = ":white_check_mark: | Your text is correct or doesn't have any apparent error!\n```" .. parameters .. "```"
						}
					})
				end
			end
		end
	end
}
commands["team"] = {
	permission = ePermissions.all,
	channel = eChannels.all,
	log = false,
	allowPrivateMessage = true,
	exe = function(message, parameters, userLanguage)
		if parameters and #parameters > 0 then
			local role = (parameters:match("<@&(%d+)>") or parameters):lower()

			local executed = false
			local names = {}
			for k, v in next, data.roles do
				if k:lower() == role then
					local src = tonumber(k) and k or v

					for i, j in next, data.team do
						if table.find(j.team, src) or table.find(j.rank, src) then
							names[#names + 1] = {j.user, client:getUser(i).fullname}
						end
					end

					executed = true
					break
				end
			end

			if executed then
				if #names > 0 then
					table.sort(names, function(a, b) return a[1] < b[1] end)

					local lines = splitByLine("**" .. string.format(userLanguage.member_title, parameters:upper(), #names) .. "**\n\n" .. table.concat(names, "\n",function(index, value)
						return "`" .. value[1] .. "` → `" .. value[2] .. "`"
					end))

					local ids = { }
					for id = 1, #lines do
						ids[#ids + 1] = message:reply({
							content = id == 1 and "<@!" .. message.author.id .. ">" or nil,
							embed = {
								color = color.system,
								description = lines[id]
							}
						})
					end

					toDelete[message.id] = ids
					return
				end
			end

			toDelete[message.id] = message:reply({
				embed = {
					color = color.error,
					description = ":fire: | " .. string.format(userLanguage.role_not_found, parameters) .. " :cry:"
				}
			})
		end
	end
}
commands["thread"] = {
	permission = ePermissions.all,
	channel = eChannels.all,
	log = false,
	allowPrivateMessage = true,
	exe = function(message, parameters)
		parameters = string.upper(tostring(parameters))

		local flag, thread = "EN", forumThreads.EN
		if forumThreads[parameters] then
			flag = parameters
			thread = forumThreads[parameters]
		end

		toDelete[message.id] = message:reply({
			embed = {
				color = color.message,
				title = data.available_languages[flag] .. " " .. flag,
				description = "https://atelier801.com/topic?f=5&t=" .. thread
			}
		})
	end
}
commands["tree"] = {
	permission = ePermissions.all,
	channel = eChannels.chat,
	log = false,
	allowPrivateMessage = true,
	exe = function(message, parameters, userLanguage)
		parameters = (parameters and #parameters > 0) and parameters or "tfm"

		local src, sequence = table.loadTable(parameters)
        
		if src then
			local pkg = sequence[2] == "exec" or sequence[2] == "events" or sequence[2] == "debug" or sequence[2] == "system" or sequence[2] == "ui"

			local t
			t = function(index, value, level, isPkg)
				level = level or 1

				local format = (isPkg and "( %s )" or ": %s")

				local typ = type(value)
        
				return string.format("`%s` **%s** %s", (isPkg and "function" or typ), index, format:format((typ == "table" and (#sequence < 4 and "#" .. table.count(value) or "\n" .. (table.concat(value, "\n", function(k, v)
					return string.rep("\t", level) .. t(k, v, level + 1)
				end))) or ("`" .. tostring(value) .. "`"))))
			end

			local lines = splitByLine(type(src) == "table" and table.concat(src, "\n", function(index, value)
				if pkg then
					return string.format("`function` **%s** ( `%s` )", (sequence[3] or index), tostring(value))
				else
					return t(index, value)
				end
			end) or t(sequence[#sequence], src, nil, pkg))

			local ids = { }
			for id = 1, #lines do
				ids[#ids + 1] = message:reply({
					content = id == 1 and "<@!" .. message.author.id .. ">" or nil,
					embed = {
						color = color.lua,
						title = id == 1 and "<:wheel:456198795768889344> " .. parameters or nil,
						description = lines[id]
					}
				})
			end

			toDelete[message.id] = ids
		else
			toDelete[message.id] = message:reply({
				embed = {
					color = color.luaerr,
					description = string.format(userLanguage.path_not_found, parameters)
				}
			})
		end
	end
}
commands["urban"] = {
	permission = ePermissions.all,
	channel = eChannels.chat,
	log = false,
	allowPrivateMessage = true,
	exe = function(message, parameters)
		if parameters and #parameters > 0 then
			parameters = deactivateAccents(parameters)

			local head, body = http.request("GET", "http://urbanscraper.herokuapp.com/define/" .. URLEncoded(parameters))

			local result = json.decode(tostring(body))

			if result and result.term and result.definition then
				toDelete[message.id] = message:reply({
					embed = {
						color = color.message,
						title = ":mag_right: Web search",
						description = "Expression => **" .. result.term .. "**\n\nDefinition => ```" .. result.definition:sub(1, 600) .. "```\nExample =>```HTML\n" .. ((result.example and result.example ~= "") and result.example:sub(1, 600):gsub("%w+", function(word)
							if word:lower() == result.term then
								return "<" .. word .. ">"
							else
								return text
							end
						end) or "-") .. "```"
					}
				})
			else
				toDelete[message.id] = message:reply({
					embed = {
						color = color.error,
						description = ":fire: | Expression `" .. parameters .. "` not found! :confused:"
					}
				})
			end
		end
	end
}
commands["weather"] = {
	permission = ePermissions.all,
	channel = eChannels.chat,
	log = false,
	allowPrivateMessage = true,
	exe = function(message, parameters, userLanguage)
		if parameters and #parameters > 2 then
			local head, body = http.request("GET", "http://api.openweathermap.org/data/2.5/weather?q=" .. URLEncoded(parameters) .. "&units=metric&APPID=" .. HTTP_headers.open_weather)
			body = json.decode(tostring(body))

			if body and body.cod == 200 then
				local w = tostring(body.weather[1].icon):match("%d+")
				w = w and tonumber(w)

				local icon = ":" .. (weatherIcon[w] or weatherIcon[1]) .. ": "

				local fields = {
					[1] = {
						name = ":thermometer: " .. userLanguage.weather.temperature,
						value = string.format("**%s:** %s°C\n**%s:** %s°C\n**%s:** %s°C\n", userLanguage.weather.current, (body.main.temp or 0), userLanguage.weather.maximum, (body.main.temp_max or 0), userLanguage.weather.minimum, (body.main.temp_min or 0)),
						inline = true,
					},
					[2] = {
						name = userLanguage.weather.wind,
						value = ":wind_blowing_face: " .. ((body.wind.speed or 0) * 18/5) .. " km/h",
						inline = true,
					},
					[3] = {
						name = userLanguage.weather.humidity,
						value = ":sweat_drops: " .. (body.main.humidity or 0) .. "%",
						inline = true,
					},
					[4] = {
						name = userLanguage.weather.cloud,
						value = ":cloud: " .. (body.clouds and body.clouds.all or 0) .. "%",
						inline = true,
					}
				}

				local rain, snow = (body.rain and body.rain["3h"] or 0), (body.snow and body.snow["3h"] or 0)

				if rain > 0 then
					fields[#fields + 1] = {
						name = userLanguage.weather.rain,
						value = ":cloud_rain: " .. rain .. " mm",
						inline = true,
					}
				end

				if snow > 0 then
					fields[#fields + 1] = {
						name = userLanguage.weather.snow,
						value = ":snowman: " .. snow .. " inch",
						inline = true,
					}
				end

				toDelete[message.id] = message:reply({
					content = "<@!" .. message.author.id .. ">",
					embed = {
						color = color.message,
						title = icon .. userLanguage.weather.at:format(body.name .. ", " .. body.sys.country),
						description = tostring(body.weather[1].description),
						fields = fields,
						footer = {
							text = userLanguage.weather.update:format(os.date("%c", body.dt))
						}
					}
				})
			else
				toDelete[message.id] = message:reply({
					content = "<@!" .. message.author.id .. ">",
					embed = {
						color = color.error,
						description = ":fire: | " .. string.format(userLanguage.weather.not_found, parameters:upper())
					}
				})
			end
		end
	end
}

	--[[ Translators ]]--
commands["active"] = {
	description = { "Toggles your activity between `Active` and `Inactive`", { "!active" } },
	permission = ePermissions.team,
	channel = eChannels.not_system,
	log = false,
	allowPrivateMessage = true,
	exe = function(message)
		data.team[message.author.id].isActive = not data.team[message.author.id].isActive
		save("team", data.team)

		local activity = "Inactive"
		if data.team[message.author.id].isActive then
			activity = "Active"
		end

		message.author:send({
			embed = {
				color = color.profile,
				description = "You just set your activity to `" .. activity .. "`"
			}
		})

		message:delete()
	end
}
commands["blacklist"] = {
	description = { "Displays the blacklisted users.", { "!blacklist" } },
	permission = ePermissions.team,
	channel = eChannels.all,
	log = false,
	allowPrivateMessage = true,
	exe = function(message)
		message:reply({
			embed = {
				color = color.error,
				title = ":x: Blacklist",
				fields = {
					{
						name = ":bust_in_silhouette: Username",
						value = table.count(blacklist.blacklisted) > 0 and (table.concat(blacklist.blacklisted, "\n", function(index, value)
							return "```Haskell\n" .. value .. ">" .. index .. "```"
						end)) or "-",
						inline = true
					},
					{
						name = ":bookmark_tabs: Data",
						value = table.count(blacklist.blacklisted) > 0 and (table.concat(blacklist.blacklisted, "\n", function(index, value)
							return "```" .. blacklist[index].reasons .. "```"
						end)) or "-",
						inline = true
					},
				},
			}
		})

		message:delete()
	end
}
commands["gender"] = {
	description = { "Changes your gender in the profile.", { "!gender none/male/female" } },
	permission = ePermissions.team,
	channel = eChannels.not_system,
	log = false,
	allowPrivateMessage = true,
	exe = function(message, parameters)
		if parameters and #parameters > 0 then
			local genders = { "NONE", "MALE", "FEMALE" }

			parameters = parameters:upper()

			local found, gender = table.find(genders, parameters)

			if found then
				data.team[message.author.id].gender = gender - 1
				message.author:send({
					embed = {
						color = color.system,
						description = "Your gender was set to `" .. parameters .. "`"
					}
				})

				save("team", data.team)
			else
				message.author:send({
					embed = {
						color = color.error,
						description = ":fire: | Invalid gender. The available genders are:\n\n" .. table.concat(genders, "\n", function(index, value) return "`" .. value .. "`" end)
					}
				})
			end
		end

		message:delete()
	end
}
commands["list"] = {
	description = { "Lists all the requests or the requests in a specific language.",
		{
			"(All the requests)\n!list",
			"(Requests with a specific language)\n!list `language`",
			"(Requests of lua scripts)\n!list script",
			"(Request)\n!list `#request_id`",
		}
	},
	permission = ePermissions.team,
	channel = eChannels.all,
	log = false,
	allowPrivateMessage = true,
	exe = function(message, parameters, _, toRet)
		local isNumber
		if parameters then 
			isNumber = tonumber(parameters:match("^#(%d+)"))

			if not isNumber then
				parameters = tostring(parameters):upper()
				parameters = (data.available_languages[parameters] or parameters == "SCRIPT") and parameters or nil
			end
		end

		if not toRet then
			message:delete()
		end

		local indexes = {}
		for id, data in next, database.unhandledRequests do
			if not parameters or (isNumber and tonumber(id) == isNumber or (table.find(data.languages, parameters)) or (parameters == "SCRIPT" and data.module)) then
				indexes[#indexes + 1] = id
			end
		end
		table.sort(indexes)

		if not isNumber then
			message.author:send({
				embed = {
					color = color.message,
					description = "Total requests: " .. #indexes .. "."
				}
			})
		end

		for i, k in ipairs(indexes) do
			local v = database.unhandledRequests[k]

			local totalDay, totalHour, totalMinute = os.transformTime(os.time() - v.requestTime)
			local calendarString = (totalDay == 0 and "" or totalDay.." days, ") .. (totalHour == 0 and "" or totalHour.." hours and ") .. (totalMinute == 0 and 1 or totalMinute) .. " minutes ago"


			local translate_to = "Translate to: " .. table.concat(v.languages, ", ", function(index, value)
				return data.available_languages[value] .. " " .. (toRet and (value == "EN" and "EN" or "<@&" .. data.roles[value] .. ">") or "`" .. value .. "`")
			end)
			local from = data.available_languages[v.currentLanguage] .. " " .. (toRet and (v.currentLanguage == "EN" and "EN" or "<@&" .. data.roles[v.currentLanguage] .. ">") or "`" .. v.currentLanguage .. "`")

			local info = {
				content = "From language: " .. data.available_languages[v.currentLanguage] .. " " .. (toRet and (v.currentLanguage == "EN" and "EN" or "<@&" .. data.roles[v.currentLanguage] .. ">") or "`" .. v.currentLanguage .. "`") .. "\nTranslate to: " .. table.concat(v.languages, ", ", function(index, value)
					return data.available_languages[value] .. " " .. (toRet and (value == "EN" and "EN" or "<@&" .. data.roles[value] .. ">") or "`" .. value .. "`")
				end),
				embed = {
					color = color.translation,
					description = ":calendar_spiral: " .. calendarString .. " (" .. os.date("%Y-%m-%d", v.requestTime) .. ")\n:mailbox: **#" .. k .. "**\nRequest from **" .. v.author.name .. "**\n%sContent: ```" .. (v.module and "" or "\n") .. "%s```" .. (v.module and "\n:gear: " .. (toRet and "<@&" .. data.roles['Module'] .. ">" or "`Module`") .. " Lua Script" or "")
				}
			}

			if toRet then
				info.embed.description = string.format(info.embed.description, "", v.content)
				return info
			else
				info.embed.description = string.format(info.embed.description, info.content .. "\n", v.content)
				info.content = nil
				message.author:send(info)
			end
		end
	end
}
commands["status"] = {
	description = { "Sets the status phrase in the profile.", { "!status `text`" } },
	permission = ePermissions.team,
	channel = eChannels.not_system,
	log = false,
	allowPrivateMessage = true,
	exe = function(message, parameters)
		if parameters and #parameters > 0 then
			local q = 0
			parameters = parameters:sub(1, 86):gsub(" +", " "):gsub("\n", function()
				q = q + 1
				return q > 1 and " " or "\n"
			end)

			for k, v in next, data.team do
				if k == message.author.id then
					message:delete()

					if parameters == v.status then
						message.author:send({
							embed = {
								color = color.error,
								title = ":x: Status change",
								description = "Your current status is already `" .. v.status .. "`"
							}
						})
					else
						local oldStatus = v.status
						v.status = parameters
						message.author:send({
							embed = {
								color = color.system,
								title = getRandomSkinTone("writing_hand") .. " Status change!",
								description = "You just changed the status\n\n`" .. oldStatus .. "`\n\nto\n\n`" .. v.status .. "`"
							}
						})
						save("team", data.team)
					end
					break
				end
			end
		end
	end
}
commands["translate"] = {
	description = { "Sends the translation for the requester.", { "!translate `#request_id translation_language ```translation_content``` `" } },
	permission = ePermissions.team,
	channel = 'public-translations',
	log = true,
	allowPrivateMessage = false,
	exe = function(message, parameters)
		local helpMessage = "\nType `!translate ?` to read the possible parameters."
		if parameters then
			local id, currentLanguage, content

			id = parameters:match("#(%d+)")
			if tonumber(id) then
				if database.unhandledRequests[id] then
					currentLanguage = parameters:match("[ \n]+(%S+)")

					if currentLanguage then
						currentLanguage = currentLanguage:upper()

						local found, index = table.find(database.unhandledRequests[id].languages, currentLanguage)
						if found then
							local output
							output, content = parameters:match("[ \n]+`(`?`?)(.*)%1`")
							if content and #content > 1 then
								table.remove(database.unhandledRequests[id].languages, index)

								local totalDay, totalHour, totalMinute = os.transformTime(os.time() - database.unhandledRequests[id].requestTime)
								local calendarString = (totalDay == 0 and "" or totalDay.." days, ") .. (totalHour == 0 and "" or totalHour.." hours and ") .. (totalMinute == 0 and 1 or totalMinute) .. " minutes"

								local points = totalDay > 7 and 0 or totalDay >= 1 and 1 or math.ceil(#database.unhandledRequests[id].content / (requestsSize[database.unhandledRequests[id].module and "module" or "regular"] / 5))

								if message.author.id ~= database.unhandledRequests[id].author.id then
									data.team[message.author.id].cookies = data.team[message.author.id].cookies + points
									data.team[message.author.id].translations = data.team[message.author.id].translations + 1
									message:reply({
										embed = {
											color = color.profile,
											description = "<@" .. message.author.id .. "> :cookie: `" .. data.team[message.author.id].cookies .. "` (`+" .. points .. "`)",
											footer = {
												text = calendarString
											}
										}
									})
								end

								save("data", database)
								save("team", data.team)

								local userLanguage = getUserLanguage(nil, true, database.unhandledRequests[id].author.id)

								translationMessages[message.id] = client:getUser(database.unhandledRequests[id].author.id):send({
									embed = {
										color = color.translation,
										description = getRandomEarth() .. " " .. string.format(userLanguage.translation, id, data.available_languages[currentLanguage], currentLanguage, (database.unhandledRequests[id].module and "Lua" or ""), content, calendarString)
									}
								})

								message.author:send({
									embed = {
										color = color.translation,
										description = "You translated the request **#" .. id .. "**! If you commited any typo, all you need to do to fix is to edit the message with the translation. Edit the __content__ within `."
									}
								})

								updateRequestMessage(id)
							else
								message.author:send({
									embed = {
										color = color.error,
										description = ":skull: | Invalid __translation_content__ parameter: There must be something translated, insert the translation." .. helpMessage
									}
								})
							end
						else
							message.author:send({
								embed = {
									color = color.error,
									description = ":skull: | Invalid __translation_language__ parameter: The language `" .. currentLanguage .. "` was not requested.\nThe request needs the following languages: " .. table.concat(database.unhandledRequests[id].languages, " - ", function(index, value)
										return "`" .. value .. "`"
									end)
								}
							})
						end
					else
						message.author:send({
							embed = {
								color = color.error,
								description = ":skull: | Invalid __translation_language__ parameter: You must insert the language you have used to translate the request.\nThe available languages are: " .. table.concat(data.available_languages, " - ", tostring, nil, nil, pairsByIndexes) .. "." .. helpMessage
							}
						})
					end

				else
					message.author:send({
						embed = {
							color = color.error,
							description = ":skull: | Invalid __request_id__ parameter: You must insert a valid ID. Type `!list` to check the available requests." .. helpMessage
						}
					})
				end
			else
				message.author:send({
					embed = {
						color = color.error,
						description = ":skull: | Invalid __request_id__ parameter: You must insert the request ID. Type `!list` to check the available requests." .. helpMessage
					}
				})
			end

		else
			message.author:send({
				embed = {
					color = color.error,
					description = "Hello, " .. message.author.name .. ". Your forgot to add parameters in this command." .. helpMessage
				}
			})
		end
	end
}
commands["word"] = {
	description = { "Gets a google translation of a short text.",
		{
			"(Detect content language)\n!word `language_to ```content``` `",
			"(Set content language)\n!word `language_from-language_to ```content``` `",
		}
	},
	permission = ePermissions.team,
	channel = eChannels.not_system,
	log = false,
	allowPrivateMessage = true,
	exe = function(message, parameters)
		if parameters and #parameters > 0 then
			local language, _, content = parameters:match("(.-)[ \n]+`(`?`?)(.*)%2`")
			if language and content and #content > 0 then
				language = language:lower()
				content = content:sub(1, 100)

				local languageReplace = {
					{"pt", "br"},
					{"he", "il"},
					{"ja", "jp"},
				}

				for k, v in next, languageReplace do
					language = language:gsub(v[2], v[1])
				end

				local head, body = http.request("GET", "https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20180406T014324Z.87adf2b8b3335e7c.212f70178f4e714754506277683f3b2cf308c272&text=" .. URLEncoded(content) .. "&lang=" .. language .. (language:find("%-") and "" or "&options=1"))
				body = json.decode(tostring(body))

				if body and body.text then
					body.lang = body.lang:lower()
					for k, v in next, languageReplace do
						body.lang = body.lang:gsub(v[1], v[2])
					end

					local from, to = body.lang:match("(.-)%-(.+)")

					from, to = from:upper(), to:upper()

					toDelete[message.id] = message:reply({
						embed = {
							color = color.translation,
							title = "Quick Translation",
							description = (data.available_languages[from] or "") .. "@**" .. from .. "**\n```\n" .. content .. "```" .. (data.available_languages[to] or "") .. "@**" .. to .. "**\n```\n" .. table.concat(body.text, "\n", nil, 1, 3) .. "```"
						}
					})
				end
			end
		end
	end,
}

	--[[ Module Translator ]]--
commands["hex"] = {
	description = { "Gets the hex of an emoji.", { "!hex `emoji`" } },
	permission = ePermissions.module,
	channel = eChannels.not_system,
	log = false,
	allowPrivateMessage = true,
	exe = function(message, parameters, _, toReturn)
		if parameters and #parameters > 0 then
			local hex = {}
			for k in parameters:gmatch(".") do
				hex[#hex + 1] = string.format("%X", k:byte())
			end
			local hexResult = "\\x" .. table.concat(hex, "\\x")
			local result = string.format("%s = %q", parameters, hexResult)

			if toReturn then
				return hexResult, result
			else
				toDelete[message.id] = message:reply({
					embed = {
						color = color.system,
						description = result
					}
				})
			end
		end
	end
}
commands["lua"] = {
	description = { "Executes a Lua chunk.", { "!lua ` ```code``` `" } },
	permission = ePermissions.module,
	channel = eChannels.not_system,
	log = true,
	allowPrivateMessage = true,
	exe = function(message, parameters)
		if not parameters then return end

		local foo
		foo, parameters = parameters:match("`(`?`?)(.*)%1`")

		if not parameters or #parameters == 0 then return end
		local lua_tag, final = parameters:lower():find("^lua\n+")
		if lua_tag then
			parameters = parameters:sub(final + 1)
		end

		local hasAccess = data.freeaccess[message.author.id]

		local dataLines = {}
		local repliedMessages = {}
		local ENV = getLuaEnv()
		ENV.discord = {
			authorId = message.author.id,
			authorName = message.author.fullname,
			messageId = message.id,
			delete = function(msgId)
				assert(msgId, "Missing parameters in discord.delete")

				local msg = message.channel:getMessage(msgId)
				assert(msg, "Message not found")

				local canDelete = msg.author.id == message.author.id
				if not canDelete then
					for i = 1, #repliedMessages do
						if repliedMessages[i].id == msgId then
							canDelete = true
							break
						end
					end
				end

				if canDelete then
					msg:delete()
				end
			end,
			http = function(url, header, body)
				assert(url, "Missing url link in discord.http")

				return http.request("GET", url, header, body)
			end,
			reply = function(text)
				assert(text, "Missing parameters in discord.reply")

				local msg = message:reply(text)
				repliedMessages[#repliedMessages + 1] = msg
				return msg.id
			end,
		}
		ENV.print = function(...)
			dataLines[#dataLines + 1] = printf(...)
		end

		if hasAccess then
			ENV.channel = message.channel
			ENV.message = message
		end

		-- Check for errors
		local func, syntaxErr = load(parameters, "TranslatorBot." .. message.author.name, 't', (hasAccess and devENV or moduleENV) + ENV)
		if not func then
			toDelete[message.id] = message:reply({
				embed = {
					color = color.luaerr,
					title = "[Lua] Error : SyntaxError",
					description = "```\n" .. syntaxErr .. "```"
				}
			})
			return
		end

		-- Runs the code
		local ms = os.clock()
		local success, runtimeErr = pcall(func)
		ms = (os.clock() - ms) * 1000

		if not success then
			toDelete[message.id] = message:reply({
				embed = {
					color = color.luaerr,
					title = "[Lua] Error : RuntimeError",
					description = "```\n" .. runtimeErr .. "```"
				}
			})
			return
		end

		local result = message:reply({
			embed = {
				color = color.lua,
				title = "[" .. message.member.name .. ".Lua] Loaded successfully!",
				description = "  ",
				footer = {
					text = "Script ran in " .. ms .. "ms."
				},
			}
		})

		local lines = splitByLine(table.concat(dataLines, "\n"))

		local listId = { }
		for id = 1, #lines do
			listId[#listId + 1] = message:reply({
				embed = {
					color = color.lua,
					description = lines[id]
				}
			})
		end

		if #listId == 0 then
			listId = repliedMessages
		else
			for k, v in next, repliedMessages do
				listId[#listId + 1] = v
			end
		end

		if #listId == 0 then
			listId = result
		else
			listId[#listId + 1] = result
		end

		toDelete[message.id] = listId
	end
}

	--[[ Leaders ]]--
commands["refuse"] = {
	description = { "Refuses a request.",
		{
			"!refuse `#request_id ```refuse_reason``` `",
			"!refuse `#request_id ```refuse_reason``` your_community `",
		}
	},
	permission = ePermissions.leader,
	channel = 'public-translations',
	log = true,
	allowPrivateMessage = false,
	exe = function(message, parameters)
		local helpMessage = "\nType `!refuse ?` to read the possible parameters."
		if parameters then
			local id, reason

			id = parameters:match("#(%d+)")
			if tonumber(id) then
				if database.unhandledRequests[id] then

					local output
					output, content = parameters:match("[ \n]+`(`?`?)(.*)%1`")
					if content and #content > 2 then
						local c = ""

						local community = parameters:match("`[ \n]+(.-)$")
						if community then
							community = community:upper()
							local found, index = table.find(database.unhandledRequests[id].languages, community)
							if found then
								table.remove(database.unhandledRequests[id].languages, index)
								c = data.available_languages[community]
							else
								message.author:send({
									embed = {
										color = color.error,
										description = ":skull: | Invalid __your_community__ parameter: The language `" .. community .. "` was not requested.\nYou cannot refuse this request."
									}
								})
								return
							end
						else
							if not getTranslatorPerm(message.author.id, perms.admin) then
								message.author:send({
									embed = {
										color = color.error,
										description = ":skull: | Invalid __your_community__ parameter: You are not allowed to refuse a request without community.",
									}
								})
								return
							end
						end

						client:getUser(database.unhandledRequests[id].author.id):send({
							embed = {
								color = color.error,
								description = ":x: | The request " .. c .. "`#" .. id .. "` has been refused :(\n```" .. content .. "```"
							}
						})

						if not community then
							database.unhandledRequests[id].languages = {}
						end
						updateRequestMessage(id)

						message:reply({
							embed = {
								color = color.error,
								description = ":x: | The request " .. c .. "`#" .. id .. "` has been refused!"
							}
						})

						save("data", database)
					else
						message.author:send({
							embed = {
								color = color.error,
								description = ":skull: | Invalid __refuse_reason__ parameter: There must be a reason to refuse this request." .. helpMessage
							}
						})
					end

				else
					message.author:send({
						embed = {
							color = color.error,
							description = ":skull: | Invalid __request_id__ parameter: You must insert a valid ID. Type `!list` to check the available requests." .. helpMessage
						}
					})
				end
			else
				message.author:send({
					embed = {
						color = color.error,
						description = ":skull: | Invalid __request_id__ parameter: You must insert the request ID. Type `!list` to check the available requests." .. helpMessage
					}
				})
			end

		else
			message.author:send({
				embed = {
					color = color.error,
					description = "Hello, " .. message.member.name .. ". Your forgot to add parameters in this command." .. helpMessage
				}
			})
		end
	end,
}
commands["setappstate"] = {
	description = { "Sets the current applications state on forums.", { "!setappstate `community open/closed`" } },
	permission = ePermissions.leader,
	channel = eChannels.not_system,
	log = true,
	allowPrivateMessage = false,
	exe = function(message, parameters)
		if parameters and #parameters > 0 then
			local community, state = string.match(parameters, "(..)[ \n]+(.+)")
			community = string.upper(tostring(community))

			state = string.lower(tostring(state))
			state = tonumber(state) or state

			if community and forumThreads[community] then -- check if the thread exists
				if state then
					local final_state = ""
					if state == 0 or state == "closed" then
						final_state = "closed"
					elseif state == 1 or state == "open" then
						final_state = "open"
					end

					if final_state ~= "" then
						local head, body = http.request("GET", "http://miceclan.com/translators/functions/setappstate?k=" .. HTTP_headers.mice_clan .. "&c=" .. string.lower(community) .. "&s=" .. final_state)

						if body then
							message:reply({
								content = "<@!" .. message.author.id .. ">",
								embed = {
									color = color.translation,
									description = "Applications for the community " .. community .. " are now **" .. final_state .. "**!"
								}
							})
						end
					end
				end
			else
				toDelete[message.id] = message:reply({
					content = "<@!" .. message.author.id .. ">",
					embed = {
						color = color.error,
						description = "The available languages with a thread are: " .. table.concat(forumThreads, " - ", tostring, nil, nil, pairsByIndexes)
					}
				})
			end
		end
	end
}

	--[[ Admin ]]--
commands["announce"] = {
	description = { "Makes a private announcement.", { "!announce `message`" } },
	permission = ePermissions.admin,
	channel = eChannels.all,
	log = true,
	allowPrivateMessage = true,
	exe = function(message, parameters, _, channel)
		if parameters and  #parameters > 0 then
			local msgchannel = client:getChannel(channel or channels['announcements'])

			msgchannel:send({
				content = (channel and "@here" or "@everyone"),
				embed = {
					color = color.message,
					description = parameters
				}
			})
		end
		message:delete()
	end
}
commands["birthday"] = {
	description = { "Sets the birthday date of a member.",
		{
			"(Insert)\n!birthday `@username day month`",
			"(Remove)\n!birthday `@username 0 0`",
		}
	},
	permission = ePermissions.admin,
	channel = eChannels.not_system,
	log = false,
	allowPrivateMessage = false,
	exe = function(message, parameters)
		if parameters and  #parameters > 0 then
			local user, day, month = parameters:match("<@!?(%d+)>[ \n]+(%d%d?)[ \n]+(%d%d?)")
			day, month = tonumber(day), tonumber(month)
			if user and day and month and data.team[user] then
				if day == 0 and month == 0 then
					data.team[user].birthdayDate = {"", ""}
					message:reply({
						embed = {
							color = color.system,
							description = "`" .. data.team[user].user .. "`'s birthday date was removed."
						}
					})
				else
					day, month = math.clamp(day, 1, 31), math.clamp(month, 1, 12)

					data.team[user].birthdayDate = { string.format("%02d/%02d", day, month) }
					data.team[user].birthdayDate[2] = getYear(data.team[user].birthdayDate[1])

					message:reply({
						embed = {
							color = color.system,
							description = "`" .. data.team[user].user .. "`'s birthday date was set to `" .. data.team[user].birthdayDate[1] .. "`"
						}
					})
				end
				save("team", data.team)
			end
		end
	end
}
commands["member"] = {
	description = { "Adds a new member in the database.", { "!member `@username`" } },
	permission = ePermissions.admin,
	channel = eChannels.all,
	log = true,
	allowPrivateMessage = false,
	exe = function(message, parameters)
		if parameters then
			parameters = string.match(tostring(parameters), "<@!?(%d+)>")

			if parameters then
				local member = message.guild:getMember(parameters)
				if member then
					generateMember(message, member)
				end
			end
		end

		message:delete()
	end
}
commands["module"] = {
	description = { "Adds a new member in the module team.", { "!module `@username`" } },
	permission = ePermissions.admin,
	channel = eChannels.all,
	log = true,
	allowPrivateMessage = false,
	exe = function(message, parameters)
		if parameters then
			parameters = string.match(tostring(parameters), "<@!?(%d+)>")

			if parameters then
				local member = message.guild:getMember(parameters)

				if member then
					if data.team[parameters] then
						if not member:hasRole(data.roles["Module"]) then
							data.team[parameters].rank[#data.team[parameters].rank + 1] = data.roles["Module"]
							member:addRole(data.roles["Module"])
						end
						local hireMessage = {
							embed = {
								color = color.system,
								description = "`" .. data.team[parameters].user .. "` is the newest Module Translator :robot:\n```Lua\nprint(\"Welcome!\")```"
							}
						}

						client:getChannel(channels['announcements']):send(hireMessage):addReaction("\xE2\x9A\x99")
						client:getChannel(channels['public-announcements']):send(hireMessage):addReaction("\xE2\x9A\x99")
					else
						message:reply({
							embed = {
								color = color.error,
								description = ":fire: | <@!" .. member.id .. "> is not a Translator.\n\nIssues? Contact `Bolodefchoco`"
							}
						})
					end
				else
					local user = client:getUser(parameters)
					message:reply({
						embed = {
							color = color.error,
							description = ":fire: | `" .. (user and user.fullname or parameters) .. "` is not a member of this server.\n\nIssues? Contact `Bolodefchoco`"
						}
					})
				end
			end
		end

		message:delete()
	end
}
commands["publish"] = {
	description = { "Makes a public announcement.", { "!publish `message`" } },
	permission = ePermissions.admin,
	channel = eChannels.all,
	log = true,
	allowPrivateMessage = true,
	exe = function(message, parameters)
		commands["announce"].exe(message, parameters, nil, channels['public-announcements'])
	end
}
commands["remove"] = {
	description = { "Removes a member from the database.", { "!remove `@username`" } },
	permission = ePermissions.admin,
	channel = eChannels.all,
	log = true,
	allowPrivateMessage = false,
	exe = function(message, parameters, _, member)
		if member then
			parameters = "<@!" .. member.id .. ">"
		else
			message:delete()
		end

		if parameters then
			parameters = string.match(tostring(parameters), "<@!?(%d+)>")

			if parameters then
				local user
				if not member then
					user = message.guild:getMember(parameters)
				end

				if data.team[parameters] then
					local fireMessage = {
						embed = {
							color = color.system,
							description = ":scream: The member " .. getIcon(parameters) .. " " .. table.concat(data.team[parameters].team, " ", function(index, value)
								return data.available_languages[data.roles[value]]
							end) .. " `" .. tostring(data.team[parameters].user) .. "` left the team. :(\nLeft " .. getRandomEarth() .. " `" .. data.team[parameters].translations .. "` | :cookie: `" .. data.team[parameters].cookies .. "`"
						}
					}

					client:getChannel(channels['announcements']):send(fireMessage)
					client:getChannel(channels['public-announcements']):send(fireMessage)

					if not member and user then
						for k, v in next, {data.team[parameters].rank, data.team[parameters].team} do
							for i, j in next, v do
								user:removeRole(j)
							end
						end
						user:addRole(data.roles["Ex-translator"])
					end

					data.team[parameters] = nil
					save("team", data.team)
				elseif not member then
					local o = user or client:getUser(parameters)
					message.author:send({
						embed = {
							color = color.error,
							description = ":fire: | `" .. o.name .. "` is not a member.\n\nIssues? Contact `Bolodefchoco`"
						}
					})
				end
			end
		end
	end
}
commands["setdata"] = {
	description = { "Sets the translations and cookies of a member.", { "!setdata `@member add/sub_translations add/sub_cookies`" } },
	permission = ePermissions.admin,
	channel = 'public-translations',
	log = true,
	allowPrivateMessage = false,
	exe = function(message, parameters)
		local id, add_translations, add_cookies = string.match(tostring(parameters), "<@!?(.-)>[ \n]+(%-?%d+)[ \n]+(%-?%d+)")
		add_translations, add_cookies = tonumber(add_translations), tonumber(add_cookies)

		if id and add_translations and add_cookies then
			if data.team[id] then
				local reset = add_translations == 0 and add_cookies == 0
				data.team[id].translations = reset and 0 or math.clamp(data.team[id].translations + add_translations, 0, 999)
				data.team[id].cookies = reset and 0 or math.clamp(data.team[id].cookies + add_cookies, 0, 999)

				save("team", data.team)

				commands["profile"].exe(message, id, translations.en, false)
			end
		end
	end
}
commands["username"] = {
	description = { "Changes the username of a member.", { "!username `@user new_name`" } },
	permission = ePermissions.admin,
	channel = eChannels.not_system,
	log = true,
	allowPrivateMessage = false,
	exe = function(message, parameters)
		message:delete()

		if parameters then
			local id, newNickname = string.match(tostring(parameters), "<@!?(%d+)>[ \n]+(%S+)")

			if id and newNickname and data.team[id] then
				local oldNickname = data.team[id].user

				data.team[id].user = newNickname
				message.guild:getMember(id):setNickname(newNickname)

				save("team", data.team)

				message:reply({
					embed = {
						color = color.system,
						description = "`" .. oldNickname .. "` has been renamed to `" .. data.team[id].user .. "` successfully"
					}
				})
			end
		end
	end
}
commands["warn"] = {
	description = { "Warns, kicks or bans a user.",
		{
			"(Premade reasons)\n!warn `@username reason_id`",
			"(Other reasons)\n!warn `@username ```Reason``` `"
		}
	},
	permission = ePermissions.admin,
	channel = eChannels.chat,
	log = true,
	allowPrivateMessage = false,
	exe = function(message, parameters)
		if parameters then
			local id, reason = string.match(tostring(parameters), "<@!?(%d+)>[ \n]+(.+)")

			if id and reason then
				if not data.team[id] then
					local reasonText
					local check_reason = tonumber(reason)
					reason = check_reason or reason

					if check_reason then
						reasonText = warningReasons[reason]
					else
						local output
						output, reason = reason:match("`(`?`?)(.*)%1`")
					end

					if reason then
						local userLanguage = getUserLanguage(nil, true, id)

						if not blacklist[id] then
							blacklist[id] = {
								warnings = 0,
								reasons = ""
							}
						end

						blacklist[id].reasons = blacklist[id].reasons .. (check_reason or "0")

						blacklist[id].warnings = blacklist[id].warnings + 1
						if blacklist[id].warnings % banConsts.warning_for_kick == 0 then
							local kicks = math.floor(blacklist[id].warnings / banConsts.warning_for_kick)

							if kicks % banConsts.kick_for_ban == 0 then
								blacklist.blacklisted[id] = client:getUser(id).fullname
								message.guild:banUser(id)

								client:getUser(id):send({
									embed = {
										color = color.error,
										description = ":skull: " .. string.format(userLanguage.ban, (reasonText or reason)) .. "\n\n" .. userLanguage.unfair_warn
									}
								})
								client:getChannel(channels['ban-log']):send({
									embed = {
										color = color.system,
										description = ":skull: <@" .. id .. "> **(" .. math.floor(kicks / banConsts.kick_for_ban) .. ")** was banned from this server: ```" .. (reasonText or reason) .. "```",
										footer = { text = "Warn from  " .. message.member.name }
									}
								})
							else
								message.guild:kickUser(id)

								client:getUser(id):send({
									embed = {
										color = color.error,
										description = ":boot: " .. string.format(userLanguage.kick, (reasonText or reason)) .. "\n\n" .. userLanguage.unfair_warn
									}
								})
								client:getChannel(channels['ban-log']):send({
									embed = {
										color = color.system,
										description = ":fire: <@" .. id .. "> **(" .. (banConsts.kick_for_ban + (kicks % -banConsts.kick_for_ban)) .. "/" .. (banConsts.kick_for_ban - 1) .. ")** was kicked from this server: ```" .. (reasonText or reason) .. "```",
										footer = { text = "Warn from  " .. message.member.name }
									}
								})
							end
						else
							local total = banConsts.warning_for_kick + (blacklist[id].warnings % -banConsts.warning_for_kick)
							client:getUser(id):send({
								embed = {
									color = color.error,
									description = ":radioactive: " .. string.format(userLanguage.sanction, total, (banConsts.warning_for_kick - 1), (reasonText or reason)) .. "\n\n" .. userLanguage.unfair_warn
								}
							})
							client:getChannel(channels['ban-log']):send({
								embed = {
									color = color.system,
									description = ":fire: <@" .. id .. "> **(" .. total .. "/" .. (banConsts.warning_for_kick - 1) .. ")** got a sanction: ```" .. (reasonText or reason) .. "```",
									footer = { text = "Warn from  " .. message.member.name }
								}
							})
						end

						save("blacklist", blacklist)
					else
						message:reply({
							embed = {
								color = color.error,
								description = ":skull: | #reason_id not found!"
							}
						})
					end
				end
			end
		end

		message:delete()
	end
}
commands["whitelist"] = {
	description = { "Unban a user.", { "!whitelist `user_id`" } },
	permission = ePermissions.admin,
	channel = eChannels.chat,
	log = true,
	allowPrivateMessage = false,
	exe = function(message, parameters)
		if parameters and tonumber(parameters) then
			if blacklist.blacklisted[parameters] then
				message.guild:unbanUser(id)

				client:getChannel(channels['ban-log']):send({
					embed = {
						color = color.system,
						description = ":warning: `" .. blacklist.blacklisted[parameters] .. "` **(" .. math.floor(blacklist[parameters].kicks / banConsts.kick_for_ban) .. ")** was unbanned!"
					}
				})
				blacklist.blacklisted[parameters] = nil

				save("blacklist", blacklist)
            
			else
				local user = client:getUser(parameters)
				message:reply({
					embed = {
						color = color.error,
						description = ":skull: | `" .. (user and user.fullname or "?") .. "` is not banned."
					}
				})
			end
		end

		message:delete()
	end
}

	--[[ Debug & Developer ]]--
commands["channels"] = {
	description = { "Lists all the channels.", { "!channels" } },
	permission = ePermissions.freeaccess,
	channel = eChannels.all,
	log = false,
	allowPrivateMessage = false,
	exe = function(message)
		local ch = ""

		for channel in message.guild.textChannels:iter() do
			ch = ch .. string.format("['%s'] = '%s',\n", channel.name, channel.id)
		end

		local lines = splitByLine(ch)

		local ids = { }
		for id = 1, #lines do
			ids[#ids + 1] = message:reply({
				embed = {
					color = color.system,
					description = lines[id]
				}
			})
		end

		toDelete[message.id] = ids
	end
}
commands["cleareact"] = {
	description = { "Clears the reactions in #welcome. Adds who needs to be added and removes who needs to be removed.", { "!cleareact" } },
	permission = ePermissions.freeaccess,
	channel = eChannels.not_system,
	log = true,
	allowPrivateMessage = false,
	exe = function(message)
		-- getUsers(100) gets the first 100 members. default=25. FUUUU if it is 100+
		local msg = client:getChannel(channels['welcome']):getMessage('418532536625659917')
    
		for member in msg.guild.members:iter() do
			for langName, lang in next, data.available_languages do
				local roleName = "public-" .. langName:lower()
				local role = data.roles[roleName]

				if member:hasRole(role) then
					local reaction = msg.reactions:get(lang)

					if not reaction then
						addLog("[MemberClearRem] [Error] The reaction [" .. langName .. "] was not found.", 41, 41, 40)
						break
					end

					if not reaction:getUsers(100):get(member.id) then
						member:removeRole(role)
						addLog("[MemberClearRem] [" .. member.name .. "] had the role [" .. roleName .. "] removed.", 42, 40, 40)
					end
				end
			end
		end

		for reaction in msg.reactions:iter() do
			for user in reaction:getUsers(100):iter() do
				if not user.bot then
					local member = msg.guild:getMember(user.id)

					local found, index = table.find(data.available_languages, reaction.emojiName)

					if not found then
						addLog("[MemberClearAdd] [Error] The reaction [" .. reaction.emojiName .. "] was not found in the flag table.", 41, 41, 40)
						break
					end

					local roleName = "public-" .. index:lower()
					local role = data.roles[roleName]
    
					if not member then
						msg:removeReaction(reaction.emojiName, user.id)
						addLog("[MemberClearRem] [" .. user.fullname .. "] is not in the server anymore.", 41, 40)
					elseif not member:hasRole(role) then
						member:addRole(role)
						addLog("[MemberClearRem] [" .. user.fullname .. "] got the role [" .. roleName .. "].", 41, 40, 40)
					end
				end
			end
		end

		message:reply({
			embed = {
				color = color.system,
				description = "The reactions were refreshed!"
			}
		})
		message:delete()
	end
}
commands["community"] = {
	description = { "Creates a new community.", { "!community `flag`" } },
	permission = ePermissions.freeaccess,
	channel = 'bot-discussion',
	log = true,
	allowPrivateMessage = false,
	exe = function(message, parameters)
		if parameters and #parameters == 2 then
			parameters = parameters:upper()
			parameters = parameters:match("%u%u")

			if parameters and not data.available_languages[parameters] then
				local newRole = message.guild:createRole(parameters)
				newRole:setColor(color.profile)
				newRole:moveUp(table.count(data.available_languages) + 4)

				newRole:enableMentioning()
				newRole:enablePermissions(
					discordia.enums.permission.readMessages,
					discordia.enums.permission.sendMessages,
					discordia.enums.permission.sendTextToSpeech,
					discordia.enums.permission.embedLinks,
					discordia.enums.permission.attachFiles,
					discordia.enums.permission.useExternalEmojis,
					discordia.enums.permission.addReactions,
					discordia.enums.permission.connect,
					discordia.enums.permission.speak,
					discordia.enums.permission.useVoiceActivity
				)
				newRole:disablePermissions(discordia.enums.permission.changeNickname)

				local publicRole = message.guild:createRole("public-" .. parameters:lower())
				publicRole:enablePermissions(
					discordia.enums.permission.sendMessages,
					discordia.enums.permission.sendTextToSpeech,
					discordia.enums.permission.embedLinks,
					discordia.enums.permission.attachFiles,
					discordia.enums.permission.useExternalEmojis,
					discordia.enums.permission.addReactions,
					discordia.enums.permission.connect,
					discordia.enums.permission.speak,
					discordia.enums.permission.useVoiceActivity
				)
				publicRole:disablePermissions(discordia.enums.permission.changeNickname)

				local newCategory = message.guild:createCategory(parameters)

				local newChannel = message.guild:createTextChannel("discussions")
				newChannel:setCategory(newCategory.id)

				local newPublicChannel = message.guild:createTextChannel(parameters:lower() .. "-public")
				newPublicChannel:setCategory('418482673921687553') -- public

				local perms
				-- Category perms
				perms = newCategory:getPermissionOverwriteFor(newRole)
				perms:setAllowedPermissions(discordia.enums.permission.readMessages)
				perms = newCategory:getPermissionOverwriteFor(message.guild:getRole('354402019458547712')) -- everyone
				perms:setDeniedPermissions(discordia.enums.permission.readMessages)

				perms = newPublicChannel:getPermissionOverwriteFor(newRole)
				perms:setAllowedPermissions(discordia.enums.permission.readMessages)
				perms = newPublicChannel:getPermissionOverwriteFor(publicRole)
				perms:setAllowedPermissions(
					discordia.enums.permission.readMessages,
					discordia.enums.permission.sendMessages,
					discordia.enums.permission.readMessageHistory
				)
				perms = newPublicChannel:getPermissionOverwriteFor(message.guild:getRole('354402019458547712')) -- everyone
				perms:setDeniedPermissions(discordia.enums.permission.readMessages)

				local flag = ":flag_" .. parameters:lower() .. ":"
				local hex, hexResult = commands["hex"].exe(message, flag, nil, true)

				message:reply({
					embed = {
						color = color.system,
						title = "Community " .. parameters .. " added successfully!",
						description = "data.roles['" .. newRole.id .. "'] = \"" .. parameters .. "\"\ndata.roles['" .. publicRole.id .. "'] = \"" .. publicRole.name .. "\"\n\nPublic channel : '" .. newPublicChannel.id .. "'\n\n" .. tostring(hexResult) .. "\n" .. parameters .. " = \"" .. tostring(hex) .. "\","
					}
				})

				local announceText = flag .. " `" .. parameters .. "`"
				-- Edit welcome message
				local announce = client:getChannel(channels['welcome']):getMessage('418532536625659917')
				if announce then
					announce:setContent(announce.content .. "\t" .. announceText)
					announce:addReaction(hex)
				end

				-- Announce
				commands["publish"].exe(message, announceText .. " is the newest community on this server! Welcome to the new member(s)!")

				-- Refresh because of the reactionAddUncached
				commands["refresh"].exe(message)
			else
				message:reply({
					embed = {
						color = color.error,
						description = ":fire: | Invalid community `" .. tostring(parameters) .. "` ~ invalid or already exists"
					}
				})
			end
		end
	end
}
commands["del"] = {
	description = { "Deletes messages.", { "!del `after_message_id quantity`" } },
	permission = ePermissions.freeaccess,
	channel = eChannels.all,
	log = false,
	allowPrivateMessage = true,
	exe = function(message, parameters)
		if parameters and #parameters > 0 then
			local messageId = string.match(parameters, "^(%d+)")
			local limit = string.match(parameters, "[\n ]+(%d+)$")
			if limit then limit = math.clamp(limit, 1, 100) end

			if message.channel:getMessage(messageId) then
				for msg in message.channel:getMessagesAfter(messageId, limit):iter() do
					msg:delete()
				end
			end
		end
	end
}
commands["exit"] = {
	description = { "Disables the bot", { "!exit" } },
	permission = ePermissions.freeaccess,
	channel = eChannels.all,
	log = true,
	allowPrivateMessage = true,
	exe = function(message)
		saveDatabases()
		message:delete()
		addLog("[CONNECTION] Disconnected from '" .. client.user.fullname .. "'", 41)
		os.exit()
	end
}
commands["refresh"] = {
	description = { "Refreshes the bot", { "!refresh" } },
	permission = ePermissions.freeaccess,
	channel = eChannels.all,
	log = true,
	allowPrivateMessage = true,
	exe = function(message)
		saveDatabases()
		message:delete()
		os.execute("luvit bot.lua")
		os.exit()
	end
}
commands["roles"] = {
	description = { "Lists all the roles.", { "!roles" } },
	permission = ePermissions.freeaccess,
	channel = eChannels.all,
	log = false,
	allowPrivateMessage = false,
	exe = function(message, _, __, alternativeMessage)
		local roles = ""
		for role in message.guild.roles:iter() do
			roles = roles .. string.format(alternativeMessage or "data.roles['%s'] = \"%s\"\n", role.id, role.name)
		end

		local lines = splitByLine(roles)

		local ids = { }
		for id = 1, #lines do
			ids[#ids + 1] = message:reply({
				embed = {
					color = color.system,
					description = lines[id]
				}
			})
		end

		toDelete[message.id] = ids
	end
}
commands["save"] = {
	description = { "Saves the current bot source on Github.",
		{
			"(All the project)\n!save",
			"(Specific file)\n!save `filename`"
		}
	},
	permission = ePermissions.freeaccess,
	channel = eChannels.all,
	log = true,
	allowPrivateMessage = true,
	exe = function(message, parameters)
		saveDatabases()
		for i = 1, #sourceFiles do
			if (not parameters or sourceFiles[i] == parameters) and not githubCommit(sourceFiles[i]) then
				addLog("[Save] [Error] GET didn't work as expected in " .. tostring(sourceFiles[i]), 42, 41)
			end
		end

		commands["refresh"].exe(message)
	end
}
commands["suggestion"] = {
	description = { "Sets the reactions in a suggestion.", { "!suggestion `suggestion_message_id suggestion_state`\n\nStates =>\n0 = Will be discussed\n1 = Under development\n2 = Denied\n3 = Implemented" } },
	permission = ePermissions.freeaccess,
	channel = 'suggestions',
	log = false,
	allowPrivateMessage = false,
	exe = function(message, parameters)
		local id, state = parameters:match("(%d+)[ \n]+(%-?%d)")
		state = tonumber(state)

		if id and state then
			state = math.clamp(state, -1, 3)

			local msg = message.channel:getMessage(id)
			if msg then
				msg:clearReactions()

				if state >= 0 then
					for i = 1, #suggestionReactions[state][2] do
						msg:addReaction(suggestionReactions[state][2][i])
					end

					-- Log
					local log
					if state == 2 or state == 3 then
						if suggestions[msg.id] then
							log = client:getChannel(channels['suggestion-logs']):getMessage(suggestions[msg.id])
							if log then
								log:delete()
							end

							suggestions[msg.id] = nil
						end
					else
						if suggestions[msg.id] then
							log = client:getChannel(channels['suggestion-logs']):getMessage(suggestions[msg.id])

							if log then
								log.embed.description = log.embed.description:gsub("Status: `.-`", "Status: `" .. suggestionReactions[state][1] .. "`")
								log:setEmbed(log.embed)
							end
						else
							local embed = {
								color = color.message,
								description = string.format("Author: <@!%s>\nID: [`%s`](https://discordapp.com/channels/354402019458547712/418931162413531147?jump=%s)\nStatus: `%s`\nContent: ```\n%s```\nImage: ", msg.author.id, msg.id, msg.id, suggestionReactions[state][1], msg.content, "%s")
							}

							local img = (msg.attachment and msg.attachment.url) or (msg.embed and msg.embed.image and msg.embed.image.url)
							if img then
								embed.image = {
									url = img
								}
							else
								embed.description = embed.description .. "N/A"
							end

							log = client:getChannel(channels['suggestion-logs']):send({ embed = embed })
							suggestions[msg.id] = log.id
						end
					end

					save("suggestions", suggestions)
				end
			end
		end

		message:delete()
	end
}
commands["update"] = {
	description = { "Updates the bot source.", { "!update" } },
	permission = ePermissions.freeaccess,
	channel = eChannels.all,
	log = true,
	allowPrivateMessage = true,
	exe = function(message)
		local body

		for i = 1, #sourceFiles do
			body = githubFile(sourceFiles[i])
			if body and type(body) == "table" and body.content then
				body = body.content

				file.editFile(sourceFiles[i], "w+", decodeBase64(body))
			else
				addLog("[Update] [Error] at " .. tostring(sourceFiles[i]), 42, 41)
			end
		end

		commands["refresh"].exe(message)
	end
}

--[[ Events ]]--
client:on("ready", function()
	-- Data
	data.team = getDatabase("team")
	data.user = getDatabase("user")
	database = getDatabase("data")
	blacklist = getDatabase("blacklist")
	suggestions = getDatabase("suggestions")

	-- Color
	color.profile = client:getGuild('354402019458547712'):getRole(data.roles["Translator"]).color -- Guild ID

	-- Limits
	local restricted_G = table.clone(_G, ENVrestrictions)
	local restricted_Gmodule = table.clone(restricted_G, moduleENVrestrictions)

	restricted_G._G = restricted_G
	restricted_Gmodule._G = restricted_Gmodule

	moduleENV = setmetatable({}, {
		__index = setmetatable({
			channels = table.deepcopy(channels),

			data = table.deepcopy({ available_languages = data.available_languages, roles = data.roles, freeaccess = data.freeaccess }),

			forumThreads = table.copy(forumThreads),

			os = { clock = os.clock, date = os.date, difftime = os.difftime, time = os.time, transformTime = os.transformTime },

			tfm = table.deepcopy(tfm),
			translations = table.deepcopy(translations),

			warningReasons = table.deepcopy(warningReasons),
		}, {
			__index = restricted_Gmodule
		}),
		__add = meta.__add
	})

	devENV = setmetatable({}, {
		__index = setmetatable({
			addLog = addLog,

			birthday = birthday,
			blacklist = blacklist,

			channels = channels,
			client = client,
			commands = commands,
			currency = currency,

			data = data,
			database = database,
			discordia = discordia,

			file = file,
			forumThreads = forumThreads,

			getUserPerm = getUserPerm,
			githubCommit = githubCommit,
			githubFile = githubFile,

			http = http,

			memes = memes,

			printf = print,

			save = save,
			saveDatabases = saveDatabases,
			sourceFiles = sourceFiles,
			suggestions = suggestions,

			tfm = tfm,
			translations = translations,

			updateCurrency = updateCurrency,
			updateRequestMessage = updateRequestMessage,

			warningReasons = warningReasons,
		}, {
			__index = restricted_G
		}),
		__add = meta.__add
	})

	clock:start()

	addLog("[CONNECTION] Running as '" .. client.user.fullname .. "'", 42)

	messageTimer = os.time() + 2
end)

local eventMessage = function(message)
	if databases > 0 then return end

	-- Skip bot messages
	if message.author.bot then return end

	if table.find(channels['delete-content'], message.channel.id) and not data.freeaccess[message.author.id] then
		message:delete()
		return
	end

	-- Message messageTimer
	if messageTimer > os.time() then return end

	local isPrivateMessage = message.channel.type == 1

	-- Bot ping
	if message.content == "<@399727277744848907>" then
		message:reply({
			content = "<@!" .. message.author.id .. ">",
			embed = {
				color = color.help,
				description = string.format(getUserLanguage(message, isPrivateMessage).help_message, message.author.id, "")
			}
		})
		return
	end

	-- Command with parameters
	local command, parameters = message.content:match("^!(.-)[ \n]+(.*)")
	-- Single command
	command = command or message.content:match("^!(.+)")

	if not command then return end

	command = command:lower()
	parameters = (parameters and parameters ~= "") and parameters
	parameters = parameters and string.trim(parameters)

	for cmd, list in next, commands do
		if command == cmd then
			local execute = getUserPerm(list.permission, message.author.id)

			if not execute then return end

			local userLanguage = getUserLanguage(message, isPrivateMessage)

			if parameters == "?" then
				local description = (userLanguage.command_descriptions[command] or list.description)
				message.author:send({
					embed = {
						color = color.help,
						title = "[" .. ePermissions(list.permission) .. "] " .. userLanguage.help .. " -> !" .. command,
						description = description[1] .. "\n\n" .. userLanguage.command .. ":\n\t● " .. table.concat(description[2], "\n\n\t● ")
					}
				})
				message:delete()
				return
			end

			-- Channel and private message
			if not data.freeaccess[message.author.id] and (not list.allowPrivateMessage or (list.allowPrivateMessage and not isPrivateMessage)) then
				if channels[list.channel] then
					execute = message.channel.id == channels[list.channel]
				else
					if list.channel == eChannels.chat then
						execute = table.find(channels['public-channel'], message.channel.id) or table.find(channels['off-topic'], message.channel.id) or table.find(channels['chat'], message.channel.id)
					elseif list.channel == eChannels.private_message then
						execute = isPrivateMessage
					elseif list.channel == eChannels.not_system then
						execute = not table.find(channels['system'], message.channel.id)
					end
				end
			end

			if execute then
				messageTimer = os.time() + .05

				if list.log then
					local info = string.format("[%s] [%s - %s] !%s %s", (isPrivateMessage and "Private" or "Public"), (message.member and message.member.name or message.author.name), message.author.id, command, parameters or "")
					addLog(info, 33, 40)
				end

				local success, err = pcall(list.exe, message, parameters, userLanguage)
				if not success then
					message:reply({
						embed = {
							color = color.luaerr,
							title = "Command ~ Error!",
							description = "```\n" .. err .. "```"
						}
					})
				end
			end

			return
		end
	end
end

client:on("messageCreate", eventMessage)
client:on("messageUpdate", function(message)
	if databases > 0 then return end

	if translationMessages[message.id] then
		local _, edition = message.content:match("[ \n]+`(`?`?)(.*)%1`")

		if edition and #edition > 0 then
			translationMessages[message.id].embed.description = translationMessages[message.id].embed.description:gsub(": ```\n.*```\n", function()
				return ": ```\n" .. tostring(edition) .. "```\n"
			end, 1)
			client:getChannel(translationMessages[message.id].channel):getMessage(translationMessages[message.id].id):setEmbed(translationMessages[message.id].embed)
		end
		return
	end

	if toDelete[message.id] then
		toDelete(message)
	end

	eventMessage(message)
end)
client:on("messageDelete", function(message)
	if databases > 0 then return end
	if translationMessages[message.id] then
		translationMessages[message.id] = nil
		return
	elseif toDelete[message.id] then
		toDelete(message)
	else
		if message.author == client.user then return end

		if message.content:sub(1, 1) ~= "!" then
			local member = message.member and message.member.name or message.author.fullname

			client:getChannel(channels['deleted-messages']):send({
				embed = {
					color = color.system,
					title = os.date("%c"),
					description = getRandomSkinTone("writing_hand") .. " | **" .. member .. "** deleted their message in <#" .. message.channel.id .. "> ```\n" .. (message.embed and message.embed.description or message.content):sub(1, 1810) .. "```"
				}
			})
		end
	end
end)

client:on("reactionAddUncached", function(channel, messageID, hash, userID)
	if databases > 0 then return end
	if userID == client.user.id then return end

	if channel.id == channels['welcome'] then
		for k, v in next, data.available_languages do
			if v == hash then
				channel.guild:getMember(userID):addRole(data.roles["public-" .. k:lower()])
				return
			end
		end
	end
end)
client:on("reactionRemoveUncached", function(channel, messageID, hash, userID)
	if databases > 0 then return end
	if userID == client.user.id then return end

	if channel.id == channels['welcome'] then
		for k, v in next, data.available_languages do
			if v == hash then
				channel.guild:getMember(userID):removeRole(data.roles["public-" .. k:lower()])
				return
			end
		end
	end
end)

client:on("reactionAdd", function(reaction, userID)
	if databases > 0 then return end
	if userID == client.user.id then return end

	local success, err = pcall(function(reaction, userID)
		local channel = reaction.message.channel
		local messageID = reaction.message.id
		local hash = reaction.emojiName

		if playingAkinator[userID] then
			if playingAkinator[userID].message.id == messageID then
				if playingAkinator[userID].canExe then
					playingAkinator[userID].canExe = false

					local found, answer = table.find(playingAkinator.__REACTIONS, hash)
					if found then
						local update, addResultReaction, query, subquery, head, body = false, true, "base=0&channel=".. playingAkinator[userID].data.channel .."&session=".. playingAkinator[userID].data.session .."&signature=".. playingAkinator[userID].data.signature
						subquery = query .. "&step=".. playingAkinator[userID].data.step

						local checkAnswer = answer == 'ok'
						if checkAnswer then
							body = playingAkinator[userID].lastBody
						else
							if answer == #playingAkinator.__REACTIONS then
								head, body = http.request("GET", "http://" .. playingAkinator[userID].lang .. "/ws/cancel_answer.php?" .. subquery)
							else
								head, body = http.request("GET", "http://" .. playingAkinator[userID].lang .. "/ws/answer.php?" .. subquery .. "&answer=" .. (answer-1))
							end
							body = xml:ParseXmlText(tostring(body))
						end

						if body and body.RESULT then
							playingAkinator[userID].data.step = body.RESULT.PARAMETERS.STEP:value()

							local userLanguage = translations[playingAkinator[userID].textLang or "en"]

							if playingAkinator[userID].data.step == 79 then
								checkAnswer = checkAnswer or (playingAkinator[userID].currentRatio and playingAkinator[userID].currentRatio >= 75)
							else
								playingAkinator[userID].currentRatio = (playingAkinator[userID].data.step == 78) and body.RESULT.PARAMETERS.PROGRESSION:value()
							end

							local msg = channel:getMessage(messageID)

							if body.RESULT.COMPLETION:value() == "KO - TIMEOUT" then
								msg.embed.description = ":x: **" .. userLanguage.akinator_system.timeout.title .. "**\n\n" .. userLanguage.akinator_system.timeout.message .. " :confused:"
								addResultReaction = false
							elseif not checkAnswer and body.RESULT.COMPLETION:value() == "WARN - NO QUESTION" then
								msg.embed.description = ":x: **" .. userLanguage.akinator_system.fail.title .. "**\n\n" .. userLanguage.akinator_system.fail.message
								msg.embed.image = { url = "https://a.ppy.sh/5790113_1464841858.png" }
							else
								if not checkAnswer and body.RESULT.PARAMETERS.PROGRESSION:value() < playingAkinator[userID].ratio then
									-- getActivity works for that too
									msg.embed.description = string.format("```%s```\n%s\n\n%s", body.RESULT.PARAMETERS.QUESTION:value(), playingAkinator[userID].cmds, getRate(body.RESULT.PARAMETERS.PROGRESSION:value()))
									msg.embed.footer.text = userLanguage.akinator_system.step:format((playingAkinator[userID].data.step or 0) + 1)
									update = true
								else
									head, body = http.request("GET", "http://" .. playingAkinator[userID].lang .. "/ws/list.php?" .. query .. "&step=" .. playingAkinator[userID].data.step .. "&size=1&max_pic_width=360&max_pic_height=640&mode_question=0")
									body = xml:ParseXmlText(tostring(body))

									if not body then
										channel:send({
											embed = {
												color = color.error,
												description = ":x: | " .. userLanguage.akinator_system.error
											}
										})
										playingAkinator[userID] = nil
										return
									end

									msg.embed.color = msg.embed.color
									msg.embed.author = {
										name = body.RESULT.PARAMETERS.ELEMENTS.ELEMENT.NAME:value(),
										icon_url = msg.author.icon_url
									}
									msg.embed.title = string.format((checkAnswer and userLanguage.akinator_system.answer.bet or userLanguage.akinator_system.answer.real), (playingAkinator[userID].data.step or 0) + (checkAnswer and 1 or 0))
									msg.embed.image = {
										url = body.RESULT.PARAMETERS.ELEMENTS.ELEMENT.ABSOLUTE_PICTURE_PATH:value()
									}
									msg.embed.description = body.RESULT.PARAMETERS.ELEMENTS.ELEMENT.DESCRIPTION:value()
									msg.embed.footer = nil
								end
							end

							msg:setEmbed(msg.embed)
							if update then
								if playingAkinator[userID].data.step == 0 then
									reaction.message:removeReaction(playingAkinator.__REACTIONS[#playingAkinator.__REACTIONS])
								elseif playingAkinator[userID].data.step == 1 then 
									reaction.message:addReaction(playingAkinator.__REACTIONS[#playingAkinator.__REACTIONS])
								end

								if playingAkinator[userID].data.step == 8 then
									reaction.message:removeReaction(playingAkinator.__REACTIONS.ok)
								elseif playingAkinator[userID].data.step == 9 then
									reaction.message:addReaction(playingAkinator.__REACTIONS.ok)
								end

								reaction.message:removeReaction(hash, userID)

								playingAkinator[userID].lastBody = body
							else
								msg:clearReactions()
								if addResultReaction then
									msg:addReaction("\xE2\x9C\x85") -- Correct
									msg:addReaction("\xE2\x9D\x8C") -- Incorrect
								end

								playingAkinator[userID] = nil
							end
						end
					end

					if playingAkinator[userID] then
						playingAkinator[userID].canExe = true
					end
				end
			end
		elseif polls[messageID] then
			local found, answer = table.find(polls.__REACTIONS, hash)
			if found then
				polls[messageID].data[answer] = polls[messageID].data[answer] + 1
				channel:getMessage(messageID):removeReaction(polls.__REACTIONS[(answer % 2) + 1], userID)
			else
				reaction.message:removeReaction(hash, userID)
			end
		end
	end, reaction, userID)

	if not success then
		reaction.message:reply({
			embed = {
				color = color.luaerr,
				title = "ReactionADD ~ Error!",
				description = "```\n" .. err .. "```"
			}
		})
	end
end)
client:on("reactionRemove", function(reaction, userID)
	if databases > 0 then return end
	if userID == client.user.id then return end

	local success, err = pcall(function(reaction, userID)
		local channel = reaction.message.channel
		local messageID = reaction.message.id
		local hash = reaction.emojiName

		if polls[messageID] then
			local found, answer = table.find(polls.__REACTIONS, hash)
			if found then
				polls[messageID].data[answer] = polls[messageID].data[answer] - 1
			end
		end
	end, reaction, userID)

	if not success then
		reaction.message:reply({
			embed = {
				color = color.luaerr,
				title = "ReactionREM ~ Error!",
				description = "```\n" .. err .. "```"
			}
		})
	end
end)

client:on("memberUpdate", function(member)
	if databases > 0 then return end
	if member.id == client.user.id then return end

	if data.team[member.id] then
		if member.name ~= data.team[member.id].user then
			member:setNickname(data.team[member.id].user)
			client:getUser(member.id):send({
				embed = {
					color = color.error,
					description = "Hey, `" .. data.team[member.id].user .. "`! You are not allowed to change your nickname. If your current __nickname__ is not your __Atelier801 Nickname__, contact `Bolodefchoco`!"
				}
			})
		else
			local newTeam, newRank = {}, {}
			local hash = {}

			for role in member.roles:iter() do
				if data.roles[role.name] then
					if not hash[data.roles[role.name]] and not role.name:find("public") then
						if #role.name > 2 then
							newRank[#newRank + 1] = data.roles[role.name]
						else
							newTeam[#newTeam + 1] = data.roles[role.name]
						end
						hash[data.roles[role.name]] = true
					end
				else
					member:send({
						embed = {
							color = color.error,
							description = ":fire: | The role `" .. role.name .. "<" .. role.id .. ">` is not hosted in the bot.\n\nContact `Bolodefchoco` as soon as possible!"
						}
					})
				end
			end

			data.team[member.id].team = newTeam
			data.team[member.id].rank = newRank
			save("team", data.team)
		end
	end
end)

client:on("memberJoin", function(member)
	if databases > 0 then return end
	commands["help"].exe(nil, nil, translations.en, member)

	client:getChannel(channels['member-log']):send({
		embed = {
			color = color.system,
			description = "`" .. member.user.fullname .. "` joined."
		}
	})

	local channel = client:getChannel(channels["chat"][1])
	channel:send({
		content = "<@!" .. member.id .. ">",
		embed = {
			color = color.message,
			description = "Welcome!",
			title = "The team hope you enjoy this experience!",
			description = "<@!" .. member.id .. "> is the new guest!\nWelcome to the public channels of the Translators Team! From now and on I am your personal bot!\n\nIf you don't mind, type `/nick your_nickname_on_Atelier801#hashtag` so we can know who you really are!"
		}
	})
end)
client:on("memberLeave", function(member)
	if databases > 0 then return end
	client:getChannel(channels['member-log']):send({
		embed = {
			color = color.system,
			description = "`" .. member.name .. "` `[" .. member.user.fullname .. "]` left."
		}
	})
	if data.team[member.id] then
		commands["remove"].exe(nil, nil, nil, member)
	end
end)

local minutes = 0
clock:on("min", function()
	if databases > 0 then return end
	minutes = minutes + 1

	if minutes == 1 then
		updateCurrency()
	end

	if minutes % 3 == 0 then
		saveDatabases()
	end
	if minutes % 10 == 0 then
		--githubCommit("Database/log.txt", getDatabase("log", true))
	end
	if minutes % 30 == 0 then
		for k, v in next, database.unhandledRequests do
			updateRequestMessage(k)
		end
	end

	for k, v in next, table.deepcopy(polls) do
		local poll = client:getChannel(v.channel)
		if poll then
			poll = poll:getMessage(k)
			if poll then
				local userLanguage = translations[v.textLang or "en"]

				if os.time() > v.time then
					local totalVotes = v.data[1] + v.data[2]

					local totalStr = ""
					for i = 1, 2 do
						totalStr = totalStr .. userLanguage.poll.total:format(v.option[i], v.data[i], math.ceil(math.percent(v.data[i], totalVotes))) .. "\n"
					end
					poll.embed.description = poll.embed.description:match("```.*```\n") .. totalStr

					local results = {{ 1, v.data[1] }, { 2, v.data[2] }}
					table.sort(results, function(a, b) return a[2] > b[2] end)

					poll.embed.author.name = poll.embed.author.name .. " - " .. userLanguage.poll.results
					poll.embed.footer.text = userLanguage.poll.decision:format(results[1][2] == results[2][2] and userLanguage.poll.tie or v.option[results[1][1]])

					poll:clearReactions()

					polls[k] = nil
				else
					poll.embed.footer.text = userLanguage.poll.ends:format(math.floor((v.time - os.time()) / 60))
				end

				poll:setEmbed(poll.embed)
			end
		end
	end
end)
clock:on("hour", function()
	if databases > 0 then return end
	local date, year = os.date("%d/%m"), os.date("%y")

	-- Birthday
	for k, v in next, data.team do
		if v.birthdayDate[2] == year and v.birthdayDate[1] == date then

			v.birthdayDate[2] = v.birthdayDate[2] + 1
			save("team", data.team)

			local message = client:getChannel(channels['public-announcements']):send({
				content = "@here <@!" .. k .. ">",
				embed = {
					color = color.profile,
					title = string.format("IT'S `%s`'S BIRTHDAY!!!!!!! SO OLD, %s YEARS ON EARTH", v.user:upper(), math.random(60, 250)),
					description = ":tada: :tada: :tada: :tada: :tada: :tada: :tada: :tada: :tada: :tada: :tada:",
					image = { url = "http://img.atelier801.com/" .. table.random(birthday) .. ".gif" },
					footer = { text = os.date("%d/%m/%Y") }
				}
			})

			local congrats = {"\xF0\x9F\x87\xA8", "\xF0\x9F\x87\xB4", "\xF0\x9F\x87\xB3", "\xF0\x9F\x87\xAC", "\xF0\x9F\x87\xB7", "\xF0\x9F\x87\xA6", "\xF0\x9F\x87\xB9", "\xF0\x9F\x87\xB8", "\xF0\x9F\x8E\x81"}
			for i = 1, #congrats do
				message:addReaction(congrats[i])
			end
		end
	end

	-- Update coins
	updateCurrency()

	saveDatabases()
end)

client:run(file.getFile("Database/token.txt", "*l"))