/*
	"Camp Fortitude" v2.1 static mission for Napf.
	Created by [CiC]red_ned using templates by eraser1 
	Credits to Pradatoru for mapping
	19 years of CiC http://cic-gaming.co.uk
	easy/mod/difficult/hardcore - reworked by [CiC]red_ned http://cic-gaming.co.uk
*/
private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate_loot_values0", "_crate_weapons0", "_crate_items0", "_crate_backpacks0", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_vehicle", "_cash", "_RocketChance", "_MineChance1", "_MineChance2", "_MineNumber1", "_MineRadius1", "_MineNumber2", "_MineRadius2", "_Minefield1", "_Minefield2", "_cleanMines1", "_cleanMines2", "_temp", "_temp2", "_temp3", "_logLauncher"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [13094.3,16155.9,0]; //insert the center here

// Possible Minefield Positions
_Minefield1 = [13094.3,16155.9,0];
_Minefield2 = [13094.3,16155.9,0];

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};

// Create temp Buildings
_baseObjs =	[
				"Camp_Fortitude_Objects"
			] call DMS_fnc_ImportFromM3E_3DEN_Static;

//create possible difficulty add more of one difficulty to weight it towards that
_PossibleDifficulty		= 	[	
								"easy",
								"easy",
								"moderate",
								"moderate",
								"difficult",
								"difficult",
								"difficult",
								"hardcore",
								"hardcore",
								"hardcore",
								"hardcore"
							];
//choose mission difficulty and set value and is also marker colour
_difficultyM = selectRandom _PossibleDifficulty;

switch (_difficultyM) do
{
	case "easy":
	{
		_difficulty = "easy";									//AI difficulty
		_AICount = (20 + (round (random 5)));					//AI starting numbers
		_AIMaxReinforcements = (10 + (round (random 5)));		//AI reinforcement cap
		_AItrigger = (10 + (round (random 5)));					//If AI numbers fall below this number then reinforce if any left from AIMax
		_AIwave = (4 + (round (random 4)));						//Max amount of AI in reinforcement wave
		_AIdelay = (55 + (round (random 120)));					//The delay between reinforcements
		_cash = (250 + round (random (500)));					//this gives 250 to 750 cash
		_crate_weapons0 	= (5 + (round (random 20)));		//Crate 0 weapons number
		_crate_items0 		= (5 + (round (random 20)));		//Crate 0 items number
		_crate_backpacks0 	= (3 + (round (random 1)));			//Crate 0 back packs number
		_RocketChance = 25;
		_MineChance1 = -1;
		_MineChance2 = 25;
		_MineNumber1 = (0 + (round (random 10)));
		_MineNumber2 = (5 + (round (random 5)));
		_MineRadius1 = (50 + (round (random 15)));
		_MineRadius2 = (55 + (round (random 50)));
	};
	case "moderate":
	{
		_difficulty = "moderate";
		_AICount = (20 + (round (random 5)));
		_AIMaxReinforcements = (20 + (round (random 10)));
		_AItrigger = (10 + (round (random 10)));
		_AIwave = (5 + (round (random 3)));
		_AIdelay = (55 + (round (random 120)));
		_cash = (500 + round (random (750)));					//this gives 500 to 1250 cash	
		_crate_weapons0 	= (10 + (round (random 15)));
		_crate_items0 		= (10 + (round (random 15)));
		_crate_backpacks0 	= (3 + (round (random 1)));
		_RocketChance = 33;
		_MineChance1 = -1;
		_MineChance2 = 33;
		_MineNumber1 = (5 + (round (random 10)));
		_MineNumber2 = (5 + (round (random 15)));
		_MineRadius1 = (60 + (round (random 25)));
		_MineRadius2 = (65 + (round (random 50)));;
	};
	case "difficult":
	{
		_difficulty = "difficult";
		_AICount = (30 + (round (random 5)));
		_AIMaxReinforcements = (20 + (round (random 10)));
		_AItrigger = (10 + (round (random 10)));
		_AIwave = (6 + (round (random 2)));
		_AIdelay = (55 + (round (random 120)));
		_cash = (750 + round (random (1000)));					//this gives 750 to 1750 cash
		_crate_weapons0 	= (30 + (round (random 20)));
		_crate_items0 		= (15 + (round (random 10)));
		_crate_backpacks0 	= (3 + (round (random 1)));
		_RocketChance = 75;
		_MineChance1 = -1;
		_MineChance2 = 75;
		_MineNumber1 = (10 + (round (random 10)));
		_MineNumber2 = (15 + (round (random 15)));
		_MineRadius1 = (70 + (round (random 35)));
		_MineRadius2 = (75 + (round (random 60)));
	};
	//case "hardcore":
	default
	{
		_difficulty = "hardcore";
		_AICount = (30 + (round (random 10)));
		_AIMaxReinforcements = (30 + (round (random 10)));
		_AItrigger = (10 + (round (random 5)));
		_AIwave = (6 + (round (random 2)));
		_AIdelay = (55 + (round (random 120)));
		_cash = (1000 + round (random (1500)));					//this gives 1000 to 2500 cash
		_crate_weapons0 	= (20 + (round (random 5)));
		_crate_items0 		= (20 + (round (random 5)));
		_crate_backpacks0 	= (2 + (round (random 1)));
		_RocketChance = 100;
		_MineChance1 = -1;
		_MineChance2 = 100;
		_MineNumber1 = (15 + (round (random 20)));
		_MineNumber2 = (15 + (round (random 25)));
		_MineRadius1 = (75 + (round (random 40)));
		_MineRadius2 = (75 + (round (random 65)));
	};
};

