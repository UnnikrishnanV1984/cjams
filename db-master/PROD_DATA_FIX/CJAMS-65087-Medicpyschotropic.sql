/*
   Issue Description: CJAMS-65087
   Category/ Module  : Medication not visible.
   Root cause: User deleted the medication.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update personmedicpshychotropic
set activeflag  = 1, updatedon = now(), updatedby = 'CJAMS-65087'
where personmedicpshychotropicid in ('bad91d2d-f8fa-42f0-be7b-9cfd897986c1', '11537f26-08ed-464c-83a2-77ae32be0902') and activeflag = 0;
