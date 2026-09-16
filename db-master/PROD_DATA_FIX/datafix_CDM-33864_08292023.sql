-- CDM-33864- Removal of case from CJAMS
/*
-- Issue Description: 
	User request to expunge the CPS-IR CW2135035 (Converted Indicated)
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: CIS Converted Investigation with No information about maltreator or the maltreatment/allegation.
--             CJAMS is not expunging such CIS converted investigations with automated batch.
-- Fix provided: Datafix has been promoted to update the finding as Unsubstantiated and expunge the CPS case.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix has been promoted to expunge the CPS IR case. (Converted Indicated Investigations)
-- CPS-IR: CW2135035 - 03196821-08f8-440c-8138-bb688e646cb7 
-- Neglect - Indicated

select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id  = 'CW2135035' ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2135035'::character varying,
		null::date
	) ;
