/*
   Issue Description: CDM-33915
   Category/ Module  : Prod data fix to the service plan
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

  update serviceplan set involvedpersons = jsonb_set(involvedpersons::jsonb, '{persons}', 		 
			jsonb_set((involvedpersons->'persons')::jsonb, '{0}', 
			jsonb_set((involvedpersons->'persons'->0)::jsonb, '{imminentrisks}', '["NONE"]'))
			)
			,updatedby = 'CDM-33915', updatedon = now()
where serviceplanid='549e9ab5-aabd-49f5-baee-4bb77d55bb7a';
