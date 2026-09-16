/*
 * CDM-39393 - Program Assignment Removal Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description Please remove CIS # 030613109 program assignment from CJAMS investigation # CW2253543 and CW2253544. 
        The Department does not have the closed records for these investigations. 
          Assistant Deputy Director, Stephanie Cooke has approved this request. 
 */


select vl_sqlcode, vs_err_message
   from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2253543'::character varying,
		null::date
 	) ;

select vl_sqlcode, vs_err_message
   from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2253544'::character varying,
		null::date
 	) ;
 