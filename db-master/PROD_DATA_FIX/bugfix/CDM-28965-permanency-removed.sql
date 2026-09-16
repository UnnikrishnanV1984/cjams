/*
   Issue Description: CDM-28965
   Category/ Module  : permanencyplan 
   Root cause: user requested remove the duplicate permanency plan record
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update cjams.permanencyplan set activeflag =0, updatedby ='CDM-28965', updatedon =now()
where permanencyplanid ='71a67df2-d3df-4c91-a47b-0ccee3c2fd26';