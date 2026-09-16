-- CDM-26139 - the case was settled
/*
-- Issue Description: 
	1. User request to update the Finding as 'Unsubstantiated' and expunge the CPS-IR CW2221829 
	2. User request to update the Finding as 'Ruled Out' and expunge the CPS-IR CW2278237
	
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: For Converted Investigations there is no option to change the Finding.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Change the Finding to Ruled Out (old value was Indicated)	
select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id  = 'CW2221829' ;

update tb_conv_inv_finding 
	set investigation_finding_cd = 'Unsubstantiated'
where referral_id  = 'CW2221829' ;

-- CPS IR: CW2221829
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2221829'::character varying,
		null::date
	) ;

-- Change the Finding to Ruled Out (old value was Indicated)	
select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id  = 'CW2278237' ;

update tb_conv_inv_finding 
	set investigation_finding_cd = 'Ruled Out'
where referral_id  = 'CW2278237' ;

-- CPS IR: CW2278237
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2278237'::character varying,
		null::date
	) ;