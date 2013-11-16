private ["_args","_option","_obj","_id","_elevatorStop","_dist"];

if (TradeInprogress) exitWith { cutText ["Upgrade already in progress." , "PLAIN DOWN"]; };
TradeInprogress = true;

player removeAction s_player_elevator_upgrade;
s_player_elevator_upgrade = 1;
player removeAction s_player_elevator_upgrade_stop;
s_player_elevator_upgrade_stop = 1;

_args = _this select 3;
_option = _args select 0;
switch (_option) do {
	case "build": {
		_obj = _args select 1;
		_id = [_obj] call ELE_fnc_generateElevatorId;
		if (_id == "") exitWith { cutText ["invalid elevator ID generated", "PLAIN"] };
		ELE_elevator = [_obj, _id] call ELE_fnc_swapObject;
		titleText ["Elevator Built", "PLAIN"];
	};
	case "build_stop": {
		_obj = _args select 1;
		if (isNil "ELE_elevator") exitWith { cutText ["no elevator selected", "PLAIN"] };
		_dist = _obj distance ELE_elevator;
		if (_dist > ELE_MaxRange) exitWith { cutText [format["Elevator Stop is to far away from Elevator (%1 > %2)", _dist, ELE_MaxRange], "PLAIN"] };
		_id = [ELE_elevator] call ELE_fnc_getNextStopId;
		if (_id == "") exitWith { cutText ["Elevator Stop already exists or to many (max. 9 per Elevator)", "PLAIN"] };
		_elevatorStop = [_obj, _id, ELE_StopClass] call ELE_fnc_swapObject;
		titleText ["Elevator Stop Built", "PLAIN"];
	};
};

TradeInprogress = false;
s_player_elevator_upgrade = -1;
s_player_elevator_upgrade_stop = -1;
