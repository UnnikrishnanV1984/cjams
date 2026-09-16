/*
-- Issue Description: 
	CDM-29913-head-of-household-has-disappeared
	 Category/ Module: 
     -- Root cause: User Request
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/


update intakeservicerequestactor set isheadofhousehold=true, updatedby='CDM-29913', updatedon=now() where
servicecaseid='17fce8aa-8aa8-496a-809c-993cc29e8d8a'  and personid='f715620c-c4ba-4781-81d8-860c0a15abff' and intakeservicerequestactorid='aed3f230-5c9b-448a-bdde-23645d0ede11';