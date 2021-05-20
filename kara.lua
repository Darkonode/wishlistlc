-------------------------------
-- Namespaces
-------------------------------
local _, namespace = ...
namespace.Kara = {}
namespace.filter = nil
namespace.searchResult = {}
namespace.searchSize = 0

local Kara = namespace.Kara

local wishlist = {}

local trash = {
	["RavagersBracers"] = {
		id = 30687,
		name = "Ravager's Bracers",
		itemType = "Plate",
		slot = "Wrist",
		source = {"Rare"}
	},
	["RavagersCuffs"] = {
		id = 30684,
		name = "Ravager's Cuffs",
		itemType = "Cloth",
		slot = "Wrist",
		source = {"Rare"}
	},
	["RavagersBands"] = {
		id = 30686,
		name = "Ravager's Bands",
		itemType = "Mail",
		slot = "Wrist",
		source = {"Rare"}
	},
	["RavagersWristWraps"] = {
		id = 30685,
		name = "Ravager's Wrist-Wraps",
		itemType = "Leather",
		slot = "Wrist",
		source = {"Rare"}
	}
}

local recipes = {
	["SchematicStabilizedEterniumScope"] = {
		id = 23809,
		name = "Schematic: Stabilized Eternium Scope",
		itemType = "Schematic",
		slot = nil,
		source = {"Attumen"}
	},
	["FormulaEnchantWeaponMongoose"] = {
		id = 22559,
		name = "Formula: Enchant Weapon - Mongoose",
		itemType = "Formula",
		slot = nil,
		source = {"Moroes"}
	},
	["FormulaEnchantWeaponSoulfrost"] = {
		id = 22561,
		name = "Formula: Enchant Weapon - Soulfrost",
		itemType = "Formula",
		slot = nil,
		source = {"Terestian Illhoof"}
	},
	["FormulaEnchantWeaponSunfire"] = {
		id = 22560,
		name = "Formula: Enchant Weapon - Sunfire",
		itemType = "Formula",
		slot = nil,
		source = {"Shade of Aran"}
	}
}

local attumen = {
	["GlovesOfSaintlyBlessings"] = {
		id = 28508,
		name = "Gloves of Saintly Blessings",
		itemType = "Cloth",
		slot = "Hands",
		source = {"Attumen"}
	},
	["BracersOfTheWhiteStag"] = {
		id = 28453,
		name = "Bracers of the White Stag",
		itemType = "Leather",
		slot = "Wrist",
		source = {"Attumen"}
	},
	["SteelhawkCrossbow"] = {
		id = 28504,
		name = "Steelhawk Crossbow",
		itemType = "Crossbow",
		slot = "Ranged",
		source = {"Attumen"}
	},
	["VambracersOfCourage"] = {
		id = 28502,
		name = "Vambracers of Courage",
		itemType = "Plate",
		slot = "Wrist",
		source = {"Attumen"}
	},
	["WhirlwindBracers"] = {
		id = 28503,
		name = "Whirlwind Bracers",
		itemType = "Mail",
		slot = "Wrist",
		source = {"Attumen"}
	},
	["GauntletsOfRenewedHope"] = {
		id = 28505,
		name = "Gauntlets of Renewed Hope",
		itemType = "Plate",
		slot = "Hands",
		source = {"Attumen"}
	},
	["HandwrapsOfFlowingThought"] = {
		id = 28507,
		name = "Handwraps of Flowing Thought",
		itemType = "Cloth",
		slot = "Hands",
		source = {"Attumen"}
	},
	["HarbingerBands"] = {
		id = 28477,
		name = "Harbinger Bands",
		itemType = "Cloth",
		slot = "Wrist",
		source = {"Attumen"}
	},
	["GlovesOfDexterousManipulation"] = {
		id = 28506,
		name = "Gloves of Dexterous Manipulation",
		itemType = "Leather",
		slot = "Hands",
		source = {"Attumen"}
	},
	["SpectralBandOfInnervation"] = {
		id = 28510,
		name = "Spectral Band of Innervation",
		itemType = "Ring",
		slot = "Finger",
		source = {"Attumen"}
	},
	["StalkersWarBands"] = {
		id = 28454,
		name = "Stalker's War Bands",
		itemType = "Mail",
		slot = "Wrist",
		source = {"Attumen"}
	},
	["WorgenClawNecklace"] = {
		id = 28509,
		name = "Worgen Claw Necklace",
		itemType = "Amulet",
		slot = "Neck",
		source = {"Attumen"}
	}
}

