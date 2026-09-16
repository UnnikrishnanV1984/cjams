/*
   Issue Description: CDM-28680
   Category/ Module  : Living Arrangement Placement
   Root cause: user unable to see the review link for LA Placement
*/

update routing 
set tosecurityusersid = 'eba740d3-c238-4497-a660-3b7b09e12922', toroleid = 'CWSP', updatedby = 'CDM-28680', updatedon = now()
where routingid = '57a52787-0f44-41f0-babc-b1dcdbd18d60';