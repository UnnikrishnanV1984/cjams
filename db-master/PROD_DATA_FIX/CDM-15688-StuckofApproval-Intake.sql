
	/*
   Issue Description: CDM-15688
   Category/ Module  : Intake approval
   Root cause: user wants New Service Case from intake and connect to the intake so that they can assign.
   Pull request# for code fix: 4698
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
with list as (
select * from cjams.createservicecase('f4e7d4cb-0912-4251-829b-5ac049282a96', null, 1, 'd01eb0ea-2486-4422-87ce-8e036fe78425', 'intake', '')
)
	INSERT INTO cjams.caseassignment
	(eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, 
	toworkeridno, insertedby, updatedby, insertedon, updatedon, objecttypekey, 
	objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, assigndate)
	VALUES('88c3ebe2-978c-49f3-8d21-4f74473fb532'::uuid, NULL, 'd01eb0ea-2486-4422-87ce-8e036fe78425', NULL, NULL, 
	'd01eb0ea-2486-4422-87ce-8e036fe78425', 'CDM-15688', 'CDM-15688', now(), now(), 'servicecase', 
	(select caseid from list)::uuid, 'family', 1, '2021-07-29 16:50:00.000', null, 'e93e0de6-170b-400c-aa47-cd74e7e9d2dc'::uuid, 'e93e0de6-170b-400c-aa47-cd74e7e9d2dc'::uuid, '<p>Admin Rights given for TPO filed</p>', 'ASSGN', '2021-07-29 00:00:00.000');

