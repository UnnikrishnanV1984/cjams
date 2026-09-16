/*
   Issue Description: CDM-41759
   Category/ Module  : 
   Root cause: case is not available in the supervisor completed dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 
/*
select isrouted,routedusersid, servicerequestnumber,* from cjams.intakeservicerequest where servicerequestnumber  = '221020233029';
select * from cjams.v_userprofile vu where securityusersid = '5b2bcf41-0610-4b6c-b62e-250d714750b5'
*/

update cjams.intakeservicerequest set isrouted = true, routedon = now(), 
routedusersid = '5b2bcf41-0610-4b6c-b62e-250d714750b5', updatedon = now(), 
updatedby = 'CDM-41759' 
where servicerequestnumber  = '221020233029';


