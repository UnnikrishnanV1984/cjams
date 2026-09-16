-- CJAMS-59618  Finding Modification
/*
--	Issue Description: 
	User requested to 
-- Category/ Module: Contact Notes 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to add the contact note in the case
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update tb_conv_inv_finding
set investigation_finding_cd = 'Unsubstantiated'
where referral_id = 'CW2221725';

update investigationfinding
  set investigationfindingtypekey = 'UD',
      updatedby = 'CJAMS-59618',
      updatedon = now()
where investigationallegationid ='8320887a-64e4-4905-af9a-e40e46875b37'
and personid ='6f6bc8e3-ddee-437f-8259-03a8e7f1d525' and activeflag = 1; 


