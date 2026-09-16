-- CDM-13698 - Modified Finding
/*
-- Issue Description: 
	User request to update the Finding as 'Ruled Out' and expunge the CPS-IR CW2264208 (Converted Indicated)
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: For Converted Investigations there is no option to change the Finding.
-- 		CPS-IR with NO Maltreatment/Allegation & Findings (migrated data).
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Change the Finding to Ruled Out (old value was Indicated)	
select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id  = 'CW2264208' ;

update tb_conv_inv_finding 
	set investigation_finding_cd = 'Ruled Out'
where referral_id  = 'CW2264208' ;

-- CPS-IR - CW2264208 - 8ad8fd3d-9cbb-4b67-8a42-7bfddce2b43e - Converted Indicated
-- Converted Data no AM
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2264208'::character varying,
		null::date
	) ;

