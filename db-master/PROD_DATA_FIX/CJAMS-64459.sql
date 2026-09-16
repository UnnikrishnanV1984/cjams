/*
Issue Description: CJAMS-64459
Category/Module: Intake Dashboard
Root cause: Screenout Intake is showing on Pending Dashboard. user requested to remove it from pending dashboard
Fix provided: Datafix provided to move the intake from pending to screenout dashboard
Regression Impacts: N/A
Is Code fix Required?: Code fix will be deployed thru another CIDM next week
Code fix ticket#: N/A
Reason why no related code fix: Not a code issue.
*/

update cjams.routing
	set eventcode = 'INTR', 
		routingstatustypeid = 8, 
		intakerecommendation = 'Scrnin', 
		supervisordecision = 'screenout',
		updatedon = now(), 
		updatedby = 'CJAMS-64459'
	where routingid = '2e813543-d7f0-491b-baf4-0096711171a4';
	
update cjams.intakedastatus
	set status = 8,  
		updatedon = now(), 
		updatedby = 'CJAMS-64459'
	where intakenumber = 'I231011390466'
		and activeflag = 1;	
		
update cjams.intakedastaging
	set status = 'Closed',  
		updatedon = now(), 
		updatedby = 'CJAMS-64459'
	where intakenumber = 'I231011390466'
		and activeflag = 1;

-- To show the status as Closed in Screen Out Dashboard	
update cjams.intakeservicerequest 
	set actiontype = null,
		intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', 
		updatedon = now(),
		updatedby = 'CJAMS-64459'
	where intakeserviceid  = '08a064e1-f8f7-4b57-8e32-21c3041f7969';

	update cjams.intakesnapshot
	set activeflag =1,
		updatedon = now(),
		updatedby = 'CJAMS-64459'
	where intakesnapshotid='e2cb26c3-eb1f-48fd-aa1e-007626dfbdf2';
