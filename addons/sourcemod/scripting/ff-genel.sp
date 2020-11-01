#include <sourcemod>
#include <cstrike>
#include <sdktools>
#include <warden>
#include <hgr>

#include "FF/Global.sp"
#include "FF/Stocks.sp"
#include "FF/FFMenu-Menu.sp"
#include "FF/FFDondur-Menu.sp"
#include "FF/OnMap.sp"
#include "FF/Event.sp"
#include "FF/Timer-Callback.sp"

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = 
{
	name = "FFMenu - FFDondur", 
	author = "ByDexter", 
	description = "", 
	version = "1.5", 
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
	RegConsoleCmd("sm_guns", SilahMenu);
	HookEvent("round_start", RoundStartEnd, EventHookMode_PostNoCopy);
	HookEvent("round_end", RoundStartEnd, EventHookMode_PostNoCopy);
	HookEvent("player_death", OnClientDead, EventHookMode_PostNoCopy);
	g_WeaponParent = FindSendPropInfo("CBaseCombatWeapon", "m_hOwnerEntity");
	g_Yetkiliflag = CreateConVar("sm_ffmenu_flag", "q", "FFMenu komutçu harici verebilecek kişilerin yetkisi");
	g_Yetkiliflagg = CreateConVar("sm_ffdondur_yetki", "q", "FFDondur komutçu harici verebilecek kişilerin yetkisi");
	AutoExecConfig(true, "FFGenel", "ByDexter");
}

// FFDondur //

public Action FFDonduriptal(int client, int args)
{
	if (args != 0)
	{
		ReplyToCommand(client, "[SM] \x01Kullanım: sm_ffdonduriptal");
		return Plugin_Handled;
	}
	else
	{
		char YetkiliflagStringg[8];
		g_Yetkiliflagg.GetString(YetkiliflagStringg, sizeof(YetkiliflagStringg));
		if (warden_iswarden(client) || HasFlags(client, YetkiliflagStringg))
		{
			if (g_gerisaytimerr != null)
				delete g_gerisaytimerr;
			PrintToChatAll("[SM] \x0C%N \x01tarafından \x04FF Dondur \x01iptal edildi!", client);
			return Plugin_Handled;
		}
		else if (!warden_iswarden(client) || !HasFlags(client, YetkiliflagStringg))
		{
			ReplyToCommand(client, "[SM] \x01Bu komuta erişiminiz yok!");
			return Plugin_Handled;
		}
		return Plugin_Handled;
	}
}

public Action FFDondur(int client, int args)
{
	if (args >= 2)
	{
		ReplyToCommand(client, "[SM] \x01Kullanım: sm_ffdondur (Saniye)");
		return Plugin_Handled;
	}
	else
	{
		char YetkiliflagStringg[8];
		g_Yetkiliflagg.GetString(YetkiliflagStringg, sizeof(YetkiliflagStringg));
		if (warden_iswarden(client) || HasFlags(client, YetkiliflagStringg))
		{
			char arg1[192];
			GetCmdArg(1, arg1, 192);
			if (args == 1)
			{
				if (g_gerisaytimerr != null)
					delete g_gerisaytimerr;
				DondurmaSure = StringToInt(arg1);
				PrintToChatAll("[SM] \x0C%N \x01tarafından \x04FF Dondurma %d saniye \x01belirlenmiştir!", client, DondurmaSure);
				ffkapatmamenu(client);
				return Plugin_Continue;
			}
			else if (args == 0)
			{
				ffdondurmenu(client);
				return Plugin_Continue;
			}
		}
		else if (!warden_iswarden(client) || !HasFlags(client, YetkiliflagStringg))
		{
			ReplyToCommand(client, "[SM] \x01Bu komuta erişiminiz yok!");
			return Plugin_Handled;
		}
		return Plugin_Continue;
	}
}

// FFMenu //

