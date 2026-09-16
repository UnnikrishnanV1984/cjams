/*
   Issue Description: CDM-18778
   Category/ Module  : Data fix for updating SDM
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservicerequestsdm 
set isneggn_exposuretounsafe = true,isnegrh_treatmenthealthrisk = true, updatedby = 'CDM-18778', updatedon = now()
where intakeserviceid = '1401ca9f-7516-4336-80c4-a3bb0e2e83f9';