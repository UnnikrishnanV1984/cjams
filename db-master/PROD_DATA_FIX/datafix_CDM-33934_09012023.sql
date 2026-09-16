-- CDM-33934 - Modification of Finding
/*
-- Issue Description: 
	User request to update the Finding as 'Unsubstantiated' for CPS-IR CW2291542 (Converted Indicated CPS)
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: CIS Converted Investigation with No information about maltreator or the maltreatment/allegation.
-- Fix provided: Datafix has been promoted to update the finding as Unsubstantiated.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix has been promoted to update the finding as Unsubstantiated (Converted Indicated Investigations)
-- CPS-IR: CW2291542 - 22fb2c72-e3f4-4db9-8992-4d42c4565c8b 
-- Neglect - Indicated


select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id  = 'CW2291542' ;

update tb_conv_inv_finding 
	set investigation_finding_cd = 'Unsubstantiated'
where referral_id  = 'CW2291542' ;
