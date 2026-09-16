/*
   Issue Description: CDM-28447
   Category/ Module  : Approved item not leaving approved screen
   Root cause: .
   Pull request# for code fix: It's a data fix   
*/

update routing 
        set activeflag = 0,updatedon = now(), updatedby = 'CDM-28447'
       where objectid  = 'b6ac2ca9-178d-4235-8796-1e1dd83003bb'
      and routingid = '5e34f75a-5845-4c88-91d6-d863f75992de';
      
update routing 
        set activeflag = 0,updatedon = now(), updatedby = 'CDM-28447'
       where objectid  = 'af6bc746-a0a5-4fb6-af6c-b5d0b187520e'
      and routingid = 'e02b7136-04f0-4c25-9873-5d0c54bf00d0';
      
update routing 
        set activeflag = 0,updatedon = now(), updatedby = 'CDM-28447'
       where objectid  = 'cd4fc7ba-9aff-418f-9132-48b6b18505d9'
      and routingid = '74a06bb4-d481-4854-8e1b-387a05b91915';
      
update routing 
        set activeflag = 0,updatedon = now(), updatedby = 'CDM-28447'
       where objectid  = '9f872cb4-33dc-4bd0-ae18-3b8766a72f66'
      and routingid = 'cdc585ed-9a58-4f4e-8187-2179603e6e7e';
      