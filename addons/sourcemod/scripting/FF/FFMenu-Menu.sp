Menu menugoster()
{
	Menu menu = new Menu(Menu_Callback);
	menu.SetTitle("^-^ FF Menu - Ne Zaman FF Açılsın?");
	if (GetConVarInt(FindConVar("mp_teammates_are_enemies")) != 1)
	{
		menu.AddItem("ffbaslat", "Dost Ateşi Başlat");
	}
	if (GetConVarInt(FindConVar("mp_teammates_are_enemies")) != 0)
	{
		menu.AddItem("ffkapat", "Dost Ateşi Kapat");
	}
	menu.AddItem("ben", "Kendim belirleyeceğim");
	menu.AddItem("60sn", "60 Saniye Sonra");
	menu.AddItem("50sn", "50 Saniye Sonra");
	menu.AddItem("45sn", "45 Saniye Sonra");
	menu.AddItem("40sn", "40 Saniye Sonra");
	menu.AddItem("30sn", "30 Saniye Sonra");
	menu.AddItem("20sn", "20 Saniye Sonra");
	menu.AddItem("15sn", "15 Saniye Sonra");
	menu.AddItem("10sn", "10 Saniye Sonra");
	menu.AddItem("5sn", "5 Saniye Sonra");
	return menu;
}

