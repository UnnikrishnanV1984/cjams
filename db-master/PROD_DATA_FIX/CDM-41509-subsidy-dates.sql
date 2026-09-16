/* 
   Issue Description: CDM-41509 CJAMS Subsidy Rate Issues
   Category/ Module  : Payments
   Root cause: User requested to correct the adoptioncaseagreementrate enddate and suspensionenddate to 2024-09-08 for the case 3184278
   Fix Provided : Data fix has been provided to correct the adoptioncaseagreementrate enddate and suspensionenddate to 2024-09-08 for the case 3184278
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/




update adoptioncaseagreementrate set enddate = '2024-09-08 00:00:00', approvaldate = now(), updatedby = 'CDM-41509', updatedon = now() 
where adoptionagreementrateid = 'bd8bc1bd-a36e-4e5a-bc46-2dd3b1e63ee3';

update adoptioncaserevision set enddate = '2024-09-08 00:00:00', approvaldate = now(), updatedby = 'CDM-41509', updatedon = now() 
where adoptionagreementrateid = 'bd8bc1bd-a36e-4e5a-bc46-2dd3b1e63ee3' and adoptionagreementid = '2354720d-4f13-454c-abc0-a2d82faf7386'
and activeflag = 1;

update adoptioncasesuspensionrevision 
set suspensionenddate ='2024-09-08 04:00:00', approvaldate =now(), updatedon =now(), updatedby ='CDM-41509'
where adoptionsuspensionrevisionid = '2b9dbb3d-0992-4fa0-a8d7-5d43b38e5bd0';

update adoptioncasesuspension
set suspensionenddate ='2024-09-08 04:00:00', updatedon =now(), updatedby ='CDM-41509'
where adoptionsuspensionid ='30008d64-f276-4fc5-a06f-e512dbc6c1be';