-- CDM-12481 - Expungement
/*
-- Issue Description: 
	User request to expunge the following CPS IRs:
	CPS-AR: CW2847279, CPS-IR: CW2384046 & CPS-IR: CW2085725
	All should have been expunged by now as per COMAR
       
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- CPS-AR: CW2847279 - 07bda4ed-7d4c-4b11-9781-1a36985752ff
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2847279'::character varying,
		null::date
	) ;

-- CPS-IR: CW2085725 - d26d6b41-3977-4b25-b9de-409d9ae770f4
-- Converted Data no AM
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2085725'::character varying,
		null::date
	) ;

-- CPS-IR: CW2384046 - f641b89f-cd2a-468d-8efd-bf018aa4aece
-- AM CLIENT ID: 1253968 (DONALD W SOCKS) - 743a67ba-ebde-4217-addf-52a24997b1da
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2384046'::character varying,
		null::date
	) ;

