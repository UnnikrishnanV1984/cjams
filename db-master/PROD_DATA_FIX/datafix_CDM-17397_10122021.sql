-- CDM-17397 - Expungement
/*
-- Issue Description: 
	User request to expunge the following CPS cases (Converted Investigations)
	CW2384038, CW2931868 & CW2876673
		   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR - CW2384038 - 35bd3d20-0aa0-4dca-aa67-db46dea5076a
-- CPS-IR - CW2931868 - cced235c-42d4-47e7-a1e6-cc2c55e2c462
-- CPS-AR - CW2876673 - 40ed0463-8b27-4249-9752-4fdef1f6ecfe

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2384038'::character varying,
		null::date
	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2931868'::character varying,
		null::date
	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2876673'::character varying,
		null::date
	) ;
