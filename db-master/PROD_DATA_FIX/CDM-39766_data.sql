/*
  Issue Description:  CDM-39766
   Category/ Module  :  Placement
   Root cause: Primary Caregiver Not Displaying Correctly
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update livingarrangement set primarycaregiver = 'Serge Fabre', updatedon = now(), updatedby = 'CDM-39766'
where placementid  = 'aad69a42-30da-4c09-9943-46aef47e364f' and activeflag=1;