-- CDM-36578 - Case removal
/*
-- Issue Description: 
	User request to expunge the CPS-IR CW2807085, CW2136678 and 20200262035952
	Reason for deletion: Investigation record has reached its record-keeping policy time. 
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR CW2807085
-- CPS-IR CW2929185
-- CPS-IR 20200262035952


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2807085'::character varying,
		null::date
 	) ;
 	
 select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2929185'::character varying,
		null::date
 	) ;
 	
 select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'20200262035952'::character varying,
		null::date
 	) ;