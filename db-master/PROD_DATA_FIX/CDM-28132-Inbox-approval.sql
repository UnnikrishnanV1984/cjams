/*
   Issue Description: CDM-28132
   Category/ Module  : Deleting permanency plan assignment
   Root cause: .
   Pull request# for code fix: It's a data fix   
*/

update routing 
        set activeflag = 0,updatedon = now(), updatedby = 'CDM-28132'
       where objectid  = 'd968439e-490b-4b63-ba86-40b790e5b67a'
      and routingid = '945e1660-22c5-4092-b126-1e3850ded5a8';