local moroes = {
	["ShadowCloakOfDalaran"] = {
		id = 28570,
		name = "Shadow-Cloak of Dalaran",
		itemType = "Cloak",
		slot = "Back",
		source = {"Moroes"}
	},
	["BootsOfValiance"] = {
		id = 28569,
		name = "Boots of Valiance",
		itemType = "Plate",
		slot = "Feet",
		source = {"Moroes"}
	},
	["MoroesLuckyPocketWatch"] = {
		id = 28528,
		name = "Moroes' Lucky Pocket Watch",
		itemType = "Trinket",
		slot = "Trinket",
		source = {"Moroes"}
	},
	["EarthsoulLeggings"] = {
		id = 28591,
		name = "Earthsoul Leggings",
		itemType = "Leather",
		slot = "Legs",
		source = {"Moroes", "The Big Bad Wolf"}
	},
	["EmeraldRipper"] = {
		id = 28524,
		name = "Emerald Ripper",
		itemType = "Dagger",
		slot = "One-hand",
		source = {"Moroes"}
	},
	["NethershardGirdle"] = {
		id = 28565,
		name = "Nethershard Girdle",
		itemType = "Cloth",
		slot = "Waist",
		source = {"Moroes"}
	},
	["RoyalCloakOfArathiKings"] = {
		id = 28529,
		name = "Royal Cloak of Arathi Kings",
		itemType = "Cloak",
		slot = "Back",
		source = {"Moroes"}
	},
	["BeltOfGaleForce"] = {
		id = 28567,
		name = "Belt of Gale Force",
		itemType = "Mail",
		slot = "Waist",
		source = {"Moroes"}
	},
	["BroochOfUnquenchableFury"] = {
		id = 28530,
		name = "Brooch Of Unquenchable Fury",
		itemType = "Amulet",
		slot = "Neck",
		source = {"Moroes"}
	},
	["CrimsonGirdleOfTheIndomitable"] = {
		id = 28566,
		name = "Crimson Girdle Of The Indomitable",
		itemType = "Plate",
		slot = "Waist",
		source = {"Moroes"}
	},
	["EdgewalkerLongboots"] = {
		id = 28545,
		name = "Edgewalker Longboots",
		itemType = "Leather",
		slot = "Feet",
		source = {"Moroes"}
	},
	["IdolOfTheAvianHeart"] = {
		id = 28568,
		name = "Idol Of The Avian Heart",
		itemType = "Idol",
		slot = "Relic",
		source = {"Moroes"}
	},
	["SignetOfUnshakenFaith"] = {
		id = 28525,
		name = "Signet Of Unshaken Faith",
		itemType = "Off-hand Frill",
		slot = "Off-hand",
		source = {"Moroes"}
	}	
}

