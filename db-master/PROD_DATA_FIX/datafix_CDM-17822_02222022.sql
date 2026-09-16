-- CDM-17822 Incorrect finding
/*
-- Issue Description: 
	User request to update the Finding as 'Ruled Out' and expunge the CPS-IR CW2157504 (Converted Indicated)
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: For Converted Investigations there is no option to change the Finding.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Change the Finding to Ruled Out (old value was Indicated)	
select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id  = 'CW2157504' ;

update tb_conv_inv_finding 
	set investigation_finding_cd = 'Ruled Out'
where referral_id  = 'CW2157504' ;

-- CPS IR: CW2157504 - 4fb6288d-9db3-48ff-9c1d-803724c04366
-- Converted : Neglect - Indicated	
-- with NO Maltreatment/Allegation & Findings (migrated data).
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2157504'::character varying,
		null::date
	) ;
