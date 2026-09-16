/*
   Issue Description: CDM-25695
   Category/ Module  : Prod data fix to Revert ACA Redetermination details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- Review
update adoptionapplicabilityinfo set ivestatus = 'APPROVED',updatedby = 'CDM-25965', updatedon= now()
where adoptionapplicabilityid = '4c878113-3407-4a45-bb06-22328c57e6ef';