local maiden = {
	["GloveOfQuickening"] = {
		id = 28519,
		name = "Gloves of Quickening",
		itemType = "Mail",
		slot = "Hands",
		source = {"Maiden of Virtue"}
	},
	["BracersOfMaliciousness"] = {
		id = 28514,
		name = "Bracers of Maliciousness",
		itemType = "Leather",
		slot = "Wrist",
		source = {"Maiden of Virtue"}
	},
	["BarbedChokerOfDiscipline"] = {
		id = 28516,
		name = "Barbed Choker of Discipline",
		itemType = "Amulet",
		slot = "Neck",
		source = {"Maiden of Virtue"}
	},
	["BootsOfForetelling"] = {
		id = 28517,
		name = "Boots of Foretelling",
		itemType = "Cloth",
		slot = "Feet",
		source = {"Maiden of Virtue"}
	},
	["BracersOfJustice"] = {
		id = 28512,
		name = "Bracers of Justice",
		itemType = "Plate",
		slot = "Wrist",
		source = {"Maiden of Virtue"}
	},
	["GlovesOfCentering"] = {
		id = 28520,
		name = "Gloves of Centering",
		itemType = "Mail",
		slot = "Hands",
		source = {"Maiden of Virtue"}
	},
	["IronGauntletsOfTheMaiden"] = {
		id = 28518,
		name = "Iron Gauntlets of the Maiden",
		itemType = "Plate",
		slot = "Hands",
		source = {"Maiden of Virtue"}
	},
	["MittsOfTheTreemender"] = {
		id = 28521,
		name = "Mitts of the Treemender",
		itemType = "Leather",
		slot = "Hands",
		source = {"Maiden of Virtue"}
	},
	["ShardOfTheVirtuous"] = {
		id = 28522,
		name = "Shard of the Virtuous",
		itemType = "One-handed Mace",
		slot = "Main-hand",
		source = {"Maiden of Virtue"}
	},
	["TotemOfHealingRains"] = {
		id = 28523,
		name = "Totem of Healing Rains",
		itemType = "Totem",
		slot = "Relic",
		source = {"Maiden of Virtue"}
	},
	["BandsOfIndwelling"] = {
		id = 28511,
		name = "Bands of Indwelling",
		itemType = "Cloth",
		slot = "Wrist",
		source = {"Maiden of Virtue"}
	},
	["BandsOfNefariousDeeds"] = {
		id = 28515,
		name = "Bands of Nefarious Deeds",
		itemType = "Cloth",
		slot = "Wrist",
		source = {"Maiden of Virtue"}
	}
}

local opera = {
	["BeastmawPauldrons"] = {
	id = 28589,
		name = "Beastmaw Pauldrons",
		itemType = "Mail",
		slot = "Shoulders",
		source = {"The Crone", "The Big Bad Wolf", "Romulo"}
	},
	["Legacy"] = {
		id = 28587,
		name = "Legacy",
		itemType = "Two-handed Axe",
		slot = "Two-hand",
		source = {"The Crone"}
	},
	["LibramOfSoulsRedeemed"] = {
		id = 28592,
		name = "Libram of Souls Redeemed",
		itemType = "Libram",
		slot = "Relic",
		source = {"The Crone"}
	},
	["RubySlippers"] = {
		id = 28585,
		name = "Ruby Slippers",
		itemType = "Cloth",
		slot = "Feet",
		source = {"The Crone"}
	},
	["TrialFireTrousers"] = {
		id = 28594,
		name = "Trial-Fire Trousers",
		itemType = "Cloth",
		slot = "Legs",
		source = {"The Crone", "The Big Bad Wolf"}
	},
	["WickedWitchsHat"] = {
		id = 28586,
		name = "Wicked Witch's Hat",
		itemType = "Cloth",
		slot = "Head",
		source = {"The Crone"}
	},
	["BigBadWolfsHead"] = {
		id = 28583,
		name = "Big Bad Wolf's Head",
		itemType = "Mail",
		slot = "Head",
		source = {"The Big Bad Wolf"}
	},
	["BigBadWolfsPaw"] = {
		id = 28584,
		name = "Big Bad Wolf's Paw",
		itemType = "Fist",
		slot = "Main-hand",
		source = {"The Big Bad Wolf"}
	},
	["EarthsoulLeggings"] = {
		id = 28591,
		name = "Earthsoul Leggings",
		itemType = "Leather",
		slot = "Legs",
		source = {"Moroes", "The Big Bad Wolf"}
	},
	["RibbonOfSacrifice"] = {
		id = 28590,
		name = "Ribbon of Sacrifice",
		itemType = "Trinket",
		slot = "Trinket",
		source = {"The Big Bad Wolf", "Romulo"}
	},
	["WolfslayerSniperRifle"] = {
		id = 28581,
		name = "Wolfslayer Sniper Rifle",
		itemType = "Gun",
		slot = "Ranged",
		source = {"The Big Bad Wolf"}
	},
	["MasqueradeGown"] = {
		id = 28578,
		name = "Masquerade Gown",
		itemType = "Cloth",
		slot = "Chest",
		source = {"Julianne"}
	}
}

