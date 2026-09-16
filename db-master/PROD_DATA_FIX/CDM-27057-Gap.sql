/*
  Issue Description: CDM-27057 - Gap enddate
  Root cause: user needs to update GAP enddate
  Fix provided : Updated enddate as user requested
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/



update gapagreement set enddate ='2024-11-06 04:00:00', updatedby ='CDM-27057', updatedon = now()
where gapagreementid ='3f10d1b1-229c-414d-9259-09a81d5f67e6';


update gapagreementrevision set enddate = '2024-11-06 04:00:00',approvaldate = now() , updatedon = now(), updatedby = 'CDM-27057'
where gapagreementid ='3f10d1b1-229c-414d-9259-09a81d5f67e6';