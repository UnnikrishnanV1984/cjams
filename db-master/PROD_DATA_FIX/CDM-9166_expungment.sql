-- CDM-9166 Expungement
/*
-- Issue Description: 
	User request to expunge the follwoing Cases
    CPS-IR: CW2918520
	CPS-ARs: CW2870754, CW2889064, CW2893640, CW2862530, CW2895309, CW2830368, CW2894600, CW2894701   
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD, All these are overdue for expungement but batch is not removing them.
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- CPS-IR	CW2918520
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2918520'::character varying,
		null::date
	) ;


-- CPS-AR	CW2830368
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2830368'::character varying,
		null::date
	) ;

-- CPS-AR	CW2862530
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2862530'::character varying,
		null::date
	) ;

-- CPS-AR	CW2870754
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2870754'::character varying,
		null::date
	) ;

-- CPS-AR	CW2889064
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2889064'::character varying,
		null::date
	) ;

-- CPS-AR	CW2893640
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2893640'::character varying,
		null::date
	) ;

-- CPS-AR	CW2894600
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2894600'::character varying,
		null::date
	) ;

-- CPS-AR	CW2894701
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2894701'::character varying,
		null::date
	) ;

-- CPS-AR	CW2895309
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2895309'::character varying,
		null::date
	) ;


