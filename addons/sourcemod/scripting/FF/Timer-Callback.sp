public Action DondurGeriSay(Handle timer, any data)
{
	if (DondurmaSure > -1)
	{
		if (KapatmaSure > -1)
		{
			for (int i = 1; i <= MaxClients; i++)if (IsValidClient(i))
			{
				PrintHintText(i, "Freeze Süresi: <font color='#00bbff'>%d</font>\nFF Kapatma Süresi: <font color='#ffbb00'>%d</font>\nBölge: <font color='#ff0000'>%s</font>", DondurmaSure, KapatmaSure, GidilecekYer);
			}
			KapatmaSure--;
		}
		else
		{
			Guns = false;
			FFAktif = false;
			if (FindConVar("mp_teammates_are_enemies").IntValue != 0)
			{
				SetCvar("mp_teammates_are_enemies", 0);
				SetCvar("mp_friendlyfire", 0);
				SetCvar("mp_respawn_on_death_t", 0);
				PrintToChatAll("[SM] \x01Dost ateşi \x04kapatılmıştır!");
			}
			for (int i = 1; i <= MaxClients; i++)if (IsValidClient(i))
			{
				PrintHintText(i, "Freeze Süresi: <font color='#00bbff'>%d</font>\n<font color='#ffbb00'>FF Kapatıldı</font>\nBölge: <font color='#ff0000'>%s</font>", DondurmaSure, GidilecekYer);
			}
		}
		DondurmaSure--;
	}
	else
	{
		SetCvar("mp_teammates_are_enemies", 0);
		SetCvar("mp_friendlyfire", 0);
		ServerCommand("sm_freeze @t -1");
		for (int i = 1; i <= MaxClients; i++)
		{
			if (IsValidClient(i))
			{
				PrintHintText(i, "<font color='#00bbff'>Freeze Atıldı</font>\n<font color='#ffbb00'>FF Kapatıldı</font>", DondurmaSure, KapatmaSure);
				SetHudTextParams(-1.0, -0.35, 3.0, 0, 255, 0, 0, 2, 1.0, 0.01, 0.01);
				ShowSyncHudText(i, ScreenText, "Oyuncular Donduruldu!");
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
		for (int i = 1; i <= MaxClients; i++)if (IsValidClient(i))
		{
			PrintHintText(i, "<font color='#ffbb00'>%d Saniye</font> sonra dost ateşi başlayacak", GeriSay);
		}
		GeriSay--;
		return Plugin_Continue;
	}
	else
	{
		Guns = false;
		SetCvar("mp_teammates_are_enemies", 1);
		SetCvar("mp_friendlyfire", 1);
		SetCvar("mp_respawn_on_death_t", 0);
		PrintToChatAll("[SM] \x01Dost ateşi \x04açıldı!");
		if (g_gerisaytimer != null)g_gerisaytimer = null;
		return Plugin_Stop;
	}
} 