/*
 * CDM-39529 - Program Assignment Removal Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description - Dashboard:remove CIS # 030788812 program assignment from CJAMS investigation # 
 * CW2223917 and CW2223916. The Department does not have the closed record for the investigations. 
 * Assistant Deputy Director, Stephanie Cooke has approved this request.
 * 
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2223917'::character varying,
		null::date
	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2223916'::character varying,
		null::date
	) ;