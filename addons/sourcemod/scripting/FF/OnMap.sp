public void OnMapEnd() 
{ 
	if (g_gerisaytimer != null)delete g_gerisaytimer; 
	if (g_gerisaytimerr != null)delete g_gerisaytimerr; 
	if (Guns)Guns = false; if (FFAktif)FFAktif = false;
	if (GetConVarInt(FindConVar("mp_teammates_are_enemies")) != 0)SetCvar("mp_teammates_are_enemies", 0); 
	if (GetConVarInt(FindConVar("mp_friendlyfire")) != 0)SetCvar("mp_friendlyfire", 0); 
	if (GetConVarInt(FindConVar("mp_respawn_on_death_t")) != 0)SetCvar("mp_respawn_on_death_t", 0);
}

public void OnMapStart() 
{ 
	if (g_gerisaytimer != null)delete g_gerisaytimer; 
	if (g_gerisaytimerr != null)delete g_gerisaytimerr; 
	if (Guns)Guns = false; if (FFAktif)FFAktif = false;
	if (GetConVarInt(FindConVar("mp_teammates_are_enemies")) != 0)SetCvar("mp_teammates_are_enemies", 0); 
	if (GetConVarInt(FindConVar("mp_friendlyfire")) != 0)SetCvar("mp_friendlyfire", 0); 
	if (GetConVarInt(FindConVar("mp_respawn_on_death_t")) != 0)SetCvar("mp_respawn_on_death_t", 0);
}