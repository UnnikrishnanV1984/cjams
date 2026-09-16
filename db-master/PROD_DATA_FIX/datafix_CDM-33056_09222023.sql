-- CDM-33056 - SEN Milestone
/*
-- Issue Description: 
    User request to connnect Intake # I231010680593 with Service Case # 2020020201913
	and disconnect from wrong service case # 3042070

-- Client ID: 201305528 (Julio Galeano Jr) - b98a3ada-c78f-4d92-a993-43230f1e2c0f
-- Intake ID: I231010680593 (SEN Indentified in this Intake)

-- Wrong Service case # 3042070 - 8386c4ed-41f9-4001-bf32-bcc59f4ef05c

-- Correct Service Case # 2020020201913 - 2a06a833-cafb-492f-8e8f-7e20421b4886

-- Category/ Module: Case Connect (Intake Management) 
-- Root cause: User error.
-- Fix Provided: Datafix has been promoted to remove the SEN flag of Client # 201021510
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To connnect Intake with the correct Service Case (CDM-33056)
-- Update the servicecaseid as 2020020201913
select intakenumber, intakeserviceid, servicecaseid, servicerequestnumber, actiontype, activeflag, updatedby, updatedon 
	from intakeservicerequest 
where intakenumber = 'I231010680593' ;

update intakeservicerequest 
set servicecaseid = '2a06a833-cafb-492f-8e8f-7e20421b4886', -- 2020020201913
	updatedon = now(), 
	updatedby = 'CDM-33056'
where intakenumber = 'I231010680593' ;

-- Nullify the servicecaseid as all persons are there in service case # 2020020201913
select intakeservicerequestactorid, intakeserviceid, servicecaseid, 
		personid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon 
	from intakeservicerequestactor 
where intakenumber = 'I231010680593'
	and servicecaseid = '8386c4ed-41f9-4001-bf32-bcc59f4ef05c' -- 3042070
	and activeflag = 1 ;

update intakeservicerequestactor
set servicecaseid = NULL,
	updatedon = now(), 
	updatedby = 'CDM-33056'
where intakenumber = 'I231010680593'
	and servicecaseid = '8386c4ed-41f9-4001-bf32-bcc59f4ef05c' -- 3042070
	and activeflag = 1 ;

select actorid, intakeserviceid, servicecaseid, personid, activeflag, updatedby, updatedon 
	from actor
where intakenumber = 'I231010680593'
	and servicecaseid = '8386c4ed-41f9-4001-bf32-bcc59f4ef05c' -- 3042070
	and activeflag = 1 ;

update actor
set servicecaseid = NULL,
	updatedon = now(), 
	updatedby = 'CDM-33056'
where intakenumber = 'I231010680593'
	and servicecaseid = '8386c4ed-41f9-4001-bf32-bcc59f4ef05c' -- 3042070
	and activeflag = 1 ;

select personroleid, intakenumber, intakeserviceid, servicecaseid, personid, activeflag, updatedby, updatedon 
	from personrole 
where intakenumber = 'I231010680593'
	and servicecaseid = '8386c4ed-41f9-4001-bf32-bcc59f4ef05c'
	and activeflag = 1;

update personrole
set servicecaseid = NULL,
	updatedon = now(), 
	updatedby = 'CDM-33056'
where intakenumber = 'I231010680593'
	and servicecaseid = '8386c4ed-41f9-4001-bf32-bcc59f4ef05c'
	and activeflag = 1 ;

