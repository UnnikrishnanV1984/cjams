/*
   Issue Description: CDM-34163
   Category/ Module  : Prod data fix to update the serviceplan
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


  update serviceplan set involvedpersons = jsonb_set(involvedpersons::jsonb, '{persons}', 		 
			jsonb_set((involvedpersons->'persons')::jsonb, '{0}', 
			jsonb_set((involvedpersons->'persons'->0)::jsonb, '{imminentrisks}', '["DJSI"]'))
			)
			,updatedby = 'CDM-34163', updatedon = now()
where serviceplanid = '98a6c1f4-cc8e-4d32-8bd7-f7cb9b73d756';