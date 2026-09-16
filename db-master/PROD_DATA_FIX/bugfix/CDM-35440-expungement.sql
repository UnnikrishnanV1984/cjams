-- CDM-35440 - Expungements
/*
-- Issue Description: 
	User request To Expunge CPS Case CW2162248 as we have the SSA/Product Owner approval on that.

-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Fix Provided: Datafix has been promoted to update expunge/updated to Unsubstatiated Neglect the CPS-IR # CW2162248
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
    (   'IR'::character varying,
        'CW2162248'::character varying,
        null::date
    ) ;