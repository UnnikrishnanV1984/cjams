-- CDM-42878 - Expungement
/*
-- Issue Description: User requested to expunge the CPS-AR case 202101050101775  
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: 
-- Fix Provided: Datafix has been promoted to update expunge the CPS-AR case 202101050101775.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select vl_sqlcode, vs_err_message from cjams.expungcaserequest(
    'AR'::character varying,'202101050101775'::character varying,null::date
    );