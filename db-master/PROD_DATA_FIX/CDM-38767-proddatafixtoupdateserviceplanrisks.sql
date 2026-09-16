/*
   Issue Description: CDM-38767
   Category/ Module  : Prod data fix to update imminentrisks from service plan
   Root cause: user error
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



 --NONE
  update serviceplan set involvedpersons = jsonb_set(involvedpersons::jsonb, '{persons}', 		 
			jsonb_set((involvedpersons->'persons')::jsonb, '{0}', 
			jsonb_set((involvedpersons->'persons'->0)::jsonb, '{imminentrisks}', '["CPBN"]'))
			)
			,updatedby = 'CDM-38767', updatedon = now()
where serviceplanid='61fbe5c0-2ed4-463b-a12f-f6f52afcdf95';

