#include <sourcemod>
#include <sdktools>
#include <warden>
#undef REQUIRE_PLUGIN
#include <hgr>

#pragma semicolon 1
#pragma newdecls required

#include "FF/Global.sp"
#include "FF/Stocks.sp"
#include "FF/FFMenu-Menu.sp"
#include "FF/FFDondur-Menu.sp"
#include "FF/Event.sp"
#include "FF/Timer-Callback.sp"

public Plugin myinfo = 
{
	name = "FFMenu - FFDondur", 
	author = "ByDexter", 
	description = "", 
	version = "1.9", 
	url = "https://steamcommunity.com/id/ByDexterTR - ByDexter#5494"
};

public void OnPluginStart()
{
	RegConsoleCmd("sm_ffdondur", FFDondur);
	
	RegConsoleCmd("sm_ffdondur0", FFDonduriptal);
	RegConsoleCmd("sm_ffdonduriptal", FFDonduriptal);
	
	RegConsoleCmd("sm_ffmenu", FFMenu);
	
	RegConsoleCmd("sm_ffmenuiptal", FFMenuiptal);
	RegConsoleCmd("sm_ffmenu0", FFMenuiptal);
	
	RegConsoleCmd("sm_ffac", FFAcKomut);
	RegConsoleCmd("sm_ffkapat", FFKapatKomut);
	RegConsoleCmd("sm_ffiptal", FFKapatKomut);
	
	RegConsoleCmd("sm_guns", SilahMenu);
	
	HookEvent("round_start", RoundStartEnd, EventHookMode_PostNoCopy);
	HookEvent("round_end", RoundStartEnd, EventHookMode_PostNoCopy);
	HookEvent("player_death", OnClientDead, EventHookMode_PostNoCopy);
	
	g_Yetkiliflag = CreateConVar("sm_ffmenu_flag", "q", "FFMenu komutçu harici verebilecek kişilerin yetkisi");
	g_Yetkiliflagg = CreateConVar("sm_ffdondur_yetki", "q", "FFDondur komutçu harici verebilecek kişilerin yetkisi");
	AutoExecConfig(true, "FFGenel", "ByDexter");
	ScreenText = CreateHudSynchronizer();
	bHgr = LibraryExists("hookgrabrope");
}

public void OnLibraryRemoved(const char[] name)
{
	if (strcmp(name, "hookgrabrope") == 0)
		bHgr = false;
}

public void OnLibraryAdded(const char[] name)
{
	if (strcmp(name, "hookgrabrope") == 0)
		bHgr = true;
}

public void OnMapStart()
{
	char map[32];
	GetCurrentMap(map, sizeof(map));
	char Filename[256];
	GetPluginFilename(INVALID_HANDLE, Filename, 256);
	if (strncmp(map, "workshop/", 9, false) == 0)
	{
		if (StrContains(map, "/jb_", false) == -1 && StrContains(map, "/jail_", false) == -1 && StrContains(map, "/ba_jail", false) == -1)
			ServerCommand("sm plugins unload %s", Filename);
	}
	else if (strncmp(map, "jb_", 3, false) != 0 && strncmp(map, "jail_", 5, false) != 0 && strncmp(map, "ba_jail", 3, false) != 0)
		ServerCommand("sm plugins unload %s", Filename);
	
	if (g_gerisaytimer != null)delete g_gerisaytimer;
	if (g_gerisaytimerr != null)delete g_gerisaytimerr;
	if (Guns)Guns = false; if (FFAktif)FFAktif = false;
	SetCvar("mp_teammates_are_enemies", 0);
	SetCvar("mp_friendlyfire", 0);
}

// FFDondur //

public Action FFDonduriptal(int client, int args)
{
	char YetkiliflagStringg[8];
	g_Yetkiliflagg.GetString(YetkiliflagStringg, sizeof(YetkiliflagStringg));
	if (!warden_iswarden(client) && !HasFlags(client, YetkiliflagStringg))
	{
		ReplyToCommand(client, "[SM] \x01Bu komuta erişiminiz yok!");
		return Plugin_Handled;
	}
	if (g_gerisaytimerr != null)
		delete g_gerisaytimerr;
	
	PrintToChatAll("[SM] \x0C%N \x01tarafından \x04FF Dondur \x01iptal edildi!", client);
	return Plugin_Handled;
}

public Action FFDondur(int client, int args)
{
	char YetkiliflagStringg[8];
	g_Yetkiliflagg.GetString(YetkiliflagStringg, sizeof(YetkiliflagStringg));
	if (!warden_iswarden(client) && !HasFlags(client, YetkiliflagStringg))
	{
		ReplyToCommand(client, "[SM] \x01Bu komuta erişiminiz yok!");
		return Plugin_Handled;
	}
	if (args == 1)
	{
		char arg1[20];
		GetCmdArg(1, arg1, 20);
		if (g_gerisaytimerr != null)
			delete g_gerisaytimerr;
		
		DondurmaSure = StringToInt(arg1);
		PrintToChatAll("[SM] \x0C%N \x01tarafından \x04FF Dondurma %d saniye \x01belirlenmiştir!", client, DondurmaSure);
		ffkapatmamenu().Display(client, MENU_TIME_FOREVER);
		return Plugin_Handled;
	}
	else if (args == 0)
	{
		ffdondurmenu().Display(client, MENU_TIME_FOREVER);
		return Plugin_Handled;
	}
	else
	{
		ReplyToCommand(client, "[SM] \x01Kullanım: sm_ffdondur (Saniye)");
		return Plugin_Handled;
	}
}