local curator = {
	["DragonQuakeShoulderGuards"] = {
		id = 28631,
		name = "Dragon-Quake Shoulderguards",
		itemType = "Armor Token",
		slot = nil,
		source = {"The Curator"}
	},
	["GlovesOfTheFallenCrusade"] = {
		id = 28758,
		name = "Gloves of the Fallen Crusade",
		itemType = "Armor Token",
		slot = nil,
		source = {"The Curator"}
	},
	["WrynnDynastyGreaves"] = {
		id = 28621,
		name = "Wrynn Dynasty Greaves",
		itemType = "Plate",
		slot = "Legs",
		source = {"The Curator"}
	},
	["ForestWindShoulderpads"] = {
		id = 28647,
		name = "Forest Wind Shoulderpads",
		itemType = "Leather",
		slot = "Shoulder",
		source = {"The Curator"}
	},
	["GaronasSignetRing"] = {
		id = 28649,
		name = "Garona's Signet Ring",
		itemType = "Ring",
		slot = "Finger",
		source = {"The Curator"}
	},
	["GlovesOfTheFallenChampion"] = {
		id = 28757,
		name = "Gloves of the Fallen Champion",
		itemType = "Armor Token",
		slot = nil,
		source = {"The Curator"}
	},
	["GlovesOfTheFallenHero"] = {
		id = 28756,
		name = "Gloves of the Fallen Hero",
		itemType = "Armor Token",
		slot = nil,
		source = {"The Curator"}
	},
	["PauldronsOfTheSolaceGiver"] = {
		id = 28612,
		name = "Pauldrons of the Solace-Giver",
		itemType = "Cloth",
		slot = "Shoulder",
		source = {"The Curator"}
	},
	["StaffOfInfniteMysteries"] = {
		id = 28633,
		name = "Staff of Infinite Mysteries",
		itemType = "Staff",
		slot = "Two-hand",
		source = {"The Curator"}
	}
}

local chess = {
	["HeaddressOfTheHighPotentate"] = {
		id = 28756,
		name = "Headdress of the High Potentate",
		itemType = "Cloth",
		slot = "Head",
		source = {"Chess Event"}
	},
	["BladedShoulderpadsOfTheMerciless"] = {
		id = 28755,
		name = "Bladed Shoulderpads of the Merciless",
		itemType = "Leather",
		slot = "Shoulder",
		source = {"Chess Event"}
	},
	["ForestlordStriders"] = {
		id = 28752,
		name = "Forestlord Striders",
		itemType = "Leather",
		slot = "Feet",
		source = {"Chess Event"}
	},
	["GirdleOfTreachery"] = {
		id = 28750,
		name = "Girdle of Treachery",
		itemType = "Leather",
		slot = "Waist",
		source = {"Chess Event"}
	},
	["FiendSlayerBoots"] = {
		id = 28746,
		name = "Fiend Slayer Boots",
		itemType = "Mail",
		slot = "Feet",
		source = {"Chess Event"}
	},
	["HeartFlameLeggins"] = {
		id = 28751,
		name = "Heart-Flame Leggings",
		itemType = "Mail",
		slot = "Legs",
		source = {"Chess Event"}
	},
	["BattlescarBoots"] = {
		id = 28747,
		name = "Battlescar Boots",
		itemType = "Plate",
		slot = "Feet",
		source = {"Chess Event"}
	},
	["LegplatesOfTheInnocent"] = {
		id = 28748,
		name = "Legplates of the Innocent",
		itemType = "Plate",
		slot = "Legs",
		source = {"Chess Event"}
	},
	["MithrilChainOfHeroism"] = {
		id = 28745,
		name = "Mithril Chain of Heroism",
		itemType = "Amulet",
		slot = "Neck",
		source = {"Chess Event"}
	},
	["RingOfRecurrence"] = {
		id = 28753,
		name = "Ring of Recurrence",
		itemType = "Ring",
		slot = "Finger",
		source = {"Chess Event"}
	},
	["KingsDefender"] = {
		id = 28749,
		name = "King's Defender",
		itemType = "One-handed Sword",
		slot = "One-hand",
		source = {"Chess Event"}
	},
	["TriptychShieldOfTheAncients"] = {
		id = 28754,
		name = "Triptych Shield of the Ancients",
		itemType = "Shield",
		slot = "Off-hand",
		source = {"Chess Event"}
	}
}

