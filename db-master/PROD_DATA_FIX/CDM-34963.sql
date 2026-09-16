/*
 * CDM-34963 - expungement
 * Customer Email ID:joann.gochnour@maryland.gov
 * Customer Name:Joann Gochnour
 * Focus Area:Decision
 * Description - 231021091029:The supervisor, Tracy Bosick has requested this AR be expunged. 
 * expunge the CPS AR Case # 231021091029 as requested.
 * 
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
    (    'AR'::character varying,
        '231021091029'::character varying,
        null::date
    );
    