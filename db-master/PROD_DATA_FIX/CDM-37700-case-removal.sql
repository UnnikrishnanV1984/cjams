-- CDM-37700- Expungement Request
/*
-- Root cause: User requested to expunge the case.
-- Fix provided: Datafix has been updated to expunge the Service case # CW2490805.

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id  = 'CW2490805' ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2490805'::character varying,
		null::date
	);