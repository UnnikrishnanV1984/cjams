-- CDM-16648 - June Thornton
/*
-- Issue Description: 
	User request to expunge the following CPS-IR cases (Converted Indicated Investigation)
	CW2258915, CW2258916, CW2258917, CW2258918 and CW2258919
	Reason for deletion: Investigation record has reached its record-keeping policy time. 
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR	CW2258915	3516bfca-6163-4253-ab16-f7b8cc522a0b
-- CPS-IR	CW2258916	1cffedcc-3a0c-47e6-b4f2-983b8b72884a
-- CPS-IR	CW2258917	688f31a2-f0d9-4f3c-ad28-03bc54222af1
-- CPS-IR	CW2258918	3ae1b361-4c28-48ff-b769-12da0926125f
-- CPS-IR	CW2258919	a401a9aa-c516-4df2-8b3e-bd2bb473be10
-- with NO Maltreatment/Allegation & Findings (migrated data).

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2258915'::character varying,
		null::date
	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2258916'::character varying,
		null::date
	) ;
	
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2258917'::character varying,
		null::date
	) ;
	
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2258918'::character varying,
		null::date
	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2258919'::character varying,
		null::date
	) ;	
	