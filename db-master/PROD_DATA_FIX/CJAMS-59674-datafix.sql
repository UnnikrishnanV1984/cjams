 -- CJAMS-59674 Expungement Request
/*
-- Issue Description: 
	User request to expunge the CPS-IR CW2275555 and CW2275557
	Reason for deletion: Investigation record has reached its record-keeping policy time. 
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: User requested to expunge the case
-- Resolution: Provided a data fix for expunging the case
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR CW2275555 and CW2275557


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2275555'::character varying,
		null::date
 	);


     select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2275557'::character varying,
		null::date
 	);