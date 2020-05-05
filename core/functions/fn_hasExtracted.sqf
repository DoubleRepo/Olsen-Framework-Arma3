/*
 * Author: BlackHawk
 *
 * Checks if given part of team has extracted to set area.
 * This function accounts for team starting in extraction area.
 *
 * Arguments:
 * 0: team name <string>
 * 1: extraction area marker <string>
 * 2: part of team that has to extract (0.8 - 80%, etc.) <number> (OPTIONAL)
 *
 * Return Value:
 * has team extracted <bool>
 *
 * Public: Yes
 */

#include "..\script_macros.hpp"

params [["_team", "", [""]],
	["_marker", "", [""]],
	["_ratio", 1, [0]]
];

private _side = [_team, 1] call FUNC(getTeamVariable);
private _count = {
	(side _x isEqualTo _side) && {_x inArea _marker}
} count ([] call BIS_fnc_listPlayers);

private _result = false;
if ((CBA_missionTime > 60) && {_count >= _ratio * ([_team, 4] call FUNC(getTeamVariable))}) then {
	if (GETVAR(missionNamespace,hasDeparted,false)) then {
		_result = true;
	};
} else {
	GVAR(hasDeparted) = true;
};
_result