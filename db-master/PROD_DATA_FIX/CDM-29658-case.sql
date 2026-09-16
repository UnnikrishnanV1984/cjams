/*
   Issue Description: CDM-29658
   Category/ Module  : Servicecase
   Root cause: user error : User requested to delete this service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

--- Right now this case data is not avaible on stage, so i checked with feby on prod

--- I see that there is no intake linked and all tabs including person tab is blank 


update cjams.servicecase set activeflag =0, updatedby ='CDM-29658', updatedon = now()
where servicecasenumber ='231030086062';

update cjams.caseassignment set activeflag =0,  updatedby ='CDM-29658', updatedon = now()
where caseassignmentid ='4286ff72-cd14-49a3-97a6-1fcdfde70129';

update cjams.servicecasedisposition set activeflag =0,  updatedby ='CDM-29658', updatedon = now()
where servicecasedispositionid ='c2a037a3-42bb-4efe-b5b6-9e98b7ab72b1';