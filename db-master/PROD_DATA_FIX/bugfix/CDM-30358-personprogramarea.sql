/*
   Issue Description: CDM-30358
   Category/ Module  : personprogramarea
   Root cause: Updates that by user in CJams is showing the name Kemeshia Maith instead of Cindy Sindorf 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

 update
	personprogramarea
set
	updatedby = '5f954182-d984-4b92-a2ec-4a378cec92ef',
	updatedon = now()
where
	personprogramid = '1e53249a-0677-46b6-8223-73e0564061af';