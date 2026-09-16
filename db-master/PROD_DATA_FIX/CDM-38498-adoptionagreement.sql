/*
   Issue Description: CDM-38498
   Category/ Module  : Prod data fix for adoption break the link
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update adoptionagreement set activeflag = 0, updatedby = 'CDM-38498', updatedon = now()
where adoptionagreementid in ('340bc2c6-a6df-4e33-86ff-6558f8cc23c3', '4a8f93cd-44f5-4257-b756-a751ec3780d6',
'7dd12399-f3e4-49a3-99f8-e77f71777431','abed2d26-b2d3-4f46-83ea-b26a877c9563','60367f0f-368e-4b9c-8075-50bf48a673f0') and activeflag = 1;
	