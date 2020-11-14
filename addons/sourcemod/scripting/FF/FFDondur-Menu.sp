void ffdondurmenu(int client)
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
	menudon.Display(client, MENU_TIME_FOREVER);
}

public int MenuDon_Callback(Menu menudon, MenuAction action, int param1, int param2)
{
	if (action == MenuAction_Select)
	{
		char Item[32];
		menudon.GetItem(param2, Item, sizeof(Item));
		if (StrEqual(Item, "kendim", true))
		{
			ReplyToCommand(param1, "[SM] \x01Kullanım: sm_ffdondur (Saniye)");
		}
		else
		{
			if (StrEqual(Item, "60san", true))
			{
				DondurmaSure = 60;
			}
			else if (StrEqual(Item, "50san", true))
			{
				DondurmaSure = 50;
			}
			else if (StrEqual(Item, "40san", true))
			{
				DondurmaSure = 40;
			}
			else if (StrEqual(Item, "30san", true))
			{
				DondurmaSure = 30;
			}
			else if (StrEqual(Item, "20san", true))
			{
				DondurmaSure = 20;
			}
			else if (StrEqual(Item, "10san", true))
			{
				DondurmaSure = 10;
			}
			else if (StrEqual(Item, "5san", true))
			{
				DondurmaSure = 5;
			}
			if (g_gerisaytimerr != null)
				delete g_gerisaytimerr;
			PrintToChatAll("[SM] \x0C%N \x01tarafından \x04FF Dondurma %d saniye \x01belirlenmiştir!", param1, DondurmaSure);
			ffkapatmamenu(param1);
		}
	}
	else if (action == MenuAction_End)
	{
		delete menudon;
	}
}

void ffkapatmamenu(int client)
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
	menudon2.Display(client, MENU_TIME_FOREVER);
}

public int MenuDon2_Callback(Menu menudon2, MenuAction action, int param1, int param2)
{
	if (action == MenuAction_Select)
	{
		char Item[32];
		menudon2.GetItem(param2, Item, sizeof(Item));
		if (StrEqual(Item, "esit", true))
		{
			KapatmaSure = DondurmaSure;
		}
		else if (StrEqual(Item, "60sne", true))
		{
			KapatmaSure = 60;
		}
		else if (StrEqual(Item, "50sne", true))
		{
			KapatmaSure = 50;
		}
		else if (StrEqual(Item, "40sne", true))
		{
			KapatmaSure = 45;
		}
		else if (StrEqual(Item, "30sne", true))
		{
			KapatmaSure = 30;
		}
		else if (StrEqual(Item, "20sne", true))
		{
			KapatmaSure = 20;
		}
		else if (StrEqual(Item, "10sne", true))
		{
			KapatmaSure = 10;
		}
		else if (StrEqual(Item, "5sne", true))
		{
			KapatmaSure = 5;
		}
		if (g_gerisaytimerr != null)
			delete g_gerisaytimerr;
		PrintToChatAll("[SM] \x0C%N \x01tarafından \x04FF Kapatma %d saniye \x01belirlenmiştir!", param1, KapatmaSure);
		g_Gidilecekyerbelirten[param1] = true;
		Handle ScreenText = CreateHudSynchronizer();
		SetHudTextParams(-1.0, -0.35, 3.0, 0, 255, 0, 0, 2, 1.0, 0.01, 0.01);
		ShowSyncHudText(param1, ScreenText, "Nereye Gidilsin?");
		delete ScreenText;
	}
	else if (action == MenuAction_End)
	{
		delete menudon2;
	}
}