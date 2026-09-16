/*
  Issue Description:  CDM-41704
   Category/ Module  : Child Removal
   Root cause: User request to add Parent Household in Environment at Removal field
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update intakeservreqchildremoval set environmentatremovalkey = 'PAHOLD', updatedby ='CDM-41704', updatedon= now() 
where intakeservreqchildremovalid in ('a2f69ff3-1fea-4aea-aaf1-1a40e57f40ab','e6beb65d-86ef-4e47-812a-1219a7a83e9f',
'e154f6c9-94e4-4173-90e5-c3f622052175','51328a06-6750-4e39-9c6b-ee54ace3603f') 
and servicecaseid = '7cc8e292-5ceb-447e-8457-5bd34e5e9d78' and activeflag = 1 