public int Menu_Callback(Menu menu, MenuAction action, int client, int param2)
{
	if (action == MenuAction_Select)
	{
		char Item[32];
		menu.GetItem(param2, Item, sizeof(Item));
		if (strcmp(Item, "ffbaslat", false) == 0)
		{
			PrintToChatAll("[SM] \x0C%N \x01tarafından Dost ateşi \x04açılmıştır!", client);
			if (!FFAktif)
				FFAktif = true;
			if (g_gerisaytimer != null)
				delete g_gerisaytimer;
			if (Guns)
				Guns = false;
			if (GetConVarInt(FindConVar("mp_teammates_are_enemies")) != 1)
				SetCvar("mp_teammates_are_enemies", 1);
			if (GetConVarInt(FindConVar("mp_friendlyfire")) != 1)
				SetCvar("mp_friendlyfire", 1);
			if (GetConVarInt(FindConVar("mp_respawn_on_death_t")) != 0)
				SetCvar("mp_respawn_on_death_t", 0);
		}
		else if (strcmp(Item, "ffkapat", false) == 0)
		{
			if (g_gerisaytimer != null)
				delete g_gerisaytimer;
			if (Guns)
				Guns = false;
			if (FFAktif)
				FFAktif = false;
			if (GetConVarInt(FindConVar("mp_teammates_are_enemies")) != 0)
				SetCvar("mp_teammates_are_enemies", 0);
			if (GetConVarInt(FindConVar("mp_friendlyfire")) != 0)
				SetCvar("mp_friendlyfire", 0);
			if (GetConVarInt(FindConVar("mp_respawn_on_death_t")) != 0)
				SetCvar("mp_respawn_on_death_t", 0);
			PrintToChatAll("[SM] \x0C%N \x01tarafından Dost ateşi \x04iptal edilmiştir!", client);
		}
		else if (strcmp(Item, "ben", false) == 0)
		{
			ReplyToCommand(client, "[SM] \x01Kullanım: sm_ffmenu (Saniye)");
		}
		else if (strcmp(Item, "60sn", false) == 0)
		{
			GeriSay = 60;
			if (g_gerisaytimer != null)
				delete g_gerisaytimer;
			if (GetConVarInt(FindConVar("mp_teammates_are_enemies")) != 0)
				SetCvar("mp_teammates_are_enemies", 0);
			if (GetConVarInt(FindConVar("mp_friendlyfire")) != 0)
				SetCvar("mp_friendlyfire", 0);
			if (GetConVarInt(FindConVar("mp_respawn_on_death_t")) != 0)
				SetCvar("mp_respawn_on_death_t", 0);
			PrintToChatAll("[SM] \x0C%N \x01tarafından \x04FF Süresi %d saniye \x01belirlenmiştir!", client, GeriSay);
			yasaklisilah().Display(client, MENU_TIME_FOREVER);
		}
		else if (strcmp(Item, "50sn", false) == 0)
		{
			GeriSay = 50;
			if (g_gerisaytimer != null)
				delete g_gerisaytimer;
			if (GetConVarInt(FindConVar("mp_teammates_are_enemies")) != 0)
				SetCvar("mp_teammates_are_enemies", 0);
			if (GetConVarInt(FindConVar("mp_friendlyfire")) != 0)
				SetCvar("mp_friendlyfire", 0);
			if (GetConVarInt(FindConVar("mp_respawn_on_death_t")) != 0)
				SetCvar("mp_respawn_on_death_t", 0);
			PrintToChatAll("[SM] \x0C%N \x01tarafından \x04FF Süresi %d saniye \x01belirlenmiştir!", client, GeriSay);
			yasaklisilah().Display(client, MENU_TIME_FOREVER);
		}
		else if (strcmp(Item, "45sn", false) == 0)
		{
			GeriSay = 45;
			if (g_gerisaytimer != null)
				delete g_gerisaytimer;
			if (GetConVarInt(FindConVar("mp_teammates_are_enemies")) != 0)
				SetCvar("mp_teammates_are_enemies", 0);
			if (GetConVarInt(FindConVar("mp_friendlyfire")) != 0)
				SetCvar("mp_friendlyfire", 0);
			if (GetConVarInt(FindConVar("mp_respawn_on_death_t")) != 0)
				SetCvar("mp_respawn_on_death_t", 0);
			PrintToChatAll("[SM] \x0C%N \x01tarafından \x04FF Süresi %d saniye \x01belirlenmiştir!", client, GeriSay);
			yasaklisilah().Display(client, MENU_TIME_FOREVER);
		}
		else if (strcmp(Item, "40sn", false) == 0)
		{
			GeriSay = 40;
			if (g_gerisaytimer != null)
				delete g_gerisaytimer;
			if (GetConVarInt(FindConVar("mp_teammates_are_enemies")) != 0)
				SetCvar("mp_teammates_are_enemies", 0);
			if (GetConVarInt(FindConVar("mp_friendlyfire")) != 0)
				SetCvar("mp_friendlyfire", 0);
			if (GetConVarInt(FindConVar("mp_respawn_on_death_t")) != 0)
				SetCvar("mp_respawn_on_death_t", 0);
			PrintToChatAll("[SM] \x0C%N \x01tarafından \x04FF Süresi %d saniye \x01belirlenmiştir!", client, GeriSay);
			yasaklisilah().Display(client, MENU_TIME_FOREVER);
		}
		else if (strcmp(Item, "30sn", false) == 0)
		{
			GeriSay = 30;
			if (g_gerisaytimer != null)
				delete g_gerisaytimer;
			if (GetConVarInt(FindConVar("mp_teammates_are_enemies")) != 0)
				SetCvar("mp_teammates_are_enemies", 0);
			if (GetConVarInt(FindConVar("mp_friendlyfire")) != 0)
				SetCvar("mp_friendlyfire", 0);
			if (GetConVarInt(FindConVar("mp_respawn_on_death_t")) != 0)
				SetCvar("mp_respawn_on_death_t", 0);
			PrintToChatAll("[SM] \x0C%N \x01tarafından \x04FF Süresi %d saniye \x01belirlenmiştir!", client, GeriSay);
			yasaklisilah().Display(client, MENU_TIME_FOREVER);
		}
		else if (strcmp(Item, "20sn", false) == 0)
		{
			GeriSay = 20;
			if (g_gerisaytimer != null)
				delete g_gerisaytimer;
			if (GetConVarInt(FindConVar("mp_teammates_are_enemies")) != 0)
				SetCvar("mp_teammates_are_enemies", 0);
			if (GetConVarInt(FindConVar("mp_friendlyfire")) != 0)
				SetCvar("mp_friendlyfire", 0);
			if (GetConVarInt(FindConVar("mp_respawn_on_death_t")) != 0)
				SetCvar("mp_respawn_on_death_t", 0);
			PrintToChatAll("[SM] \x0C%N \x01tarafından \x04FF Süresi %d saniye \x01belirlenmiştir!", client, GeriSay);
			yasaklisilah().Display(client, MENU_TIME_FOREVER);
		}
		else if (strcmp(Item, "15sn", false) == 0)
		{
			GeriSay = 15;
			if (g_gerisaytimer != null)
				delete g_gerisaytimer;
			if (GetConVarInt(FindConVar("mp_teammates_are_enemies")) != 0)
				SetCvar("mp_teammates_are_enemies", 0);
			if (GetConVarInt(FindConVar("mp_friendlyfire")) != 0)
				SetCvar("mp_friendlyfire", 0);
			if (GetConVarInt(FindConVar("mp_respawn_on_death_t")) != 0)
				SetCvar("mp_respawn_on_death_t", 0);
			PrintToChatAll("[SM] \x0C%N \x01tarafından \x04FF Süresi %d saniye \x01belirlenmiştir!", client, GeriSay);
			yasaklisilah().Display(client, MENU_TIME_FOREVER);
		}
		else if (strcmp(Item, "10sn", false) == 0)
		{
			GeriSay = 10;
			if (g_gerisaytimer != null)
				delete g_gerisaytimer;
			if (GetConVarInt(FindConVar("mp_teammates_are_enemies")) != 0)
				SetCvar("mp_teammates_are_enemies", 0);
			if (GetConVarInt(FindConVar("mp_friendlyfire")) != 0)
				SetCvar("mp_friendlyfire", 0);
			if (GetConVarInt(FindConVar("mp_respawn_on_death_t")) != 0)
				SetCvar("mp_respawn_on_death_t", 0);
			PrintToChatAll("[SM] \x0C%N \x01tarafından \x04FF Süresi %d saniye \x01belirlenmiştir!", client, GeriSay);
			yasaklisilah().Display(client, MENU_TIME_FOREVER);
		}
		else if (strcmp(Item, "5sn", false) == 0)
		{
			GeriSay = 5;
			if (g_gerisaytimer != null)
				delete g_gerisaytimer;
			if (GetConVarInt(FindConVar("mp_teammates_are_enemies")) != 0)
				SetCvar("mp_teammates_are_enemies", 0);
			if (GetConVarInt(FindConVar("mp_friendlyfire")) != 0)
				SetCvar("mp_friendlyfire", 0);
			if (GetConVarInt(FindConVar("mp_respawn_on_death_t")) != 0)
				SetCvar("mp_respawn_on_death_t", 0);
			PrintToChatAll("[SM] \x0C%N \x01tarafından \x04FF Süresi %d saniye \x01belirlenmiştir!", client, GeriSay);
			yasaklisilah().Display(client, MENU_TIME_FOREVER);
		}
	}
	else if (action == MenuAction_End)
	{
		delete menu;
	}
}

