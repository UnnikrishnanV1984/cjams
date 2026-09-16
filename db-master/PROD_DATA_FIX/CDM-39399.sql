/*
 * CDM-39399 - Program Assignment Removal Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description - Dashboard:Please remove CIS #s 030091472 and 30091472 program assignments from CJAMS 
 * investigations CW2278105 and CW2226101. The Department does not have the closed records for the investigations. 
 * Assistant Deputy Director, Stephanie Cooke has approved this request.

 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
    (    'IR'::character varying,
        'CW2278105'::character varying,
        null::date
    );
    
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
    (    'IR'::character varying,
        'CW2226101'::character varying,
        null::date
    );
