void SetCvar(char cvarName[64], int value)
{
	Handle IntCvar = FindConVar(cvarName);
	if (IntCvar == null)return;
	int flags = GetConVarFlags(IntCvar);
	flags &= ~FCVAR_NOTIFY;
	SetConVarFlags(IntCvar, flags);
	SetConVarInt(IntCvar, value);
	flags |= FCVAR_NOTIFY;
	SetConVarFlags(IntCvar, flags);
}

public Action HGR_OnClientHook(int client)
{
	if (FFAktif && GetClientTeam(client) == CS_TEAM_T)return Plugin_Handled;
	return Plugin_Continue;
}

public Action HGR_OnClientGrab(int client)
{
	if (FFAktif && GetClientTeam(client) == CS_TEAM_T)return Plugin_Handled;
	return Plugin_Continue;
}

public Action HGR_OnClientRope(int client)
{
	if (FFAktif && GetClientTeam(client) == CS_TEAM_T)return Plugin_Handled;
	return Plugin_Continue;
}

bool HasFlags(int client, char[] sFlags)
{
	if (StrEqual(sFlags, "public", false) || StrEqual(sFlags, "", false))return true; if (StrEqual(sFlags, "none", false))return false; AdminId id = GetUserAdmin(client); if (id == INVALID_ADMIN_ID)return false; if (CheckCommandAccess(client, "sm_not_a_command", ADMFLAG_ROOT, true))return true; int iCount, iFound, flags;
	if (StrContains(sFlags, ";", false) != -1)
	{
		int c = 0, iStrCount = 0;
		while (sFlags[c] != '\0')
		{
			if (sFlags[c++] == ';')iStrCount++;
		}
		iStrCount++; char[][] sTempArray = new char[iStrCount][30]; ExplodeString(sFlags, ";", sTempArray, iStrCount, 30);
		for (int i = 0; i < iStrCount; i++)
		{
			flags = ReadFlagString(sTempArray[i]); iCount = 0; iFound = 0;
			for (int j = 0; j <= 20; j++)
			{
				if (flags & (1 << j))
				{
					iCount++; if (GetAdminFlag(id, view_as<AdminFlag>(j)))iFound++;
				}
			}
			if (iCount == iFound)return true;
		}
	}
	else
	{
		flags = ReadFlagString(sFlags); iCount = 0; iFound = 0;
		for (int i = 0; i <= 20; i++)
		{
			if (flags & (1 << i))
			{
				iCount++; if (GetAdminFlag(id, view_as<AdminFlag>(i)))iFound++;
			}
		}
		if (iCount == iFound)return true;
	} return false;
} 