Menu yasaklisilah()
{
	Menu menu2 = new Menu(Menu2_Callback);
	menu2.SetTitle("^-^ FF Menu - Ayarlar");
	menu2.AddItem("onayla", "Ayarları Onayla");
	menu2.AddItem("ayarlasilah", "Yasaklı Ana Silahar");
	menu2.AddItem("ayarlatabanca", "Yasaklı Tabanacalar");
	if (bac)
		menu2.AddItem("bunnyayarla", "Bunny: [KAPALI]");
	else
		menu2.AddItem("bunnyayarla", "Bunny: [AÇIK]");
	if (revive)
		menu2.AddItem("canlandirmaayarla", "Oto Respawn: [AÇIK]");
	else
		menu2.AddItem("canlandirmaayarla", "Oto Respawn: [KAPALI]");
	if (onlyhs)
		menu2.AddItem("kafaayarla", "Sadece HS: [AÇIK]");
	else
		menu2.AddItem("kafaayarla", "Sadece HS: [KAPALI]");
	menu2.ExitBackButton = true;
	menu2.ExitButton = false;
	return menu2;
}

public int Menu2_Callback(Menu menu2, MenuAction action, int client, int param2)
{
	if (action == MenuAction_Select)
	{
		char Item[32];
		menu2.GetItem(param2, Item, sizeof(Item));
		if (strcmp(Item, "onayla", false) == 0)
		{
			if (bac)
			{
				SetCvar("sv_enablebunnyhopping", 0);
				SetCvar("sv_autobunnyhopping", 0);
				SetCvar("abner_bhop", 0);
			}
			else
			{
				SetCvar("sv_enablebunnyhopping", 1);
				SetCvar("sv_autobunnyhopping", 1);
				SetCvar("abner_bhop", 1);
			}
			if (revive)
			{
				SetCvar("mp_respawn_on_death_t", 1);
			}
			else
			{
				SetCvar("mp_respawn_on_death_t", 0);
			}
			if (onlyhs)
			{
				SetCvar("mp_damage_headshot_only", 1);
			}
			else
			{
				SetCvar("mp_damage_headshot_only", 0);
			}
			if (!Ak47 && !M4a4 && !M4a1 && !Awp && !SSG && !Mag7 && !Sawedoff)
				sadecetabanca = true;
			else if (Ak47 || M4a4 || M4a1 || Awp || SSG || Mag7 || Sawedoff)
				sadecetabanca = false;
			FFAktif = true;
			Guns = true;
			revive = false;
			for (int i = 1; i <= MaxClients; i++)
			{
				if (IsClientInGame(i) && !IsFakeClient(i) && IsPlayerAlive(i) && GetClientTeam(i) == CS_TEAM_T)
				{
					GivePlayerItem(i, "weapon_hegrenade");
					if (!sadecetabanca)
						gunsmenu().Display(i, MENU_TIME_FOREVER);
					else
						tabancamenu().Display(i, MENU_TIME_FOREVER);
				}
			}
			g_gerisaytimer = CreateTimer(1.0, GeriSayTimer, _, TIMER_REPEAT);
		}
		else if (strcmp(Item, "kafaayarla", false) == 0)
		{
			if (onlyhs)
				onlyhs = false;
			else
				onlyhs = true;
			yasaklisilah().Display(client, MENU_TIME_FOREVER);
		}
		else if (strcmp(Item, "ayarlasilah", false) == 0)
		{
			silahayarlama().Display(client, MENU_TIME_FOREVER);
		}
		else if (strcmp(Item, "ayarlatabanca", false) == 0)
		{
			tabancaayarlama().Display(client, MENU_TIME_FOREVER);
		}
		else if (strcmp(Item, "bunnyayarla", false) == 0)
		{
			if (bac)
				bac = false;
			else
				bac = true;
			yasaklisilah().Display(client, MENU_TIME_FOREVER);
		}
		else if (strcmp(Item, "canlandirmaayarla", false) == 0)
		{
			if (revive)
				revive = false;
			else
				revive = true;
			yasaklisilah().Display(client, MENU_TIME_FOREVER);
		}
	}
	else if (action == MenuAction_End)
	{
		delete menu2;
	}
	else if (action == MenuAction_Cancel)
	{
		if (param2 == MenuCancel_ExitBack)
			menugoster().Display(client, MENU_TIME_FOREVER);
	}
}

