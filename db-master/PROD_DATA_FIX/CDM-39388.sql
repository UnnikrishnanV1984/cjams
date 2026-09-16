/*
 * CDM-39388 - Program Assignment Removal Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description - Dashboard:Please remove CIS # 030843801 program assignment from CJAMS 
 * investigation # CW2250736, CW2272318, and CW2250737. The Department does not have the 
 * closed records for the investigations. Assistant Deputy Director, Stephanie Cooke has approved this request.
 * proceed with the requested data fix.
 * 
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
    (    'IR'::character varying,
        'CW2250736'::character varying,
        null::date
    );
    
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
    (    'IR'::character varying,
        'CW2272318'::character varying,
        null::date
    );
    
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
    (    'IR'::character varying,
        'CW2250737'::character varying,
        null::date
    );   