-- CDM-32376 - Expungement
/*
-- Issue Description: 
	User request to expunge the CPS-IR CW2052897 (Converted Indicated Investigations)
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: CIS Converted Investigation with No information about maltreator or the maltreatment/allegation.
--			   CJAMS is not expunging such converted investigations with automated batch.
-- Fix provided: Datafix has been promoted to expunge the CPS IR case.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To expunge the Converted CPS IR cases (CDM-32376)

-- Datafix has been promoted to expunge the requested CPS-IR case (Converted Indicated Investigations)
-- CPS-IR: CW2052897 - 30eb3b0f-de59-4bbd-b48b-a2ce730c1aa6
-- Physical Abuse - Indicated

select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id = 'CW2052897' ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2052897'::character varying,
		null::date
	) ;

