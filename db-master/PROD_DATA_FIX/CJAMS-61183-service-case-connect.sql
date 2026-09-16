/*
Issue Description: Case connect missing for the intake I251013335618 that was created for infromation and referral
Category/Module: Intake / Information and refferal
Root cause: Case connect didn't happen for while intake creation I251013335618 and we were unable to replicate this issue in stage-3.
            We will monitor this kind of issues and open a code fix ticket if needed.
Fix provided: Data fix has been to done to connect the case for this intake.
Data/Code fix ticket#:TBD
Regression Impacts: N/A
Is Code fix Required?: TBD
Code fix ticket#: N/A
Reason why no related code fix: This issue is not replicable in stage-3 while new intake creation and service case is getting created. We will monitor it for future replication.
*/

--intakeserviceid -->6c7db459-0aec-4bb1-933c-1de81d00dd04
--supervisor id --> e7bc9b54-ccce-43dd-bff0-4a8bb9dbd04c :Ashley M. Stuck

select * 
from cjams.createservicecase(
  '6c7db459-0aec-4bb1-933c-1de81d00dd04',
  null,
  1,
  'e7bc9b54-ccce-43dd-bff0-4a8bb9dbd04c',
  '{}',       
  'ASSGN',     
  'intake'
);

update
	servicecase
set
	insertedon = '2025-08-06 15:31:06',
	updatedby = 'CJAMS-61183',
	startdate = '2025-08-06 15:31:06',
	updatedon = now()
where
	servicecaseid = (select servicecaseid from intakeservicerequest where intakeserviceid = '6c7db459-0aec-4bb1-933c-1de81d00dd04')
	and activeflag = 1;
--select * from servicecasedisposition where servicecaseid = '1f8f2d18-c34f-4c46-91f3-6827b306e9f3'

update
	servicecasedisposition 
set
	statusdate = '2025-08-06 15:31:06',
	effectivedate = '2025-08-06 15:31:06',
	updatedby = 'CJAMS-61183',
	updatedon = now()
where
	servicecaseid = (select servicecaseid from intakeservicerequest where intakeserviceid = '6c7db459-0aec-4bb1-933c-1de81d00dd04')
	and activeflag = 1;

insert into caseassignment
(caseassignmentid,fromworkeridno,fromsupervisoridno,toworkeridno,tosupervisoridno,old_id,insertedby,updatedby,insertedon,updatedon,objecttypekey,objectid,responsibilitytypekey,
activeflag,
startdate,fromteamid,toteamid,
statustypekey ,fromldssid,toldssid,assignmenttype,fk_id)
values
(gen_random_uuid(),'e7bc9b54-ccce-43dd-bff0-4a8bb9dbd04c','200006452','80519666-45fd-4739-8b1d-559f0680d17e','200006514','6004118','CJAMS-61183','CJAMS-61183',now(),now(),
'servicecase',(select servicecaseid from intakeservicerequest where intakeserviceid='6c7db459-0aec-4bb1-933c-1de81d00dd04'),'family',
1,
'2025-08-06 15:31:06','d196fdff-ae65-418e-96c4-f5df54ab6e33','d196fdff-ae65-418e-96c4-f5df54ab6e33',
'OPEN','ec6a5d23-4bc8-451a-9ea6-9253448aeb8a','ec6a5d23-4bc8-451a-9ea6-9253448aeb8a','W','200006452');