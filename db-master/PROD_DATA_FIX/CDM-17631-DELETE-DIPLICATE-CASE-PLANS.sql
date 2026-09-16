/*
   Issue Description: CDM-17631
      Category/ Module  : delet duplicarte case plans
   Root cause: user wants to remove
   Pull request# for code fix: 
  explanantion: user wants to remove
  */


update snapshothist 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-17631' 
where id in ('d8303b3b-9d05-493a-b2d7-971046d74029', '52381f20-3a04-4731-88e4-0d53aef46f40');