local terestian = {
	["GildedThoriumCloak"] = {
		id = 28660,
		name = "Gilded Thorium Cloak",
		itemType = "Cloak",
		slot = "Back",
		source = {"Terestian Illhoof"}
	},
	["BreatplateOfTheLightbringer"] = {
		id = 28662,
		name = "Breatplate of the Lightbringer",
		itemType = "Plate",
		slot = "Chest",
		source = {"Terestian Illhoof"}
	},
	["CordOfNaturesSustenance"] = {
		id = 28655,
		name = "Cord of Nature's Sustenance",
		itemType = "Leather",
		slot = "Waist",
		source = {"Terestian Illhoof"}
	},
	["CinctureOfWill"] = {
		id = 28652,
		name = "Cincture of Will",
		itemType = "Cloth",
		slot = "Waist",
		source = {"Terestian Illhoof"}
	},
	["FoolsBane"] = {
		id = 28657,
		name = "Fool's Bane",
		itemType = "One-handed Mace",
		slot = "Main-hand",
		source = {"Terestian Illhoof"}
	},
	["GirdleOfTheProwler"] = {
		id = 28656,
		name = "Girdle of the Prowler",
		itemType = "Mail",
		slot = "Waist",
		source = {"Terestian Illhoof"}
	},
	["MaleficGirdle"] = {
		id = 28654,
		name = "Malefic Girdle",
		itemType = "Cloth",
		slot = "Waist",
		source = {"Terestian Illhoof"}
	},
	["MendersHeartRing"] = {
		id = 28661,
		name = "Mender's Heart-Ring",
		itemType = "Ring",
		slot = "Finger",
		source = {"Terestian Illhoof"}
	},
	["ShadowvineCloakOfInfusion"] = {
		id = 28653,
		name = "Shadowvine Cloak of Infusion",
		itemType = "Cloak",
		slot = "Back",
		source = {"Terestian Illhoof"}
	},
	["TerestiansStranglestaff"] = {
		id = 28658,
		name = "Terestian's Stranglestaff",
		itemType = "Cloth",
		slot = "Head",
		source = {"Terestian Illhoof"}
	},
	["TheLightningCapacitor"] = {
		id = 28785,
		name = "The Lightning Capacitor",
		itemType = "Trinket",
		slot = "Trinket",
		source = {"Terestian Illhoof"}
	},
	["XavianStiletto"] = {
		id = 28659,
		name = "Xavian Stiletto",
		itemType = "Thrown",
		slot = "Ranged",
		source = {"Terestian Illhoof"}
	}	
}

