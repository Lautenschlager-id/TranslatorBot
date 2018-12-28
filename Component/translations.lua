local translations = setmetatable({}, {
	__newindex = function(list, index, value)
		rawset(list, index, setmetatable(value, {
			__tostring = function() return index end
		}))
	end
})

--[[ Main ]]--
translations.en = {
	command_descriptions = {
		a801 = { "Displays the Atelier801's profile of the specified player.", { "(Tags are needed if they are not 0000)\n!a801 `playerName#0000`" } },
		akinator = { "Starts an Akinator game.",
			{
				"(Regular game)\n!akinator",
				"(Set probability ratio)\n!akinator `number [70 - 97]`"
			}
		},
		animal = { "Displays a random animal picture.", { "!animal" } },
		avatar = { "Displays the avatar of a specific user.",
			{
				"(Own avatar)\n!avatar",
				"(Someone's avatar)\n!avatar `@username`",
			}
		},
		coin = { "Performs a currency conversion between two currencies. (default = USD)",
			{
				"(Conversion of the total money)\n!coin `target_currency source_currency total_money`",
				"(Conversion of $1)\n!coin `target_currency source_currency`",
				"(Conversion from USD)\n!coin `target_currency total_money`",
			}
		},
		color = { "Displays the color of a specific #hex code.", { "!color `#hexadecimal`" } },
		define = { "Gets the definition, synonyms, antonyms and examples of use of an english word.", { "!define `word`" } },
		fact = { "Shows a random fact.", { "!fact" } },
		help = { "Displays the Help message.", { "!help" } },
		invite = { "Shows the invite link for the Translators Team server.", { "!invite" } },
		lang = { "Sets a standard language for the public commands for you.", { "!lang `flag`" } },
		languages = { "Displays a list of available languages.", { "!languages" } },
		leaderboard = { "Displays a leaderboard with the best translators.",
			{
				"(Regular)\n!leaderboard",
				"(Specific role)\n!leaderboard `@role`",
				"(More positions)\n!leaderboard `@role_or_* total_members[3-6]`",	
			}
		},
		meme = { "Random meme of Galaktine & Company.", { "!meme" } },
		message = { "The bot automatically sends you a private message.", { "!message" } },
		momma = { "Shows a random joke about ~~your~~ momma!", { "!momma" } },
		poll = { "Creates a poll (Yes/No).",
			{
				"!poll Question",
				"(Member Only) (Custom)\n!poll ` ```question``` poll_time` ` `poll_option_1` ` ` ` ` `poll_option_2` ` ` `"
			}
		},
		profile = { "Displays the profile of the specified member of the team.",
			{
				"(Your profile)\n!profile",
				"(Member profile)\n!profile `username`"
			}
		},
		quote = { "Quotes an old message, so you can answer it.",
			{
				"(Message id)\n!quote `message_id`",
				"(Channel id)\n!quote `message_id channel_id`"
			}
		},
		request = { "Sends a translation request for the Translators Team. [1000 characters max]", 
			{
				"(One language)\n!request `content_language [request_language] ```request_content``` `",
				"(Multiple languages)\n!request `content_language [request_language1, request_language2, ...] ```request_content``` `",
				"(Member only) (All the languages)\n!request `content_language [xx] ```request_content``` `",
				"(Lua module [1200 characters max])\n!request `content_language [request_language1, request_language2, ...] ```LUA\nrequest_content``` `"
			}
		},
		serverinfo = { "Shows the available informations about the server.", { "!serverinfo" } },
		spell = { "Checks if an english text is spelled correctly.", { "!spell `text`" } },
		team = { "Displays the members in the given role.",
			{
				"(Community)\n!team `community`",
				"(Position)\n!team `role`",
			}
		},
		thread = { "Shows the Atelier801 translators team thread link.", { "!thread `community`" } },
		tree = { "Displays the Atelier801's Lua tree.", { "!tree `tfm.path`\n\nExample => `!tree tfm.enum.ground`" } },
		urban = { "Gets the definition of an english expression.", { "!urban `expression`" } },
		weather = { "Shows the current weather in the specified city/country.", { "!weather `city_name, country_abbreviation`" } },
	},
	avatar = "%s's avatar: [here](%s)",
	help_message = "Hello, <@!%s>! %sMy prefix is `!` and to see what I am capable of, use the command `!help`. Use the command `!command_name ?` to read a more detailed help message for the specified command.",
	command_quantity = "The available commands for you (%s) are:",
	help_welcome = "Welcome to the Translators Team server!",
	help_permissions = {"ALL", "TRANSLATOR", "MODULE TRANSLATOR", "LEADER", "ADMIN", "DEVELOPER DEBUG"},
	help_commands = "Commands for `%s`", --e.g.: commands for translators
	invite_link = "**Public** invite link: %s",
	available_languages = "Available Languages",
	leaderboard = "Leaderboard",
	global = "Global", --e.g.: leaderboard
	leaderboard_stats = {"Public Translators", "Cookie Eaters"},
	message_message = "Hello, %s. Type a command below!",
	profile_fields = {
		birthday = "Birthday",
		role = "Role",
		language = "Language",
		translations = "Public Translations",
		state = "State",
		states = { "Active", "Inactive" }
	},
	not_translator = "`%s` is not a translator",
	available_translators = "You can check the available translators using the command `!team translator`",
	request_help = "Type `!request ?` to read the possible parameters.",
	available_languages = "The available languages are: %s",
	exceeded_char_request = "The request was refused. The content cannot contain more than %s characters! Send it through private message on forums or make it smaller.",
	request = {
		[1] = "Your request is in the position #%s",
		[2] = "The text below will be translated in the following languages: %s"
	},
	request_error = {
		no_content = "Invalid __request_content__ parameter: There must be something to translate, insert the content.",
		no_language = "Invalid __request_language__ parameter: You must insert at least one language that you need the content translated.",
		unavailable_language = "Unfortunately our team do not have members to read texts in %s!",
		no_content_language = "Invalid __content_language__ parameter: You must insert the language of the content.",
	},
	no_parameters = "You forgot to add parameters in this command.",
	member_title = "`%s` members (%s)", --e.g: en members (3)
	role_not_found = "Role `%s` not found!",
	path_not_found = "Path `%s` not found!",
	help = "Help",
	command = "Command",
	akinator_system = {
		timeout = {
			title = "TIMEOUT",
			message = "Unfortunately you took too much time to answer",
		},
		fail = {
			title = "Ugh, you won!",
			message = "I did not figure out who your character is :( I dare you to try again!",
		},
		step = "Question %s",
		error = "Akinator Error. :( Try again.",
		answer = {
			bet = "I bet my hunch is correct... after %s questions...",
			real = "I figured out in the %sth question!",
		}
	},
	standard_language = "Your standard language has been set to `%s`",
	poll = {
		already_exists = "There's already a poll made by you. Wait its results before opening a new poll.",
		poll = "Poll",
		option = {"Yes", "No"},
		ends = "Ends in %s minutes.",
		total = "Total of `\"%s\"`: %s (%s%%)", -- e.g.: Total of "Yes": 10 (30%)
		results = "Results",
		decision = "Final Decision: \"%s\"",
		tie = "TIE",
	},
	weather = {
		at = "Weather at %s",
		temperature = "Temperature",
		current = "Current",
		maximum = "Maximum",
		minimum = "Minimum",
		wind = "Wind Speed",
		humidity = "Humidity",
		cloud = "Cloudiness",
		rain = "Rain",
		snow = "Snow",
		update = "Last update at %s",
		not_found = "The location of `%s` was not found. Make sure to write its name in English and try again later!",
	},
	atelier = {
		roles = {
			ex = "Ex-staff",
			adm = "Administrator",
			mod = "Moderator",
			sent = "Sentinel",
			mc = "Mapcrew"
		},
		not_found = "The player `%s` doesn't exist.",
		registration = "Registration date",
		community = "Community",
		messages = "Messages",
		prestige = "Prestige",
		title = "Title",
		tribe = "Tribe",
		visit = "Visit profile",
		sm = "Soulmate"
	},
	translation = "Translated by The Translators Team (#%s)\n\nLanguage: %s (%s)\nContent: ```%s\n%s```\n\nThis translation took `%s`.\n_Share the experience with your friends!_",
	ban = "**You got banned from the Translators Team server!**\n\n```\n%s```\nUnfortunately your behavior has compromised your participation in the public channels of the server.",
	kick = "**You got kicked from the Translators Team server!**\n\n```\n%s```\nAfter several sanctions, you got kicked. Consider improving your behavior or you may be banned permanently from the server!",
	sanction = "**You got a sanction from the Translators Team server!** *(%s/%s)*\n\n```\n%s```\nYou got sanctioned! If you get other sanctions you may be kicked from this server, or even banned! Check your behavior and do your best to avoid creating new problems in the public channels!",
	unfair_warn = "If you find the punishment __unfair__, contact any International Leader. Check their nicknames using the command `!team International Leader`",
	server = {
		owner = "Owner",
		channels = "Channels",
		creation = "Created on",
		translators = "Translators",
		members = "Members",
		away = "Away",
		busy = "Busy",
		people = "People",
	},
}

