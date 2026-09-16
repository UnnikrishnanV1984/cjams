-- CDM-18581 - Expungements
/*
-- Issue Description: 
	User request To Expunge the follwoing CPS Cases

	CPS-AR	CW2876673	40ed0463-8b27-4249-9752-4fdef1f6ecfe
	CPS-AR	CW2897088	b457315c-09ee-4f04-a0cb-7fdf346be0cc
	CPS-AR	CW2897814	5ab57a1b-adf9-4770-a4be-a24ba1b4acc1
	CPS-IR	CW2384038	35bd3d20-0aa0-4dca-aa67-db46dea5076a
	CPS-IR	CW2931868	cced235c-42d4-47e7-a1e6-cc2c55e2c462

-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: MD CHESSSIE migrated CPS-AR & IR cases, which are not qualifying for the auto expungement in CJAMS.
-- Fix Provided: Datafix has been promoted to expunge the requested CPS caes.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-AR CW2876673	40ed0463-8b27-4249-9752-4fdef1f6ecfe
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2876673'::character varying,
		null::date
	) ;
	
-- CPS-AR	CW2897088	b457315c-09ee-4f04-a0cb-7fdf346be0cc
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2897088'::character varying,
		null::date
	) ;
	
-- CPS-AR	CW2897814	5ab57a1b-adf9-4770-a4be-a24ba1b4acc1	
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2897814'::character varying,
		null::date
	) ;

-- CPS-IR	CW2384038	35bd3d20-0aa0-4dca-aa67-db46dea5076a
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2384038'::character varying,
		null::date
	) ;

-- CPS-IR	CW2931868	cced235c-42d4-47e7-a1e6-cc2c55e2c462
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2931868'::character varying,
		null::date
	) ;
