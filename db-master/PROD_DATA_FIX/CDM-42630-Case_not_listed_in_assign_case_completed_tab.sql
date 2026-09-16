/*
   Issue Description: CDM-42630
   Category/ Module  : 
   Root cause: case is not available in the supervisor completed dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 
/*
select isrouted,routedusersid, servicerequestnumber,* from cjams.intakeservicerequest where servicerequestnumber  = '241022928005';
select * from cjams.v_userprofile vu where securityusersid = '936ce49e-956d-46f8-bb8e-7e37415221ad'
*/

update cjams.intakeservicerequest set isrouted = true, routedon = now(), 
routedusersid = '936ce49e-956d-46f8-bb8e-7e37415221ad', updatedon = now(), 
updatedby = 'CDM-42630' 
where servicerequestnumber  = '241022928005';