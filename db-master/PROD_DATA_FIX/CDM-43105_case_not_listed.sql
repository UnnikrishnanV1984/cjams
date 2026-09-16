/*
   Issue Description: CDM-43105
   Category/ Module  : 
   Root cause: case is not available in the supervisor completed dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 
/*
select isrouted,routedusersid, servicerequestnumber,* from cjams.intakeservicerequest where servicerequestnumber  = '241022945306';
select * from cjams.v_userprofile vu where securityusersid = '936ce49e-956d-46f8-bb8e-7e37415221ad'
*/
update cjams.intakeservicerequest set isrouted = true, routedon = now(), 
routedusersid = '936ce49e-956d-46f8-bb8e-7e37415221ad', updatedon = now(), 
updatedby = 'CDM-43105' 
where servicerequestnumber  = '241022945306';