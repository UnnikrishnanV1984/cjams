/*
 * CDM-31416 - CPS Record Expungement
 * Customer Email ID:stephanie.cooke1@maryland.gov
 * Customer Name:Stephanie Cooke
 * CW2211734:The Agency is unable to locate the record for this investigation. 
 * Please expunge this record from CJAMS per Stephanie Cooke, Assistant Deputy Director. Thank you
 * CASE NUMBER - CW2211733, CW2211734, CW2211735, CW2211736
 * 
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2211733'::character varying,
		null::date
	);
	
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2211734'::character varying,
		null::date
	);
	
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2211735'::character varying,
		null::date
	);
	
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2211736'::character varying,
		null::date
	);