Menu tabancaayarlama()
{
	Menu menub = new Menu(MenuB_Callback);
	menub.SetTitle("^-^ FF Menu - Yasaklı Tabancalar");
	if (!Deagle)
	{
		menub.AddItem("deaglem", "DEAGLE [KAPALI]");
	}
	else
	{
		menub.AddItem("deaglem", "DEAGLE [AÇIK]");
	}
	if (!Usp)
	{
		menub.AddItem("uspm", "USP-S [KAPALI]");
	}
	else
	{
		menub.AddItem("uspm", "USP-S [AÇIK]");
	}
	if (!Glock)
	{
		menub.AddItem("glockm", "GLOCK [KAPALI]");
	}
	else
	{
		menub.AddItem("glockm", "GLOCK [AÇIK]");
	}
	if (!P2000)
	{
		menub.AddItem("hkpm", "P2000 [KAPALI]");
	}
	else
	{
		menub.AddItem("hkpm", "P2000 [AÇIK]");
	}
	if (!Cz75)
		menub.AddItem("czm", "CZ75 [KAPALI]");
	else
		menub.AddItem("czm", "CZ75 [AÇIK]");
	if (!Tec9)
		menub.AddItem("tecm", "TEC9 [KAPALI]");
	else
		menub.AddItem("tecm", "TEC9 [AÇIK]");
	if (!P25O)
		menub.AddItem("p250m", "P250 [KAPALI]");
	else
		menub.AddItem("p250m", "P250 [AÇIK]");
	if (!Revolver)
		menub.AddItem("revolverm", "REVOLVER [KAPALI]");
	else
		menub.AddItem("revolverm", "REVOLVER [AÇIK]");
	if (!fiveseven)
		menub.AddItem("fivesevenm", "FIVESEVEN [KAPALI]");
	else
		menub.AddItem("fivesevenm", "FIVESEVEN [AÇIK]");
	if (!marazali)
		menub.AddItem("marazalim", "ÇİFT BERETTA [KAPALI]");
	else
		menub.AddItem("marazalim", "ÇİFT BERETTA [AÇIK]");
	menub.ExitBackButton = true;
	menub.ExitButton = false;
	return menub;
}

