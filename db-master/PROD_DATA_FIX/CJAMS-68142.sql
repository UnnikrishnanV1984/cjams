/*
   Issue Description: CJAMS-68142
   Category/ Module  : 
   Root cause: CPS IR case# 241022961681 was not listed in the supervisor completed dashboard because the routinguserid and isrouted flag value was empty in DB.
   Fix Provided: datafix has been promoted for this case with the assignment of proper routinguserid and active isrouted flag status.
   Regression Impacts: cw-assign-case tab
   Is Code fix Required?: No
   Code fix ticket#: N/A 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 


update cjams.intakeservicerequest set isrouted = true, routedon = now(), 
routedusersid = '35e42a69-a74e-466e-9d1c-39d234acd8c9',
updatedby ='CJAMS-68142',
updatedon =now()
where servicerequestnumber  = '241022961681';