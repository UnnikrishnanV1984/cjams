 --CJAMS-59663 Expungement Request
/*
-- Issue Description: 
	User request to expunge the CPS-IR CW2265417, CW2265415, and CW2211007.
	Reason for deletion: Investigation record has reached its record-keeping policy time. 
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: User requested to expunge the case
-- Resolution: Provided a data fix for expunging the case
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR CW2265417, CW2265415, and CW2211007.


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2265417'::character varying,
		null::date
 	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2265415'::character varying,
		null::date
 	) ;


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2211007'::character varying,
		null::date
 	) ;