local shade = {
	["PendantOfTheVioletEye"] = {
		id = 28727,
		name = "Pendant of the Violet Eye",
		itemType = "Trinket",
		slot = "Trinket",
		source = {"Shade of Aran"}
	},
	["AransSoothingSapphire"] = {
		id = 28728,
		name = "Aran's Soothing Sapphire",
		itemType = "Off-hand Frill",
		slot = "Off-hand",
		source = {"Shade of Aran"}
	},
	["BootsOfTheIncorrupt"] = {
		id = 28663,
		name = "Boots of the Incorrupt",
		itemType = "Cloth",
		slot = "Feet",
		source = {"Shade of Aran"}
	},
	["BootsOfTheInfernalCoven"] = {
		id = 28670,
		name = "Boots of the Infernal Coven",
		itemType = "Cloth",
		slot = "Feet",
		source = {"Shade of Aran"}
	},
	["DrapeOfTheDarkReavers"] = {
		id = 28672,
		name = "Drape of the Dark Reavers",
		itemType = "Cloak",
		slot = "Back",
		source = {"Shade of Aran"}
	},
	["MantleOfTheMindFlayer"]	= {
		id = 28762,
		name = "Mantle of the Mind Flayer",
		itemType = "Cloth",
		slot = "Shoulder",
		source = {"Shade of Aran"}
	},
	["PauldronsOfTheJusticeSeeker"] = {
		id = 28666,
		name = "Pauldrons of the Justice Seeker",
		itemType = "Plate",
		slot = "Shoulder",
		source = {"Shade of Aran"}
	},
	["RapscallionBoots"] = {
		id = 28669,
		name = "Rapscallion Boots",
		itemType = "Leather",
		slot = "Feet",
		source = {"Shade of Aran"}
	},
	["SaberclawTalisman"] = {
		id = 28674,
		name = "Saberclaw Talisman",
		itemType = "Amulet",
		slot = "Neck",
		source = {"Shade of Aran"}
	},
	["ShermanarGreatRing"] = {
		id = 28675,
		name = "Shermanar Great-Ring",
		itemType = "Ring",
		slot = "Finger",
		source = {"Shade of Aran"}
	},
	["SteelspineFaceguard"] = {
		id = 28671,
		name = "Steelspine Faceguard",
		itemType = "Mail",
		slot = "Head",
		source = {"Shade of Aran"}
	},
	["TirisfalWandOfAscendancy"] = {
		id = 28673,
		name = "Tirisfal Wand of Ascendancy",
		itemType = "Wand",
		slot = "Ranged",
		source = {"Shade of Aran"}
	}
}

local netherspite = {
	["CowlOfDefiance"] = {
		id = 28732,
		name = "Cowl of Defiance",
		itemType = "Leather",
		slot = "Head",
		source = {"Netherspite"}
	},
	["EarthbloodChestguard"] = {
		id = 28735,
		name = "Earthblood Chestguard",
		itemType = "Mail",
		slot = "Chest",
		source = {"Netherspite"}
	},
	["GirdleOfTruth"] = {
		id = 28733,
		name = "Girdle of Truth",
		itemType = "Plate",
		slot = "Waist",
		source = {"Netherspite"}
	},
	["JewelOfInfinitePossibilities"] = {
		id = 28734,
		name = "Jewel of Infinite Possibilities",
		itemType = "Off-hand Frill",
		slot = "Off-hand",
		source = {"Netherspite"}
	},
	["MantleOfAbrahmis"] = {
		id = 28743,
		name = "Mantle of Abrahmis",
		itemType = "Plate",
		slot = "Shoulder",
		source = {"Netherspite"}
	},
	["MithrilBandOfTheUnscarred"] = {
		id = 28730,
		name = "Mithril Band of the Unscarred",
		itemType = "Ring",
		slot = "Finger",
		source = {"Netherspite"}
	},
	["PantaloonsOfRepentance"] = {
		id = 28742,
		name = "Pantaloons of Repentance",
		itemType = "Cloth",
		slot = "Legs",
		source = {"Netherspite"}
	},
	["RipFlayerLeggings"] = {
		id = 28740,
		name = "Rip-Flayer Leggings",
		itemType = "Mail",
		slot = "Legs",
		source = {"Netherspite"}
	},
	["ShiningChainOfTheAfterworld"] = {
		id = 28731,
		name = "Shining Chain of the Afterworld",
		itemType = "Amulet",
		slot = "Neck",
		source = {"Netherspite"}
	},
	["SkulkersGreaves"] = {
		id = 28741,
		name = "Skulker's Greaves",
		itemType = "Leather",
		slot = "Legs",
		source = {"Netherspite"}
	},
	["Spiteblade"] = {
		id = 28729,
		name = "Spiteblade",
		itemType = "One-handed Sword",
		slot = "One-hand",
		source = {"Netherspite"}
	},
	["UniMindHeaddress"] = {
		id = 28744,
		name = "Uni-Mind Headdress",
		itemType = "Cloth",
		slot = "Head",
		source = {"Netherspite"}
	}
}

