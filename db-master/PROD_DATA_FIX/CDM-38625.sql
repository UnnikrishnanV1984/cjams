/*
 * CDM-38625 - Program Assignment Removal Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description - CW2236793:Please remove CIS# 30508842 program assignment from CJAMS investigation # CW2236793. 
 * Assistant Deputy Director, Stephanie Cooke has approved this request.
 * data fix for expunging the case
 * 
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
    (   'IR'::character varying,
        'CW2236793'::character varying,
        null::date
    ) ;
    