--[[ Others ]]--
translations.ar = {
	command_descriptions = {
		a801 = {"تظهر الملف الشخصي بورشة 801 الخاص باللاعب المحدد.", { "(رقم اللاعب إجباري #0000إذا لم يكن \n!a801 `ism_alla3ib#0000`" } },
		akinator = { ".بدء لعبة أكيناتور",
			{
				"(لعبة عادية)\n!akinator",
				"(تحديد المعدل المحتمل)\n!akinator `رقم [70 - 97]`"
			}
		},
		animal = { ".تظهر صورة حيوان عشوائي", { "!animal" } },
		avatar = { ".تظهر الصورة الشخصي للشخص المحدد",
			{
				"(صورتك الشخصية)\n!avatar",
				"(الصورة الشخصية لشخص ما)\n!avatar `@username`",
			}
		},
		coin = { "(USD = يقوم بعمل تحويل بين عُملتين. (إفتراضي",
			{
				"(إجمالي تحويل المال)\n!coin `al3mlat_almustahdafa al3mla_almasdar majmou3_al3mlat`",
				"(تحويل 1 دولار)\n!coin `al3mlat_almustahdafa al3mla_almasdar`",
				"(USD التحويل من)\n!coin `al3mlat_almustahdafa majmou3_al3mlat`",
			}
		},
		color = { "المحدد #hex تظهر لون خاص برمز", { "!color `#hexadecimal`" } },
		define = { ".الحصول على التعريف، المرادفات، المتضادات، وأمثلة عن استخدام كلمة إنجليزية بلغة معينة", { "!define `kalima`" } },
		fact = { "يعرض حقيقة عشوائية", { "!fact" } },
		help = { ".تظهر رسالة المساعدة", { "!help" } },
		invite = { ".يظهر رابط الدعوة لخادم فريق المُترجمين", { "!invite" } },
		lang = { ".يحدد لغة موحدة للأوامر العامة لك", { "!lang `العلم`" } },
		languages = { ".يظهر قائمة اللغات المتوفرة", { "!languages" } },
		leaderboard = { ".يظهر قائمة المتصدرين تحوي أفضل المترجمين",
			{
				"(منتظم)\n!leaderboard",
				"(لرتبة محددة)\n!leaderboard `@rotba`",
				"(اكثر من رتبة)\n!leaderboard `@rotba_aw_* majmo3_ala3dae[3-6]`",	
			}
		},
		meme = { ".ميم عشوائي عن غلاكتاين وشركائها", { "!meme" } },
		message = { ".سيرسل البوت رسالةً خاصةً لك أوتوماتيكيًا", { "!message" } },
		momma = { "يُظهر نُكتة عشوائية عن ~~الماما~~ الخاصة بك", { "!momma" } },
		poll = { ".(تنشئ استفتاء (نعم/لا",
			{
				"!poll السؤال",
				"(مخصصة) (الأعضاء فقط)\n!poll ` ```alsou2l``` wa9t_alistifta2` ` `al5iyar_1` ` ` ` ` `al5iyar_2` ` ` `"
			}
		},
		profile = { ".تظهر الملف الشخصي لعضو ما في الفريق",
			{
				"(ملفك الشخصي)\n!profile",
				"(الملف الشخصي لشخص ما)\n!profile `username`"
			}
		},
		quote = { ".يقتبس رسالة قديمة، حتى تتمكن من الإجابة عليها",
			{
				"(id الرسالة)\n!quote `id_Arissala`",
				"(id القناة)\n!quote `id_Arissala id_Al9anat`"
			}
		},
		request = { "[الحد الأقصى لعدد الحروف 1000] .ترسل طلب ترجمة لفريق المترجمين", 
			{
				"(لغة واحدة)\n!request `Loghat_almo7tawa [Loghat_atalab] ```Mo7tawa_atalab``` `",
				"(عدة لغات)\n!request `Loghat_almo7tawa [Loghat_atalab1, Loghat_atalab2, ...] ```Mo7tawa_atalab``` `",
				"(الأعضاء فقط) (كل اللغات)\n!request `Loghat_almo7tawa [xx] ```Mo7tawa_atalab``` `",
				"نمط لوا) [الحد الأقصى لعدد الحروف 1200])\n!request `Loghat_almo7tawa [Loghat_atalab1, Loghat_atalab2, ...] ```LUA\nMo7tawa_atalab``` `"
			}
		},
		serverinfo = { "يعرض المعلومات المتاحة عن الخادم", { "!serverinfo" } },
		spell = { ".التحقق مما إذا كان النص مكتوبًا بشكل صحيح", { "!spell `النص`" } },
		team = { ".يعرض الأعضاء في الرتبة المحددة",
			{
				"(المجتمع)\n!team `المجتمع`",
				"(الرتبة)\n!team `الرتبة`",
			}
		},
		thread = { ".يعرض رابط موضوع فريق المُترجمين على أتيلير801", { "!thread `almoujtama3`" } },
		tree = { ".تظهر شجرة لوا الخاصة بترانسفورمايس", { "!tree `tfm.path`\n\nمثال => `!tree tfm.enum.ground`" } },
		urban = { ".الحصول على تعريف تعبير حضري", { "!urban `العبارة`" } },
		weather = { ".يعرض الطقس الحالي في المدينة / البلد المحدد", { "!weather `ism_almadina, i5tissar_albalad`" } },
	},
	avatar = "[هنا](%s) : الشخصية %s صورة",
	help_message = "مرحبا, <@!%s>! %sإختصاري هو `!` و لرؤية ما يمكنني فعله، إستخدم الأمر `!help`.إستخدم الأمر `!command_name ?` لكي تقرأ تفاصيل رسالة المساعدة للأمر المحدد",
	command_quantity = ":هي (%s) الايعازات المتوفرة لديك",
	help_welcome = "!مرحبًا يك في خادم فريق المُترجمين",
	help_permissions = {"الجميع", "المُترجمين", "مترجمو البرمجيات التركيبية", "المدير", "المطور مصحح الأخطاء"},
	help_commands = "`%s` الإيعازات لـ",
	invite_link = "%s : رابط الدعوة **العام**",
	available_languages = "اللُغات المتوفرة",
	leaderboard = "قائمة المتصدرين",
	global = "عالمي",
	leaderboard_stats = {"المُترجمون العامون", "آكلو الكوكيز"},
	message_message = "!أكتب أي إيعازٍ أدناه .%s ،مرحبًا",
	profile_fields = {
		birthday = "عيد الميلاد",
		role = "الرتبة",
		language = "اللغة",
		translations = "الترجمات العامة",
		state = "الحالة",
		states = { "نشط", "غير نشط"}
	},
	not_translator = "ليس مترجمًا `%s`",
	available_translators = "`!team translator` يُمكنك التحقق من المترجمين المُتاحين عن طريق استعمال الايعاز التالي",
	request_help = ".لقراءة الاعدادات المُمكنة `!request ?` اكتب",
	available_languages = "%s :اللُغات المتوفرة هي",
	exceeded_char_request = "الطلب تم رفضه. محتواك لا يجب أن يتضمن أكثر من %s حرفًا! أرسل رسالة خاصة عبر المنتدى أو اجعله أصغر.",
	request = {
		[1] = "#%s طبلك في المنصب رقم",
		[2] = "%s :سيتم ترجمة النص ادناه للغات التالية"
	},
	request_error = {
		no_content = "خاطئة : يجب أن يكون هناك شيء لترجمته، أدخل المحتوى __Mo7tawa_atalab__ معلومة",
		no_language = "خاطئة : يجب عليك ادخال لغة واحدة على الأقل التي تريد ان يترجم اليها المحتوى __Loghat_atalab__ معلومة",
		unavailable_language = "!%sلسوء الحظ فريقنا ليس لديه اعضاء لقراءة النصوص بـ",
		no_content_language = "خاطئة : يجب عليك ادخال لغة المحتوى __Loghat_almo7tawa__ معلومة",
	},
	no_parameters = ".لقد نسيت إضافة المعلومات في هذا الأمر",
	member_title = "`%s` الأعضاء (%s)",
	role_not_found = "!غير موجودة `%s` الرتبة",
	path_not_found = "!غير موجود `%s` المسار",
	help = "مساعدة",
	command = "ايعاز",
	akinator_system = {
		timeout = {
			title = "نفذ الوقت",
			message = "للأسف لقد استغرقت الكثير من الوقت للاجابة",
		},
		fail = {
			title = "!اغغ، لقد فزت",
			message = "!لم أعرف من هي شخصيتك :( أتحداك أن تحاول مرة أخرى",
		},
		step = "%s السؤال",
		error = ".خطأ أكيناتور. :( حاول مرة أخرى",
		answer = {
			bet = "... %s أراهن أن حدسي صحيح... بعد السؤال",
			real = "! %s لقد اكتشفت الشخصية في السؤال رقم",
		}
	},
	standard_language = "`%s` اللغة الأساسية تم تعيينها لـ",
	poll = {
		already_exists = "لقد قمت بإنشاء استفتاء بالفعل. انتظر النتائج قبل صنع واحدٍ جديدٍ",
		poll = "استفتاء",
		option = {"نعم", "لا"},
		ends = ".دقائق %s تنتهي بعد",
		total = "مجموع \"%s\" هو: %s (%s%%) صوت", 
		results = "النتائج",
		decision = "القرار الأخير : \"%s\"",
		tie = "تعادل",
	},
	weather = {
		at = "%s الطقس في",
		temperature = "درجة الحرارة",
		current = "الحاليّ",
		maximum = "الحد الأقصى",
		minimum = "الحد الأدنى",
		wind = "سرعة الرياح",
		humidity = "رطوبة",
		cloud = "درجة التغيم",
		rain = "مطر",
		snow = "ثلج",
		update = "أخر تحديث في %s",
		not_found = "لم يتم العثور على موقع `%s`. تأكد من كتابة اسمه باللغة الإنجليزية وحاول مرة أخرى لاحقًا!",
	},
	atelier = {
		roles = {
			ex = "مسؤول قديم",
			adm = "مدير",
			mod = "مشرف",
			sent = "مراقب",
			mc = "عضو في طاقم الخرائط"
		},
		not_found = ".غير موجود `%s` اللاعب",
		registration = "تاريخ التسجيل",
		community = "المجتمع",
		messages = "الرسائل",
		prestige = "عدد الإعجاب",
		title = "اللقب الحاليّ",
		tribe = "القبيلة",
		visit = "يصخشلا فلملا ةرايز",
		sm = "رفيق الحياة",
	},
	translation = "(#%s) تمت الترجمة من قبل فريق المترجمين\n\n(%s) %s :اللّغة\n```%s\n%s``` :المحتوى\n\n.`%s` هذه الترجمة استغرقت\n_!شارك التجربة مع أصدقائك_",
	ban = "**!لقد تم حظرك من خادم فريق المترجمين**\n\n```\n%s```\n.لسوء الحظ، سلوكك منع مشاركتك في القنوات العامّة في الخادم",
	kick = "**!لقد تم طردك من خادم فريق المترجمين**\n\n```\n%s```\nبعد عدّة عقوبات، تم طردك. خذ بعين الاعتبار تطوير سلوكك وإلّا قد يتم !حظرك نهائيا من الخادم",
	sanction = "*(%s/%s)* **!لقد تلقّيت عقوبة من خادم فريق المترجمين**\n\n```\n%s```\nلقد تم عقابك! إذا تلقّيت عقوبات أخرى فقد يتمّ !طردك من الخادم، أو حتّى حظرك! تثبّت من سلوكك وحاول قدر المستطاع أن تتجنّب خلق مشاكل جديدة في القنوات العامّةa",
	unfair_warn = "إذا وجدت العقوبة __ظالمة__ ، اتصل بأي قائد عالمي. تحقق من أسمائهم باستخدام الأمر`!team International Leader`",
	server = {
        owner = "المالك",
        channels = "القنوات",
        creation = "تم إنشاؤه في",
        translators = "المترجمين",
        members = "الأعضاء",
        away = "غائب",
        busy = "مشغول",
        people = "الناس",
    },
}
translations.br = {
	command_descriptions = {
		a801 = { "Mostra o perfil da Atelier801 do jogador especificado.", { "(Tags são necessárias se elas não são 0000)\n!a801 `nomeJogador#0000`" } },
		akinator = { "Inicia um jogo do Akinator.",
			{
				"(Jogo regular)\n!akinator",
				"(Definir taxa de probabilidade)\n!akinator `número [70 - 97]`"
			}
		},
		animal = { "Exibe a foto de um animal aleatório.", { "!animal" } },
		avatar = { "Exibe o avatar de um usuário específico.",
			{
				"(Próprio avatar)\n!avatar",
				"(Avatar de alguém)\n!avatar `@username`",
			}
		},
		coin = { "Realiza uma conversão de moeda entre duas moedas. (padrão = USD)",
			{
				"(Conversão do dinheiro total)\n!coin `moeda_alvo moeda_origem dinheiro_total`",
				"(Conversão de $1)\n!coin `moeda_alvo moeda_origem`",
				"(Conversão de USD)\n!coin `moeda_alvo dinheiro_total`",
			}
		},
		color = { "Exibe a cor com um código #hex específico.", { "!color `#hexadecimal`" } },
		define = { "Obtém a definição, sinônimos, antônimos e exemplos do uso de uma palavra inglesa.", { "!define `palavra`" } },
		fact = { "Mostra um fato aleatório.", { "!fact" } },
		help = { "Exibe a mensagem de ajuda.", { "!help" } },
		invite = { "Exibe o link do convite para o servidor da Equipe de Tradutores.", { "!invite" } },
		lang = { "Define o idioma padrão de comandos públicos para você.", { "!lang `país`" } },
		languages = { "Exibe uma lista de idiomas disponíveis.", { "!languages" } },
		leaderboard = { "Exibe um ranking com os melhores tradutores.",
			{
				"(Regular)\n!leaderboard",
				"(Cargo específico)\n!leaderboard `@cargo`",
				"(Mais posições)\n!leaderboard `@cargo_ou_* total_de_membros[3-6]`",	
			}
		},
		meme = { "Meme aleatório da Galaktine & Companhia.", { "!meme" } },
		message = { "O bot automaticamente envia uma mensagem privada para você.", { "!message" } },
		momma = { "Mostra uma piada aleatória sobre ~~sua~~ mãe!", { "!momma" } },
		poll = { "Cria uma enquete (Sim/Não).",
			{
				"!poll Pergunta",
				"(Só para membros) (Personalizado)\n!poll ` ```questão``` tempo_enquete` ` `enquete_opção_1` ` ` ` ` `enquete_opção_2` ` ` `"
			}
		},
		profile = { "Exibe o perfil do membro da equipe especificado.",
			{
				"(Seu perfil)\n!profile",
				"(Perfil do membro)\n!profile `username`"
			}
		},
		quote = { "Cita uma mensagem antiga, assim você poderá respondê-la.",
			{
				"(ID da mensagem)\n!quote `id_da_mensagem`",
				"(ID do canal)\n!quote `id_da_mensagem id_do_canal`"
			}
		},
		request = { "Envia um pedido de tradução para a Equipe de Tradutores. [máximo de 1000 caracteres]", 
			{
				"(Um idioma)\n!request `idioma_do_conteúdo [idioma_do_pedido] ```conteúdo_do_pedido``` `",
				"(Múltiplos idiomas)\n!request `idioma_do_conteúdo [idioma_do_pedido1, idioma_do_pedido2, ...] ```conteúdo_do_pedido``` `",
				"(Só para membros) (Todos os idiomas)\n!request `idioma_do_conteúdo [xx] ```conteúdo_do_pedido``` `",
				"(Lua module [máximo de 1200 caracteres])\n!request `idioma_do_conteúdo [idioma_do_pedido1, idioma_do_pedido2, ...] ```LUA\nconteúdo_do_pedido``` `"
			}
		},
		serverinfo = { "Mostra as informações disponíveis sobre o servidor.", { "!serverinfo" } },
		spell = { "Checa se um texto em inglês está escrito corretamente.", { "!spell `texto`" } },
		team = { "Exibe os membros de um cargo.",
			{
				"(Comunidade)\n!team `comunidade`",
				"(Cargo)\n!team `cargo`",
			}
		},
		thread = { "Mostra o link do tópico da equipe de tradutores da Atelier801.", { "!thread `comunidade`" } },
		tree = { "Exibe a Árvore Lua do Atelier801.", { "!tree `tfm.caminho`\n\nExemplo => `!tree tfm.enum.ground`" } },
		urban = { "Obtém a definição de uma expressão em inglês.", { "!urban `expressão`" } },
		weather = { "Mostra o clima atual na cidade/país especificado.", { "!weather `nome_cidade, abreviação_país`" } },
	},
	avatar = "Avatar de %s: [aqui](%s)",
	help_message = "Olá, <@!%s>! %sMeu prefixo é `!` e para obter ajudar, digite `!help`. Utilize `!nome_do_comando ?` para ter uma informação detalhada sobre um determinado comando",
	command_quantity = "Os comandos disponíveis para você (%s) são:",
	help_welcome = "Bem-vindo(a) ao servidor da Equipe de Tradutores!",
	help_permissions = {"TODOS", "TRADUTOR", "TRADUTOR MODULE", "LÍDER", "ADMINISTRADOR", "DEBUG DO DESENVOLVEDOR"},
	help_commands = "Comandos para `%s`",
	invite_link = "Link de convite **público**: %s",
	available_languages = "Idiomas Disponíveis",
	leaderboard = "Ranking",
	global = "Global",
	leaderboard_stats = {"Tradutores Públicos", "Comedores de Cookies"},
	message_message = "Olá, %s. Digite um comando abaixo!",
	profile_fields = {
		birthday = "Aniversário",
		role = "Cargo",
		language = "Idioma",
		translations = "Traduções Públicas",
		state = "Estado",
		states = { "Ativo", "Inativo" }
	},
	not_translator = "`%s` não é um tradutor",
	available_translators = "Você pode checar os tradutores disponíveis usando o comando `!team translator`",
	request_help = "Digite `!request ?` para ler os parâmetros possíveis.",
	available_languages = "Os idiomas disponíveis são: %s",
	exceeded_char_request = "O pedido foi recusado. O conteúdo não pode ter mais do que %s caracteres! Envie-o através de uma mensagem privada ou deixe-o menor.",
	request = {
		[1] = "Seu pedido está na posição #%s",
		[2] = "O texto abaixo será traduzido nos seguintes idiomas: %s"
	},
	request_error = {
		no_content = "Parâmetro __conteúdo_do_pedido__ inválido: Deve haver algo para ser traduzido, insira o conteúdo.",
		no_language = "Parâmetro __idioma_do_pedido__ inválido: Você deve inserir pelo menos um idioma em que o conteúdo deve ser traduzido.",
		unavailable_language = "Infelizmente nossa equipe não tem membros para ler textos em %s!",
		no_content_language = "Parâmetro __idioma_do_conteúdo__ inválido: Você deve inserior o idioma do conteúdo.",
	},
	no_parameters = "Você esqueceu de adicionar os parâmetros neste comando.",
	member_title = "Membros `%s` (%s)",
	role_not_found = "O cargo `%s` não foi encontrado!",
	path_not_found = "O caminho `%s` não foi encontrado!",
	help = "Ajuda",
	command = "Comando",
	akinator_system = {
		timeout = {
			title = "TEMPO ESGOTADO",
			message = "Infelizmente você levou muito tempo para responder",
		},
		fail = {
			title = "Aff, você ganhou!",
			message = "Eu não descobri quem era seu personagem :( Desafio-te a tentar novamente!",
		},
		step = "Pergunta %s",
		error = "Error do Akinator. :( Tente novamente.",
		answer = {
			bet = "Eu aposto que meu palpite está certo... depois de %s perguntas...",
			real = "Descobri na %s° pergunta!",
		}
	},
	standard_language = "Seu idioma padrão foi definido para `%s`",
	poll = {
		already_exists = "Já existe uma enquete feita por você. Espere pelos resultados antes de abrir uma nova.",
		poll = "Enquete",
		option = {"Sim", "Não"},
		ends = "Finaliza em %s minutos.",
		total = "Total de `\"%s\"`: %s (%s%%)",
		results = "Resultados",
		decision = "Decisão Final: \"%s\"",
		tie = "EMPATE",
	},
	weather = {
		at = "Clima em %s",
		temperature = "Temperatura",
		current = "Atual",
		maximum = "Máxima",
		minimum = "Mínima",
		wind = "Velocidade do Vento",
		humidity = "Umidade",
		cloud = "Nebulosidade",
		rain = "Chuva",
		snow = "Neve",
		update = "Última atualização em %s",
		not_found = "A localização de `%s` não foi encontrada. Certifique-se de que o nome do lugar está em inglês e tente novamente mais tarde!",
	},
	atelier = {
		roles = {
			ex = "Ex-staff",
			adm = "Administrador",
			mod = "Moderador",
			sent = "Sentinela",
			mc = "Mapcrew"
		},
		not_found = "O jogador `%s` não existe.",
		registration = "Data de inscrição",
		community = "Comunidade",
		messages = "Mensagens",
		prestige = "Reputação",
		title = "Título",
		tribe = "Tribo",
		visit = "Visitar perfil",
		sm = "Alma-gêmea"
	},
	translation = "Traduzido pela Equipe de Tradutores (#%s)\n\nIdioma: %s (%s)\nConteúdo: ```%s\n%s```\n\nEssa tradução levou `%s`.\n_Compartilhe a experiência com seus amigos!_",
	ban = "**Você foi banido do servidor da Equipe de Tradutores!**\n\n```\n%s```\nInfelizmente seu comportamento compromete sua participação nos canais públicos do servidor.",
	kick = "**Você foi expulso do servidor da Equipe de Tradutores!**\n\n```\n%s```\nApós diversas advertências, você foi expulso. Considere melhorar seu comportamento ou você será permanentemente banido!",
	sanction = "**Você foi advertido no servidor da Equipe de Tradutores** *(%s/%s)*\n\n```\n%s```\nVocê foi advertido! Se você acumular mais sanções, você será expulso do servidor, ou até mesmo banido! Reveja seus atos e faça seu melhor para evitar criar problemas em canais públicos!",
	unfair_warn = "Se você considerar essa punição __injusta__, entre em contato com qualquer Líder internacional. Veja seus nicknames usando o comando `!team International Leader`",
	server = {
        owner = "Administrador",
        channels = "Canais",
        creation = "Criado em",
        translators = "Tradutores",
        members = "Membros",
        away = "Ausente",
        busy = "Ocupado",
        people = "Pessoas",
    },
}
translations.cn = {
	command_descriptions = {
		a801 = { "显示指定 Atelier801 玩家的个人资料。", { "(如果名字后面的编号不是#0000请加上#编号)\n!a801 `玩家名字#0000`" } },
		akinator = { "开启Akinator(猜角色)游戏.",
			{
				"(常规游戏)\n!akinator",
				"(设定概率比例)\n!akinator `number [70 - 97]`"
			}
		},
		animal = { "随机展示一张动物照片.", { "!animal" } },
		avatar = { "显示特定用家的个人头像.",
			{
				"(自己的头像)\n!avatar",
				"(其他人的头像)\n!avatar `@username`",
			}
		},
		coin = { "进行两种贷币的换算 (默认 = USD美金)",
			{
				"(转换自定金额)\n!coin `目标贷币 需要转换的贷币 总金额`",
				"(换算 $1)\n!coin `目标贷币 需要转换的贷币`",
				"(从美金USD 换算)\n!coin `目标贷币 总金额`",
			}
		},
		color = { "显示特定#hex(十六进制色彩码)的颜色.", { "!color `#色彩码`" } },
		define = { "查询一个英文字词的定义, 同义词, 反义词和使用的例子.", { "!define `英文字词`" } },
		fact = { "随机告诉你一个事实", { "!fact" } },
		help = { "展示帮助讯息.", { "!help" } },
		invite = { "展示翻译团队这个伺服器的邀请连结.", { "!invite" } },
		lang = { "设定你使用指令的语言.", { "!lang `国家简写`" } },
		languages = { "显示可提供翻译的语言列表.", { "!languages" } },
		leaderboard = { "显示最佳翻译员的排行榜.",
			{
				"(正常显示)\n!leaderboard",
				"(显示特定身份)\n!leaderboard `@身份组`",
				"(显示更多)\n!leaderboard `@身份组_或_* 总人数[3-6]`",	
			}
		},
		meme = { "随机发出Galaktine(一位Atelier801游戏开发者)& Atelier801 的一个梗.", { "!meme" } },
		message = { "伺服器的机械人自动向你发送私人讯息.", { "!message" } },
		momma = { "随机显示一个 ~~他~~ 妈的笑话!", { "!momma" } },
		poll = { "创建一次投票, 选项(是/不是).",
			{
				"!poll 问题",
				"(只限成员使用) (自定义投票)\n!poll ` ```问题``` 投票时限` ` `选项_1` ` ` ` ` `选项_2` ` ` `"
			}
		},
		profile = { "显示翻译团队中特定的成员资料.",
			{
				"(自己的资料)\n!profile",
				"(成员的资料)\n!profile `username`"
			}
		},
		quote = { "引用之前的讯息来回应别人.",
			{
				"(讯息代码 ID)\n!quote `讯息代码`",
				"(频道代码 ID)\n!quote `讯息代码 频道代码`"
			}
		},
		request = { "向翻译团队发送翻译请求. [最多1000 字元]", 
			{
				"(请求一种语言)\n!request `文本的语言 [请求翻译至的语言] ```文本内容``` `",
				"(请求多种语言)\n!request `文本的语言 [请求翻译至的语言1, 请求翻译至的语言2, ...] ```文本内容``` `",
				"(请求翻译到所有语言) (只限翻译团队成员)\n!request `文本的语言 [xx] ```文本內容``` `",
				"(Lua 模组 [上限1200 字元])\n!request `文本的语言 [请求翻译至的语言1, 请求翻译至的语言2, ...] ```LUA\n文本內容``` `"
			}
		},
		serverinfo = { "显示关于伺服器的资讯", { "!serverinfo" } },
		spell = { "检查英文拼字是否正确.", { "!spell `文字`" } },
		team = { "显示特定身份组所属的成员.",
			{
				"(社区)\n!team `社区`",
				"(身份组)\n!team `身份组`",
			}
		},
		thread = { "显示 Atelier801 翻译团队的论坛帖子连结。 ", { "!thread `社区`" } },
		tree = { "展示 Atelier801 可用的Lua 列表.", { "!tree `tfm.路径`\n\n例如 => `!tree tfm.enum.ground`" } },
		urban = { "查询一个英文惯用语的定义.", { "!urban `惯用语`" } },
		weather = { "报告特定城市/国家的现时天气状况", { "!weather `城市名称, 国家简写`" } },
	},
	avatar = "%s的头像: [这里](%s)",
	help_message = "你好, <@!%s>! %s我的指令用语前面都要加上`!`。你可以使用指令`!help` 来看看我可以做什么。而且你可以使用指令 `!指令名称?` 来得到该指令的详细用途",
	command_quantity = "(%s) 你可以使用的指令如下:",
	help_welcome = "欢迎来到翻译团队的伺服器!",
	help_permissions = {"所有人", "翻译员", "模组翻译员", "LEADER", "管理员", "开发人员排除故障"},
	help_commands = "`%s` 可用的指令",
	invite_link = "**伺服器** 邀请连结: %s",
	available_languages = "可提供翻译的语言",
	leaderboard = "排行榜",
	global = "Global",
	leaderboard_stats = {"翻译员", "曲奇获得数"},
	message_message = "你好, %s. 请输入下面其一的指令!",
	profile_fields = {
		birthday = "生日日期",
		role = "身份组",
		language = "语言",
		translations = "翻译完成数",
		state = "状态",
		states = { "活跃", "不活跃" }
	},
	not_translator = "`%s` 并不是翻译员",
	available_translators = "你可以使用指令`!team translator`来查看翻译员列表",
	request_help = "输入 `!request ?` 以了解请求的相关参数.",
	available_languages = "现在可提供翻译的语言有: %s",
	exceeded_char_request = "你的请求已经被拒绝。 你的请求内容不可以多于 %s 字元! 请透过论坛发送私人讯息给我们, 又或是减少请求的内容不超过上限。",
	request = {
		[1] = "你的请求正在轮候位置 #%s",
		[2] = "以下文字将会被翻译到语言: %s"
	},
	request_error = {
		no_content = "无效的请求__参数: 翻译请求需要具内容, 请加入内容.",
		no_language = "无效的请求_语言请求__参数: 你需要至少选择一种语言以翻译你的文本.",
		unavailable_language = "很可惜我们没有成员能够阅读 %s 的文字!",
		no_content_language = "无效的请求 __文本语言__ 参数: 你必须标明文本的语言.",
	},
	no_parameters = "你忘记了在指令里加上参数.",
	member_title = "`%s` 成员 (%s)",
	role_not_found = "身份组 `%s` 不存在!",
	path_not_found = "路径 `%s` 不存在!",
	help = "帮助",
	command = "指令",
	akinator_system = {
		timeout = {
			title = "时间到了",
			message = "不幸地你用了过多时间来回答",
		},
		fail = {
			title = "呃, 你胜了!",
			message = "我猜不到你心中的角色是谁 :( 我跟你打赌再来一次!",
		},
		step = "问题 %s",
		error = "Akinator 错误. :( 请重新试试.",
		answer = {
			bet = "在第 %s 题问题之后... 我相信我的直觉准没错...",
			real = "我在第 %s 题问题时猜出了!",
		}
	},
	standard_language = "你的语言默认设定成 `%s`",
	poll = {
		already_exists = "你已经创建了一次投票, 请你先等候它的结果才另外创建新的投票",
		poll = "投票",
		option = {"是", "不是"},
		ends = "将在 %s 分钟后结束.",
		total = "\"%s\" 的总数: %s (%s%%)",
		results = "结果",
		decision = "最终结果论: \"%s\"",
		tie = "和局",
	},
	weather = {
		at = "%s 的天气情况",
		temperature = "气温",
		current = "现时",
		maximum = "最高",
		minimum = "最低",
		wind = "风速",
		humidity = "湿度",
		cloud = "云朵覆盖率",
		rain = "下雨",
		snow = "下雪",
		update = "最后更新於 %s",
		not_found = "找不到 `%s` 这个位置。请确定你输入了它的英文名称, 稍后再尝试!",
	},
	atelier = {
		roles = {
			ex = "离任职员",
			adm = "工作人员",
			mod = "管理员",
			sent = "版主",
			mc = "地图管理员"
		},
		not_found = " `%s` 这个玩家不存在。",
		registration = "注册日期",
		community = "服务器",
		messages = "信息",
		prestige = "威望",
		title = "称号",
		tribe = "部落",
		visit = "点击查看更详细资料",
		sm = "伴侣",
	},
	translation = "由翻译团队协助翻译 (#%s)\n\n语言: %s (%s)\n内容: ```%s\n%s```\n\n这次的翻译耗时 `%s`.\n_请跟朋友们分享这次的体验吧!_",
	ban = "**你已经被加到翻译团队的伺服器的黑名单!**\n\n```\n%s```\n很抱歉你违反了伺服器里公众频道的规则。",
	kick = "**你已经从翻译团队的伺服器中被踢除!**\n\n```\n%s```\n如果你被多次警告, 你有机会从翻译团队的伺服器中被踢除。请改善你的行为否则会被加到黑名单!",
	sanction = "**你现在收到了一个来自翻译团队的警告!** *(%s/%s)*\n\n```\n%s```你收到了警告! 如果你再收到另一个警告有机会从伺服器中被踢除, 甚至被加到黑名单! 请谨慎你的行为语言, 避免在公众频道制造问题!",	
	unfair_warn = "如果你认为处分不公平, 请联络任何国际首领。你可以使用指令`!team International Leader` 来查询国际首领的昵称。",
	server = {
        owner = "拥有人",
        channels = "频道",
        creation = "创建日期",
        translators = "翻译员",
        members = "成员",
        away = "闲置",
        busy = "请勿打扰",
        people = "总人数",
    },
}
translations.es = {
	command_descriptions = {
		a801 = { "Muestra el perfil de Atelier801 del jugador especificado.", { "(Los tags son necesarios en caso de que no sean #0000)\n!a801 `nombreJugador#0000`" } },
		akinator = { "Empieza una partida de Akinator.",
			{
				"(Partida normal)\n!akinator",
				"(Elige índice de probabilidad)\n!akinator `number [70 - 97]`"
			}
		},
		animal = { "Muestra una foto de un animal aleatorio.", { "!animal" } },
		avatar = { "Muestra el avatar de un usuario específico.",
			{
				"(Tu avatar)\n!avatar",
				"(Avatar de alguien)\n!avatar `@username`",
			}
		},
		coin = { "Realiza un cambio de una moneda a otra (predeterminada = USD)",
			{
				"(Conversión total del dinero)\n!coin `moneda_final moneda_inicial dinero_total`",
				"(Conversión de $1)\n!coin `moneda_final moneda_inicial`",
				"(Conversión de USD)\n!coin `moneda_final dinero_total`",
			}
		},
		color = { "Muestra el color de un código #hexadecimal específico.", { "!color `#hexadecimal`" } },
		define = { "Muestra la definición, sinónimos, antónimos y ejemplos de una palabra en inglés.", { "!define `palabra`"} },
		fact = { "Muestra un factor aleatorio.", { "!fact" } },
		help = { "Muestra el mensaje de Ayuda", { "!help" } },
		invite = { "Muestra el enlace de invitación al servidor del Equipo de Traductores.", { "!invite" } },
		lang = { "Asigna el idioma predeterminado de los comandos públicos para ti", { "!lang `Abreviación_de_la_comunidad`" } },
		languages = { "Muestra una lista de los idiomas disponibles.", { "!languages" } },
		leaderboard = { "Muestra una clasificación con los mejores traductores.",
			{
				"(Normal)\n!leaderboard",
				"(En un rol concreto)\n!leaderboard `@rol`",
				"(Más posiciones)\n!leaderboard `@rol_o_* miembros_totales[3-6]`",	
			}
		},
		meme = { "Muestra un meme aleatorio de Galaktine y compañía.", { "!meme" } },
		message = { "El bot te envía un mensaje privado automáticamente.", { "!message" } },
		momma = { "Muestra un chiste aleatorio sobre ~~tu~~ madre!", { "!momma" } },
		poll = { "Crea una encuesta (Sí/No).", 
			{
				"!poll Pregunta",
				"(Solo para miembros) (Personalizado)\n!poll ` ```pregunta``` tiempo_encuesta` ` `encuesta_opción_1` ` ` ` ` `encuesta_opción_2` ` ` `"
			}
		},
		profile = { "Muestra el perfil de un miembro concreto del equipo.",
			{
				"(Tu perfil)\n!profile",
				"(Perfil de un miembro)\n!profile `username`"
			}
		},
		quote = { "Cita un mensaje antiguo para que puedas responderlo",
			{
				"(Id del mensaje)\n!quote `id_mensaje`",
				"(Id del canal)\n!quote `id_mensaje id_canal`"
			}
		},
		request = { "Envía una petición de traducción al Equipo de Traductores. [1000 caracteres como máximo]", 
			{
				"(Un solo idioma)\n!request `idioma_del_contenido [idioma_solicitado] ```contenido_solicitado``` `",
				"(Varios idiomas)\n!request `idioma_del_contenido [idioma_solicitado1, idioma_solicitado2, ...] ```contenido_solicitado``` `",
				"(Solo miembros) (Todos los idiomas)\n!request `idioma_del_contenido [xx] ```contenido_solicitado``` `",
				"(Módulo Lua [1200 caracteres como máximo])\n!request `idioma_del_contenido [idioma_solicitado1, idioma_solicitado2, ...] ```LUA\ncontenido_solicitado``` `"
			}
		},
		serverinfo = { "Muestra la información disponible del servidor.", { "!serverinfo" } },
		spell = { "Revisa si un texto en inglés está escrito correctamente.", { "!spell `texto`" } },
		team = { "Muestra los miembros en un rol específico.",
			{
				"(Comunidad)\n!team `comunidad`",
				"(Posición)\n!team `rol`",
			}
		},
		thread = {"Muestra la dirección del tema del Equipo de Traductores de Atelier801." , {"!thread `comunidad`" } },
		tree = { "Muestra el árbol de Lua de Atelier801.", { "!tree `tfm.ruta`\n\nEjemplo => `!tree tfm.enum.ground`" } },
		urban = { "Muestra la deficinión de una expresión urbana en inglés.", { "!urban `expresión`" } },
		weather = { "Muestra el clima actual en una ciudad o país en específico.", { "!weather `nombre_ciudad, abreviación_país`" } },
	},
	avatar = "Avatar de %s: [aquí](%s)",
	help_message = "¡Hola, <@!%s>! %sMy prefijo es `!` y para ver de lo que soy capaz de hacer utiliza el comando `!help`. Usa `!command_name ?` para leer un mensaje de ayuda más detallado sobre el comando especificado.",
	command_quantity = "Los comandos disponibles para ti (%s) son:",
	help_welcome = "¡Bienvenido al servidor del Equipo de Traductores!",
	help_permissions = {"TODOS", "TRADUCTOR", "TRADUCTOR DE MÓDULOS", "LEADER", "ADMIN", "DESARROLLADOR DEL DEBUG"},
	help_commands = "Comandos para `%s`",
	invite_link = "Enlace de invitación **público**: %s",
	available_languages = "Idiomas Disponibles",
	leaderboard = "Clasificación",
	global = "Global",
	leaderboard_stats = {"Traductores Públicos", "Comedores de Cookies"},
	message_message = "Hola, %s. ¡Escribe un comando abajo!",
	profile_fields = {
		birthday = "Cumpleaños",
		role = "Rol",
		language = "Idioma",
		translations = "Traducciones Públicas",
		state = "Estado",
		states = { "Activo", "Inactivo" }
	},
	not_translator = "`%s` no es un traductor",
	available_translators = "Puedes ver los traductores disponibles mediante el comando `!team translator`",
	request_help = "Escribe `!request ?` para ver los parámetros disponibles.",
	available_languages = "Los idiomas disponibles son: %s",
	exceeded_char_request = "El pedido ha sido rechazado. ¡El contenido no puede tener más de %s caracteres! Envíalo a través de un mensaje privado en el foro o hazlo más pequeño.",
	request = {
		[1] = "Tu solicitud está en la posición #%s",
		[2] = "El texto de abajo será traducido en los siguientes idiomas: %s"
	},
	request_error = {
		no_content = "Parámetro __contenido_solicitado__ inválido: Debe haber algo para traducir, inserta el contenido.",
		no_language = "Parámetro __idioma_solicitado__ inválido: Debes insertar al menos un idioma al que necesites traducir tu contenido.",
		unavailable_language = "¡Desgraciadamente nuestro equipo no tiene miembros para leer textos en %s!",
		no_content_language = "Parámetro __idioma_del_contenido__ inválido: Debes insertar el idioma del contenido.",
	},
	no_parameters = "Te has olvidado de añadir parámetros en este comando.",
	member_title = "Miembros `%s` (%s)",
	role_not_found = "¡Rol `%s` no encontrado!",
	path_not_found = "¡Ruta `%s` no encontrada!",
	help = "Ayuda",
	command = "Comando",
	akinator_system = {
		timeout = {
			title = "TIEMPO AGOTADO",
			message = "Desgraciadamente has tardado demasiado en contestar",
		},
		fail = {
			title = "Uf, ¡has ganado!",
			message = "No he adivinado cuál es tu personaje :( ¡Te reto a intentarlo de nuevo!",
		},
		step = "Pregunta %s",
		error = "Error de Akinator. :( Inténtalo de nuevo.",
		answer = {
			bet = "Apuesto a que mi predicción es correcta... después de %s preguntas...",
			real = "¡Lo he adivinado en la pregunta %s!",
		}
	},
	standard_language = "Tu idioma estándar ha sido cambiado a `%s`",
	poll = {
		already_exists = "Ya hay una encuesta hecha por ti. Espera a sus resultados antes de comenzar una nueva encuesta.",
		poll = "Encuesta",
		option = {"Sí", "No"},
		ends = "Termina en %s minutos.",
		total = "Cantidad de `\"%s\"`: %s (%s%%)",
		results = "Resultados",
		decision = "Decisión Final: \"%s\"",
		tie = "EMPATE",
	},
	weather = {
		at = "El tiempo en %s",
		temperature = "Temperatura",
		current = "Actual",
		maximum = "Máxima",
		minimum = "Mínima",
		wind = "Velocidad del viento",
		humidity = "Humedad",
		cloud = "Nubosidad",
		rain = "Lluvia",
		snow = "Nieve",
		update = "Última actualización el %s",
		not_found = "La ubicación de `%s` no fue encontrada. ¡Asegúrate de escribir su nombre en Inglés y vuelve a intentarlo nuevamente más tarde!",
	},
	atelier = {
		roles = {
			ex = "Ex-staff",
			adm = "Administrador",
			mod = "Moderador",
			sent = "Centinela",
			mc = "Mapcrew"
		},
		not_found = "El juegador `%s` no existe.",
		registration = "Fecha de registro",
		community = "Comunidad",
		messages = "Mensajes",
		prestige = "Prestigio",
		title = "Título",
		tribe = "Tribu",
		visit = "Visitar perfil",
		sm = "Pareja",
	},
	translation = "Traducido por el Equipo de Traductores (#%s)\n\nIdioma: %s (%s)\nContenido: ```%s\n%s```\n\nSe ha tardado en hacer esta traducción `%s`.\n_¡Comparte la experiencia con tus amigos!_",
	ban = "**¡Has sido baneado en el servidor del Equipo de Traductores!**\n\n```\n%s```\nDesafortunadamente tu comportamiento ha comprometido tu participación en los canales públicos del servidor.",
	kick = "**¡Has sido expulsado del servidor del Equipo de Traductores!**\n\n```\n%s```\nDespués de varias sanciones, has sido expulsado. ¡Piensa en mejorar tu comportamiento o puedes acabar baneado permamentemente en el servidor!",
	sanction = "**¡Has recibido una sanción del servidor del Equipo de Traductores!** *(%s/%s)*\n\n```\n%s```\n¡Has sido sancionado! Si recibes más sanciones puedes acabar expulsado del servidor, ¡o incluso baneado! ¡Revisa tu comportamiento e intenta evitar crear problemas en los canales públicos!",
	unfair_warn = "Si consideras que el castigo es __injusto__, contacta a cualquier Líder Internacional. Revisa sus nombres utilizando el comando `!team International Leader`",
	server = {
        owner = "Propietario",
        channels = "Canales",
        creation = "Creado el",
        translators = "Traductores",
        members = "Miembros",
        away = "Ausente",
        busy = "Ocupado",
        people = "Personas",
    },
}
translations.fr = {
	command_descriptions = {
		a801 = { "Montre le profil d'Atelier801 du joueur indiqué.", { "(Les tags sont nécessaires si il ne sont pas 0000)\n!a801 `playerName#0000`" } },
		akinator = { "Commencez le jeu Akinator.",
			{
				"(Partie régulière)\n!akinator",
				"(Ratio d'ensemble de probabilité)\n!akinator `number [70 - 97]`"
			}
		},
		animal = { "Affiche une image d'animal aléatoire.", { "!animal" } },
		avatar = { "Affiche l'avatar d'un utilisateur spécifique.",
			{
				"(Propre avatar)\n!avatar",
				"(Avatar de quelqu'un)\n!avatar `@username`",
			}
		},
		coin = { "Exécute une conversion monétaire entre deux monnaies. (valeur par défaut = USD)",
			{
				"(Conversion de l'argent total)\n!coin monnaie_ciblée source_monnaie monnaie_total",
				"(Conversion de 1$)\n!coin monnaie_ciblée source_monnaie",
				"(Conversion de USD)\n!coin monnaie_ciblée monnaie_total",
			}
		},
		color = { "Montre la couleur d'un code #hex spécifique.", { "!color `#hexadecimal`" } },
		define = { "Obtient la définition, des synonymes, des antonymes et des exemples d'utilisation d'un mot anglais.", { "!define `word`" } },
		fact = { "Montre un fait aléatoire.", { "!fact" } },
		help = { "Affiche le message d'aide.", { "!help" } },
		invite = { "Affiche le lien d'invitation pour le serveur de l'équipe de Traducteurs.", { "!invite" } },
		lang = { "Met une langue standard pour les commandes publiques pour vous.", { "!lang `flag`" } },
		languages = { "Affiche la liste des langues disponibles.", { "!languages" } },
		leaderboard = { "Affiche un classement avec les meilleurs traducteurs.",
			{
				"(Ordinaire)\n!leaderboard",
				"(Rôle spécifique)\n!leaderboard `@role`",
				"(Plusieurs positions)\n!leaderboard `@role_or_* total_members[3-6]`", 
			}
		},
		meme = { " meme random de Galaktine & Companie.", { "!meme" } },
		message = { "Le bot vous envoie automatiquement un message privé.", { "!message" } },
		momma = { "Montre une plaisanterie aléatoire de ~~votre~~ maman", { "!momma" } },
		poll = { "Créer un sondage (Oui/Non).",
			{
				"!poll Question",
				"(Seulement pour les membres) (Personnalisé)\n!poll ` ```question``` poll_temps` ` `poll_option_1` ` ` ` ` `poll_option_2` ` ` `"
			}
		},
		profile = { "Montre le profil du membre indiqué dans l'équipe.",
			{
				"(Votre profil)\n!profile",
				"(Profil d'un membre)\n!profile username"
			}
		},
		quote = { "Citez un vieux message, donc vous pouvez y répondre.",
			{
				"(Message id)\n!quote `message_id`",
				"(Canal id)\n!quote `message_id canal_id`"
			}
		},
		request = { "Envoie une demande de traduction pour l'équipe de traducteurs. [1000 caractères max]",
			{
				"(Une langue)\n!request `langue_du_contenu [langue_demandée] ```contenu_de_la_demande``` `",
				"(Plusieurs langues)\n!request `langue_du_contenu [langue-demandée1, langue_demandée2, ...] ```contenu_de_la_demande``` `",
				"(Membre seulement) (Toutes les langues)\n!request `langue_du_contenu [xx] ```contenu_de_la_demande``` `",
				"(module lua [1200 caractères max])\n!request `langue_du_contenu [langue_demandée1, langue_demandée2, ...] ```LUA\ncontenu_de_la_demande``` `"
			}
		},
		serverinfo = { "Montre les informations disponibles sur le serveur.", { "!serverinfo" } },
		spell = { "Contrôle si un texte anglais est orthographié correctement.", { "!spell `text`" } },
		team = { "Montre les membres dans le rôle donné.",
			{
				"(Communauté)\n!team `community`",
				"(Position)\n!team `role`",
			}
		},
		thread = { "Afficher le lien du topic Atelier801 de l'équipe des traducteurs.", { "!thread `communauté`" } },
		tree = { "Affiche l'arbre lua d'Atelier801.", { "!tree `tfm.path`\n\nExemple => `!tree tfm.enum.ground`" } },
		urban = { "Obtient la définition d'une expression anglaise.", { "!urban `expression`" } },
		weather = { "Montre la météo actuelle dans la ville/le pays indiqué.", { "!weather `Nom_de_la_ville, abréviation_du_pays`" } },
	},
	avatar = "Avatar de %s : [ici](%s)",
	help_message = "Bonjour, <@!%s>! %sMon préfix est `!` et pour voir de quoi je suis capable, utilise la commande `!help`. Utilise la commande `!command_name ?` pour lire un message d'aide plus détaillé sur la commande indiquée.",
	command_quantity = "Les commandes diponibles pour vous (%s) sont:",
	help_welcome = "Bienvenue sur le serveur de l'équipe de traducteurs!",
	help_permissions = {"TOUT", "TRADUCTEUR", "TRADUCTEUR DE MODULE", "LEADER", "ADMIN", "DÉVELOPPEUR DE DEBUG"},
	help_commands = "Commandes pour `%s`",
	invite_link = "Lien d'invitation **Publique** : %s",
	available_languages = "Langues disponibles",
	leaderboard = "Classement",
	global = "Global",
	leaderboard_stats = {"Traducteurs Publique", "Mangeur de cookie"},
	message_message = "Bonjour, %s. Tapez une commande ci-dessous!",
	profile_fields = {
		birthday = "Anniversaire",
		role = "Rôle",
		language = "Langue",
		translations = "Traductions Publiques",
		state = "Activité",
		states = { "Actif", "Inactif" }
	},
	not_translator = "`%s` n'est pas un traducteur",
	available_translators = "Vous pouvez vérifier les traducteurs disponibles en utilisant la commande `!team translator`",
	request_help = "Type `!request ?` pour lire les paramètres possibles.",
	available_languages = "Les langues disponibles sont: %s",
	exceeded_char_request = "La demande a été refusée. Le contenu ne peut pas contenir plus de %s caractères! Envoyez-le par message privé sur le forum ou rendez-le plus petit.",
	request = {
		[1] = "Votre demande est dans la position #%s",
		[2] = "Le texte ci dessous sera traduit dans les langues suivantes: %s"
	},
	request_error = {
		no_content = "Paramètre_de_contenu_de_demande_invalide: Il doit y avoir quelque chose pour traduire, insérez le contenu.",
		no_language = "Paramètre_de_langue_demandée_invalide: Vous devez insérer au moins une langue que vous avez besoin du contenu traduit.",
		unavailable_language = "Malheureusement notre équipe n'a pas de membres pour lire des textes dans %s!",
		no_content_language = "Paramètre_de_langue_du_contenu_invalide: Vous devez insérer la langue du contenu.",
	},
	no_parameters = "Vous avez oublié d'ajouter des paramètres dans cette commande.",
	member_title = "`%s` membres (%s)",
	role_not_found = "le rôle `%s` n'a pas été trouvé!",
	path_not_found = "Le chemin `%s` n'a pas été trouvé!",
	help = "Aide",
	command = "Commandes",
	akinator_system = {
		timeout = {
			title = "EXPIRATION",
			message = "Malheureusement vous avez pris trop de temps pour répondre",
		},
		fail = {
			title = "Ugh, vous avez gagné!",
			message = "Je n'ai pas compris qui est votre personnage :( Je te défie de recommencer!",
		},
		step = "Question %s",
		error = "Akinator Error. :( Réessayez.",
		answer = {
			bet = "Je parie que mon pressentiment est correct... après %s questions...",
			real = "J'ai compris dans la %sth question!",
		}
	},
	standard_language = "Votre langue principale a été désignée : `%s`",
	poll = {
		already_exists = "Il y a déjà un sondage fait par vous. Attendez ses résultats avant l'ouverture d'un nouveau sondage.",
		poll = "Sondage",
		option = {"Oui", "Non"},
		ends = "Fin dans %s minutes.",
		total = "Total de `\"%s\"`: %s (%s%%)",
		results = "Résultats",
		decision = "Décision Final: \"%s\"",
		tie = "TIE",
	},
	weather = {
		at = "Météo sur %s",
		temperature = "Température",
		current = "Actuel",
		maximum = "Maximum",
		minimum = "Minimum",
		wind = "Vitesse du vent",
		humidity = "Humidité",
		cloud = "Aspect Nuageux",
		rain = "Pluie",
		snow = "Neige",
		update = "Dernière mise à jour à %s",
		not_found = "L'emplacement de `%s` n'a pas été trouvé. Assurez-vous d'écrire son nom en Anglais et réessayez de nouveau plus tard!"
	},
	atelier = {
		roles = {
			ex = "Ex-staff",
			adm = "Administrator",
			mod = "Moderator",
			sent = "Sentinel",
			mc = "Mapcrew"
		},
		not_found = "The player `%s` doesn't exist.",
		registration = "Registration date",
		community = "Community",
		messages = "Messages",
		prestige = "Prestige",
		title = "Title",
		tribe = "Tribe",
		visit = "Visit profile",
		sm = "Âme Sœur",
	},
	translation = "Traduit par l'équipe des traducteurs (#%s)\n\nLangage: %s (%s)\nContenu: ```%s\n%s```\n\nCette traduction a pris `%s`.\n_Partagez l'expérience avec vos amis!_",
	ban = "**Vous avez été banni du serveur de l'équipe des Traducteurs!**\n\n```\n%s```\nMalheureuseent votre comportement a mis en péril votre participation aux chaînes publiques du serveur.",
	kick = "**Vous avez été viré du serveur de l'équipe des Traducteurs!**\n\n```\n%s```\nAprès plusieurs sanctions, on vous a virés. Envisagez d'améliorer votre comportement ou vous pouvez être banni de manière permanente du serveur!",
	sanction = "**Vous avez reçu une sanction du serveur de l'équipe des Traducteurs!** *(%s/%s)*\n\n```\n%s```\nVous avez été sanctionnés! Si vous recevez d'autres sanctions on peut vous virer de ce serveur, ou même bannis! Vérifiez votre comportement et faites de votre mieux pour éviter de créer de nouveaux problèmes sur les chaînes publiques!",
	unfair_warn = "Si vous trouvez la punition __injuste__, contactez n'importe quel Leader International. Vérifiez leurs pseudos utilisant la commande `!team International Leader`",
	server = {
        owner = "Propriétaire",
        channels = "Salons",
        creation = "Créé dans",
        translators = "Traducteurs",
        members = "Membres",
        away = "Indisponible",
        busy= "Occupé",
        people = "Gens",
    },
}
translations.he = {
	command_descriptions = {
		a801 = { "מראה את פרופיל הפורום של שחקן מסויים.", { "(צריך תיוג אם המספר הוא לא 0000)\n!a801 `playerName#0000`" } },
		akinator = { "מתחיל משחק של אקינאטור",
			{
			"(משחק רגיל)\n!akinator",
			"(הגדרת יחס הסתברות)\n!akinator `number [70 - 97]`"
			}
		},
		animal = { "מראה תמונה אקראית של חיה", { "!animal" } },
		avatar = { "מראה אווטאר של משתמש מסויים",
			{
			"(אווטאר עצמי)\n!avatar",
			"(אווטאר של מישהו)\n!avatar `@username`",
			}
		},
		coin = { "(מבצע המרת מטבע בין שני מטבעות. (ברירת מחדל = USD",
			{
				"(המרה של כל הסכום)\n!coin `target_currency source_currency total_money`",
				"(המרה של $1)\n!coin `target_currency source_currency`",
				"(המרה מ USD)\n!coin `target_currency total_money`",
			}
		},
		color = { "מראה את הצבע הספציפי של קוד הקסדצימל.", { "!color `#hexadecimal`" } },
		define = { "מראה את ההגדרה, מילים נרדפות, מילים הפוכות ודוגמא באנגלית", { "!define `מילה`" } },
		fact = { "מראה עובדה אקראית.", { "!fact" } },
		help = { "מראה את הודעת העזרה", { "!help" } },
		invite = { "מראה את קישור ההזמנה לקבוצת המתרגמים", { "!invite" } },
		lang = { "מגדיר את השפה עבור הפעולות הציבוריות עבורך", { "!lang `flag`" } },
		languages = { "מראה רשימה של השפות האפשריות", { "!languages" } },
		leaderboard = { "מראה את טבלת המובילים עם המתרגמים הטובים ביותר",
			{
			"(רגיל)\n!leaderboard",
			"(תפקיד מסויים)\n!leaderboard `@תפקיד`",
			"(תפקידים נוספים)\n!leaderboard `@role_or_* total_members[3-6]`", 
			}
		},
		meme = { "מים רנדומלי של המנהלים", { "!meme" } },
		message = { "הבוט שולח לך הודעה פרטית אוטמוטית", { "!message" } },
		momma = { "מראה בדיחה אקראית על אמא ~~שלך~~!", { "!momma" } },
		poll = { "לערוך הצבעה (כן/לא).",
			{
				"!poll שאלה",
				"(התאמה) (חבר בלבד)\n!poll ` ```question``` poll_time` ` `poll_option_1` ` ` ` ` `poll_option_2` ` ` `"
			}
		},
		profile = { "מראה את הפרופיל של חבר מסויים",
			{
			"(פרופיל עצמי)\n!profile",
			"(פרופיל חבר)\n!profile `username`"
			}
		},
		quote = { "מצטט הודעה ישנה כך שתוכל לענות עליה.",
				{
					"(ההודעה)\n!quote `message_id`",
					"(הערוץ)\n!quote `message_id channel_id`"
				}
			},
		request = { "שולח בקשת תרגום לקבוצה [1000 תווים מקסימום]",
			{
			"(שפה אחת)\n!request `content_language [request_language] ```request_content``` `",
			"(מספר שפות)\n!request `content_language [request_language1, request_language2, ...] ```request_content``` `",
			"(חברים בלבד) (All the languages)\n!request `content_language [xx] ```request_content``` `",
			"(מודול LUA [1200 characters max])\n!request `content_language [request_language1, request_language2, ...] ```LUA\nrequest_content``` `"
			}
		},
		serverinfo = { "מראה את המידע הזמין על השרת.", { "!serverinfo" } },
		spell = { "בודק אם טקטט באנגלית אויית כראוי", { "!spell `טקסט`" } },
		team = { "מראה את החברים בתפקיד הספציפי",
			{
			"(קהילה)\n!team `קהילה`",
			"(תפקיד)\n!team `תפקיד`",
			}
		},
		thread = { "מראה את הלינק לאשכול קבוצת המתרגמים בפורום הרשמי.", { "!thread `קהילה`" } }, 
		tree = { ".Atelier801 של LUAמראה את עץ ה", { "!tree `tfm.path`\n\nדוגמא => `!tree tfm.enum.ground`" } },
		urban = { "מראה את ההגדרה של ביטוי באנגלית", { "!urban `ביטוי`" } },
		weather = { "מראה את המזג אוויר בעיר/מדינה המצוינת.", {"!weather `שם_העיר, ראשי_תיבות_של_הארץ`"} },
	},
	help_message = "שלום, <@!%s>! %sהקידומת שלי היא `!` וכדי לראות מה אני מסוגל לעשות, השתמשו בפעולה `!help`. השתמשו בפעולה`!command_name ?` כדי לקרוא תיאור יותר מורחב על הפעולה הספציפית.",
	avatar = "%sאווטר של: [hכאן](%s)",
	command_quantity = "הפעולות שאתה יכול להשתמש בהן (%s) הן:",
	help_welcome = "!ברוכים הבאים לשרת של קבוצת המתרגמים",
	help_permissions = {"הכל", "מתרגם", "מתרגם מודול", "LEADER", "מנהל", "מפתח דה-באג"},
	help_commands = "פקודות עבור `%s`",
	invite_link = "**ציבורי** invite link: %s",
	available_languages = "שפות אפשריות",
	leaderboard = "טבלת המובילים",
	global = "גלובלי",
	leaderboard_stats = {"מתרגמים ציבוריים", "אוכלי עוגיות"},
	message_message = "שלום, %s. !הקלד פקודה למטה",
	profile_fields = {
		birthday = "יום הולדת",
		role = "תפקיד",
		language = "שפות",
		translations = "תירגומים ציבוריים",
		state = "מצב",
		states = { "פעיל", "לא פעיל" }
	},
	not_translator = "`%s` לא מתרגם",
	available_translators = "אתה יכול לבדוק את המתרגמים האפשריים בפקודה `!team translator`",
	request_help = "הקלד `!request ?` כדי לקרוא על הפרמטרים האפשריים",
	available_languages = "השפות האפשריות הן: %s",
	exceeded_char_request = "בקשה זו סורבה. תשלח אותה דרך הודעה פרטית בפורום או הקטן אותה. התוכן שלך לא יכול להכיל יותר מ %s תווים!",
	request = {
	[1] = "בקשתך נמצאת במקום #%s",
	[2] = "הטקסט למטה יתורגם לשפות הבאות: %s"
	},
	request_error = {
	no_content = "לא חוקי __request_content__ parameter: חייב להיות משהו לתרגם, הכנס את התוכן",
	no_language = "לא חוקי __request_language__ parameter: עליך להכניס לפחות שפה אחת אליה הבקשה תתורגם",
	unavailable_language = "לצערנו, אין לנו מתרגמים לשפה %s!",
	no_content_language = "לא חוקי __content_language__ parameter: עליך להכניס את השפה של התוכן",
	},
	no_parameters = "שכחת להכניס את הפרמטרים עבור הפעולה",
	member_title = "`%s` חברים (%s)",
	role_not_found = "תפקיד `%s` לא נמצא!",
	path_not_found = "שביל `%s` לא נמצא!",
	help = "עזרה",
	command = "פעולה",
	akinator_system = {
	timeout = {
		title = "נגמר זמן",
		message = "לרוע המזל, לקח לך יותר מדי זמן לענות",
	},
	fail = {
		title = "אוף, ניצחת!",
		message = "לא הצלחתי לזהות את דמותך :( אני מאתגר אותך לנסות שוב!",
	},
	step = "צעד %s",
	error = "שגיאת אקינאטור :( נסה שוב",
	answer = {
		bet = "אני בטוח שהרגשת הטן שלי נכון אחרי... %s צעדים...",
		real = "זיהיתי את דמותך לאחר %s צעדים!",
	}
	},
	standard_language = "השפה הסטנדרית שונתה ל `%s`",
	poll = {
		already_exists = "יש כבר הצבעה שנערכה על ידך. חכה עד שיהיו תוצאות לפני שתוכל לערוך הצבעה חדשה",
		poll = "הצבעה",
		option = {"כן", "לא"},
		ends = "נגמר בעוד %s דקות.",
		total = "מספר כלל של`\"%s\"`: %s (%s%%)",
		results = "תוצאות",
		decision = "החלטה סופית: \"%s\"",
		tie = "תיקו",
	},
	weather = {
		at = "%s מזג אוויר ב",
		temperature = "טמפרטורה",
		current = "נוכחי",
		maximum = "מקסימום",
		minimum = "מינימום",
		wind = "מהירות הרוח",
		humidity = "לחות",
		cloud = "עננים",
		rain = "גשם",
		snow = "שלג",
		update = "עדכון אחרון ב %s",
		not_found = "המיקום של`%s` לא נמצא. וודאו לכתוב את השם באנגלית ונסו שוב מאוחר יותר!",

	},
	atelier = {
		roles = {
			ex = "צוות לשעבר",
			adm = "אחראי",
			mod = "מנהל",
			sent = "מנהל פורום",
			mc = "חבר צוות מפות"
		},
		not_found = "המשתמש`%s` לא קיים.",
		registration = "תאריך הרשמה",
		community = "קהילה",
		messages = "הודעות",
		prestige = "לייקים",
		title = "תואר",
		tribe = "שבט",
		visit = "בקר בפרופיל",
		sm = "נפש תאומה",
	},
	translation = "תורגם על ידי קבוצת המתרגמים (#%s)\n\nשפה: %s (%s)\nתוכן: ```%s\n%s```\n\nהתרגום לקח `%s`.\n_שתף את החוויה עם חבריך_",
	ban = "**קיבלת הרחקה מהשרת של קבוצת המתרגמים!**\n\n```\n%s```\nלצערינו, התנהגותך סיכנה את השתתפותך בערוצים הפומביים של השרת.",
	kick = "**הועפת מהשרת של קבוצת המתרגמים!**\n\n```\n%s```\nלאחר מספר סנקציות, הועפת. אנא שקול לשפר את התנהגותך או שיש סיכוי שתקבל הרחקה לצמיתות מהשרת!",
	sanction = "**קיבלת סנקציה מהשרת של קבוצת המתרגמים!** *(%s/%s)*\n\n```\n%s```\nקיבלת סנקציה! אם תקבל עוד סנקציות, ישנו סיכוי שתורחק מהשרת, ואפילו לצמיתות! בדוק את התנהגותך, ועשה ככל שביכולתך להימנע מיצירת בעיות חדשות בערוצים בפומביים!",
	unfair_warn = "אם מצאת את העונש -_לא_הוגן_, צור קשר אם מנהיג בינלאומי. בדוק את הכינויים שלהם על ידי הפעולה `!team International Leader`",
	server = {
        owner = "בעלים",
        channels = "ערוצים",
        creation = "יצירה",
        translators = "מתרגמים",
        members = "חברים",
        away = "לא כאן",
        busy = "עסוקים",
        people = "אנשים",
    },
}
translations.hr = {
	command_descriptions = {
		a801 = { "Prikazuje Atelier801 profil od specifičnog igrača.", { "(Brojevi su potrebni ako nisu 0000)\n!a801 `imeIgrača#0000`" } },
		coin = { "Konvertuje ti dve valute. (default = USD)",
			{
				"(Konvertovanje totalnog novca)\n!coin target_currency source_currency total_money",
				"(Konvertovanje od $1)\n!coin target_currency source_currency",
				"(Konvertovanje iz USD)\n!coin target_currency total_money",
			}
		},
		fact = { "Prikazuje nasumične činjenice.", { "!fact" } },
		momma = { "Prikaže šalu o ~~tvojoj~~ mamiii!", { "!momma" } },
		poll = { "Napravlja poll (Da/Ne).",
			{
				"!poll Pitanje",
				"(Član Samo) (Prilagodi)\n!poll ` ```pitanje``` poll_vreme` ` `poll_opcija_1` ` ` ` ` `poll_opcija_2` ` ` `"
			}
		},
		quote = { "Prikazuje ti staru poruku tako da je možeš odgovoriti",
			{
				"(Poruka id)\n!quote `poruka_id`",
				"(Kanal id)\n!quote `poruka_id kanal_id`"
			}
		},
		serverinfo = { "Pokazuje nam dostupne informacije o serveru.", { "!serverinfo" } },
		thread = { "Prikazuje od atelier801 tim prevodilaca link. ", { "!tema `zajednica`" } },
		weather = { "Pokazute ti trenutno vreme u speficičnom gradu/državi.", { "!weather `ime_grada, država`" } },
	},
	help_message = "Zdravo, <@!%s>! %sMoj prefiks je `!` i da vidiš na šta sam sve sposoban, probaj komandu `!help`. Koristi komandu `!command_name ?` da pročitaš malo više u detaljima pomoć poruke za specifičnu komandu.",
	exceeded_char_request = "Tvoj zahtev je bio odbijen. Voj text ne može da sadrži više od %s elemenata! Pošalji je putem privatne poruke na forumu ili je napravi manjom.",
	standard_language = "Tvoj jezik je podešen na `%s`",
	poll = {
		already_exists = "Već je poll napravljeno od strane tebe. Sačekaj rezultate pre ponovnog pravljenja.",
		poll = "Poll",
		option = {"Da", "Ne"},
		ends = "Završava u roku od %s minuta.",
		total = "Ukupno \"%s\": %s (%s%%)",
		results = "Rezultati",
		decision = "Zadnja odluka: \"%s\"",
		tie = "Nerešeno",
	},
	weather = {
		at = "Vreme u %s",
		temperature = "Temperatura",
		current = "Trenutno",
		maximum = "Maksimalno",
		minimum = "Minimulno",
		wind = "Brzina vetra",
		humidity = "Vlažnost",
		cloud = "Oblaćnost",
		rain = "Kiša",
		snow = "Sneg",
		update = "Poslednji update u %s",
		not_found = "Lokacija od `%s` nije pronađena. Napiši njegovo ime na engleskom jeziku i pokušaj posle ponovo!",
	},
	atelier = {
		roles = {
			ex = "Ex-staff",
			adm = "Administrator",
			mod = "Moderator",
			sent = "Sentinel",
			mc = "Mapcrew"
		},
		not_found = "Igrač `%s` nepostoji",
		registration = "Datum registracije",
		community = "Zajednica",
		messages = "Poruke",
		prestige = "Prestiž",
		title = "Naslov",
		tribe = "Pleme",
		visit = "Poseti profil",
		sm = "Partner/ka",
	},
	translation = "Prevođeno od strane 'The Translators Team' (#%s)\n\nLanguage: %s (%s)\nTekst: ```%s\n%s```\n\nZa ovaj prevod trebalo je `%s`.\n_Pobeli svoje iskustvo sa svojim prijateljima!_",
	ban = "**Dobili ste ban od Translators Team servera!**\n\n```\n%s```\nNažalost tvoje ponašanje nije bilo dobro u public kanalima od servera.",
	kick = "**Izbačeni ste iz servera Translators Tima!**\n\n```\n%s```\nPosle nekoliko sankcija, dobio/la si izbačenje. Pokušaj da promeniš svoje ponašanje ili bi ti mogao/la biti i zauvek izbačen/a sa servera!",
	sanction = "**Dobili ste sankciju od Translators Tima servera!** *(%s/%s)*\n\n```\n%s```\nDobio/la si sankciju! Ako dobiješ još neke sankcije, možeš biti izbačen/a sa servera, ili čak i banovana! Proveri svoje ponašanje i pokušaj najbolje što možeš da izbegavaš stvaranje novih problema u public kanalima!",
	unfair_warn = "Ako misliš da je kazna __unfair__, kontaktiraj bilo kog International Leader. Proveri njihovo ime koristeći komandu `!team International Leader`",
	server = {
        owner = "Vlasnik",
        channels = "Kanali",
        creation = "Napravljen od",
        translators = "Prevodilaci",
        members = "Članovi",
        away = "Odsutan",
        busy = "Zauzet",
        people = "Ljudi",
    },
}
translations.hu = {
	command_descriptions = {
		a801 = { "Kijelzi az Atelier801 profilját a megadott játékosnak.", { "(A # számok szükségesek, ha nem 0000-ás.)\n!a801 `játékosNév#0000`" } },
		akinator = { "Elkezd egy Akinator játékot.",
			{
				"(Rendes játék)\n!akinator",
				"(Beállít egy valószínűség arányt)\n!akinator `szám [70 - 97]`"
			}
		},
		animal = { "Kiad egy véletlenszerű állatról egy képet.", { "!animal" } },
		avatar = { "Kiadja a felhasználóképét egy bizonyos embernek.",
			{
				"(Saját felhasználókép)\n!avatar",
				"(Más felhasználóképe)\n!avatar `@felhasználónév`",
			}
		},
		coin = { "Elvégez egy pénzváltási folyamatot két ország valutája között (alapértelmezett = USD)",
			{
				"(Teljes összeg átváltása)\n!coin `cél_pénznem alap_pénznem pénz_összeg`",
				"($1 átváltása)\n!coin `cél_pénznem alap_pénznem`",
				"(USD-ről váltás)\n!coin `cél_pénznem pénz_összeg`",
			}
		},
		color = { "Kiadja a színkódját egy bizonyos #hex kódnak.", { "!color `#hexadecimális`" } },
		define = { "Kiírja a leírását, szinonímáit, antonímáit és példákat a használatára az egyik angol szónak", { "!define `szó`" } },
		fact = { "Leír véletlenszerűen egy tényt", { "!fact" } },
		help = { "Kiírja a segítségeket.", { "!help" } },
		invite = { "Kiírja a meghívó kódot a Fordítók Csapata discordjának.", { "!invite" } },
		lang = { "Beállít egy alap nyelvet a nyílvános parancsoknak", { "!lang `zászló`" } },
		languages = { "Kiírja az elérhető nyelveket.", { "!languages" } },
		leaderboard = { "Kiír egy ranglistát a legjobb fordítókról.",
			{
				"(Általános)\n!leaderboard",
				"(Bizonyos szerepkörben lévő)\n!leaderboard `@szerepkör`",
				"(Több pozíció)\n!leaderboard `@szerepkör_vagy_* minden tag [3-6]`",	
			}
		},
		meme = { "Véletlenszerű meme a Galaktine & Company-től.", { "!meme" } },
		message = { "A bot automatikusan küldd neked egy véletlenszerű üzenetet", { "!message" } },
		momma = { "Mutat egy véletlenszerű viccet a ~te~ anyukádról!", { "!momma" } },
		poll = { "Készít egy szavazást (Igen/Nem).",
			{
				"!poll Kérdés",
				"(Csak Tagoknak) (Személyre szabható)\n!poll kérdés szavazás_idő szavazás_válasz_1 szavazás_válasz_2"
			}
		},
		profile = { "Kiírja a profilját bizonyos tagoknak.",
			{
				"(A profilod)\n!profile",
				"(Más tag profilja)\n!profile `felhasználónév`"
			}
		},
		quote = { "Idéz egy régi üzenetet, hogy tudj rá válaszolni.",
			{
				"(Üzenet ID)\n!quote `üzenet_id`",
				"(Csatorna ID)\n!quote `üzenet_id csatorna_id`"
			}
		},
		request = { "Elküldd egy kérelmet a Fordítók Csapatának [1000 karakter max]", 
			{
				"(Egy nyelvre)\n!request `tartalom_nyelve [kérelem_nyelve] ```kérelem_tartalma``` `",
				"(Több nyelvre)\n!request `tartalom_nyelve [kérelem_nyelve1, kérelem_nyelve2, ...] ```kérelem_tartalma``` `",
				"(Csak tagoknak) (Minden nyelvre)\n!request `tartalom_nyelve [xx] ```kérelem_tartalma``` `",
				"(Lua modul [1200 karakter max])\n!request `tartalom_nyelve [kérelem_nyelve1, kérelem_nyelve2, ...] ```LUA\nkérelem_tartalma``` `"
			}
		},
		serverinfo = { "Megmutatja az elérhető információkat a szerverről.", { "!serverinfo" } },
		spell = { "Ellenőrzi, hogy egy angol tartalom helyesen van-e írva", { "!spell `szöveg`" } },
		team = { "Kiírja a tagokat egy bizonyos szerepkörrel.",
			{
				"(Közösség)\n!team `közösség`",
				"(Szerepkör)\n!team `szerepkör`",
			}
		},
		thread = { "Megmutatja az Atelier801-en található fordító csapat témának a linkjét.", { "!thread `közösség`"} },
		tree = { "Kiírja a Transformice Lua fáját.", { "!tree `tfm.path`\n\nPélda => `!tree tfm.enum.ground`" } },
		urban = { "Kiadja a magyarázatát egy angol kifejezésnek.", { "!urban `kifejezés`" } },
		weather = { "Megmutatja a jelenlegi időjárást a megadott városban/országban.", { "!weather `város_név ország_rövidítése`" } },
	},
	avatar = "%s profilképe: [itt](%s)",
	help_message = "Helló, <@!%s>! %sA parancsaim a `!` jellel kezdődnek, és hogy megtudd, mire vagyok képes, használd a `!help` parancsot. Használd a `!command_name ?` parancsot, hogy kapj egy részletes leírást a megadott parancsról.",
	command_quantity = "Az elérhető parancsok számodra (%s) a következők:",
	help_welcome = "Üdv a Fordítók Csapata szerveren!",
	help_permissions = {"MINDENKI", "FORDÍTÓ", "MODUL FORDÍTÓ", "LEADER", "ADMIN", "FEJLESZTŐ DEBUG"},
	help_commands = "Parancsok `%s` számára",
	invite_link = "**Nyílvános** meghívó link: %s",
	available_languages = "Elérhető Nyelvek",
	leaderboard = "Ranglista",
	global = "Teljes",
	leaderboard_stats = {"Nyílvános Fordítók", "Sütievők"},
	message_message = "Helló, %s. Írj egy parancsot!",
	profile_fields = {
		birthday = "Születésnap",
		role = "Szerepkör",
		language = "Nyelv",
		translations = "Nyílvános Fordítások",
		state = "Állapot",
		states = { "Aktív", "Inaktív" }
	},
	not_translator = "`%s` nem egy Fordító",
	available_translators = "Megnézheted az elérhető Fordítók listáját a `!team translator` paranccsal",
	request_help = "Írd be a `!request ?` parancsot, hogy elolvasd a lehetséges paramétereket.",
	available_languages = "Az elérhető nyelvek: %s",
	exceeded_char_request = "A kérelmedet elutasítottuk. A tartalom nem tartalmazhat több karaktert, mint %s! Küldd el privát üzenetként a fórumon vagy kicsinyítsd le a szöveget.",
	request = {
		[1] = "A kérelmed a #%s pozícióban van",
		[2] = "A lent lévő szöveg a következő nyelvekre lesz fordítva: %s"
	},
	request_error = {
		no_content = "Érvénytelen __kérelem_tartalom__ paraméter: Muszáj valaminek lenni, amit lefordíthatunk. Írj be a szöveget.",
		no_language = "Érvénytelen __kérelem_nyelve__ paraméter: Muszáj legalább egy nyelvet beírnod, amelyikre leakarod fordítani a szövegedet.",
		unavailable_language = "Sajnos a csapatunkban nincs olyan tag, aki %s nyelvről tud fordítani!",
		no_content_language = "Érvénytelen __tartalom_nyelv__ paraméter: Muszáj beírnod a tartalmad nyelvét.",
	},
	no_parameters = "Elfelejtettél paramétereket megadni ehhez a parancshoz.",
	member_title = "`%s` tagok (%s)",
	role_not_found = "A `%s` szerepkör nem létezik",
	path_not_found = "A `%s` rendszer nem létezik!",
	help = "Segítség",
	command = "Parancs",
	akinator_system = {
		timeout = {
			title = "IDŐTÚLLÉPÉS",
			message = "Sajnos sok időbe telt válaszolnod.",
		},
		fail = {
			title = "Ugh, nyertél!",
			message = "Nem tudtam kitalálni, hogy ki a karaktered :( Legközelebb sikerülni fog!",
		},
		step = "Kérdés %s",
		error = "Akinator Hiba. :( Próbáld újra.",
		answer = {
			bet = "A tippem biztos helyes... %s kérdés után...",
			real = "Kitaláltam a %s. kérdés után!",
		}
	},
	standard_language = "Az alapértelmezett nyelv mostantól `%s`",
	poll = {
		already_exists = "Már készítettél egy szavazást. Várj, amíg a jelenlegi szavazásod lezárul, hogy újat kezdj.",
		poll = "Szavazás",
		option = {"Igen", "Nem"},
		ends = "%s percen belül véget ér.",
		total = "Maximum \"%s\" szavazatok száma: %s (%s%%)", -- példa: Maximum "Igen" szavazatok száma: 10 (30%)
		results = "Eredmények",
		decision = "Végső döntés: \"%s\"",
		tie = "DÖNTETLEN",
	},
	weather = {
		at = "Időjárás itt:",
		temperature = "Hőmérséklet",
		current = "Jelenlegi",
		maximum = "Maximum",
		minimum = "Minimum",
		wind = "Szélsebesség",
		humidity = "Páratartalom",
		cloud = "Felhők",
		rain = "Eső",
		snow = "Hó",
		update = "Az utolsó frissítés %s időpontban történt.",
		not_found = "A `%s` helye nem található. Írd a nevét Angolul és próbáld újra később!",
	},
	atelier = {
		roles = {
			ex = "Régi-személyzet",
			adm = "Adminisztrátor",
			mod = "Moderátor",
			sent = "Sentinel",
			mc = "Pálya legénység"
		},
		not_found = "`%s` játékos nem létezik.",
		registration = "Regisztráció ideje",
		community = "Közösség",
		messages = "Üzenetek",
		prestige = "Hírnév",
		title = "Cím",
		tribe = "Törzs",
		visit = "Profil meglátogatása",
	},
	translation = "A Fordítók Csapata fordította. (#%s)\n\nNyelv: %s (%s)\nTartalom: ```%s\n%s```\n\nEz a fordítás `%s` időbe telt.\n_Oszd meg a tapasztalataidat a barátaiddal!_",
	ban = "**Tiltva lettél a Fordítók Csapata szerveréről!**\n\n```\n%s```\nSajnos a viselkedésed miatt nem engedhetjük meg, hogy továbbra is csevegni tudj a szerver nyílvános chatszobáiban.",
	kick = "**Ki lettél dobva a Fordítók Csapata szerveréről!**\n\n```\n%s```\nTöbb figyelmeztetés után ki lettél dobva. Próbálj javítani a viselkedéseden, vagy akár véglegesen is kitilthatunk a szerverről!",
	sanction = "**Figyelmeztetést kaptál a Fordítók Csapata szerveren!** *(%s/%s)*\n\n```\n%s```\nFigyelmeztetés! Ha több figyelmeztetést kapsz, akkor kidobhatunk, vagy akár ki is tilthatunk a szerverről! Figyelj a viselkedésedre és ne okozz problémákat a nyílvános chatszobákban!",
	unfair_warn = "Ha a büntetést __nem találod jogosnak__, vedd fel a kapcsolatot bárnely Nemzetközi Vezetővel. Nézd meg a nevüket a `!team International Leader` paranccsal!",
	server = {
        owner = "Tulajdonos",
        channels = "Csatornák",
        creation = "Létrehozás dátuma:",
        translators = "Fordítók",
        members = "Tagok",
        away = "Nincs a gépnél",
        busy = "Elfoglalt",
        people = "Emberek",
    },
}
translations.lv = {
	command_descriptions = {
		a801 = { "Attēlo Atelier801's profilu no norādītā spēlētāja.", { "(Tagi ir nepieciešami ja tie nav 0000)\n!a801 `spēlētājaVārds#0000`" } },
		akinator = { "Palaiž Akinator spēli.",
			{
				"(Parasta spēle)\n!akinator",
				"(Uzstādīt varbūtības koeficientu)\n!akinator `number [70 - 97]`"
			}
		},
		animal = { "Attēlo nejaušu dzīvnieka bildi.", { "!animal" } },
		avatar = { "Attēlo specifiska lietotāja avatāru.",
			{
				"(Paša avatārs)\n!avatar",
				"(Kāda avatārs)\n!avatar `@username`",
			}
		},
		coin = { "Izdara valūtas konversiju starp divām valūtām. (noklusējuma = USD)",
			{
				"(Konversija no kopējās naudas)\n!coin `izvēlētā_valūta avota_valūta kopējā_nauda`",
				"(Konversija no $1)\n!coin `izvēlētā_valūta avota_valūta`",
				"(Konversija no USD)\n!coin `izvēlētā_valūta kopējā_nauda`",
			}
		},
		color = { "Attēlo krāsu no specifiska #hex koda.", { "!color `#hexadecimal`" } },
		define = { "Dabū definīciju, sinonīmus, antonīmus un lietošanas piemērus no angļu vārda.", { "!define `vārds`" } },
		fact = { "Parāda nejaušu faktu.", { "!fact" } },
		help = { "Attēlo Palīdzības ziņu.", { "!help" } },
		invite = { "Attēlo uzaicinājuma saiti priekš Tulkošanas komandas servera.", { "!invite" } },
		lang = { "Uzstāda Jums standarta valodu priekš publiskajām pavēlēm.", { "!lang `karogs`" } },
		languages = { "Attēlo pieejamo valodu sarakstu.", { "!languages" } },
		leaderboard = { "Attēlo līderu sarakstu ar labākajiem tulkotājiem.",
			{
				"(Parasts)\n!leaderboard",
				"(Specifiska loma)\n!leaderboard `@role`",
				"(Vēl pozīcijas)\n!leaderboard `@role_or_* total_members[3-6]`",	
			}
		},
		meme = { "Nejaušs meme no Galaktine & Kompānijas.", { "!meme" } },
		message = { "Bots automātiski nosūta jums privātu ziņu.", { "!message" } },
		momma = { "Parāda nejaušu joku par ~~tavu~~ mammu!", { "!momma" } },
		poll = { "Izveidot aptauju (Jā/Nē).",
			{
				"!poll Jautājums",
				"(Biedriem tikai) (Pielāgots)\n!poll ` ```jautājums``` aptaujas_laiks` ` `aptaujas_opcija_1` ` ` ` ` `aptaujas_opcija_2` ` ` `"
			}
		},
		profile = { "Attēlo profilu no specifiska komandas biedra.",
			{
				"(Jūsu profils)\n!profile",
				"(Biedra profils)\n!profile `username`"
			}
		},
		quote = { "Citē vecu ziņu, lai tu varētu atbildēt.",
			{
				"(Ziņas id)\n!quote `ziņas_id`",
				"(Kanāla id)\n!quote `ziņas_id kanāla_id`"
			}
		}, 
		request = { "Nosūta tulkošanas pieprasījumu priekš Tulkošanas Komandas. [1000 zīmes maksimums]", 
			{
				"(Viena valoda)\n!request `satura_valoda [pieprasījuma_valoda] ```pieprasījuma_saturs``` `",
				"(Vairākas valodas)\n!request `satura_valoda [pieprasījuma_valoda1, pieprasījuma_valoda2, ...] ```pieprasījuma_saturs``` `",
				"(Biedriem tikai) (Visas valodas)\n!request `satura_valoda [xx] ```pieprasījuma_saturs``` `",
				"(Lua modulis [1200 simboli maksimums])\n!request `satura_valoda [pieprasījuma_valoda1, pieprasījuma_valoda2, ...] ```LUA\npieprasījuma_saturs``` `"
			}
		},
		serverinfo = { "Parāda pieejamo informāciju par serveri.", { "!serverinfo" } },
		spell = { "Pārbauda vai angļu teksts ir uzrakstīts pareizi.", { "!spell `teksts`" } },
		team = { "Attēlo biedra doto lomu.",
			{
				"(Kopiena)\n!team `kopiena`",
				"(Pozīcija)\n!team `loma`",
			}
		},
		thread = { "Parāda atelier801 tulkotāju komandas tēmas saiti.", { "!thread `kopiena`" } },
		tree = { "Attēlo Atelier801 Lua koku.", { "!tree `tfm.taka`\n\nPiemērs => `!tree tfm.enum.ground`" } },
		urban = { "Dabū definīciju no angļu pilsētas izpausmes.", { "!urban `izpausme`" } },
		weather = { "Parāda pašreizējos laikapstākļus norādītajā pilsētā/valstī.", { "!weather `pilsētas_vārds, valsts_saīsinājums`" } },
	},
	avatar = "%s`s avatārs: [šeit](%s)",
	command_quantity = "Pieejamās pavēles priekš Jums (%s) ir:",
	help_welcome = "Esiet sveicināti Tulkošanas Komandas serverī!",
	help_permissions = {"VISI", "TULKOTĀJS", "MODUĻA TULKOTĀJS", "LEADER", "ADMINISTRATORS", "IZSTRĀDĀTĀJA ATKĻŪDOŠANA"},
	help_commands = "Pavēles 4 `%s`",
	invite_link = "**Publisks** uzaicinājuma saite: %s",
	available_languages = "Pieejamās Valodas",
	leaderboard = "Līderu saraksts",
	global = "Global",
	leaderboard_stats = {"Publiskie Tulkotāji", "Cepumu Ēdāji"},
	message_message = "Sveiki, %s. Ievadiet pavēli zemāk!",
	profile_fields = {
		birthday = "Dzimšanas diena",
		role = "Loma",
		language = "Valoda",
		translations = "Publiskie Tulkojumi",
		state = "Stāvoklis",
		states = { "Aktīvs", "Neaktīvs" }
	},
	not_translator = "`%s` nav tulkotājs",
	available_translators = "Jūs varat pārbaudīt pieejamos tulkotājus izmantojot pavēli `!team translator`",
	request_help = "Ievadiet `!request ?` lai izlasītu pieejamos parametrus.",
	available_languages = "Pieejamās valodas ir: %s",
	exceeded_char_request = "Šis pieprasījums tika noraidīts. Tavam saturam nedrīkst būt vairāk kā %s zīmes! Sūtiet to cauri privātajai ziņai uz forumu vai pataisiet to mazāku.",
	request = {
		[1] = "Jūsu pieprasījums ir #%ā pozīcijā ",
		[2] = "Teksts zemāk tiks iztulkots sekojošās valodās: %s"
	},
	request_error = {
		no_content = "Nederīga __pieprasījuma_satura__ parametrs: Ir jābūt kaut kam ko tulkot, ievietojiet saturu.",
		no_language = "Nederīga __pieprasījuma_valoda__ parametrs: Jums ir jāievada vismaz viena valoda, kurā Jūs gribat saturu iztulkotu.",
		unavailable_language = "Diemžēl mūsu komandai nav biedru lai izlasītu tekstus %s!",
		no_content_language = "Nederīga __satura_valoda__ parametrs: Jums ir jāievieto satura valoda.",
	},
	no_parameters = "Jūs aizmirsāt pievienot parametrus šai pavēlei.",
	member_title = "`%s` biedri (%s)",
	role_not_found = "Loma `%s` nav atrasta!",
	path_not_found = "Taka `%s` nav atrasta!",
	help = "Palīdzība",
	command = "Pavēle",
	akinator_system = {
		timeout = {
			title = "TAIMAUTS",
			message = "Diemžēl Jūs paņēmāt pārāk daudz laika, lai atbildētu",
		},
		fail = {
			title = "Ugh, Jūs uzvarējāt!",
			message = "Es neizdomāju kas ir Jūsu tēls. :( Es uzdrošinos Jūs mēģināt vēlreiz!",
		},
		step = "Soļi %s",
		error = "Akinator Kļūda. :( Mēģiniet vēlreiz.",
		answer = {
			bet = "Es deru mans pareģojums ir pareizs... pēm %s soļiem...",
			real = "Es izdomāju %jā solī!",
		}
	},
	standard_language = "Jūsu standarta valoda ir iestatīta uz `%s`",
	poll = {
		already_exists = "Ir jau Jūsu izveidota aptauja. Pagaidiet savus rezultātus pirms jaunas aptaujas izveidošanas.",
		poll = "Aptauja",
		option = {"Jā", "Nē"},
		ends = "Beidzās %s minūtēs.",
		total = "Kopējais `\"%s\"`: %s (%s%%)",
		results = "Rezultāti",
		decision = "Gala lēmums: \"%s\"",
		tie = "NEIZŠĶIRTS",
	},
	weather = {
		at = "Laikapstākļi %s",
		temperature = "Temperatūra",
		current = "Pašreizējā",
		maximum = "Maksimums",
		minimum = "Minimums",
		wind = "Vēja ātrums",
		humidity = "Mitrums",
		cloud = "Mākoņainība",
		rain = "Lietus",
		snow = "Sniegs"
	},
	atelier = {
		roles = {
			ex = "Bijušais personāls",
			adm = "Administrators",
			mod = "Moderators",
			sent = "Sargs",
			mc = "Mapju komanda"
		},
		not_found = "Spēlētājs `%s` neeksistē.",
		registration = "Reģistrācijas datums",
		community = "Kopiena",
		messages = "Ziņojumi",
		prestige = "Prestižs",
		title = "Tituls",
		tribe = "Cilts",
		visit = "Apmeklēt profilu",
		sm = "Dvēseles radinieks",
	},
	translation = "Iztulkoja Tulkotāju Komanda (#%s)\n\nValoda: %s (%s)\nSastāvs: ```%s\n%s```\n\nŠis tulkojums paņēma `%s`.\n_Padalies ar pieredzi ar saviem draugiem!_",
	ban = "**Jūs tikāt aizliegts no Translators Team servera!**\n\n```\n%s```\nDiemžēl Jūsu uzvedība ir apdraudējusi Jūsu dalību servera publiskajos kanālos.",
	kick = "**Jūs tikāt izmests no Translators Team servera!**\n\n```\n%s```\nPēc pāris sankcijām, Jūs tiksiet izmests. Apsveriet uzlabot Jūsu uzvedību vai Jūs tiksiet pat aizliegts pastāvīgi no servera!",
	sanction = "**Jūs dabūjāt sankciju no Translators Team servera!** *(%s/%s)*\n\n```\n%s```\nJūs tikāt sankcionēts! Ja jūs dabūjat citas sankcijas, jūs variet tikt izmests no šī servera, vai pat aizliegts! Pārbaudiet savu uzvedību un dariet Jūsu labāko, lai izvairītos rast jaunas problēmas publiskajos kanālos!",
	unfair_warn = "Jā jūs atrodat sodu __negodīgu__, sazinieties ar jebkuru Starptautisko Līderi. Pārbaudiet viņu lietotājvārdus, izmantojot komandu `!team International Leader`",
	server = {
        owner = "Īpašnieks",
        channels = "Kanāli",
        creation = "Radīts",
        translators = "Tulkotāji",
        members = "Biedri",
        away = "Projām",
        busy = "Aizņemts",
        people = "Cilvēki",
    },
}
translations.pl = {
	command_descriptions = {
		a801 = { "Wyświetla profil Atelier801 wybranego gracza.", { "(Tagi są potrzebne, jeżeli to nie są 0000)\n!a801 `Nazwa_Gracza#0000`" } },
		akinator = { "Zaczyna grę Akinator.",
			{
				"(Normalna gra)\n!akinator",
				"(Ustaw wskaźnik prawdopodobieństwa)\n!akinator `numer [70 - 97]`"
			}
		},
		animal = { "Wyświetla losowe zdjęcie zwierzęcia.", { "!animal" } },
		avatar = { "Wyświetla avatar danej osoby.",
			{
				"(Własny avatar)\n!avatar",
				"(Kogoś avatar)\n!avatar `@username`",
			}
		},
		coin = { "Przeprowadza wymianę walut pomiędzy dwoma krajami. (podstawowa = USD)",
			{
				"(Wymiana łącznej kwoty)\n!coin wybrana_waluta waluta_źródłowa łączna_money",
				"(Wymiana $1)\n!coin wybrana_waluta waluta_źródłowa",
				"(Wymiana z USD)\n!coin wybrana_waluta łączna_kwota",
			}
		},
		color = 	{ "Wyświetla kolor danego #hex code.", { "!color `#hexadecimal`" } },
		define = { "Podaje definicje, synonimy, antonimy i przykłady użycia angielskiego słowa w danym języku.", { "!define `word`" } },
		fact = { "Pokazuje losowy fakt.", { "!fact" } },
		help = { "Wyświetla wiadomość pomocną.", { "!help" } },
		invite = { "Wyświetla link z zaproszeniem na serwer Translators Team.", { "!invite" } },
		lang = { "Ustawia podstawowy język na publiczne komendy dla ciebie.", { "!lang `flag`" } },
		languages = { "Wyświetla liste dostępnych języków.", { "!languages" } },
		leaderboard = { "Wyświetla tablice wyników najlepszych tłumaczy.",
			{
				"(Nornalna)\n!leaderboard",
				"(Z wybraną rolą)\n!leaderboard `@rola`",
				"(Więcej pozycji)\n!leaderboard `@role_or_* total_members[3-6]`",	
			}
		},
		meme = { "Wyświetla losowego mema z Galaktine & Spółka.", { "!meme" } },
		message = { "Bot automatycznie wysyła ci prywatną wiadomość.", { "!message" } },
		momma = { "Pokazuje losowy żart o ~~twojej~~ mamie!", { "!momma" } },
		poll = { "Utwórz głosowanie (Tak/Nie).",
			{
				"!poll Pytanie",
				"(Tylko Członek) (Niestandardowy)\n!poll ` ```pytanie``` czas_głosowania` ` `opcja_głosowania_1` ` ` ` ` `opcja_głosowania_2` ` ` `"
			}
		},
		profile = { "Wyświetla profil wybranego członka zespołu.",
			{
				"(Swój profil)\n!profile",
				"(User profile)\n!profile `username`"
			}
		},
		quote = { "Zacytuj starą wiadomość, abyś mógł na nią odpowiedzieć",
			{
				"(Id wiadomości)\n!quote `id_wiadomości`",
				"(Id kanału)\n!quote `id_wiadomości id_kanału`"
			}
		},
		request = { "Wysyła zamówienie tłumaczenia do Translators Team. [maksymalnie 1000 znaków]", 
			{
				"(Jeden język)\n!request `język_treści [język_zamówienia] ```treść_zamówienia``` `",
				"(Kilka języków)\n!request `język_treści [język_zamówienia1, język_zamówienia2, ...] ```treść_zamówienia``` `",
				"(Tylko dla członów) (Wszystkie języki)\n!request `język_treści [xx] ```treść_zamówienia``` `",
				"(Moduł Lua [maksymalnie 1200 znaków])\n!request `język_treści [język_zamówienia1, język_zamówienia2, ...] ```LUA\ntreść_zamówienia``` `"
			}
		},
		serverinfo = { "Pokazuje dostępne informacje o serwerze.", { "!serverinfo" } },
		spell = { "Sprawdza, czy tekst jest poprawnie napisany.", { "!spell `tekst`" } },
		team = { "wyśweitla członków w podanej roli.",
			{
				"(Społeczności)\n!team `społeczność`",
				"(Pozycja)\n!team `rola`",
			}
		},
		thread = { "Pokazuje link do wątku o drużynie tłumaczy.", { "!thread `społeczność`" } },
		tree = { "Wyświetla drzewo lua Atelier801.", { "!tree `tfm.path`\n\nPrzykład => `!tree tfm.enum.ground`" } },
		urban = { "Podaje definicje z miejskiego wyrażenia.", { "!urban `wyrażenie`" } },
		weather = { "Pokazuje obecną pogodę w wybranym mieście/kraju.", { "!weather `nazwa_miasta, skrót_kraju`" } },
	},
	avatar = "avatar %s: [tutaj](%s)",
	help_message = "Witaj, <@!%s>! %sMój przedrostek to `!` i żeby zobaczyć do czego jestem zdolny, użyj komendy `!help`. Użyj komendy `!command_name ?` żeby dowiedzieć się bardziej szczegółowej wiadomości z pomocą danej komendy.",
	command_quantity = "Dostępne komendy dla ciebie (%s) to:",
	help_welcome = "Witaj na serwerze Translators Team!",
	help_permissions = {"WSZYSCY", "TŁUMACZ", "TŁUMACZ MODUŁU", "LEADER", "ADMIN", "DEVELOPER DEBUG"},
	help_commands = "Komendy dla `%s`",
	invite_link = "**Publiczny** link z zaproszeniem: %s",
	available_languages = "Dostępne języki",
	leaderboard = "Tablica wyników",
	global = "Globalna",
	leaderboard_stats = {"Publiczni tłumacze", "Zjadacze ciastek"},
	message_message = "Witaj, %s. Pisz komende poniżej!",
	profile_fields = {
		birthday = "Urodziny",
		role = "Rola",
		language = "Język",
		translations = "Publiczne tłumaczenia",
		state = "Status",
		states = { "Aktywny", "Nieaktywny" }
	},
	not_translator = "`%s` nie jest tłumaczem",
	available_translators = "Możesz sprawdzić dostępnych tłumaczy używając komendy `!team translator`",
	request_help = "Napisz `!request ?` żeby przeczytać dostępne parametry.",
	available_languages = "Dostępne języki to: %s",
	exceeded_char_request = "Zamówienie zostało odrzucone. Twoja objętność nie może mieć więcej niż %s znaków! Wyślij je przez prywatną wiadomość na forum albo skróć je.",
	request = {
		[1] = "Twoje zamówienie jest w #%s pozycji",
		[2] = "Tekst poniżej będzie przetłumaczony w podanych językach: %s"
	},
	request_error = {
		no_content = "Błędny parametr __treści_zamówienia__ : Musi być coś do przetłumaczenia, podaj treść.",
		no_language = "Błędny parametr __języku_zamówienia__ : Musisz podać przynajmniej 1 język w którym treść musi być przetłumaczona.",
		unavailable_language = "Niestety nasz zespół nie ma członków by czytać tekst w %s!",
		no_content_language = "Błędny parametr __języku_zawartości__: Musisz podać język treści.",
	},
	no_parameters = "Zapomniałeś dodać parametrów w tej komendzie.",
	member_title = "`%s` członków (%s)",
	role_not_found = "Rola `%s` nie znaleziona!",
	path_not_found = "Ścieżka `%s` nie znaleziona!",
	help = "Pomoc",
	command = "Komendy",
	akinator_system = {
		timeout = {
			title = "KONIEC CZASU",
			message = "Niestety, przekroczyłeś swój czas na odpowiedź.",
		},
		fail = {
			title = "Ugh, wygrałeś!",
			message = "Nie zgadłem kim jest twoja postać :( Wyzywam cię byś spróbował jeszcze raz!",
		},
		step = "Pytanie %s",
		error = "Błąd z Akinatorem. :( Spróbuj ponownie.",
		answer = {
			bet = "Zakładam że moje przeczucie jest poprawne... po %s pytaniach...",
			real = "Zgadłem w %sth pytaniu!",
		}
	},
	standard_language = "Twój standardowy język został zmieniony na `%s`",
	poll = {
		already_exists = "Już istnieje ankieta stworzona przez ciebie. Poczekaj na jej wyniki, zanim utworzysz nową.",
		poll = "Głosowanie",
		option = {"Tak", "Nie"},
		ends = "Koniec za %s minut.",
		total = "W sumie na `\"%s\"`: %s (%s%%)",
		results = "Wyniki",
		decision = "Ostateczna Decyzja: \"%s\"",
		tie = "REMIS",
	},
	weather = {
		at = "Pogoda w %s",
		temperature = "Temperatura",
		current = "Obecnie",
		maximum = "Maksymalnie",
		minimum = "Minimalnie",
		wind = "Prędkość wiatru",
		humidity = "Wilgotność",
		cloud = "Zachmurzenie",
		rain = "Deszcz",
		snow = "Śnieg",
		update = "Ostatnia aktualizacja: %s",
		not_found = "Położenie `%s` nie zostało znalezione. Upewnij się żeby napisać nazwę w języku Angielskim i spróbuj ponownie później!",
	},
	atelier = {
		roles = {
			ex = "Były personel",
			adm = "Administrator",
			mod = "Moderator",
			sent = "Sentinel",
			mc = "Mapcrew"
		},
		not_found = "Gracz `%s` nie istnieje.",
		registration = "Data rejestracji",
		community = "Społeczność",
		messages = "Wiadomości",
		prestige = "Prestiż",
		title = "Tytuł",
		tribe = "Plemię",
		visit = "Odwiedź profil",
	},
	translation = "Przetłumaczone przez Drużyne Tłumaczy (#%s)\n\nJęzyk: %s (%s)\nZawartość: ```%s\n%s```\n\nTo tłumaczenie zajęło `%s`.\n_Podziel się doświadczeniem z twoimi przyjaciółmi!_",
	ban = "**Zostałeś zablokowany na serwerze Translators Team!**\n\n```\n%s```\nNiestety twoje zachowanie zagroziło twojemu udziałowi w publicznych kanałach serweru.",
	kick = "**Zostałeś wyrzucony z serwera Translators Team!**\n\n```\n%s```\nPo kilku sankcjach, zostałeś wyrzucony. Rozważ polepszenie twojego zachowania, albo możesz zostać zablokowany na stałe na serwerze!",
	sanction = "**Dostałeś sankcje od serwera Translators Team!** *(%s/%s)*\n\n```\n%s```\nDostajesz sankcje! Jeżeli dostaniesz inne sankcje, możesz zostać wyrzuconym z serwera, albo nawet zablokowany! Sprawdź swoje zachowanie i postaraj się unikać tworzenia nowych problemów w publicznych kanałach!",
	unfair_warn = "Jeśli uważasz, że nadana kara jest __niesprawiedliwa__, skontaktuj się z dowolnym International Liderem. Sprawdź ich nazwy używając komendy `!team International Leader`",
}
translations.tr = {
	command_descriptions = {
		a801 = { "Belirlenmiş oyuncunun Atelier 801 profilini gösterir.", { "(Eğer 0000 değilse etiketleri yazmak zorunludur. \n!a801 kullanıcıAdı`#0000`" } },
		akinator = { "Bir Akinatör oyunu başlatır.",
			{
				"(Normal oyun)\n!akinator",
				"(Olasılık oranı ayarlar.)\n!akinator `sayı [70 - 97]`"
			}
		},
		animal = { "Rastgele bir hayvan fotoğrafı gösterir.", { "!animal" } },
		avatar = { "Belirtilen kullanıcının avatarını gösterir.",
			{
				"(Avatarınız)\n!avatar",
				"(Bir başkasının avatarı)\n!avatar `@username`",
			}
		},
		coin = { "İki para birimi arasında çeviri yapar. (varsayılan = USD)",
			{
				"(Toplam paranın çevirisi)\n!coin `hedef_birim kaynak_birim toplam_para`",
				"(1$'ın çevirisi)\n!coin `hedef_birim kaynak_birim`",
				"(USD'den çeviri)\n!coin `hedef_birim toplam_para`",
			}
		},
		color =	 { "Belirtilen #hex kodunun rengini gösterir.", { "!color `#onaltılık`" } },
		define = { "Belirli bir dilde bir İngilizce sözcüğün eş ve zıt anlamlarını ve kullanıldığı bir örneği alır.", { "!define `kelime`" } },
		fact = { "Rastgele bir bilgi gösterir.", { "!fact" } },
		help = { "Yardım mesajını gösterir.", { "!help" } },
		invite = { "Çeviri Ekibi sunucusu davet linkini gösterir.", { "!invite" } },
		lang = { "Herkese açık komutlar için size varsayılan dil ayarlar.", { "!lang `bayrak`" } },
		languages = { "Geçerli dillerin listesini gösterir.", { "!languages" } },
		leaderboard = { "En iyi çevirmenlerin olduğu lider tablosunu gösterir.",
			{
				"(Normal)\n!leaderboard",
				"(Belirli bir rol)\n!leaderboard `@rol`",
				"(Daha fazla pozisyon)\n!leaderboard `@rol_veya_* toplam_üyeler[3-6]`",	 
			}
		},
		meme = { "Galaktine ve şirket ile alakalı rastgele bir meme.", { "!meme" } },
		message = { "Bot otomatik olarak özel mesaj yollar.", { "!message" } },
		momma = { "Anancı bir espri yapar.", { "!momma" } },
		poll = { "Anket oluşturur (Evet/Hayır).",
			{
				"!poll Soru",
				"(Sadece üyeler) (Özelleştirilmiş)\n!poll ` ```soru``` anket_zamanı` ` `anket_seçeneği_1` ` ` ` ` `anket_seçeneği_2` ` ` `"
			}
		},
		profile = { "Ekibin belirli bir üyesinin profilini gösterir.",
			{
				"(Profiliniz)\n!profile",
				"(Kullanıcı profili)\n!profile `username`"
			}
		},
		quote = { "Eski bir mesajı alıntılar, bu şekilde yanıt verebilirsiniz.",
			{
				"(Mesaj kimliği)\n!quote `mesaj_kimliği`",
				"(Kanal kimliği)\n!quote `mesaj_kimliği kanal_kimliği`"
			}
		},
		request = { "Çeviri Ekibi için çeviri isteği yollar. [maksimum 1000 karakter]",
			{
				"(Tek dil)\n!request `içerik_dili [istek_dili] ```istek_içeriği``` `",
				"(Çoklu dil)\n!request `içerik_dili [istek_dili1, istek_dili2, ...] ```istek_içeriği``` `",
				"(Sadece üyeler) (Tüm diller)\n!request `içerik_dili [xx] ```istek_içeriği``` `",
				"(Lua modülü [maksimum 1200 karakter])\n!request `içerik_dili [istek_dili1, istek_dili2, ...] ```LUA\nistek_içeriği``` `"
			}
		},
		serverinfo = { "Sunucuyla alakalı uygun bilgileri gösterir.", { "!serverinfo" } },
		spell = { "Bir yazının doğru yazılıp yazılmadığını kontrol eder.", { "!spell `yazı`" } },
		team = { "Verilen roldeki üyeleri gösterir.",
			{
				"(Topluluk)\n!team `topluluk`",
				"(Pozisyon)\n!team `rol`",
			}
		},
		tree = { "Atelier801’nin Lua ağacını gösterir.", { "!tree `tfm.yol`\n\nÖrnek => `!tree tfm.enum.ground`" } },
		urban = { "Sokak ağzındaki bir deyimin anlamını çeker.", { "!urban `ifade`" } },
		weather = { "Belirtilmiş şehirdeki/ülkedeki anlık hava durumunu gösterir.", { "!weather `şehir_adı, ülke_kodu`" } },
	},
	avatar = "%s adlı kullanıcının avatarı: [bura](%s)",
	help_message = "Merhaba, <@!%s>! %s`!` ön eki ile bir komut çalıştırabilirsiniz ve neler yapabildiğimi görmek için `!help` komutunu kullanabilirsiniz. Belirli bir komut ile ilgili daha detaylı bir yardım mesajı okumak için `!komut_adı ?` komutunu kullanınız.",
	command_quantity = "Sizin (%s) için kullanılabilir olan komutlar:",
	help_welcome = "Çeviri Ekibi sunucusuna hoş geldiniz!",
	help_permissions = {"HERKES", "ÇEVİRMEN", "MODÜL ÇEVİRMENİ", "LEADER", "YÖNETİCİ", "GELİŞTİRİCİ HATA AYIKLAMA"},
	help_commands = "`%s` için kullanılabilir olan komutlar:",
	invite_link = "**Herkese açık** davet linki: %s",
	available_languages = "Geçerli diller",
	leaderboard = "Lider tahtası",
	global = "Genel",
	leaderboard_stats = {"Herkese Açık İstek Çevirmenleri", "Kurabiye Yiyenler"},
	message_message = "Merhaba, %s. Aşağıya herhangi bir komut yazınız!",
	profile_fields = {
		birthday = "Doğum Günü",
		role = "Rol",
		language = "Dil",
		translations = "Halka Açık Çeviriler",
		state = "Durum",
		states = { "Etkin", "Etkin değil" }
	},
	not_translator = "`%s` bir çevirmen değil.",
	available_translators = "`!team translator` komutunu kullanarak geçerli çevirmenleri kontrol edebilirsiniz.",
	request_help = "Olası parametreleri öğrenmek için `!request ?`yazınız.",
	available_languages = "Geçerli diller: %s",
	exceeded_char_request = "Talebiniz reddedildi. İçeriğiniz, %s karakterden fazlasına sahip olamaz! İsteğinizi forumlar üzerinden özel mesaj olarak yollayınız ya da daha küçük hâle getiriniz.",
	request = {
		[1] = "İsteğiniz #%s pozisyonunda.",
		[2] = "Aşağıdaki yazı şu dillere çevrilecektir: %s"
	},
	request_error = {
		no_content = "Geçersiz __request_content__ parameter: Ortada çevrilecek bir şey olmalı, içerik ekleyiniz.",
		no_language = "Geçersiz __request_language__ parameter: İçeriğinizin çevrilmesi gereken en az bir dili eklemelisiniz.",
		unavailable_language = "Maalesef ekibimiz %s dilinde yazılanları okumak için bir üyeye sahip değil!",
		no_content_language = "Geçersiz __content_language__ parameter: İçeriğin dilini belirtmelisiniz.",
	},
	no_parameters = "Bu komutta parametreleri eklemeyi unuttunuz.",
	member_title = "`%s` üyeleri (%s)",
	role_not_found = "`%s` rolü bulunamadı!",
	path_not_found = "`%s` yolu bulunamadı!",
	help = "Yardım",
	command = "Komut",
	akinator_system = {
		timeout = {
			title = "SÜRENİZ DOLDU",
			message = "Maalesef cevaplamak için çok fazla zaman harcadınız.",
		},
		fail = {
			title = "Ah, siz kazandınız!",
			message = "Karakterinizin kim olduğunu çıkaramadım. :( Tekrar denemeniz için size meydan okuyorum!",
		},
		step = "%s. adım",
		error = "Akinatör Hatası. :( Tekrar deneyiniz.",
		answer = {
			bet = "Önsezilerimin doğru olduğunu iddia ediyorum… %s adımdan sonra...",
			real = "%s. adımda buldum!",
		}
	},
	standard_language = "Varsayılan diliniz `%s` olarak belirlendi.",
	poll = {
		already_exists = "Zaten bir anket oluşturdunuz. Yeni bir tane daha başlatmadan önce anketinizin sonuçlarını bekleyin.",
		poll = "Anket",
		option = {"Evet", "Hayır"},
		ends = "%s dakika içinde bitecek.",
		total = "Toplamda verilmiş olan \"%s\" cevabı: %s (%s%%)",
		results = "Sonuçlar",
		decision = "Son karar: \"%s\"",
		tie = "BERABERE",
	},
	weather = {
		at = "%s şehrindeki hava durumu",
		temperature = "Sıcaklık",
		current = "Anlık",
		maximum = "En yüksek",
		minimum = "En düşük",
		wind = "Rüzgar hızı",
		humidity = "Nem",
		cloud = "Bulutluluk",
		rain = "Yağmur",
		snow = "Kar",
		update = "En son %s tarihinde güncellendi.",
		not_found = "`%s` konumu bulunamadı. İsmini İngilizce yazdığınızdan emin olunuz ve tekrar deneyiniz.",
	},
	atelier = {
		roles = {
			ex = "Eski ekip üyesi",
			adm = "Yönetici",
			mod = "Moderatör",
			sent = "Sentinel",
			mc = "Harita ekibi üyesi"
		},
		not_found = "`%s` oyuncusu bulunamadı.",
		registration = "Kaydolma tarihi",
		community = "Topluluk",
		messages = "İletiler",
		prestige = "Prestij",
		title = "Unvan",
		tribe = "Kabile",
		visit = "Profili ziyaret et",
		sm = "ruh ikizi",
	},
	translation = "Çeviri Ekibi tarafından tercüme edildi. (#%s)\n\nDil: %s (%s)\nİçerik: ```%s\n%s```\n\nBu tercümeyi sağlamamız `%s` tuttu.\n_Deneyiminizi arkadaşlarınızla paylaşabilirsiniz!_",
	ban = "**Çeviri Ekibi sunucusundan yasaklandınız!**\n\n```\n%s```\nMaalesef ki, tutum ve davranışlarınız sunucumuzun halka açık kanallarındaki varlığınızı tehlikeye attı.",
	kick = "**Çeviri Ekibi sunucusundan atıldınız!**\n\n```\n%s```\nBirkaç uyarıdan sonra atıldınız. Tutumunuzu geliştirmeye karar verin aksi takdirde sunucudan kalıcı olarak yasaklanabilirsiniz!",
	sanction = "**Çeviri Ekibi sunucusundan bir uyarı aldınız.** *(%s/%s)*\n\n```\n%s```\nUyarıldınız! Eğer daha başka uyarılar da alırsanız sunucudan atılabilir hatta ve hatta yasaklanabilirsiniz! Kendinize bir çeki düzen verin ve halka açık kanallarda yeni hatalar yapmaktan kaçınmak için yapabileceğinizin en iyisini sergileyin!",
	unfair_warn = "Eğer cezayı __adaletsiz__ olarak görüyorsanız, herhangi bir uluslararası lider ile iletişime geçiniz. `!team International Leader` komutunu kullanarak da uluslararası liderlerimizin kullanıcı adlarını kontrol edebilirsiniz.",
	server = {
		owner = "Sahip",
		channels = "Kanallar",
		creation = "Oluşturma tarihi:",
		translators = "Tercümanlar",
		members = "Üyeler",
		away = "Dışarıda",
		busy = "Meşgul",
		people = "Kişiler",
    },
}

return translations