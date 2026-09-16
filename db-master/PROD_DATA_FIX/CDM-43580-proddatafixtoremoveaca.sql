/*
   Issue Description: CDM-43580
   Category/ Module  : Prod data fix to remove ive aca review record
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update routing set activeflag = 0, updatedby = 'CDM-43580', updatedon= now() 
where routingid = '58ce6410-a32d-4a2a-8669-0f58dcf84381' and activeflag = 1;


update adoptionapplicabilityinfo set ivestatus = 'APPROVED',updatedby = 'CDM-438580', updatedon= now()
where adoptionapplicabilityid = '1d16093f-3d94-403d-9af0-053d3d4ba8d8';