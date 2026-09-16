/*
-- Issue Description: CW2913206:Case should of been expunged 5/29/2023.  
-- Root cause: Change requested by user.
-- Fix Provided: Called expungcaserequest store proc.
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2913206'::character varying,
		null::date
	) ;