-- CDM-30025 - Expungement Request
/*
-- Issue Description: 
	User request to expunge the CPS-IR CW2176215 (Converted Indicated)
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: CIS Converted Investigation with No information about maltreator or the maltreatment/allegation.
--			   CJAMS is not expunging such converted investigations with automated batch.
-- Fix provided: Datafix has been promoted to expunge the CPS IR case.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
--select actiontype, * from intakeservicerequest where servicerequestnumber ='CW2176215';

-- To expunge the Converted CPS IR case (CDM-30025)
select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id  = 'CW2176215' ;

-- CPS IR: CW2176215 - 0597e13a-a8a0-4a6c-bc01-95eb90a27f8f
-- Converted : Physical Abuse	Indicated

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2176215'::character varying,
		null::date
	) ;