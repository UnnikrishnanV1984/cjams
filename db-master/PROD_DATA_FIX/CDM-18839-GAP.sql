/*
   Issue Description: CDM-18878
   Category/ Module  : remove enddate and remove under decision
   Root cause: GAP issue
   Pull request# for code fix: 
   Explanantion: user wants to delete the approval record which is already approved
*/


update servicecasedisposition s set activeflag =0,updatedby ='CDM-18839',updatedon =now() where servicecasedispositionid ='c6cf0685-2e88-42ca-bf55-4158d5ccc94e' and activeflag =1;

update personprogramarea set enddate = null , updatedby = 'CDM-18839', updatedon = now() where personprogramid='6a615a1e-2927-41dd-9c4b-0412aadebcca';
