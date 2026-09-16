-- CDM-16219 - Expungement
/*
-- Issue Description: 
	User request to expunge the CPS-AR CW2868218. 
	Reason for deletion: Investigation record has reached its record-keeping policy time. 
       
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/
	
-- CPS-AR CW2868218	- d63d85de-2914-40c8-b128-fac9d0d47139
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2868218'::character varying,
		null::date
	) ;