public int MenuB_Callback(Menu menub, MenuAction action, int client, int param2)
{
	if (action == MenuAction_Select)
	{
		char Item[32];
		menub.GetItem(param2, Item, sizeof(Item));
		if (strcmp(Item, "deaglem", false) == 0)
		{
			if (!Deagle)
			{
				Deagle = true;
			}
			else
			{
				Deagle = false;
			}
		}
		else if (strcmp(Item, "uspm", false) == 0)
		{
			if (!Usp)
			{
				Usp = true;
			}
			else
			{
				Usp = false;
			}
		}
		else if (strcmp(Item, "glockm", false) == 0)
		{
			if (!Glock)
			{
				Glock = true;
			}
			else
			{
				Glock = false;
			}
		}
		else if (strcmp(Item, "hkpm", false) == 0)
		{
			if (!P2000)
			{
				P2000 = true;
			}
			else
			{
				P2000 = false;
			}
		}
		else if (strcmp(Item, "czm", false) == 0)
		{
			if (!Cz75)
				Cz75 = true;
			else
				Cz75 = false;
		}
		else if (strcmp(Item, "tecm", false) == 0)
		{
			if (!Tec9)
				Tec9 = true;
			else
				Tec9 = false;
		}
		else if (strcmp(Item, "p250m", false) == 0)
		{
			if (!P25O)
				P25O = true;
			else
				P25O = false;
		}
		else if (strcmp(Item, "revolverm", false) == 0)
		{
			if (!Revolver)
				Revolver = true;
			else
				Revolver = false;
		}
		else if (strcmp(Item, "fivesevenm", false) == 0)
		{
			if (!fiveseven)
				fiveseven = true;
			else
				fiveseven = false;
		}
		else if (strcmp(Item, "marazalim", false) == 0)
		{
			if (!marazali)
				marazali = true;
			else
				marazali = false;
		}
		tabancaayarlama().Display(client, MENU_TIME_FOREVER);
	}
	else if (action == MenuAction_End)
	{
		delete menub;
	}
	else if (action == MenuAction_Cancel)
	{
		if (param2 == MenuCancel_ExitBack)
			yasaklisilah().Display(client, MENU_TIME_FOREVER);
	}
}

