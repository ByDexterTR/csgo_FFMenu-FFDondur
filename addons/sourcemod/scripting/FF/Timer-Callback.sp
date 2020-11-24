public Action DondurGeriSay(Handle timer, any data)
{
	if (DondurmaSure > -1)
	{
		if (KapatmaSure > -1)
		{
			for (int i = 1; i <= MaxClients; i++)
			if (IsClientInGame(i) && !IsFakeClient(i))
				PrintHintText(i, "Freeze Süresi: %d\nFF Kapatma Süresi: %d\nBölge: %s", DondurmaSure, KapatmaSure, GidilecekYer);
			KapatmaSure--;
		}
		if (KapatmaSure <= -1)
		{
			if (Guns)
				Guns = false;
			if (FFAktif)
				FFAktif = false;
			if (GetConVarInt(FindConVar("mp_teammates_are_enemies")) != 0)
			{
				SetCvar("mp_teammates_are_enemies", 0);
				SetCvar("mp_friendlyfire", 0);
				if (GetConVarInt(FindConVar("mp_respawn_on_death_t")) != 0)
					SetCvar("mp_respawn_on_death_t", 0);
				PrintToChatAll("[SM] \x01Dost ateşi \x04kapatılmıştır!");
			}
			for (int i = 1; i <= MaxClients; i++)
			if (IsClientInGame(i) && !IsFakeClient(i))
				PrintHintText(i, "Freeze Süresi: %d\nFF Kapatıldı!\nBölge: %s", DondurmaSure, GidilecekYer);
		}
		DondurmaSure--;
	}
	if (DondurmaSure <= -1)
	{
		if (GetConVarInt(FindConVar("mp_teammates_are_enemies")) == 1 || GetConVarInt(FindConVar("mp_friendlyfire")) == 1)
		{
			SetCvar("mp_teammates_are_enemies", 0);
			SetCvar("mp_friendlyfire", 0);
		}
		ServerCommand("sm_freeze @t -1");
		for (int i = 1; i <= MaxClients; i++)
		{
			if (IsClientInGame(i) && !IsFakeClient(i))
			{
				PrintHintText(i, "Freeze Atıldı\nFF Kapatıldı!", DondurmaSure, KapatmaSure);
				Handle ScreenText = CreateHudSynchronizer();
				SetHudTextParams(-1.0, -0.35, 3.0, 0, 255, 0, 0, 2, 1.0, 0.01, 0.01);
				ShowSyncHudText(i, ScreenText, "Oyuncular Donduruldu!");
				delete ScreenText;
			}
		}
		g_gerisaytimerr = null;
		return Plugin_Stop;
	}
	return Plugin_Continue;
}

//

public Action GeriSayTimer(Handle timer, any data)
{
	if (GeriSay > -1)
	{
		YerdekiSilahlariSil();
		for (int i = 1; i <= MaxClients; i++)
		{
			if (IsClientInGame(i) && !IsFakeClient(i))
			{
				PrintHintText(i, "<font color='#00FF00'>%d Saniye</font> sonra dost ateşi başlayacak", GeriSay);
			}
		}
		GeriSay--;
		return Plugin_Continue;
	}
	if (GeriSay <= -1)
	{
		Guns = false;
		if (GetConVarInt(FindConVar("mp_teammates_are_enemies")) != 1)SetCvar("mp_teammates_are_enemies", 1);
		if (GetConVarInt(FindConVar("mp_friendlyfire")) != 1)SetCvar("mp_friendlyfire", 1);
		if (GetConVarInt(FindConVar("mp_respawn_on_death_t")) != 0)SetCvar("mp_respawn_on_death_t", 0);
		PrintToChatAll("[SM] \x01Dost ateşi \x04açıldı!");
		if (g_gerisaytimer != null)g_gerisaytimer = null;
		return Plugin_Stop;
	}
	return Plugin_Continue;
} 