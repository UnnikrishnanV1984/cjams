/*
-- CDM-28529 - Expungement 
-- Issue Description: 
	Dashboard:This is another record that should be expunged.
	CW2936678, 2897814; 2897088; 2876673; 2931868; 2384038, CW2949248
		   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2936678'::character varying,
		null::date
	);
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2949248'::character varying,
		null::date
	);	
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2897814'::character varying,
		null::date
	);
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2897088'::character varying,
		null::date
	);	
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2876673'::character varying,
		null::date
	);	
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2931868'::character varying,
		null::date
	);	