-- CDM-38579 
/*
Issue Description:
    User request for Expungement 
    CW2864659 - UnsubstantiatedCaes should have beene xpungement 5/4/2021

-- Category/Module: Inake/Investigation (Expungement)
-- Root cause: TBD, CJAMS system is working as expected.
-- Pull Request: TBD
-- Reason why no related code fix: N/A 

*/

-- CPS-IR CW2864659 
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
    (
        'IR'::character varying,
        'CW2864659'::character varying,
        null::date
    );

