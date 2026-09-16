-- CDM-22566
/*
-- Issue Description: 
	Ruled out case   
-- Category/ Module: Expungement
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR: CW2835279
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2835279'::character varying,
		null::date
	) ;