
/*
   Issue Description: CDM-17654
   Category/ Module  :  Child Removal Fix
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-17654', updatedon = now() where intakeservreqchildremovalid = '285a4167-1ce2-436e-9fd9-de8fad067b4b';
update personprogramarea set activeflag = 0, updatedby = 'CDM-17654', updatedon = now() where personprogramid = 'a8e8ace1-44d8-40cd-a2f1-efeb5ebb67fa';
update placement set activeflag  = 0, updatedby = 'CDM-17654', updatedon = now() where placementid  in ('b24e044d-4b4f-45d3-a3d2-6e10409f8642',
'6a813afc-0742-4bf4-8d38-34d523015fc8');
update placementrevision set activeflag  = 0, updatedby = 'CDM-17654', updatedon = now() where placementid  in ('b24e044d-4b4f-45d3-a3d2-6e10409f8642',
'6a813afc-0742-4bf4-8d38-34d523015fc8');

