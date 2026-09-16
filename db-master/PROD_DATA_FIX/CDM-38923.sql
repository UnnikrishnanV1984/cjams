/*
 * CDM-38923 - Expungement
 * Customer Email ID:tammy.hoffman@maryland.gov
 * Focus Area:Case Timeline
 * Description - CW2947773:Case should have been expunged 11/26/2021
 * 
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2947773'::character varying,
		null::date
	) ;
    