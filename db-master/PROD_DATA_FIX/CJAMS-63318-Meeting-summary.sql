/*
Issue: 241030385788:Meeting summary saved and created 3 identical meeting records for 11/4/2025 ftdm.
Category/Module: Support
Root cause: User Request, User requested to delete the duplicate FTDM meeting records on the Contact notes - Meeting screen for the case 241030385788.
Fix provided: datafix has been provided to remove the duplicated FTDM meeting records
Data/Code fix ticket#: N0
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is wasn't replicable in current system even after trying 
with different possible sceanrios like multi-submission, resubmission, edit etc. Hence, provided datafix.

Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

/*
select * from meetingrecording
where servicecaseid = '5b6ab290-9eeb-4527-92b8-348bd81f4dd3' and activeflag =1
order by insertedon  desc;
*/

update meetingrecording 
	set activeflag = 0,
	updatedby = 'CJAMS-63318',
	updatedon = now()
where meetingrecordingid in  ('371866a6-4c1d-4165-9582-ebd68ee49a80',
'b1eaf736-e426-46ca-be42-f5c2db714a42')
and activeflag =1;


update meetingparticipants 
	set activeflag = 0,
	updatedby = 'CJAMS-63318',
	updatedon = now()
where meetingrecordingid in  ('371866a6-4c1d-4165-9582-ebd68ee49a80',
'b1eaf736-e426-46ca-be42-f5c2db714a42')
and activeflag =1;