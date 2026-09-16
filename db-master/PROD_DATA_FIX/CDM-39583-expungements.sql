-- CDM-39583 - Expungements
/*
-- Issue Description: 
	User request To Expunge CPS Case CW2213097,CW2243907,CW2243905,CW2217627,CW2217626

-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Fix Provided: Datafix has been promoted to expunge CPS-IR # CW2213097,CW2243907,CW2243905,CW2217627,CW2217626
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2213097'::character varying,
		null::date
	);
	
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2243907'::character varying,
		null::date
	);

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2243905'::character varying,
		null::date
	);

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2217627'::character varying,
		null::date
	);

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2217626'::character varying,
		null::date
	);
