-- CDM-21200 - Access Error
/*
-- Issue Description: 
-- User request to update the finding to unsubstantiated and also be expunged.

-- CPS IR: CW2042600 - 8ce2441e-84c1-45bf-82ec-b4bd7e1be43f
-- Converted : Physical Abuse - Indicated
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: For Converted Investigations there is no option to change the Finding.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR: CW2042600 - 8ce2441e-84c1-45bf-82ec-b4bd7e1be43f
-- Converted : Physical Abuse - Indicated

-- Change the Finding to Unsubstantiated (old value was Indicated)	
select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id  = 'CW2042600' ;

update tb_conv_inv_finding 
	set investigation_finding_cd = 'Unsubstantiated'
where referral_id  = 'CW2042600' ;

-- with NO Maltreatment/Allegation & Findings (migrated data).
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2042600'::character varying,
		null::date
	) ;
