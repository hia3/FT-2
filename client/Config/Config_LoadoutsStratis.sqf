
Local_RscGear_SavedInventory = [player] call Func_Client_GetPlayerInventory;
FT2_WF_Logic setVariable ["currentCost", Local_RscGear_SavedInventory call Func_Client_GetInventoryCost];
