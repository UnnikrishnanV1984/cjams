/*
   Issue Description: CDM-22208
   Category/ Module  : Placement end date
   Root cause: user wants to end date placement 
   Pull request# for code fix: 5410
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing placement end date. Need to do data fix
*/
update livingarrangement 
set livingenddate = '2021-11-01 00:00:00', updatedon = now(), updatedby = 'CDM-22208' 
where placementid = '03ed0e81-93b4-4e54-ac5b-9f26a0a3e3b9';

update placement 
set enddatetime = '2021-11-01 00:00:00', updatedon = now(), updatedby = 'CDM-22208' 
where placementid = '03ed0e81-93b4-4e54-ac5b-9f26a0a3e3b9';
