/*
   Issue Description: CDM-22372
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to end date changes
   Pull request# for code fix: 5575
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update placement set enddatetime = '2021-06-03 00:00:00', updatedby = 'CDM-22373', 
updatedon = now() where placementid = 'fe7c1b81-e5dc-4d49-b7b6-eadcbafd2003';
update livingarrangement set livingenddate = '2021-06-03 00:00:00', updatedby = 'CDM-22373', 
updatedon = now() where placementid = 'fe7c1b81-e5dc-4d49-b7b6-eadcbafd2003';