-- CDM-16818 - Record deletion
/*
-- Issue Description: 
	User request to expunge the following CPS-IR cases (Converted Indicated Investigation)
	CW2179115, CW2164690, CW2140406 and CW2175308
	Reason for deletion: CPS IR cases need to be expunged as they met 25 years timeline.
		   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR CW2140406	- e721b13c-993e-48e3-862e-1aec7479dee9
-- CPS-IR CW2164690	- 79db8a82-c211-4ff1-bba0-d9ab5802c214
-- CPS-IR CW2175308	- 03c017ed-0699-4cee-a00f-62cac1c239a4
-- CPS-IR CW2179115	- cb657d94-92ce-4139-8d2c-69ba01853a71
-- with NO Maltreatment/Allegation & Findings (migrated data).

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2140406'::character varying,
		null::date
	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2164690'::character varying,
		null::date
	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2175308'::character varying,
		null::date
	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2179115'::character varying,
		null::date
	) ;
