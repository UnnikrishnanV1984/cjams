/*
 Issue Description: CDM-36298
 Category/ Module : Intake/Referral
 Root cause: Screenout intake is still showing on pending tab .
 Fix: Data fix to record supervison decision and status.
 Pull request# for code fix: N/A
 Reason why no related code fix: 
 Need to do data fix
 */

INSERT INTO cjams.routing
( eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
insertedby, insertedon, updatedby, updatedon, isreviewrequest) 
VALUES('INTR', 'fab84a8e-2e81-4699-a435-285c577e008b', 'ba384e95-a535-4b1f-b9ea-b94c4f9ef782', 'f34d0100-99a2-431c-bbc7-3ed529de4b13', 'CWIW', 'CWSP', 'I231011323471', 8, 0, 
'CDM-36298', now(), 'CDM-36298', now(), true);

update intakedastaging
set jsondata = replace(jsondata::text, 
	'"supDisposition": ""', '"supDisposition": "ScreenOUT"')::json,
	status = 'Closed',
	updatedon = now(),
    updatedby = 'CDM-36298'
where intakenumber = 'I231011323471'
	and activeflag = 1 ;

-- To show screenout status as closed
update intakeservicerequest
set activeflag = 1,
	updatedon = now(),
    updatedby = 'CDM-36298'
where intakeserviceid = '2b1956b3-91d4-4a37-8cf9-93ddd7d73852'
and activeflag = 0;