return {
	['enum']={
		['particle']={
			['shamanTeleportation']=37,
			['blueConfetti']=23,
			['tealGlitter']=9,
			['littlePinkHeart']=31,
			['orangeGlitter']=2,
			['blueGlitter']=1,
			['whiteGlitter']=0,
			['meep']=20,
			['plus10']=16,
			['wind']=27,
			['redConfetti']=21,
			['plus1']=15,
			['mouseTeleportation']=36,
			['pinkCandyConfetti']=40,
			['bubble']=6,
			['diagonalRain']=25,
			['redGlitter']=13,
			['daisy']=32,
			['bell']=33,
			['plus12']=17,
			['projection']=35,
			['greenConfetti']=22,
			['yellowConfetti']=24,
			['waterBubble']=14,
			['star']=29,
			['plus16']=19,
			['spirit']=10,
			['yellowCandyConfetti']=39,
			['curlyWind']=26,
			['dullWhiteGlitter']=4,
			['cloud']=3,
			['yellowGlitter']=11,
			['egg']=34,
			['littleRedHeart']=30,
			['ghostSpirit']=12,
			['lollipopConfetti']=38,
			['heart']=5,
			['rain']=28,
			['plus14']=18
		},
		['shamanObject']={
			['orangePortal']=26,
			['board']=4,
			['anvil']=10,
			['sheep']=40,
			['greenBalloon']=30,
			['paperPlane']=80,
			['snowBall']=34,
			['bluePortal']=26,
			['redBalloon']=29,
			['longBoard']=67,
			['bomb']=23,
			['box']=2,
			['ball']=6,
			['blueBalloon']=28,
			['pumpkinBall']=89,
			['littleBox']=1,
			['bubble']=59,
			['balloonFish']=65,
			['chicken']=33,
			['stableRune']=62,
			['cloud']=57,
			['iceCube']=54,
			['yellowBalloon']=31,
			['apple']=39,
			['rune']=32,
			['arrow']=0,
			['paperBall']=95,
			['trampoline']=7,
			['balloon']=28,
			['cupidonArrow']=35,
			['tinyBoard']=60,
			['rock']=85,
			['littleBoard']=3,
			['littleBoardChocolate']=46,
			['tombstone']=90,
			['triangle']=68,
			['sBoard']=69,
			['littleBoardIce']=45,
			['companionCube']=61,
			['cannon']=17
		},
		['emote']={
			['rockpaperscissor_2']=27,
			['highfive_1']=14,
			['highfive_2']=15,
			['kiss']=3,
			['kissing']=21,
			['clap']=5,
			['kissing_1']=22,
			['cry']=2,
			['jigglypuff']=20,
			['highfive']=13,
			['kissing_2']=23,
			['rockpaperscissors_1']=26,
			['hug']=17,
			['partyhorn']=16,
			['selfie']=12,
			['flag']=10,
			['facepaw']=7,
			['marshmallow']=11,
			['carnaval']=24,
			['hug_2']=19,
			['rockpaperscissors']=25,
			['angry']=4,
			['laugh']=1,
			['dance']=0,
			['sit']=8,
			['hug_1']=18,
			['confetti']=9,
			['sleep']=6
		},
		['ground']={
			['wood']=0,
			['snow']=11,
			['ice']=1,
			['web']=15,
			['rectangle']=12,
			['earth']=5,
			['sand']=7,
			['water']=9,
			['chocolate']=4,
			['trampoline']=2,
			['invisible']=14,
			['stone']=10,
			['cloud']=8,
			['grass']=6,
			['lava']=3,
			['circle']=13
		}
	},
	['events']={
		['eventChatCommand']="playerName`, `command",
		['eventChatMessage']="playerName`, `message",
		['eventEmotePlayed']="playerName`, `emoteType`, `emoteParam",
		['eventFileLoaded']="fileNumber`, `fileData",
		['eventFileSaved']="fileNumber",
		['eventKeyboard']="playerName`, `keyCode`, `down`, `xPlayerPosition`, `yPlayerPosition",
		['eventMouse']="playerName`, `xMousePosition`, `yMousePosition",
		['eventLoop']="elapsedTime`, `remainingTime",
		['eventNewGame']="` `",
		['eventNewPlayer']="playerName",
		['eventPlayerDataLoaded']="playerName`, `playerData",
		['eventPlayerDied']="playerName",
		['eventPlayerGetCheese']="playerName",
		['eventPlayerLeft']="playerName",
		['eventPlayerVampire']="playerName",
		['eventPlayerWon']="playerName`, `timeElapsed`, `timeElapsedSinceRespawn",
		['eventPlayerRespawn']="playerName",
		['eventPopupAnswer']="popupId`, `playerName`, `answer",
		['eventSummoningStart']="playerName`, `objectType`, `xPosition`, `yPosition`, `angle",
		['eventSummoningCancel']="playerName",
		['eventSummoningEnd']="playerName`, `objectType`, `xPosition`, `yPosition`, `angle`, `objectDescription",
		['eventTextAreaCallback']="textAreaId`, `playerName`, `eventName",
		['eventColorPicked']="colorPickerId`, `playerName`, `color",
	},
	['system']={
		['bindKeyboard']="playerName`, `keyCode`, `down`, `activate",
		['bindMouse']="playerName`, `active",
		['disableChatCommandDisplay']="command`, `hide",
		['exit']="` `",
		['giveEventGift']="playerName`, `giftCode",
		['loadFile']="fileNumber",
		['loadPlayerData']="playerName",
		['newTimer']="callback`, `time`, `loop`, `arg1`, `arg2`, `arg3`, `arg4",
		['removeTimer']="timerId",
		['saveFile']="data`, `fileNumber",
		['savePlayerData']="playerName`, `data",
	},
	['debug']={
		['disableEventLog']="activate"
	},
	['exec']={
		['addConjuration']="xPosition`, `yPosition`, `duration",
		['addImage']="imageId`, `target`, `xPosition`, `yPosition`, `targetPlayer",
		['addJoint']="id`, `ground1`, `ground2`, `jointDef",
		['addPhysicObject']="id`, `xPosition`, `yPosition`, `bodyDef",
		['addShamanObject']="objectType`, `xPosition`, `yPosition`, `angle`, `xSpeed`, `ySpeed`, `ghost",
		['chatMessage']="message`, `playerName",
		['disableAfkDeath']="activate",
		['disableAllShamanSkills']="active",
		['disableAutoNewGame']="activate",
		['disableAutoScore']="activate",
		['disableAutoShaman']="activate",
		['disableAutoTimeLeft']="activate",
		['disableDebugCommand']="activate",
		['disableMinimalistMode']="activate",
		['disableMortCommand']="activate",
		['disablePhysicalConsumables']="activate",
		['disableWatchCommand']="activate",
		['displayParticle']="particleType`, `xPosition`, `yPosition`, `xSpeed`, `ySpeed`, `xAcceleration`, `yAcceleration`, `targetPlayer",
		['explosion']="xPosition`, `yPosition`, `power`, `radius`, `miceOnly",
		['giveCheese']="playerName",
		['giveConsumables']="playerName`, `consumableId`, `amount",
		['giveMeep']="playerName",
		['killPlayer']="playerName",
		['lowerSyncDelay']="playerName",
		['moveObject']="objectId`, `xPosition`, `yPosition`, `positionOffset`, `xSpeed`, `ySpeed`, `speedOffset`, `angle`, `angleOffset",
		['movePlayer']="playerName`, `xPosition`, `yPosition`, `positionOffset`, `xSpeed`, `ySpeed`, `speedOffset",
		['newGame']="mapCode`, `flipped",
		['playEmote']="playerName`, `emoteId`, `emoteArg",
		['playerVictory']="playerName",
		['removeImage']="imageId",
		['removeJoint']="id",
		['removeObject']="objectId",
		['removePhysicObject']="id",
		['respawnPlayer']="playerName",
		['setAutoMapFlipMode']="flipped",
		['setGameTime']="time`, `init",
		['setNameColor']="playerName`, `color",
		['setPlayerScore']="playerName`, `score`, `add",
		['setRoomMaxPlayers']="maxPlayers",
		['setRoomPassword']="password",
		['setShaman']="playerName",
		['setVampirePlayer']="playerName",
		['snow']="duration`, `snowballPower",
	},
	['ui']={
		['addPopup']="id`, `type`, `text`, `targetPlayer`, `x`, `y`, `width`, `fixedPos",
		['addTextArea']="id`, `text`, `targetPlayer`, `x`, `y`, `width`, `height`, `backgroundColor`, `borderColor`, `backgroundAlpha`, `fixedPos",
		['removeTextArea']="id`, `targetPlayer",
		['setMapName']="text",
		['setShamanName']="text",
		['showColorPicker']="id`, `targetPlayer`, `defaultColor`, `title",
		['updateTextArea']="id`, `text`, `targetPlayer",
	},
	['get']={
		['room']={
			['playerList']={
				['Bolodefchoco#0000']={
					['isJumping']=false,
					['x']=120,
					['community']="en",
					['id']=7903955,
					['y']=334,
					['look']="72;76,0,0,0,0,0,0,2",
					['isShaman']=true,
					['shamanMode']=2,
					['registrationDate']=1322521544535,
					['score']=0,
					['isVampire']=false,
					['hasCheese']=false,
					['isFacingRight']=false,
					['playerName']="Bolodefchoco#0000",
					['tribeName']="Translators Team",
					['inHardMode']=2,
					['title']=114,
					['isDead']=false,
					['vy']=0,
					['movingRight']=false,
					['vx']=0,
					['movingLeft']=false
				}
			},
			['community']="en",
			['currentMap']="0",
			['objectList']={
				[1]={
					['angle']=0,
					['id']=1,
					['y']=320,
					['colors']={
						[1]=2126993,
						[2]=2126993,
						[3]=2126993,
						[4]=2126993,
						[5]=2126993
					},
					['baseType']=2,
					['ghost']=false,
					['type']=201,
					['vx']=0,
					['x']=56,
					['vy']=0
				}
			},
			['maxPlayers']=50,
			['name']="*#grounds",
			['passwordProtected']=false
		},
		['misc']={
			['transformiceVersion']=5.51,
			['apiVersion']="0.26"
		}
	}
}