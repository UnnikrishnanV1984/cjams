/*
   Issue Description: CDM-28156
   Category/ Module  : Approved item not leaving approved screen
   Root cause: .
   Pull request# for code fix: It's a data fix   
*/
     
update routing 
        set activeflag = 0,updatedon = now(), updatedby = 'CDM-28156'
       where objectid  = 'e14657d0-fb1b-4522-8ac9-c432fd46f707'
      and routingid = 'a7ce2e71-6ed7-46e1-85cd-1f689299caf2';
  
          
update routing 
        set activeflag = 0,updatedon = now(), updatedby = 'CDM-28156'
       where objectid  = '4b26aeb5-ee10-4573-8a22-fd3109b8859f'
      and routingid = '0d341a8f-41d8-45c9-9c1f-b0f17fa819d3';
     