local nightbane = {
	["ChestguardOfTheConniver"] = {
		id = 28601,
		name = "Chestguard of the Conniver",
		itemType = "Leather",
		slot = "Chest",
		source = {"Nightbane"}
	},
	["PanzarTharBreastplate"] = {
		id = 28597,
		name = "Panzar'Thar Breastplate",
		itemType = "Plate",
		slot = "Chest",
		source = {"Nightbane"}
	},
	["DragonheartFlameshield"] = {
		id = 28611,
		name = "Dragonheart Flameshield",
		itemType = "Shield",
		slot = "Shield",
		source = {"Nightbane"}
	},
	["EmberspurTalisman"] = {
		id = 28609,
		name = "Emberspur Talisman",
		itemType = "Amulet",
		slot = "Neck",
		source = {"Nightbane"}
	},
	["FerociousSwiftKickers"] = {
		id = 28610,
		name = "Ferocious Swift-Kickers",
		itemType = "Mail",
		slot = "Feet",
		source = {"Nightbane"}
	},
	["IronstridersOfUrgency"] = {
		id = 28608,
		name = "Ironstriders of Urgency",
		itemType = "Plate",
		slot = "Feet",
		source = {"Nightbane"}
	},
	["NightstaffOfTheEverliving"] = {
		id = 28604,
		name = "Nightstaff of the Everliving",
		itemType = "Staff",
		slot = "Two-hand",
		source = {"Nightbane"}
	},
	["RobeOfTheElderScribes"] = {
		id = 28602,
		name = "Robe of the Elder Scribes",
		itemType = "Cloth",
		slot = "Chest",
		source = {"Nightbane"}
	},
	["ScaledBreastplateOfCarnage"] = {
		id = 28599,
		name = "Scaled Breastplate of Carnage",
		itemType = "Mail",
		slot = "Chest",
		source = {"Nightbane"}
	},
	["ShieldOfImpenetrableDarkness"] = {
		id = 28606,
		name = "Shield of Impenetrable Darkness",
		itemType = "Shield",
		slot = "Shield",
		source = {"Nightbane"}
	},
	["StoneboughJerkin"] = {
		id = 28600,
		name = "Stonebough Jerkin",
		itemType = "Leather",
		slot = "Chest",
		source = {"Nightbane"}
	},
	["TalismanOfNightbane"] = {
		id = 28603,
		name = "Talisman of Nightbane",
		itemType = "Off-hand Frill",
		slot = "Off-hand",
		source = {"Nightbane"}
	}	
}

