/*
   Issue Description: CDM-19000
   Category/ Module  : User wants case closure
   Root cause user wants case closure
   Pull request# for code fix: 
   Explanantion: user wants to close case by entering end date
*/
update placement 
        set enddatetime ='2021-12-01 00:00:00', endtime ='06:00',updatedon = now(), updatedby = 'CDM-19000'
        where placementid  = '643db66b-ee28-4b08-9f57-724e86e0ccf9'  and servicecaseid  = 'a956c9c2-19cc-43e4-b8d1-873c0d543a47';

update livingarrangement set livingenddate = '2021-12-01 00:00:00', updatedon = now(), updatedby = 'CDM-17216'
where personid  = '82f70ee1-6b32-4449-9c52-7de7e2361bef'
and placementid  = '643db66b-ee28-4b08-9f57-724e86e0ccf9';