public Action FFMenu(int client, int args)
{
	if (args >= 2)
	{
		ReplyToCommand(client, "[SM] \x01Kullanım: sm_ffmenu (Saniye)");
		return Plugin_Handled;
	}
	else
	{
		char YetkiliflagString[8];
		g_Yetkiliflag.GetString(YetkiliflagString, sizeof(YetkiliflagString));
		if (warden_iswarden(client) || HasFlags(client, YetkiliflagString))
		{
			char arg1[192];
			GetCmdArg(1, arg1, 192);
			if (args == 1)
			{
				if (g_gerisaytimer != null)
					delete g_gerisaytimer;
				GeriSay = StringToInt(arg1);
				PrintToChatAll("[SM] \x0C%N \x01tarafından \x04FF Süresi %d saniye \x01belirlenmiştir!", client, GeriSay);
				yasaklisilah(client);
				return Plugin_Continue;
			}
			else if (args == 0)
			{
				menugoster(client);
				return Plugin_Continue;
			}
		}
		else if (!warden_iswarden(client) || !HasFlags(client, YetkiliflagString))
		{
			ReplyToCommand(client, "[SM] \x01Bu komuta erişiminiz yok!");
			return Plugin_Handled;
		}
		return Plugin_Continue;
	}
}

public Action FFAcKomut(int client, int args)
{
	if (args != 0)
	{
		ReplyToCommand(client, "[SM] \x01Kullanım: sm_ffac");
		return Plugin_Handled;
	}
	else
	{
		char YetkiliflagString[8];
		g_Yetkiliflag.GetString(YetkiliflagString, sizeof(YetkiliflagString));
		if (warden_iswarden(client) || HasFlags(client, YetkiliflagString))
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
			return Plugin_Handled;
		}
		else if (!warden_iswarden(client) || !HasFlags(client, YetkiliflagString))
		{
			ReplyToCommand(client, "[SM] \x01Bu komuta erişiminiz yok!");
			return Plugin_Handled;
		}
		return Plugin_Handled;
	}
}

public Action FFKapatKomut(int client, int args)
{
	if (args != 0)
	{
		ReplyToCommand(client, "[SM] \x01Kullanım: sm_ffkapat");
		return Plugin_Handled;
	}
	else
	{
		char YetkiliflagString[8];
		g_Yetkiliflag.GetString(YetkiliflagString, sizeof(YetkiliflagString));
		if (warden_iswarden(client) || HasFlags(client, YetkiliflagString))
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
			return Plugin_Handled;
		}
		else if (!warden_iswarden(client) || !HasFlags(client, YetkiliflagString))
		{
			ReplyToCommand(client, "[SM] \x01Bu komuta erişiminiz yok!");
			return Plugin_Handled;
		}
		return Plugin_Handled;
	}
}

public Action FFMenuiptal(int client, int args)
{
	if (args != 0)
	{
		ReplyToCommand(client, "[SM] \x01Kullanım: sm_ffmenuiptal");
		return Plugin_Handled;
	}
	else
	{
		char YetkiliflagString[8];
		g_Yetkiliflag.GetString(YetkiliflagString, sizeof(YetkiliflagString));
		if (warden_iswarden(client) || HasFlags(client, YetkiliflagString))
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
			return Plugin_Handled;
		}
		else if (!warden_iswarden(client) || !HasFlags(client, YetkiliflagString))
		{
			ReplyToCommand(client, "[SM] \x01Bu komuta erişiminiz yok!");
			return Plugin_Handled;
		}
		return Plugin_Handled;
	}
}

public Action SilahMenu(int client, int args)
{
	if (args != 0)
	{
		ReplyToCommand(client, "[SM] \x01Kullanım: sm_guns");
		return Plugin_Handled;
	}
	else
	{
		if (Guns)
		{
			if (!sadecetabanca)
				gunsmenu(client);
			else
				tabancamenu(client);
			return Plugin_Continue;
		}
		else
		{
			ReplyToCommand(client, "[SM] \x01Bu komutu şu an \x04kullanamazsın!");
			return Plugin_Handled;
		}
	}
}