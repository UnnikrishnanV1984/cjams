/*
   Issue Description: CDM-23961: 
   Category/ Module  : Appeals assignement 
   Root cause: user wants to see cases in dashboard to assign to appeals
   Pull request# for code fix: 6231
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update cjams.intakeservicerequest set isrouted = true, routedon = now(), 
routedusersid = '38ef2748-75db-4001-95b3-3250ffec78b6', updatedon = now(), 
updatedby = 'CDM-23961' where servicerequestnumber  = '221020231576';