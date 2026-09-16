-- CDM-13691 - Finding modified on appeal
/*
-- Issue Description: 
	User request to expunge the following CPS IRs:
	CW2497459 CPS-IR & CW2138544 CPS-IR - Converted Indicated
	
	The finding for this case was modified by the Administrative Law Judge after an appeal. 
	This is an old case and it needs to be expunged due to the Unsubstantiated finding. 
       
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/
	
-- CPS-IR - CW2138544 - 28658dd6-7fcb-49bb-b0d7-cb626fc93bba - Converted Indicated
-- Converted Data no AM
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2138544'::character varying,
		null::date
	) ;

-- CPS-IR - CW2497459 - f963f1a6-bca4-453e-8ab0-8c1517b3b80c
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2497459'::character varying,
		null::date
	) ;
