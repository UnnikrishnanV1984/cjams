

/*
   Issue Description: CDM-29657
   Category/ Module  : Servicecase
   Root cause: user error : User requested to delete this service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
--- Right now this case data is not avaible on stage, so i checked with feby on prod

--- I see that there is no intake linked and all tabs including person tab is blank 

update cjams.servicecase set activeflag =0, updatedby ='CDM-29657', updatedon = now()
where servicecasenumber ='231030086061';

update cjams.caseassignment set activeflag =0,  updatedby ='CDM-29657', updatedon = now()
where caseassignmentid ='b378eef2-8f37-4d62-bc39-47190a54ced5';

update cjams.servicecasedisposition set activeflag =0,  updatedby ='CDM-29657', updatedon = now()
where servicecasedispositionid ='d4a1b5f2-f2e8-4867-937b-dcae9866d7e8';