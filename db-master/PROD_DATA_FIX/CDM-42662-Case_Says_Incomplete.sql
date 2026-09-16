/*
   Issue Description: CDM-42662
   Category/ Module  :  IVE Gap
   Root cause: Secondary guardianship details not binding in grid due to invalid provider Id. 
   Pull request# for code fix: 
   Reason why no related code fix: 
 
*/

update cjams.gapeligibilityinfo
set 
    providerapprovalid ='80926', updatedby ='CDM-42662', updatedon = now()
where 
    client_id = '3460991' and activeflag = 1;