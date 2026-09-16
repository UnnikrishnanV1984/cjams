-- CDM-30669 - Modify Finding
/*
-- Issue Description: 
	User request to update the Finding as 'Unsubstantiated' and expunge the CPS-IR CW2291541 (Converted Indicated)
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: CIS Converted Investigation with No information about maltreator or the maltreatment/allegation.
-- Fix provided: Datafix has been promoted to update the finding as Unsubstantiated and expunge the CPS case.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Change the Finding to Unsubstantiated (old value was Indicated)	
select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id  = 'CW2291541' ;

update tb_conv_inv_finding 
	set investigation_finding_cd = 'Unsubstantiated'
where referral_id  = 'CW2291541' ;

-- CPS IR: CW2291541 - b90ad51c-6a36-4014-8621-967c04f1ba82
-- Converted : Neglect	Indicated

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2291541'::character varying,
		null::date
	) ;
