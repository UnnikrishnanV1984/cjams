/*
   Issue Description: CDM-34142
   Category/ Module  : Placement tab
   Root cause:Unable to edit placement as there is no record in revision table
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.placement
SET activeflag=0, updatedby='CDM-34142', updatedon=now()
WHERE placementid='43156e04-eb48-43fa-9f85-f17ad5db2328'::uuid;