local malchezaar = {
	["RingOfAThousandMarks"] = {
		id = 28757,
		name = "Ring of a Thousand Marks",
		itemType = "Ring",
		slot = "Finger",
		source = {"Prince Malchezaar"}
	},
	["AdornmentOfStolenSouls"] = {
		id = 28762,
		name = "Adornment of Stolen Souls",
		itemType = "Amulet",
		slot = "Neck",
		source = {"Prince Malchezaar"}
	},
	["HelmOfTheFallenChampion"] = {
		id = 28760,
		name = "Helm of the Fallen Champion",
		itemType = "Armor Token",
		slot = "Head",
		source = {"Prince Malchezaar"}
	},
	["HelmOfTheFallenHero"] = {
		id = 28759,
		name = "Helm of the Fallen Hero",
		itemType = "Armor Token",
		slot = "Head",
		source = {"Prince Malchezaar"}
	},
	["Malchazeen"] = {
		id = 28768,
		name = "Malchazeen",
		itemType = "Dagger",
		slot = "One-hand",
		source = {"Prince Malchezaar"}
	},
	["FarstriderWildercloak"] = {
		id = 28764,
		name = "Farstrider Wildercloak",
		itemType = "Cloak",
		slot = "Back",
		source = {"Prince Malchezaar"}
	},
	["Gorehowl"] = {
		id = 28773,
		name = "Gorehowl",
		itemType = "Two-handed Axe",
		slot = "Two-hand",
		source = {"Prince Malchezaar"}
	},
	["HelmOfTheFallenDefender"] = {
		id = 28761,
		name = "Helm of the Fallen Defender",
		itemType = "Armor Token",
		slot = "Head",
		source = {"Prince Malchezaar"}
	},
	["JadeRingOfTheEverliving"] = {
		id = 28763,
		name = "Jade Ring Of The Everliving",
		itemType = "Ring",
		slot = "Finger",
		source = {"Prince Malchezaar"}
	},
	["LightsJustice"] = {
		id = 28771,
		name = "Light's Justice",
		itemType = "One-handed Mace",
		slot = "Main-hand",
		source = {"Prince Malchezaar"}
	},
	["NathrezimMindblade"] = {
		id = 28770,
		name = "Nathrezim Mindblade",
		itemType = "Dagger",
		slot = "Main-hand",
		source = {"Prince Malchezaar"}
	},
	["RubyDrapeOfTheMysticant"] = {
		id = 28766,
		name = "Ruby Drape of the Mysticant",
		itemType = "Cloak",
		slot = "Back",
		source = {"Prince Malchezaar"}
	},
	["StainlessCloakOfThePureHearted"] = {
		id = 28765,
		name = "Stainless Cloak of the Pure Hearted",
		itemType = "Cloak",
		slot = "Back",
		source = {"Prince Malchezaar"}
	},
	["SunfuryBowOfThePhoenix"] = {
		id = 28772,
		name = "Sunfury Bow of the Phoenix",
		itemType = "Bow",
		slot = "Ranged",
		source = {"Prince Malchezaar"}
	},
	["TheDecapitator"] = {
		id = 28767,
		name = "The Decapitator",
		itemType = "One-handed Axe",
		slot = "Main-hand",
		source = {"Prince Malchezaar"}
	}
}

local allEncounters = {trash, recipes, attumen, moroes,
					maiden, opera, curator, chess,
					terestian, shade, netherspite,
					nightbane, malchezaar
					}

local function FindMatchesInTable(encounter)
	if (namespace.filter == "all") then
		for itemKey, item in next, encounter do
			namespace.searchResult[itemKey] = item
		end
		
	else
		for itemKey, item in next, encounter do
			for key, field in next, item do
				if type(field) == "table" then
					for i, source in next, field do
						if string.lower(source) == namespace.filter then
							namespace.searchResult[itemKey] = item
						end
					end
				
				else
					if string.lower(field) == namespace.filter then
						namespace.searchResult[itemKey] = item
					end
				end
			end
		end
	end
end
					
function Kara:FilterSearch(filter)
	namespace.filter = filter or "all"
	namespace.searchResult = {}
	namespace.searchSize = 0
	for key, encounter in next, allEncounters do
		FindMatchesInTable(encounter)
	end
end

function Kara:GetWishlist() 
	return wishlist
end

function Kara:AddToWishlist(item)
	table.insert(wishlist, item)
end

function Kara:DeleteFromWishlist(item)
	item = item or "all"
	index = 1
	if item == "all" then
		wishlist = {}
	else
		for key, nextItem in next, wishlist do
			if item.id == nextItem.id then
				table.remove(index)
				break
			end
		end
		index = index + 1
	end
end