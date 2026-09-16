/*
 * CDM-32327 - Expungement Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * CW2290871:Please expunge this case. The Department does not have the closed record for this investigation. 
 * Assistant Deputy Director, Stephanie Cooke has approved this expungement request. 
 * Screen URL: https://cw.cjams.mdthink.maryland.gov/#/pages/case-worker/5e05fc27-0bd2-402a-9a80-0faf557cb1c5/CW2290871/dsds-action/investigation-findings
 * CASE NUMBER - CW2270818, CW2269956, CW2290871, CW2216225, CW2246429, CW2295112, CW2280234, CW2242088
 * 
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2270818'::character varying,
		null::date
	);
	
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2269956'::character varying,
		null::date
	);

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2290871'::character varying,
		null::date
	);

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2216225'::character varying,
		null::date
	);

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2246429'::character varying,
		null::date
	);

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2295112'::character varying,
		null::date
	);

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2280234'::character varying,
		null::date
	);

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2242088'::character varying,
		null::date
	);