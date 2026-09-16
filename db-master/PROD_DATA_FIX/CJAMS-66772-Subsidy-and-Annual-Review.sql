/*
  Issue Description:  CJAMS-66772- Subsidy and Annual Review
   Category/ Module  :  GAP
   Root cause: 3027077:This case was closed over a year ago. I am trying to put in the annual review and the subsidy rate.
   Pull request# for code fix: 
*/




update routing 
set activeflag  =0, updatedon = now(), updatedby ='CJAMS-66772'
where routingid ='569a7c74-7aaf-4389-92ed-42a281555bc7' and activeflag = 1;