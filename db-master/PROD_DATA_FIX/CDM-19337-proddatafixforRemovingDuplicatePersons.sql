
/*
   Issue Description: CDM-19337
   Category/ Module  : Removing duplicate persons from servicecase
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-19337', updatedon = now() where personid in ('3437aecd-7fdf-48a0-803b-f1123b6c0dea',
'7c636480-a5ad-4627-af44-b5272c9c40f9') and servicecaseid = 'bb0a06c3-7d04-4f15-8832-6a1dc0d0732f' and activeflag = 1;