-- CDM-21888 - Expungement
/*
-- Issue Description: 
	User request to update the Finding as 'Ruled Out' and expunge the CPS-IR CW2220090 (Converted Indicated)
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: For Converted Investigations there is no option to change the Finding.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Change the Finding to Ruled Out (old value was Indicated)	
select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id  = 'CW2220090' ;

update tb_conv_inv_finding 
	set investigation_finding_cd = 'Ruled Out'
where referral_id  = 'CW2220090' ;

-- CPS IR: CW2220090 - 15b50b4b-4c91-43be-b905-ffa5bc33ff2d
-- Converted : Neglect - Indicated	
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2220090'::character varying,
		null::date
	) ;

