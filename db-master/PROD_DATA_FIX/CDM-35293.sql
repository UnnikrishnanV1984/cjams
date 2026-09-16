/*
 * CDM-35293 - Expungement Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Case CW2279867
 */

 --select * from tb_conv_inv_finding where referral_id = 'CW2279867';

UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Unsubstantiated' 
where referral_id='CW2279867'; 

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2279867'::character varying,
		null::date
	) ; 