-- CDM-17104 - Expungment
/*
-- Issue Description: 
	User request to expunge the following CPS-IR cases (Converted Indicated Investigation)
	CW2080724 and CW2080725
	Reason for deletion: CPS IR cases need to be expunged as they met 25 years timeline.
		   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR: CW2080724 - a465b82d-9577-4cc4-9e16-d941f58e77b6
-- CPS-IR: CW2080725 - cdd0d6fa-bbc1-4ec9-a697-083f94b04f78
-- with NO Maltreatment/Allegation & Findings (migrated data).

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2080724'::character varying,
		null::date
	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2080725'::character varying,
		null::date
	) ;

