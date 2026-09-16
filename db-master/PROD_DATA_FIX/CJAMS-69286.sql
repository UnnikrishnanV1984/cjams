/*
-- CJAMS-69286 - Service logs not showing up
-- Root cause: 14 PA routings (service logs) got stuck at Funding Approval (routingstatustypeid=40)
--             as eventcode='PCAUTH' pinned to the CW supervisor (tosecurityusersid=JasonSammons)
--             with toroleid='CWSP', so they never reached the fiscal queue - neither the Fiscal
--             Supervisor / Finance Worker nor the CW supervisor could find them.
-- Fix: Data fix to move the records to the role-based funding-approval box
--      (eventcode='PCAUTHR', tosecurityusersid=NULL, toroleid='FNSFW').
-- Is code fix required: N
-- Why no code fix is required: N/A, data-only correction of misrouted records.
 */

UPDATE cjams.routing
SET
    eventcode = 'PCAUTHR',
    tosecurityusersid = NULL,
    toroleid = 'FNSFW',
    updatedby = 'CJAMS-69286',
    updatedon = now ()
WHERE
    objectid IN (
        '4455347','4456174','4456167','4449546','4447635','4447633','4447631',
        '4447629','4447622','4447619','4447616','4447614','4447609','4447607'
    )
    AND eventcode = 'PCAUTH'
    AND toroleid = 'CWSP'
    AND routingstatustypeid = 40
    AND activeflag = 1;
