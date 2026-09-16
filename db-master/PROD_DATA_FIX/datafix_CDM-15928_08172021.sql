-- CDM-15928 - Record deletion

/*
-- Issue Description: 
	User request to expunge the CPS-IR CW2128606 (Converted Indicated Investigation)
	Reason for deletion: Investigation record has reached its record-keeping policy time. 
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR CW2128606	- 33fc372f-cc2b-4972-9733-5f70313a4b18
-- with NO Maltreatment/Allegation & Findings (migrated data).

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2128606'::character varying,
		null::date
	) ;
