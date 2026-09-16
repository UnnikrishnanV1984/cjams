-- CDM-13692 - Appealed Case
/*
-- Issue Description: 
	User request to expunge the following CPS IRs:
	CPS-IR CW2259612 (Converted Ruled Out) - afcbf8ee-0600-458a-b9cb-63aab5ed153a
	CPS-IR CW2530267 (Appealed & Unsubstantiated) - 0016c26b-19ef-49ec-96e8-330e09da74e2 (Originally Indicated)
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- CPS-IR CW2530267 (Appealed & Unsubstantiated) - 0016c26b-19ef-49ec-96e8-330e09da74e2 (Originally Indicated)
-- AM CLIENT ID: 1428679 - 813d2e65-565f-495f-8cdd-aa1e7b532d7f
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2530267'::character varying,
		null::date
	) ;

-- CPS-IR CW2259612 (Converted Ruled Out) - afcbf8ee-0600-458a-b9cb-63aab5ed153a
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2259612'::character varying,
		null::date
	) ;



