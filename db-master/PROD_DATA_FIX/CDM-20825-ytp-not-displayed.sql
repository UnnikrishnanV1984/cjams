/*
   Issue Description: CDM-20825
   Category/ Module  :Dashboard 
   Root cause: user wants remove the records which are approved but shown as pending
   Pull request# for data fix: 7477
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/
update routing 
set activeflag = 0, 
updatedby = 'CDM-20825', 
updatedon = now() 
where routingid IN('e0187fee-9fef-40b4-b2d5-0f1ee6afc593' , 'a989bafe-01dd-4a4c-83f1-dac2419d822d', '34af7dc3-6b8a-4df0-ab31-4a1141d2b84f');