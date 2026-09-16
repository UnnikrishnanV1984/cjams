-- CJAMS-60402 - Modification of Finding
/*
-- Issue Description: 
	User request to update the Finding as 'Unsubstantiated' for CPS-IR CW2257895 and expunge the case
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: CIS Converted Investigation with No information about maltreator or the maltreatment/allegation.
-- Fix provided: Datafix has been promoted to update the finding as Unsubstantiated.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix has been promoted to update the finding as Unsubstantiated and expunge the case
-- Neglect - Indicated

update tb_conv_inv_finding 
	set investigation_finding_cd = 'Unsubstantiated'
where referral_id  = 'CW2257895';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2257895'::character varying,
		null::date
 	) ;