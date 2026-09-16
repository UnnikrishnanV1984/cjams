-- CDM-24387 --case-not-expunged
/*
-- Issue Description: 
   Case needs to be removed  
 
-- Category/ Module: Removal (Case Management) 
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS AR: CW2843455 - 28625925-3af6-4ad1-96d8-175c43fb539f

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2843455'::character varying,
		null::date
	) ;