// FFMenu //

public Action FFMenu(int client, int args)
{
	char YetkiliflagString[8];
	g_Yetkiliflag.GetString(YetkiliflagString, sizeof(YetkiliflagString));
	if (!warden_iswarden(client) && !HasFlags(client, YetkiliflagString))
	{
		ReplyToCommand(client, "[SM] \x01Bu komuta erişiminiz yok!");
		return Plugin_Handled;
	}
	if (args == 1)
	{
		char arg1[20];
		GetCmdArg(1, arg1, 20);
		if (g_gerisaytimer != null)
			delete g_gerisaytimer;
		
		GeriSay = StringToInt(arg1);
		PrintToChatAll("[SM] \x0C%N \x01tarafından \x04FF Süresi %d saniye \x01belirlenmiştir!", client, GeriSay);
		yasaklisilah().Display(client, MENU_TIME_FOREVER);
		return Plugin_Handled;
	}
	else if (args == 0)
	{
		menugoster().Display(client, MENU_TIME_FOREVER);
		return Plugin_Handled;
	}
	else
	{
		ReplyToCommand(client, "[SM] \x01Kullanım: sm_ffmenu (Saniye)");
		return Plugin_Handled;
	}
}

public Action FFAcKomut(int client, int args)
{
	char YetkiliflagString[8];
	g_Yetkiliflag.GetString(YetkiliflagString, sizeof(YetkiliflagString));
	if (!warden_iswarden(client) && !HasFlags(client, YetkiliflagString))
	{
		ReplyToCommand(client, "[SM] \x01Bu komuta erişiminiz yok!");
		return Plugin_Handled;
		
	}
	if (args != 0)
	{
		ReplyToCommand(client, "[SM] \x01Kullanım: sm_ffac");
		return Plugin_Handled;
	}
	
	PrintToChatAll("[SM] \x0C%N \x01tarafından Dost ateşi \x04açılmıştır!", client);
	FFAktif = true;
	if (g_gerisaytimer != null)
		delete g_gerisaytimer;
	
	Guns = false;
	SetCvar("mp_teammates_are_enemies", 1);
	SetCvar("mp_friendlyfire", 1);
	SetCvar("mp_respawn_on_death_t", 0);
	return Plugin_Handled;
}

public Action FFKapatKomut(int client, int args)
{
	char YetkiliflagString[8];
	g_Yetkiliflag.GetString(YetkiliflagString, sizeof(YetkiliflagString));
	if (!warden_iswarden(client) && !HasFlags(client, YetkiliflagString))
	{
		ReplyToCommand(client, "[SM] \x01Bu komuta erişiminiz yok!");
		return Plugin_Handled;
	}
	if (args != 0)
	{
		ReplyToCommand(client, "[SM] \x01Kullanım: sm_ffkapat");
		return Plugin_Handled;
	}
	if (g_gerisaytimer != null)
		delete g_gerisaytimer;
	
	Guns = false;
	FFAktif = false;
	SetCvar("mp_teammates_are_enemies", 0);
	SetCvar("mp_friendlyfire", 0);
	SetCvar("mp_respawn_on_death_t", 0);
	PrintToChatAll("[SM] \x0C%N \x01tarafından Dost ateşi \x04iptal edilmiştir!", client);
	return Plugin_Handled;
}

public Action FFMenuiptal(int client, int args)
{
	char YetkiliflagString[8];
	g_Yetkiliflag.GetString(YetkiliflagString, sizeof(YetkiliflagString));
	if (!warden_iswarden(client) && !HasFlags(client, YetkiliflagString))
	{
		ReplyToCommand(client, "[SM] \x01Bu komuta erişiminiz yok!");
		return Plugin_Handled;
		
	}
	if (g_gerisaytimer != null)
		delete g_gerisaytimer;
	Guns = false;
	FFAktif = false;
	SetCvar("mp_teammates_are_enemies", 0);
	SetCvar("mp_friendlyfire", 0);
	SetCvar("mp_respawn_on_death_t", 0);
	PrintToChatAll("[SM] \x0C%N \x01tarafından Dost ateşi \x04iptal edilmiştir!", client);
	return Plugin_Handled;
}

public Action SilahMenu(int client, int args)
{
	if (!Guns)
	{
		ReplyToCommand(client, "[SM] \x01Bu komutu kullanmak için geciktin!");
	}
	
	if (!sadecetabanca)
	{
		gunsmenu().Display(client, MENU_TIME_FOREVER);
		return Plugin_Handled;
	}
	else
	{
		tabancamenu().Display(client, MENU_TIME_FOREVER);
		return Plugin_Handled;
	}
} 