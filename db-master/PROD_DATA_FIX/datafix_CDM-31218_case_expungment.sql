-- CDM-31218 - Modified Finding
/*
-- Issue Description: 
	User request to update the Finding as 'Unsubstantiated' and expunge the CPS-IR CW2246281 (Converted Indicated)
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: For Converted Investigations there is no option to change the Finding.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Change the Finding to Ruled Out (old value was Indicated)	
select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id  = 'CW2246281' ;

update tb_conv_inv_finding 
	set investigation_finding_cd = 'Unsubstantiated'
where referral_id  = 'CW2246281' ;

-- CPS IR: CW2246281 - b6fea289-5be9-43f8-967b-41432afab1a7
-- Converted : Physical Abuse - Indicated	

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2246281'::character varying,
		null::date
	) ;
