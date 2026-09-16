
/*
   Issue Description: CJAMS-65782
   Category/ Module  : Intake
   Root cause: user error, Requested for a datafix 
   Fix provided : Data fix has been done to remove the intake
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakedastatus 
	set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-65782' 
where intakenumber = 'I261013913416' and activeflag =1;

update intakedastaging 
	set activeflag=0, updatedon = now(), updatedby = 'CJAMS-65782' 
where intakenumber ='I261013913416' and activeflag=1;


/* no record in intakesnapshot */
/* No record in intakeservicerequest*/
/*No record in routing*/
/*No record in intakeservicerequestactor*/
/*No record in actor*/
/* No record actorrelationship*/
/* Active flag 0 in personrole table */
