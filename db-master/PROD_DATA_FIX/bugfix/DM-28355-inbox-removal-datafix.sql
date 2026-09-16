/*
   Issue Description: CDM-28355
   Category/ Module  : Approved item not leaving approved screen
   Root cause: .
   Pull request# for code fix: It's a data fix   
*/


update routing 
        set activeflag = 0,updatedon = now(), updatedby = 'CDM-28355'
       where objectid  = '7cb8b278-8b71-47e3-b4c3-01c8b0bc99a1'
      and routingid = '0bd109ce-15a3-4b70-94fa-aefcc1530a04';


update routing 
        set activeflag = 0,updatedon = now(), updatedby = 'CDM-28355'
       where objectid  = 'd3606fc8-1864-42eb-876e-0d5f7231ed81'
      and routingid = '796e4eaa-0d33-45e2-a785-97e059e55f3b';


update routing 
        set activeflag = 0,updatedon = now(), updatedby = 'CDM-28355'
       where objectid  = '94f1e398-ac2a-4feb-a30f-71a17f6a5363'
      and routingid = '958f288e-c742-45b5-b58b-a79f0531ea02';

update routing 
        set activeflag = 0,updatedon = now(), updatedby = 'CDM-28355'
       where objectid  = 'a5d3463c-138b-41d2-935e-00a9009e3ecd'
      and routingid = '9391818b-a6ca-4651-884f-41f48ed2b18c';