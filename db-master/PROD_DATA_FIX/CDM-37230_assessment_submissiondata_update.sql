/*
	Issue Description: CDM-37230 - safe-c/milestone - 3265519
	This is a new case with the same issue I put a ticket in for a few days ago (S2024043056937).
	The child in this safe-c OHP is Dontae Myers. His PID is 3822820, but that is not the PID that is showing in the safe-c. 
	I believe this is also causing the milestone report to not show Dontae's correct safe-c OHP date
	Category/ Module  : Case / Assessment
	Case#: 3265519 (311c1547-939b-4dd3-9aa9-447304be62da)
	Root cause: In assessment submissiondata, child cjams pid is saved as 3707939
	Fix Provided: Data fix to correct child cjams pid to 3707938
*/

-- Only one assessment has this issue for this case
select 	assessmentid, submissiondata ->> 'ClientName' as ClientName, 
		p.firstname || ' ' || p.lastname as personname, submissiondata ->> 'clientid' as clientid
	from assessment a
		join person p on p.cjamspid =  (submissiondata ->> 'clientid')::integer
	where a.assessmenttemplateid = 'f6e4c466-72ae-4453-9997-a2a12fcf8035'
		and a.objectid = '311c1547-939b-4dd3-9aa9-447304be62da'
		and (p.firstname || ' ' || p.lastname) != submissiondata ->> 'ClientName'
		and a.activeflag = 1;

update  cjams.assessment 
	set submissiondata = jsonb_set(submissiondata:: jsonb, '{clientid}', '"3822820"')
where assessmentid =  '18f5dc13-6b41-4092-acc6-5a7c43b763b7';

select * from intakeservicerequestactor  where servicecaseid = '311c1547-939b-4dd3-9aa9-447304be62da' 
	and personid in (select personid from person where cjamspid = 3822820);
	
update  cjams.assessment 
	set submissiondata = jsonb_set(submissiondata:: jsonb, '{assessmentactor}', '[{"intakeservicerequestactorid": "c8d078fe-ce09-46aa-b6cc-63dc09158fe7"}]')
where assessmentid =  '18f5dc13-6b41-4092-acc6-5a7c43b763b7';

UPDATE assessmentactor set intakeservicerequestactorid = 'c8d078fe-ce09-46aa-b6cc-63dc09158fe7',
		updatedon = now(),
		updatedby = 'CDM-37230'
	where assessmentactorid = '18f5dc13-6b41-4092-acc6-5a7c43b763b7'
		AND activeflag = 1;