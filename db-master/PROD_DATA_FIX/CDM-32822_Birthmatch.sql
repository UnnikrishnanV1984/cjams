/*
   Issue Description: CDM-32822
   Category/ Module  : Person 
   Root cause: user updated this info by error  
    Fix Provided: Did data to uncheck birthmatchflag 
*/


update cjams.personbirthmatch set birthmatchflag =0, updatedby ='CDM-32822', updatedon = now()
where personbirthmatchid ='ad529625-26de-4cd2-9cc9-f023a99d7ff8';