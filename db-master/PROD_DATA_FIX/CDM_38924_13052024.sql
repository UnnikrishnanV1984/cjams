-- CDM-38924 
/*
Issue Description:
    User request for Expungement 
    CW2919922 - Case should have been expunged 11/26/2021.

-- Category/Module: Inake/Investigation (Expungement)
-- Root cause: TBD, CJAMS system is working as expected.
-- Pull Request: TBD
-- Reason: Case has been ruled out
-- Reason why no related code fix: N/A 

*/

-- CPS-IR CW2919922 
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
    (
        'IR'::character varying,
        'CW2919922'::character varying,
        null::date
    );