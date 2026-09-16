/*
   Issue Description: CDM-14364: 
   Category/ Module  : Appeals assignement 
   Root cause: user wants to see cases in dashboard to assign to appeals
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update cjams.intakeservicerequest set isrouted = true, routedon = now(), 
routedusersid = 'c9af31e6-2a79-411c-8826-4c122192b389', updatedon = now(), 
updatedby = 'a2b0fb1f-2ffa-4209-b2d3-82584d914cc2' 
where servicerequestnumber  = '202101230106397';

update cjams.intakeservicerequest set isrouted = true, routedon = now(), 
routedusersid = 'f5fe6a5b-5767-4437-911b-33c9827d172c', updatedon = now(), 
updatedby = 'a2b0fb1f-2ffa-4209-b2d3-82584d914cc2' 
where servicerequestnumber  = '202101240106719';

