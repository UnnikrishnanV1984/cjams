-- CDM-33950 - Expungement Request
/*
-- Issue Description: 
   User request to expunge the CPS-IR CW2229397 (Converted Indicated)
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: CIS Converted Investigation with No information about maltreator or the maltreatment/allegation.
--             CJAMS is not expunging such CIS converted investigations with automated batch.
-- Fix provided: Datafix has been promoted to expunge the requested CPS case.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix has been promoted to expunge the reuested CPS IR case. (Converted Indicated Investigations)
-- CPS-IR: CW2229397 - b1b55cb1-6dc5-4023-8711-1fb71a5b0dec 
-- Neglect - Indicated

select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id = 'CW2229397' ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2229397'::character varying,
		null::date
	) ;
