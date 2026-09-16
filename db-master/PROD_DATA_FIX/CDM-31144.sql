/*
 * CDM-31144 - can't expunge case
 * Customer Email ID:elizabeth.long@maryland.gov
 * Description - CW2108822:Trying to expunge old case from 1988, 
 * no appeals/ expungement tab in investigation findings. Have verified with old records that case was expunged manually; need to expunge case.
 * IR Case -  CW2108822 for   Expungement. 
 * 
 */


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2108822'::character varying,
		null::date
	) ;
