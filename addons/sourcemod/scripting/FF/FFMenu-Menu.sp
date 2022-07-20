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
	menu.AddItem("31", "Kendim belirleyeceğim");
	menu.AddItem("60", "60 Saniye Sonra");
	menu.AddItem("50", "50 Saniye Sonra");
	menu.AddItem("45", "45 Saniye Sonra");
	menu.AddItem("40", "40 Saniye Sonra");
	menu.AddItem("30", "30 Saniye Sonra");
	menu.AddItem("20", "20 Saniye Sonra");
	menu.AddItem("15", "15 Saniye Sonra");
	menu.AddItem("10", "10 Saniye Sonra");
	menu.AddItem("5", "5 Saniye Sonra");
	return menu;
}

public int Menu_Callback(Menu menu, MenuAction action, int client, int param2)
{
	if (action == MenuAction_Select)
	{
		char Item[12];
		menu.GetItem(param2, Item, 12);
		if (strcmp(Item, "ffbaslat", false) == 0)
		{
			if (g_gerisaytimer != null)
				delete g_gerisaytimer;
			
			FFAktif = true;
			Guns = false;
			SetCvar("mp_teammates_are_enemies", 1);
			SetCvar("mp_friendlyfire", 1);
			SetCvar("mp_respawn_on_death_t", 0);
			PrintToChatAll("[SM] \x0C%N \x01tarafından Dost ateşi \x04açılmıştır!", client);
		}
		else if (strcmp(Item, "ffkapat", false) == 0)
		{
			if (g_gerisaytimer != null)
				delete g_gerisaytimer;
			
			Guns = false;
			FFAktif = false;
			SetCvar("mp_teammates_are_enemies", 0);
			SetCvar("mp_friendlyfire", 0);
			SetCvar("mp_respawn_on_death_t", 0);
			PrintToChatAll("[SM] \x0C%N \x01tarafından Dost ateşi \x04iptal edilmiştir!", client);
		}
		else if (StringToInt(Item) == 31)
		{
			ReplyToCommand(client, "[SM] \x01Kullanım: sm_ffmenu (Saniye)");
		}
		else
		{
			GeriSay = StringToInt(Item);
			if (g_gerisaytimer != null)
				delete g_gerisaytimer;
			
			SetCvar("mp_teammates_are_enemies", 0);
			SetCvar("mp_friendlyfire", 0);
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
	menu2.AddItem("0", "Ayarları Onayla");
	menu2.AddItem("1", "Yasaklı Ana Silahar");
	menu2.AddItem("2", "Yasaklı Tabanacalar");
	if (bac)
		menu2.AddItem("3", "Bunny: [KAPALI]");
	else
		menu2.AddItem("3", "Bunny: [AÇIK]");
	if (revive)
		menu2.AddItem("4", "Oto Respawn: [AÇIK]");
	else
		menu2.AddItem("4", "Oto Respawn: [KAPALI]");
	if (onlyhs)
		menu2.AddItem("5", "Sadece HS: [AÇIK]");
	else
		menu2.AddItem("5", "Sadece HS: [KAPALI]");
	return menu2;
}

public int Menu2_Callback(Menu menu2, MenuAction action, int client, int param2)
{
	if (action == MenuAction_Select)
	{
		char Item[4];
		menu2.GetItem(param2, Item, 4);
		if (StringToInt(Item) == 0)
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
			else
				sadecetabanca = false;
			
			FFAktif = true;
			Guns = true;
			revive = false;
			for (int i = 1; i <= MaxClients; i++)if (IsValidClient(i) && IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				GivePlayerItem(i, "weapon_hegrenade");
				if (!sadecetabanca)
					gunsmenu().Display(i, MENU_TIME_FOREVER);
				else
					tabancamenu().Display(i, MENU_TIME_FOREVER);
			}
			g_gerisaytimer = CreateTimer(1.0, GeriSayTimer, _, TIMER_REPEAT);
		}
		else if (StringToInt(Item) == 5)
		{
			onlyhs = !onlyhs;
			yasaklisilah().Display(client, MENU_TIME_FOREVER);
		}
		else if (StringToInt(Item) == 1)
		{
			silahayarlama().Display(client, MENU_TIME_FOREVER);
		}
		else if (StringToInt(Item) == 2)
		{
			tabancaayarlama().Display(client, MENU_TIME_FOREVER);
		}
		else if (StringToInt(Item) == 3)
		{
			bac = !bac;
			yasaklisilah().Display(client, MENU_TIME_FOREVER);
		}
		else if (StringToInt(Item) == 4)
		{
			revive = !revive;
			yasaklisilah().Display(client, MENU_TIME_FOREVER);
		}
	}
	else if (action == MenuAction_End)
	{
		delete menu2;
	}
	else if (action == MenuAction_Cancel)
	{
		if (param2 == MenuCancel_Exit)
			menugoster().Display(client, MENU_TIME_FOREVER);
	}
}

Menu tabancaayarlama()
{
	Menu menub = new Menu(MenuB_Callback);
	menub.SetTitle("^-^ FF Menu - Yasaklı Tabancalar");
	if (!Deagle)
		menub.AddItem("0", "DEAGLE [KAPALI]");
	else
		menub.AddItem("0", "DEAGLE [AÇIK]");
	
	if (!Usp)
		menub.AddItem("1", "USP-S [KAPALI]");
	else
		menub.AddItem("1", "USP-S [AÇIK]");
	
	if (!Glock)
		menub.AddItem("2", "GLOCK [KAPALI]");
	else
		menub.AddItem("2", "GLOCK [AÇIK]");
	
	if (!P2000)
		menub.AddItem("3", "P2000 [KAPALI]");
	else
		menub.AddItem("3", "P2000 [AÇIK]");
	
	if (!Cz75)
		menub.AddItem("4", "CZ75 [KAPALI]");
	else
		menub.AddItem("4", "CZ75 [AÇIK]");
	
	if (!Tec9)
		menub.AddItem("5", "TEC9 [KAPALI]");
	else
		menub.AddItem("5", "TEC9 [AÇIK]");
	
	if (!P25O)
		menub.AddItem("6", "P250 [KAPALI]");
	else
		menub.AddItem("6", "P250 [AÇIK]");
	
	if (!Revolver)
		menub.AddItem("7", "REVOLVER [KAPALI]");
	else
		menub.AddItem("7", "REVOLVER [AÇIK]");
	
	if (!fiveseven)
		
	menub.AddItem("8", "FIVESEVEN [KAPALI]");
	else
		menub.AddItem("8", "FIVESEVEN [AÇIK]");
	
	if (!marazali)
		menub.AddItem("9", "ÇİFT BERETTA [KAPALI]");
	else
		menub.AddItem("9", "ÇİFT BERETTA [AÇIK]");
	return menub;
}

public int MenuB_Callback(Menu menub, MenuAction action, int client, int param2)
{
	if (action == MenuAction_Select)
	{
		char Item[4];
		menub.GetItem(param2, Item, 4);
		int item = StringToInt(Item);
		if (item == 0)
		{
			Deagle = !Deagle;
		}
		else if (item == 1)
		{
			Usp = !Usp;
		}
		else if (item == 2)
		{
			Glock = !Glock;
		}
		else if (item == 3)
		{
			P2000 = !P2000;
		}
		else if (item == 4)
		{
			Cz75 = !Cz75;
		}
		else if (item == 5)
		{
			Tec9 = !Tec9;
		}
		else if (item == 6)
		{
			P25O = !P25O;
		}
		else if (item == 7)
		{
			Revolver = !Revolver;
		}
		else if (item == 8)
		{
			fiveseven = !fiveseven;
		}
		else if (item == 9)
		{
			marazali = !marazali;
		}
		tabancaayarlama().Display(client, MENU_TIME_FOREVER);
	}
	else if (action == MenuAction_End)
	{
		delete menub;
	}
	else if (action == MenuAction_Cancel)
	{
		if (param2 == MenuCancel_Exit)
			yasaklisilah().Display(client, MENU_TIME_FOREVER);
	}
}

Menu silahayarlama()
{
	Menu menua = new Menu(MenuA_Callback);
	menua.SetTitle("^-^ FF Menu - Yasaklı Ana Silahlar");
	if (!Ak47)
		menua.AddItem("0", "AK47 [KAPALI]");
	else
		menua.AddItem("0", "AK47 [AÇIK]");
	
	if (!M4a4)
		menua.AddItem("1", "M4A4 [KAPALI]");
	else
		menua.AddItem("1", "M4A4 [AÇIK]");
	
	if (!M4a1)
		menua.AddItem("2", "M4A1-S [KAPALI]");
	else
		menua.AddItem("2", "M4A1-S [AÇIK]");
	
	if (!Aug)
		menua.AddItem("3", "AUG [KAPALI]");
	else
		menua.AddItem("3", "AUG [AÇIK]");
	
	if (!Awp)
		menua.AddItem("4", "AWP [KAPALI]");
	else
		menua.AddItem("4", "AWP [AÇIK]");
	
	if (!SSG)
		menua.AddItem("5", "SSG08 [KAPALI]");
	else
		menua.AddItem("5", "SSG08 [AÇIK]");
	
	if (!Mag7)
		menua.AddItem("6", "MAG7 [KAPALI]");
	else
		menua.AddItem("6", "MAG7 [AÇIK]");
	
	if (!Sawedoff)
		menua.AddItem("7", "SAWED-OFF [KAPALI]");
	else
		menua.AddItem("7", "SAWED-OFF [AÇIK]");
	return menua;
}

public int MenuA_Callback(Menu menua, MenuAction action, int client, int param2)
{
	if (action == MenuAction_Select)
	{
		char Item[4];
		menua.GetItem(param2, Item, 4);
		int item = StringToInt(Item);
		if (item == 0)
		{
			Ak47 = !Ak47;
		}
		else if (item == 1)
		{
			M4a4 = !M4a4;
		}
		else if (item == 2)
		{
			M4a1 = !M4a1;
		}
		else if (item == 3)
		{
			Aug = !Aug;
		}
		else if (item == 4)
		{
			Awp = !Awp;
		}
		else if (item == 5)
		{
			SSG = !SSG;
		}
		else if (item == 6)
		{
			Mag7 = !Mag7;
		}
		else if (item == 7)
		{
			Sawedoff = !Sawedoff;
		}
		silahayarlama().Display(client, MENU_TIME_FOREVER);
	}
	else if (action == MenuAction_End)
	{
		delete menua;
	}
	else if (action == MenuAction_Cancel)
	{
		if (param2 == MenuCancel_Exit)
			yasaklisilah().Display(client, MENU_TIME_FOREVER);
	}
}

Menu gunsmenu()
{
	Menu menu3 = new Menu(Menu3_Callback);
	menu3.SetTitle("^-^ FF Menu - Silah Menü\n ");
	if (Ak47)
		menu3.AddItem("weapon_ak47", "AK47");
	
	if (M4a4)
		menu3.AddItem("weapon_m4a1", "M4A4");
	
	if (M4a1)
		menu3.AddItem("weapon_m4a1_silencer", "M4A1-S");
	
	if (Aug)
		menu3.AddItem("weapon_aug", "AUG");
	
	if (Awp)
		menu3.AddItem("weapon_awp", "AWP");
	
	if (SSG)
		menu3.AddItem("weapon_ssg08", "SSG08");
	
	if (Mag7)
		menu3.AddItem("weapon_mag7", "MAG7");
	
	if (Sawedoff)
		menu3.AddItem("weapon_sawedoff", "SAWED-OFF");
	
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
			GivePlayerItem(client, Item);
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
		menu4.AddItem("weapon_deagle", "DEAGLE");
	}
	if (Usp)
	{
		menu4.AddItem("weapon_usp_silencer", "USP-S");
	}
	if (Glock)
	{
		menu4.AddItem("weapon_glock", "GLOCK");
	}
	if (P2000)
	{
		menu4.AddItem("weapon_hkp2000", "P2000");
	}
	if (Cz75)
		menu4.AddItem("weapon_cz75a", "CZ75");
	if (Tec9)
		menu4.AddItem("weapon_tec9", "TEC9");
	if (P25O)
		menu4.AddItem("weapon_p250", "P250");
	if (Revolver)
		menu4.AddItem("weapon_revolver", "REVOLVER");
	if (fiveseven)
		menu4.AddItem("weapon_fiveseven", "FIVESEVEN");
	if (marazali)
		menu4.AddItem("weapon_elite", "ÇİFT BERETTA");
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
			GivePlayerItem(client, Item);
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