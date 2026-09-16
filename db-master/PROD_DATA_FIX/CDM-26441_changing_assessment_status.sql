/*
   Issue Description: CDM-26441
   Category/ Module  : Changing the Assessment Status 
   Root cause: Not able to submit the SAFE-C assessment because system is asking for
    child information even the Department Unable to locate the family/child checkbox is checked.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update assessment 
set assessmentstatustypekey = 'Accepted',
    updatedby = 'CDM-26441',
    updatedon = now()
where assessmentid = 'b13ae45e-d5ae-4040-ac61-dd64df1b8c13';