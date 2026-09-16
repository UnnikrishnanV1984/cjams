-- CDM-32823 - Modify Finding Request
/*
-- Issue Description: 
	User request to update the Finding as 'Unsubstantiated' for CPS-IR CW2291536 (Converted Indicated)
	   
-- CPS-IR: CW2291536 - 7b5e7244-3b42-44d9-8f8b-27ef67897b42 
-- Neglect - Indicated
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: For Converted Investigations there is no option to change the Finding.
-- Fix Provided: Datafix has been promoted to update the Finding as 'Unsubstantiated' for CPS-IR CW2291536 (Converted Indicated)
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR: CW2291536 - 7b5e7244-3b42-44d9-8f8b-27ef67897b42 
-- Neglect - 
-- To change the Finding as Unsubstantiated (old value was Indicated)	

select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id  = 'CW2291536' ;

update tb_conv_inv_finding 
	set investigation_finding_cd = 'Unsubstantiated'
where referral_id  = 'CW2291536' ;

