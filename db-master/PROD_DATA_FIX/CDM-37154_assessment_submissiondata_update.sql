/*
	Issue Description: CDM-37154 - Safe-C OHP/Milestone - 3244208
	This safe-C OHP was completed for Robert Strother. 
	However the CJAMS PID that is showing is incorrect. 
	The correct PID is 3707938. 
	Is this able to be fixed or should we complete a new assessment? 
	The incorrect PID is causing it to show as not having been completed in the milestone report
	Category/ Module  : Case / Assessment
	Case#: 3244208
	Root cause: In assessment submissiondata, child cjams pid is saved as 3707939
	Fix Provided: Data fix to correct child cjams pid to 3707938
*/

update  cjams.assessment 
	set submissiondata = jsonb_set(submissiondata:: jsonb, '{clientid}', '"3707938"')
where assessmentid =  '246f2209-67b2-4858-ad7b-cbae4c35c334';

update  cjams.assessment 
	set submissiondata = jsonb_set(submissiondata:: jsonb, '{assessmentactor}', '[{"intakeservicerequestactorid": "68fafc5f-a902-427b-a45a-a6f4f3ea7d8b"}]')
where assessmentid =  '246f2209-67b2-4858-ad7b-cbae4c35c334';

UPDATE assessmentactor set intakeservicerequestactorid = '68fafc5f-a902-427b-a45a-a6f4f3ea7d8b',
		updatedon = now(),
		updatedby = 'CDM-37154'
	where assessmentactorid = '20822718-83ff-40a0-b533-0300aa5b0683'
		AND activeflag = 1;