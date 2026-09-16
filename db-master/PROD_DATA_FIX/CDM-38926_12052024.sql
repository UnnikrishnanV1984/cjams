-- CDM-38926 
/*
Issue Description:
    User request for Expungement 
    CW2917472 - Case should have been expunged 11/26/2021.

-- Category/Module: Inake/Investigation (Expungement)
-- Root cause: TBD, CJAMS system is working as expected.
-- Pull Request: TBD
-- Reason: Case has been ruled out and investigation decision is available
-- Reason why no related code fix: N/A 

*/

-- CPS-IR CW2917472 
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
    (
        'IR'::character varying,
        'CW2917472'::character varying,
        null::date
    );