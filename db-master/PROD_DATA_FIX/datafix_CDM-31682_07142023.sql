-- CDM-31682 - Expungement Request
/*
-- Issue Description: 
	User request to expunge the CPS-IR CW2233997 & CW2211437 (Converted Indicated Investigations)
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: CIS Converted Investigation with No information about maltreator or the maltreatment/allegation.
--			   CJAMS is not expunging such converted investigations with automated batch.
-- Fix provided: Datafix has been promoted to expunge the CPS IR case.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To expunge the Converted CPS IR cases (CDM-31682)

-- Datafix has been promoted to expunge the requested CPS-IR cases. (Converted Indicated Investigations)
-- CPS-IR: CW2233997 -  71bb58a4-c0d3-41c3-83e8-863a20177b04 
-- Physical Abuse - Indicated

-- CPS-IR: CW2211437 - 72680089-edc1-4827-838f-61bb24ef1be4
-- Neglect - Indicated

select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id in ('CW2233997', 'CW2211437') ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2233997'::character varying,
		null::date
	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2211437'::character varying,
		null::date
	) ;
