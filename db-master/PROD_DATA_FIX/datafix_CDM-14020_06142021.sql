-- CDM-14020 - Unsub. Finding
/*
-- Issue Description: 
	User request to expunge the following CPS IR:
	CW2860603:This case was unsubstantiated & should have been expunged by now, per COMAR.
	(Original Finding was Indicated)
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- CPS-IR  CW2860603 - d3809d21-7226-4046-84ae-f35d80412601 (Originally Indicated)
-- AM CLIENT ID: 3924893 - 2d479d2c-c6a2-4e5a-a024-65fe2ca93e03
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2860603'::character varying,
		null::date
	) ;

