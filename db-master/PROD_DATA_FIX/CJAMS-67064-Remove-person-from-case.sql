/*
   Issue Description: CJAMS-67064 - SSA/PO Approved need data fix to proceed to the CJAMS PID#: 204863143 be removed from the case 261023713872. This was an accidental add to the case.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix: Data fix to remove the approval request record.
*/

update cjams.personrole 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-67064'
	where personroleid='a2e375a8-c78a-4f97-88cb-11cc5281994a'
		and activeflag = 1;

update cjams.personroletype 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-67064'
	where personroleid='a2e375a8-c78a-4f97-88cb-11cc5281994a'
		and activeflag = 1;
		
update cjams.intakeservicerequestactor  
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-67064'
	where intakeservicerequestactorid = '895a9894-16c9-48bf-b839-02c97b13c07a'
		and activeflag = 1;

update cjams.actor 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-67064'
	where actorid ='a171bcc5-a4f7-431b-942f-bc2e8cbe8b31'
		and activeflag = 1;



update cjams.actorrelationship 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-67064'
	where intakeservicerequestactorid ='895a9894-16c9-48bf-b839-02c97b13c07a'
		and activeflag = 1;
		

		
