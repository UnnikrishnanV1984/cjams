/*
   Issue Description: CDM-24599
   Category/ Module  : Deleting permanency plan assignment
   Root cause:There is a permanency plan that is showing as established in the year 2024. This needs to be deleted so the correct plan can be entered.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update permanencyplan set  activeflag = 0, updatedon = now(), updatedby = 'CDM-24599' where permanencyplanid = 'fb8acdd0-86cb-4464-96eb-919621d2ac61';

update routing set activeflag = 0, updatedby = 'CDM-24599', updatedon = now() where objectid = 'fb8acdd0-86cb-4464-96eb-919621d2ac61';