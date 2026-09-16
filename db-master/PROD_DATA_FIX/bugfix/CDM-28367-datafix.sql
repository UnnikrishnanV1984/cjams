/*
   Issue Description: CDM-28367
   Category/ Module  : Approved item not leaving approved screen
   Root cause: .
   Pull request# for code fix: It's a data fix   
*/

update routing 
        set activeflag = 0,updatedon = now(), updatedby = 'CDM-28367'
       where objectid  = '0ad24385-8b56-4883-a60f-d647a8755195'
      and routingid = '79c63fc9-3625-45c9-a269-fa7250410f4e';
      