Menu silahayarlama()
{
	Menu menua = new Menu(MenuA_Callback);
	menua.SetTitle("^-^ FF Menu - Yasaklı Ana Silahlar");
	if (!Ak47)
	{
		menua.AddItem("ak47m", "AK47 [KAPALI]");
	}
	else
	{
		menua.AddItem("ak47m", "AK47 [AÇIK]");
	}
	if (!M4a4)
	{
		menua.AddItem("m4a4m", "M4A4 [KAPALI]");
	}
	else
	{
		menua.AddItem("m4a4m", "M4A4 [AÇIK]");
	}
	if (!M4a1)
	{
		menua.AddItem("m4a1m", "M4A1-S [KAPALI]");
	}
	else
	{
		menua.AddItem("m4a1m", "M4A1-S [AÇIK]");
	}
	if (!Aug)
		menua.AddItem("augm", "AUG [KAPALI]");
	else
		menua.AddItem("augm", "AUG [AÇIK]");
	if (!Awp)
	{
		menua.AddItem("awpm", "AWP [KAPALI]");
	}
	else
	{
		menua.AddItem("awpm", "AWP [AÇIK]");
	}
	if (!SSG)
		menua.AddItem("ssgm", "SSG08 [KAPALI]");
	else
		menua.AddItem("ssgm", "SSG08 [AÇIK]");
	if (!Mag7)
		menua.AddItem("mag7m", "MAG7 [KAPALI]");
	else
		menua.AddItem("mag7m", "MAG7 [AÇIK]");
	if (!Sawedoff)
		menua.AddItem("sawedoffm", "SAWED-OFF [KAPALI]");
	else
		menua.AddItem("sawedoffm", "SAWED-OFF [AÇIK]");
	menua.ExitBackButton = true;
	menua.ExitButton = false;
	return menua;
}

public int MenuA_Callback(Menu menua, MenuAction action, int client, int param2)
{
	if (action == MenuAction_Select)
	{
		char Item[32];
		menua.GetItem(param2, Item, sizeof(Item));
		if (strcmp(Item, "ak47m", false) == 0)
		{
			if (!Ak47)
			{
				Ak47 = true;
			}
			else
			{
				Ak47 = false;
			}
		}
		else if (strcmp(Item, "m4a4m", false) == 0)
		{
			if (!M4a4)
			{
				M4a4 = true;
			}
			else
			{
				M4a4 = false;
			}
		}
		else if (strcmp(Item, "m4a1m", false) == 0)
		{
			if (!M4a1)
			{
				M4a1 = true;
			}
			else
			{
				M4a1 = false;
			}
		}
		else if (strcmp(Item, "augm", false) == 0)
		{
			if (!Aug)
			{
				Aug = true;
			}
			else
			{
				Aug = false;
			}
		}
		else if (strcmp(Item, "awpm", false) == 0)
		{
			if (!Awp)
			{
				Awp = true;
			}
			else
			{
				Awp = false;
			}
		}
		else if (strcmp(Item, "ssgm", false) == 0)
		{
			if (!SSG)
				SSG = true;
			else
				SSG = false;
		}
		else if (strcmp(Item, "mag7m", false) == 0)
		{
			if (!Mag7)
				Mag7 = true;
			else
				Mag7 = false;
		}
		else if (strcmp(Item, "sawedoffm", false) == 0)
		{
			if (!Sawedoff)
				Sawedoff = true;
			else
				Sawedoff = false;
		}
		silahayarlama().Display(client, MENU_TIME_FOREVER);
	}
	else if (action == MenuAction_End)
	{
		delete menua;
	}
	else if (action == MenuAction_Cancel)
	{
		if (param2 == MenuCancel_ExitBack)
			yasaklisilah().Display(client, MENU_TIME_FOREVER);
	}
}

Menu gunsmenu()
{
	Menu menu3 = new Menu(Menu3_Callback);
	menu3.SetTitle("^-^ FF Menu - Silah Menü\n ");
	if (Ak47)
	{
		menu3.AddItem("akver", "AK47");
	}
	if (M4a4)
	{
		menu3.AddItem("a4ver", "M4A4");
	}
	if (M4a1)
	{
		menu3.AddItem("a1ver", "M4A1-S");
	}
	if (Aug)
		menu3.AddItem("augver", "AUG");
	if (Awp)
	{
		menu3.AddItem("awpver", "AWP");
	}
	if (SSG)
		menu3.AddItem("ssgver", "SSG08");
	if (Mag7)
		menu3.AddItem("mag7ver", "MAG7");
	if (Sawedoff)
		menu3.AddItem("sawedoffver", "SAWED-OFF");
	return menu3;
}

