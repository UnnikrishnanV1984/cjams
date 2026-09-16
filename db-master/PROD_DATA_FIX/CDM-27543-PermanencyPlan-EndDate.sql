/*
   Issue Description: CDM-27543
   Category/ Module  : Permanency Plan
   Root cause: user wants to change date for permanency plan
   Pull request# for code fix: 7402
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
update permanencyplan set enddate = '2022-12-19 00:00:00',updatedon = now(), 
updatedby = 'CDM-27543' where permanencyplanid = '33ebc718-48fe-4ffa-8474-bea3ca775fb2';

update permanencyplan set enddate = null, updatedby = 'CDM-27543', 
updatedon = now()  where permanencyplanid = '6240648f-8cfc-4932-bb95-9ad69f840fab';