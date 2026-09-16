-- CDM-14492 - Isabell Liverpool
/*
-- Issue Description: 
	User request to update the Finding as 'Unsubstantiated' and expunge the CPS-IR CW2213886 (Converted Indicated)
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: For Converted Investigations there is no option to change the Finding.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Change the Finding to Unsubstantiated (old value was Indicated)	
select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id  = 'CW2213886' ;

update tb_conv_inv_finding 
	set investigation_finding_cd = 'Unsubstantiated'
where referral_id  = 'CW2213886' ;

-- CPS-IR - CW2213886 - 12e8fad1-b51b-4bc9-9fb6-22b8970fb8a1 - Converted Indicated
-- with NO Maltreatment/Allegation & Findings (migrated data).
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2213886'::character varying,
		null::date
	) ;