public int Menu3_Callback(Menu menu3, MenuAction action, int client, int param2)
{
	if (action == MenuAction_Select)
	{
		if (Guns)
		{
			char Item[32];
			menu3.GetItem(param2, Item, sizeof(Item));
			if (strcmp(Item, "akver", false) == 0)
			{
				GivePlayerItem(client, "weapon_ak47");
			}
			else if (strcmp(Item, "a4ver", false) == 0)
			{
				GivePlayerItem(client, "weapon_m4a1");
			}
			else if (strcmp(Item, "a1ver", false) == 0)
			{
				GivePlayerItem(client, "weapon_m4a1_silencer");
			}
			else if (strcmp(Item, "augver", false) == 0)
			{
				GivePlayerItem(client, "weapon_aug");
			}
			else if (strcmp(Item, "awpver", false) == 0)
			{
				GivePlayerItem(client, "weapon_awp");
			}
			else if (strcmp(Item, "ssgver", false) == 0)
			{
				GivePlayerItem(client, "weapon_ssg08");
			}
			else if (strcmp(Item, "mag7ver", false) == 0)
			{
				GivePlayerItem(client, "weapon_mag7");
			}
			else if (strcmp(Item, "sawedoffver", false) == 0)
			{
				GivePlayerItem(client, "weapon_sawedoff");
			}
			tabancamenu().Display(client, MENU_TIME_FOREVER);
		}
		else
		{
			PrintToChat(client, "[SM] Bu menüyü kullanmak için geciktin!");
		}
	}
	else if (action == MenuAction_End)
	{
		delete menu3;
	}
}

Menu tabancamenu()
{
	Menu menu4 = new Menu(Menu4_Callback);
	menu4.SetTitle("^-^ FF Menu - Tabanca Menü\n ");
	if (Deagle)
	{
		menu4.AddItem("dver", "DEAGLE");
	}
	if (Usp)
	{
		menu4.AddItem("uver", "USP-S");
	}
	if (Glock)
	{
		menu4.AddItem("gver", "GLOCK");
	}
	if (P2000)
	{
		menu4.AddItem("pver", "P2000");
	}
	if (Cz75)
		menu4.AddItem("czver", "CZ75");
	if (Tec9)
		menu4.AddItem("tecver", "TEC9");
	if (P25O)
		menu4.AddItem("p250ver", "P250");
	if (Revolver)
		menu4.AddItem("revolverver", "REVOLVER");
	if (fiveseven)
		menu4.AddItem("fivesevenver", "FIVESEVEN");
	if (marazali)
		menu4.AddItem("marazaliver", "ÇİFT BERETTA");
	return menu4;
}

public int Menu4_Callback(Menu menu4, MenuAction action, int client, int param2)
{
	if (action == MenuAction_Select)
	{
		if (Guns)
		{
			char Item[32];
			menu4.GetItem(param2, Item, sizeof(Item));
			if (strcmp(Item, "dver", false) == 0)
			{
				GivePlayerItem(client, "weapon_deagle");
			}
			else if (strcmp(Item, "uver", false) == 0)
			{
				GivePlayerItem(client, "weapon_usp_silencer");
			}
			else if (strcmp(Item, "gver", false) == 0)
			{
				GivePlayerItem(client, "weapon_glock");
			}
			else if (strcmp(Item, "pver", false) == 0)
			{
				GivePlayerItem(client, "weapon_hkp2000");
			}
			else if (strcmp(Item, "czver", false) == 0)
			{
				GivePlayerItem(client, "weapon_cz75a");
			}
			else if (strcmp(Item, "tecver", false) == 0)
			{
				GivePlayerItem(client, "weapon_tec9");
			}
			else if (strcmp(Item, "p250ver", false) == 0)
			{
				GivePlayerItem(client, "weapon_p250");
			}
			else if (strcmp(Item, "revolverver", false) == 0)
			{
				GivePlayerItem(client, "weapon_revolver");
			}
			else if (strcmp(Item, "fivesevenver", false) == 0)
			{
				GivePlayerItem(client, "weapon_fiveseven");
			}
			else if (strcmp(Item, "marazaliver", false) == 0)
			{
				GivePlayerItem(client, "weapon_elite");
			}
		}
		else
		{
			PrintToChat(client, "[SM] Bu menüyü kullanmak için geciktin!");
		}
	}
	else if (action == MenuAction_End)
	{
		delete menu4;
	}
} 