//add launchers if chance great enough
if (_RocketChance >= (random 100)) then {
											_temp = DMS_ai_use_launchers;
											DMS_ai_use_launchers = true;
											_temp2 = DMS_ai_use_launchers_chance;
											DMS_ai_use_launchers_chance = 100;
											_logLauncher = "1";
										} else
										{
											_temp = DMS_ai_use_launchers;
											DMS_ai_use_launchers = false;
											_temp2 = DMS_ai_use_launchers_chance;
											DMS_ai_use_launchers_chance = 0;
											_logLauncher = "0";
										};

// Make sure mine clean up is on, but we will handle it too
_temp3 = DMS_despawnMines_onCompletion;
DMS_despawnMines_onCompletion = true;

//add minefields if chance great enough
if (_MineChance1 >= (random 100)) then 	{
							_cleanMines1 = 		[
													_pos,
													_difficulty,
													[_MineNumber1,_MineRadius1],
													_side
												] call DMS_fnc_SpawnMinefield;
										} else
										{
							_cleanMines1 = [];
										};

if (_MineChance2 >= (random 100)) then 	{
							_cleanMines2 =		[
													_Minefield2,
													_difficultyM,
													[_MineNumber2,_MineRadius2],
													_side
												] call DMS_fnc_SpawnMinefield;
										} else
										{
							_cleanMines2 = [];
										};

// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations = 	[
								[13061.7,16166,0.00270176],
								[13064.1,16147,0.00415325],
								[13072.5,16200.7,0.00630569],
								[13082.8,16126.1,0.00469208],
								[13084.1,16164.2,4.22812],
								[13089.5,16152.8,0.00466633],
								[13090.1,16168.9,3.47277],
								[13097.3,16145.4,0.00573826],
								[13101,16199.1,0.00356293],
								[13104.9,16125.9,0.00562668],
								[13106.3,16145.1,0.00328255],
								[13117.7,16126,0.00569534],
								[13136.2,16134.3,0.00784588],
								[13137.6,16164.5,0.00195694]
							];
// Shuffle the list of possible patrol spawn locations
_AISoldierSpawnLocations = _AISoldierSpawnLocations call ExileClient_util_array_shuffle;			
							
_group = 	[
				_AISoldierSpawnLocations+[_pos,_pos,_pos],			// Pass the regular spawn locations as well as the center pos 3x
				_AICount,
				_difficulty,
				"random",
				_side
			] call DMS_fnc_SpawnAIGroup_MultiPos;
			
/*	Uncomment to stop Ai wandering off
{_x disableAI "PATH";} forEach (units _group);
*/

_staticGuns = 	[
					[
						[13081.8,16165.7,4.15311],
						[13082.6,16160.2,2.17255],
						[13090.6,16139.2,-6.29425e-005],
						[13091.8,16161,4.26693],
						[13095.8,16170.1,0.000451088],
						[13100.5,16144.5,6.67572e-006],
						[13111.3,16167.9,9.53674e-005]
					],
					_group,
					"assault",
					_difficulty,
					"bandit",
					"random"
				] call DMS_fnc_SpawnAIStaticMG;

// Define the class names and locations where the crates can spawn (at least 2, since we're spawning 2 crates)
_crateClasses_and_Positions = 	[
									[[13082.1,16149,0.0111084],"I_CargoNet_01_ammo_F"],
									[[13088.9,16165.3,3.91915],"I_CargoNet_01_ammo_F"],
									[[13100,16142.7,0.0279121],"I_CargoNet_01_ammo_F"],
									[[13109.6,16155.3,0.0179853],"I_CargoNet_01_ammo_F"],
									[[13110.4,16171,0.0176811],"I_CargoNet_01_ammo_F"]
								];

