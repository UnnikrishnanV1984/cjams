/*
   Issue Description: CJAMS-58600
   Category/ Module  : Investigation finding
   Root cause:  Once Maltreatment type has been changed by Appeal worker . Currently application is not displaying latest maltreatment type due to Check box from SDM is not matching.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update investigationallegation 
set allegationid = '627b574e-aa98-48c1-98c3-cf6f5d155eff',
    updatedby = 'CJAMS-58600', updatedon = now()
where investigationallegationid in('01218781-42a4-40e1-be97-fb43a2d12421') 
and allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31';