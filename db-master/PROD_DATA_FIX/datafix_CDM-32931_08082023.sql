-- CDM-32931 - Expungement of record
/*
-- Issue Description: 
	User request to update the Finding as 'Ruled Out' and expunge the CPS-IR CW2242710 (Converted Indicated)
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: CIS Converted Investigation with No information about maltreator or the maltreatment/allegation.
-- Fix provided: Datafix has been promoted to update the finding as Unsubstantiated and expunge the CPS case.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix has been promoted to update the finding as Ruled Out and expunge the CPS case. (Converted Indicated Investigations)
-- CPS-IR: CW2242710 - 30aa99ad-2e45-4f4b-a221-9c188ec61744 
-- Converted : Neglect	Indicated

select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id  = 'CW2242710' ;

update tb_conv_inv_finding 
	set investigation_finding_cd = 'Ruled Out'
where referral_id  = 'CW2242710' ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2242710'::character varying,
		null::date
	) ;
