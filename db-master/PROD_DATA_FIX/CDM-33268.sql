 /*
   Issue Description: CDM-33268
   Category/ Module  : service plan
   Root cause: ImminentRisks moved back to None 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
 update serviceplan set involvedpersons = jsonb_set(involvedpersons::jsonb, '{persons}', 		 
			jsonb_set((involvedpersons->'persons')::jsonb, '{0}', 
			jsonb_set((involvedpersons->'persons'->0)::jsonb, '{imminentrisks}', '["NONE"]'))
			)
			,updatedby = 'CDM-33268', updatedon = now()
where serviceplanid='4f704d13-5baa-41e4-bf61-6e592dcf7d71';



 update serviceplan set involvedpersons = jsonb_set(involvedpersons::jsonb, '{persons}', 		 
			jsonb_set((involvedpersons->'persons')::jsonb, '{1}', 
			jsonb_set((involvedpersons->'persons'->1)::jsonb, '{imminentrisks}', '["NONE"]'))
			)
			,updatedby = 'CDM-33268', updatedon = now()
where serviceplanid='4f704d13-5baa-41e4-bf61-6e592dcf7d71';

update snapshothist set snapshotdata  = 
replace( snapshotdata::text ,  '"imminentrisks": []',  '"imminentrisks": ["NONE"]' )::json
where   objectid ='4f704d13-5baa-41e4-bf61-6e592dcf7d71';
