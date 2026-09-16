/*
   Issue Description: CDM-17115
   Category/ Module  : Approval inbox
   Root cause: user wants to remove
   Pull request# for code fix: 
  explanantion: user wants to remove remaining items from inbox

  */

  update routing  set activeflag = 0 , updatedby ='CDM-17115',updatedon = now() 
where routingid = '25f9d38d-a294-40e5-abbc-b9be7020e7b9';