{
	deleteVehicle (nearestObject _x);		// Make sure to remove any previous crates.
} forEach _crateClasses_and_Positions;

// Shuffle the list
_crateClasses_and_Positions = _crateClasses_and_Positions call ExileClient_util_array_shuffle;

// Create Crates
_crate0 = [_crateClasses_and_Positions select 0 select 1, _crateClasses_and_Positions select 0 select 0] call DMS_fnc_SpawnCrate;

// Enable smoke on the crates due to size of area
{
	_x setVariable ["DMS_AllowSmoke", true];
} forEach [_crate0];

// Define mission-spawned AI Units
_missionAIUnits = 	[
						_group 		// We only spawned the single group for this mission
					];

// Define the group reinforcements
_groupReinforcementsInfo = 	[
								[
									_group,			// pass the group
									[
										[
											0,		// Let's limit number of units instead...
											0
										],
										[
											_AIMaxReinforcements,	// Maximum units that can be given as reinforcements (defined in difficulty selection).
											0
										]
									],
									[
										_AIdelay,		// The delay between reinforcements. >> you can change this in difficulty settings
										diag_tickTime
									],
									_AISoldierSpawnLocations,
									"random",
									_difficulty,
									_side,
									"reinforce",
									[
										_AItrigger,		// Set in difficulty select - Reinforcements will only trigger if there's fewer than X members left
										_AIwave			// X reinforcement units per wave. >> you can change this in mission difficulty section
									]
								]
							];

// setup crates with items from choices
_crate_loot_values0 = 	[
							_crate_weapons0,		// Set in difficulty select - Weapons
							_crate_items0,			// Set in difficulty select - Items
							_crate_backpacks0 		// Set in difficulty select - Backpacks
						];

// add cash to crate
_crate0 setVariable ["ExileMoney", _cash,true];						
						
// Define mission-spawned objects and loot values
_missionObjs = [
					_staticGuns+_baseObjs,			// static gun(s). Add so they get cleaned up.
					[],
					[[_crate0,_crate_loot_values0]],
					_cleanMines1,
					_cleanMines2
				];

// Define Mission Start message
_msgStart = ['#FFFF00',format["%1 Terrorists are setting up camp",_difficultyM]];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully killed the Terrorists and stolen all the loot"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Terrorists got bored and buggered off taking all the goodies..."];

// Define mission name (for map marker and logging)
_missionName = "Camp Fortitude";

// Create Markers
_markers = 	[
				_pos,
				_missionName,
				_difficultyM
			] call DMS_fnc_CreateMarker;

_circle = _markers select 1;
_circle setMarkerDir 0;
_circle setMarkerSize [200,200];

_time = diag_tickTime;

// Parse and add mission info to missions monitor
_added = 	[
				_pos,
				[
					[
						"kill",
						_group
					],
					[
						"playerNear",
						[_pos,100]
					]
				],
				_groupReinforcementsInfo,
				[
					_time,
					DMS_StaticMissionTimeOut call DMS_fnc_SelectRandomVal
				],
				_missionAIUnits,
				_missionObjs,
				[_missionName,_msgWIN,_msgLOSE],
				_markers,
				_side,
				_difficultyM,
				[[],[]]
			] call DMS_fnc_AddMissionToMonitor_Static;

// Check to see if it was added correctly, otherwise delete the stuff
if !(_added) exitWith
{
	diag_log format ["DMS ERROR :: Attempt to set up mission %1 with invalid parameters for DMS_fnc_AddMissionToMonitor_Static! Deleting mission objects and resetting DMS_MissionCount.",_missionName];

	_cleanup = [];
	{
		_cleanup pushBack _x;
	} forEach _missionAIUnits;

	_cleanup pushBack ((_missionObjs select 0)+(_missionObjs select 1));
	
	{
		_cleanup pushBack (_x select 0);
	} foreach (_missionObjs select 2);

	_cleanup call DMS_fnc_CleanUp;

	// Delete the markers directly
	{deleteMarker _x;} forEach _markers;

	// Reset the mission count
	DMS_MissionCount = DMS_MissionCount - 1;
};

// Notify players
[_missionName,_msgStart] call DMS_fnc_BroadcastMissionStatus;

if (DMS_DEBUG) then
{
	(format ["MISSION: (%1) :: Mission #%2 started at %3 with %4 AI units and %5 difficulty at time %6",_missionName,_num,_pos,_AICount,_difficulty,_time]) call DMS_fnc_DebugLog;
};