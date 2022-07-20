Menu ffdondurmenu()
{
	Menu menudon = new Menu(MenuDon_Callback);
	menudon.SetTitle("^-^ FFDondur - Ne Zaman Freeze Atılsın?");
	menudon.AddItem("31", "Kendim belirleyeceğim");
	menudon.AddItem("60", "60 Saniye Sonra");
	menudon.AddItem("50", "50 Saniye Sonra");
	menudon.AddItem("40", "40 Saniye Sonra");
	menudon.AddItem("30", "30 Saniye Sonra");
	menudon.AddItem("20", "20 Saniye Sonra");
	menudon.AddItem("10", "10 Saniye Sonra");
	menudon.AddItem("5", "5 Saniye Sonra");
	return menudon;
}

public int MenuDon_Callback(Menu menudon, MenuAction action, int client, int param2)
{
	if (action == MenuAction_Select)
	{
		char Item[4];
		menudon.GetItem(param2, Item, 4);
		int item = StringToInt(Item);
		if (item != 31)
		{
			DondurmaSure = item;
			if (g_gerisaytimerr != null)
				delete g_gerisaytimerr;
			PrintToChatAll("[SM] \x0C%N \x01tarafından \x04FF Dondurma %d saniye \x01belirlenmiştir!", client, DondurmaSure);
			ffkapatmamenu().Display(client, MENU_TIME_FOREVER);
		}
		else
		{
			ReplyToCommand(client, "[SM] \x01Kullanım: sm_ffdondur (Saniye)");
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
	menudon2.AddItem("31", "Freeze zamanla aynı süre");
	if (DondurmaSure >= 60)
		menudon2.AddItem("60", "60 Saniye Sonra");
	if (DondurmaSure >= 50)
		menudon2.AddItem("50", "50 Saniye Sonra");
	if (DondurmaSure >= 40)
		menudon2.AddItem("40", "40 Saniye Sonra");
	if (DondurmaSure >= 30)
		menudon2.AddItem("30", "30 Saniye Sonra");
	if (DondurmaSure >= 20)
		menudon2.AddItem("20", "20 Saniye Sonra");
	if (DondurmaSure >= 10)
		menudon2.AddItem("10", "10 Saniye Sonra");
	if (DondurmaSure >= 5)
		menudon2.AddItem("5", "5 Saniye Sonra");
	return menudon2;
}

public int MenuDon2_Callback(Menu menudon2, MenuAction action, int client, int param2)
{
	if (action == MenuAction_Select)
	{
		char Item[4];
		menudon2.GetItem(param2, Item, 4);
		int item = StringToInt(Item);
		if (item != 31)
		{
			KapatmaSure = item;
		}
		else
		{
			KapatmaSure = DondurmaSure;
		}
		if (g_gerisaytimerr != null)
			delete g_gerisaytimerr;
		PrintToChatAll("[SM] \x0C%N \x01tarafından \x04FF Kapatma %d saniye \x01belirlenmiştir!", client, KapatmaSure);
		g_Gidilecekyerbelirten[client] = true;
		SetHudTextParams(-1.0, -0.35, 3.0, 0, 255, 0, 0, 2, 1.0, 0.01, 0.01);
		ShowSyncHudText(client, ScreenText, "! > Gidilecek yeri sohbete yaz < !");
	}
	else if (action == MenuAction_End)
	{
		delete menudon2;
	}
	else if (action == MenuAction_Cancel)
	{
		if (param2 == MenuCancel_Exit)
			ffdondurmenu().Display(client, MENU_TIME_FOREVER);
	}
} 