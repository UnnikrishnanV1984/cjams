-- CDM-15410 - Expungement
/*
-- Issue Description: 
	User request to expunge the CPS-AR CW2857191. 
	Reason for deletion: Investigation record has reached its record-keeping policy time. 
       
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/
	
-- CPS-AR CW2857191	- 80aafbac-3df7-403c-83b8-84987e7ec890
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2857191'::character varying,
		null::date
	) ;
