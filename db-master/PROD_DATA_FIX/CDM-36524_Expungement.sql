-- CDM-36524- Expungement Request
/*	   
-- Root cause: CW2276103:Please expunge this investigation. The Department does not have the closed record for this investigation. Assistant Deputy Director, Stephanie Cooke has approved
-- Fix provided: Datafix has been updated to expunge the Service case # CW2276103.

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id  = 'CW2276103' ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	('IR'::character varying,
	'CW2276103'::character varying,
	null::date);