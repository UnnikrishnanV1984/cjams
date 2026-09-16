-- CJAMS-61837  Expungement Request
/*
-- Issue Description: 
	User request to expunge the following CPS IRs:
	CW2270975
	
	Reason for deletion: 
	Therefore, the record needs to be deleted in CJAMS. 
	NOTE: the record has been approved by SSA.
       
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: expunge the CPS IR # CW2270975
-- Pull request# Data fix has been done to expunge the CPS IR # CW2270975 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2270975'::character varying,
		null::date
	) ;