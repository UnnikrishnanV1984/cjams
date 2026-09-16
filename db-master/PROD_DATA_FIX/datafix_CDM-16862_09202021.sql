-- CDM-16862 - Case Numbers: 2277082 and 2213428
/*
-- Issue Description: 
	User request to expunge the following CPS-IR cases (Converted Indicated Investigation)
	CW2264295 and CW2277082
	Reason for deletion: the permanent record has not be found in closed records.
		   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR	CW2264295	1f8774f2-a908-450e-8656-7a2beb96601e
-- CPS-IR	CW2277082	52a9ff9e-6db9-438d-b6a3-125fcbaaa1a3
-- with NO Maltreatment/Allegation & Findings (migrated data).

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2264295'::character varying,
		null::date
	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2277082'::character varying,
		null::date
	) ;
