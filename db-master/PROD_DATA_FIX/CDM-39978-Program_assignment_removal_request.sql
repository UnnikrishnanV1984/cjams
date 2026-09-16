/*
 * CDM-39978 - Program Assignment Removal Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description - Please remove CIS # 30978192 program assignment from CJAMS investigation # CW2261144. 
 * Assistant Deputy Director, Stephanie Cooke has approved this request.
 * data fix for expunging the case
 * 
 */

 select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2261144'::character varying,
		null::date
 	) ;