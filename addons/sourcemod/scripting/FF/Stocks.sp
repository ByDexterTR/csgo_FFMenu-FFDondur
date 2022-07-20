void SetCvar(char[] cvarName, int value)
{
	ConVar IntCvar = FindConVar(cvarName);
	if (IntCvar == null)return;
	int flags = IntCvar.Flags;
	flags &= ~FCVAR_NOTIFY;
	IntCvar.Flags = flags;
	IntCvar.IntValue = value;
	flags |= FCVAR_NOTIFY;
	IntCvar.Flags = flags;
}

public Action HGR_OnClientHook(int client)
{
	if (bHgr && FFAktif && GetClientTeam(client) == 2)return Plugin_Handled;
	return Plugin_Continue;
}

public Action HGR_OnClientGrab(int client)
{
	if (bHgr && FFAktif && GetClientTeam(client) == 2)return Plugin_Handled;
	return Plugin_Continue;
}

public Action HGR_OnClientRope(int client)
{
	if (bHgr && FFAktif && GetClientTeam(client) == 2)return Plugin_Handled;
	return Plugin_Continue;
}

bool HasFlags(int client, const char[] flags)
{
	int iCount = 0;
	char sflagNeed[22][8], sflagFormat[64];
	bool bEntitled = false;
	Format(sflagFormat, sizeof(sflagFormat), flags);
	ReplaceString(sflagFormat, sizeof(sflagFormat), " ", "");
	iCount = ExplodeString(sflagFormat, ",", sflagNeed, sizeof(sflagNeed), sizeof(sflagNeed[]));
	for (int i = 0; i < iCount; i++)if ((GetUserFlagBits(client) & ReadFlagString(sflagNeed[i])) || (GetUserFlagBits(client) & ADMFLAG_ROOT))
	{
		bEntitled = true;
		break;
	}
	return bEntitled;
}

void YerdekiSilahlariSil()
{
	int g_WeaponParent = FindSendPropInfo("CBaseCombatWeapon", "m_hOwnerEntity");
	int maxent = GetMaxEntities();
	char weapon[64];
	for (int i = MaxClients; i < maxent; i++)if (IsValidEdict(i) && IsValidEntity(i))
	{
		GetEntityClassname(i, weapon, sizeof(weapon));
		if ((StrContains(weapon, "weapon_") != -1 || StrContains(weapon, "item_") != -1) && GetEntDataEnt2(i, g_WeaponParent) == -1)
			RemoveEntity(i);
	}
}

bool IsValidClient(int client, bool nobots = true)
{
	if (client <= 0 || client > MaxClients || !IsClientConnected(client) || (nobots && IsFakeClient(client)))
	{
		return false;
	}
	return IsClientInGame(client);
} 