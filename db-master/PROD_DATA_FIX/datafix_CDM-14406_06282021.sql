-- CDM-14406 - Record deletion
/*
-- Issue Description: 
	User request to expunge the CPS-IR CW2133018 (Converted Indicated)
	Reason for deletion: the investigation record has reached its 25 years of record-keeping policy. 
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: For Converted Investigations there is no option to change the Finding.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR - CW2133018 - 447600ab-d345-40f7-85b9-f14a8e207a04 - Converted Indicated
-- with NO Maltreatment/Allegation & Findings (migrated data).
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2133018'::character varying,
		null::date
	) ;
