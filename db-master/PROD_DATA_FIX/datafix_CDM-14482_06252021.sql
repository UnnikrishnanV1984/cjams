-- CDM-14482 - Jacia Bell
/*
-- Issue Description: 
	User request to update the Finding as 'Unsubstantiated' and expunge the CPS-IR CW2244681 (Converted Indicated)
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: For Converted Investigations there is no option to change the Finding.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Change the Finding to Unsubstantiated (old value was Indicated)	
select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id  = 'CW2244681' ;

update tb_conv_inv_finding 
	set investigation_finding_cd = 'Unsubstantiated'
where referral_id  = 'CW2244681' ;

-- CPS-IR - CW2244681 - 87bf751f-f986-4983-a326-eb1d56f27799 - Converted Indicated
-- with NO Maltreatment/Allegation & Findings (migrated data).
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2244681'::character varying,
		null::date
	) ;
