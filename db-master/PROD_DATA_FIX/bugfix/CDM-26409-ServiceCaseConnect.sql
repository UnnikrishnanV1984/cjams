-- CDM-26409-Service Case Connect 
/*
   File Name: CDM-26409-ServiceCaseConnect 
-- Issue Description: 
    For the Case number : 3033816 and Intake number S20220311045446  - 
	1) Please remove the case connect from AR case- 221020250468
	2) Remove the last change made(reopened) in decision tab and close the case - 3033816

    Customer Email ID:Susan.Tossman1@maryland.gov
  
-- Resolution: Updated the servicecaseid to null in intakeservicerequest and updated activeflag to 0  in servicecasedisposition, 

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/


-------Please remove the case connect from AR case- 221020250468-----------------------------------------
--c0158c74-ec2c-4391-ac56-11f68270ddc5
 UPDATE
	intakeservicerequest i
SET
	servicecaseid = NULL ,
	updatedby = 'CDM-26409',
	updatedon = now()
WHERE
	servicerequestnumber = '221020250468';
	

--------Remove the last change made(reopened) in decision tab and close the case - 3033816-----------------
UPDATE
	servicecasedisposition
SET
	activeflag = 0,
	updatedby = 'CDM-26409',
	updatedon = now()
WHERE
	servicecasedispositionid = 'd2f3fdb3-e718-4b48-8e76-75e763b0bcc7';

UPDATE
	servicecase
SET
	statustypekey = 'Closed',
	dispositioncode = 'Closed',
	updatedon = now(),
	updatedby = 'CDM-26409'
WHERE
	servicecaseid = 'c0158c74-ec2c-4391-ac56-11f68270ddc5';