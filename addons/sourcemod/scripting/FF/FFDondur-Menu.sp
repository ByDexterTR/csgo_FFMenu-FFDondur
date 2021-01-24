Menu ffdondurmenu()
{
	Menu menudon = new Menu(MenuDon_Callback);
	menudon.SetTitle("^-^ FFDondur - Ne Zaman Freeze Atılsın?");
	menudon.AddItem("kendim", "Kendim belirleyeceğim");
	menudon.AddItem("60san", "60 Saniye Sonra");
	menudon.AddItem("50san", "50 Saniye Sonra");
	menudon.AddItem("40san", "40 Saniye Sonra");
	menudon.AddItem("30san", "30 Saniye Sonra");
	menudon.AddItem("20san", "20 Saniye Sonra");
	menudon.AddItem("10san", "10 Saniye Sonra");
	menudon.AddItem("5san", "5 Saniye Sonra");
	return menudon;
}

public int MenuDon_Callback(Menu menudon, MenuAction action, int client, int param2)
{
	if (action == MenuAction_Select)
	{
		char Item[32];
		menudon.GetItem(param2, Item, sizeof(Item));
		if (strcmp(Item, "kendim", false) == 0)
		{
			ReplyToCommand(client, "[SM] \x01Kullanım: sm_ffdondur (Saniye)");
		}
		else
		{
			if (strcmp(Item, "60san", false) == 0)
			{
				DondurmaSure = 60;
			}
			else if (strcmp(Item, "50san", false) == 0)
			{
				DondurmaSure = 50;
			}
			else if (strcmp(Item, "40san", false) == 0)
			{
				DondurmaSure = 40;
			}
			else if (strcmp(Item, "30san", false) == 0)
			{
				DondurmaSure = 30;
			}
			else if (strcmp(Item, "20san", false) == 0)
			{
				DondurmaSure = 20;
			}
			else if (strcmp(Item, "10san", false) == 0)
			{
				DondurmaSure = 10;
			}
			else if (strcmp(Item, "5san", false) == 0)
			{
				DondurmaSure = 5;
			}
			if (g_gerisaytimerr != null)
				delete g_gerisaytimerr;
			PrintToChatAll("[SM] \x0C%N \x01tarafından \x04FF Dondurma %d saniye \x01belirlenmiştir!", client, DondurmaSure);
			ffkapatmamenu().Display(client, MENU_TIME_FOREVER);
		}
	}
	else if (action == MenuAction_End)
	{
		delete menudon;
	}
}

Menu ffkapatmamenu()
{
	Menu menudon2 = new Menu(MenuDon2_Callback);
	menudon2.SetTitle("^-^ FFDondur - Ne Zaman FF Kapatılsın?");
	menudon2.AddItem("esit", "Freeze zamanla aynı süre");
	if (DondurmaSure >= 60)
		menudon2.AddItem("60sne", "60 Saniye Sonra");
	if (DondurmaSure >= 50)
		menudon2.AddItem("50sne", "50 Saniye Sonra");
	if (DondurmaSure >= 40)
		menudon2.AddItem("40sne", "40 Saniye Sonra");
	if (DondurmaSure >= 30)
		menudon2.AddItem("30sne", "30 Saniye Sonra");
	if (DondurmaSure >= 20)
		menudon2.AddItem("20sne", "20 Saniye Sonra");
	if (DondurmaSure >= 10)
		menudon2.AddItem("10sne", "10 Saniye Sonra");
	if (DondurmaSure >= 5)
		menudon2.AddItem("5sne", "5 Saniye Sonra");
	return menudon2;
}

public int MenuDon2_Callback(Menu menudon2, MenuAction action, int client, int param2)
{
	if (action == MenuAction_Select)
	{
		char Item[32];
		menudon2.GetItem(param2, Item, sizeof(Item));
		if (strcmp(Item, "esit", false) == 0)
		{
			KapatmaSure = DondurmaSure;
		}
		else if (strcmp(Item, "60sne", false) == 0)
		{
			KapatmaSure = 60;
		}
		else if (strcmp(Item, "50sne", false) == 0)
		{
			KapatmaSure = 50;
		}
		else if (strcmp(Item, "40sne", false) == 0)
		{
			KapatmaSure = 40;
		}
		else if (strcmp(Item, "30sne", false) == 0)
		{
			KapatmaSure = 30;
		}
		else if (strcmp(Item, "20sne", false) == 0)
		{
			KapatmaSure = 20;
		}
		else if (strcmp(Item, "10sne", false) == 0)
		{
			KapatmaSure = 10;
		}
		else if (strcmp(Item, "5sne", false) == 0)
		{
			KapatmaSure = 5;
		}
		if (g_gerisaytimerr != null)
			delete g_gerisaytimerr;
		PrintToChatAll("[SM] \x0C%N \x01tarafından \x04FF Kapatma %d saniye \x01belirlenmiştir!", client, KapatmaSure);
		g_Gidilecekyerbelirten[client] = true;
		Handle ScreenText = CreateHudSynchronizer();
		SetHudTextParams(-1.0, -0.35, 3.0, 0, 255, 0, 0, 2, 1.0, 0.01, 0.01);
		ShowSyncHudText(client, ScreenText, "Nereye Gidilsin?");
		delete ScreenText;
	}
	else if (action == MenuAction_End)
	{
		delete menudon2;
	}
} 