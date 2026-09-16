-- CDM-33962 - Expungement Request
/*
-- Issue Description: 
	User requested to expunge the CW2269742
	   
-- Root cause: The Department does not have the closed record for this investigation.
-- Fix provided: Datafix has been updated to expunge the Service case # CW2269742.

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Backup
select referral_id, maltreatment_type_cd, investigation_finding_cd from tb_conv_inv_finding where referral_id  = 'CW2269742';

-- Update
select vl_sqlcode, vs_err_message from cjams.expungcaserequest ('IR'::character varying,'CW2269742'::character varying,null::date);