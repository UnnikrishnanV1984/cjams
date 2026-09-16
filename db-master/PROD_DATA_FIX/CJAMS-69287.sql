/*

-- CJAMS-69287 - Unable to find Service log
-- Root cause: PA routing for auth 4449065 & 4449049 (service log 261030656350) was sent to an
--             individual PM (eventcode='PCAUTH', tosecurityusersid=AmeshaTinkler) instead of the
--             role-based PM box (eventcode='PCAUTHR', tosecurityusersid=NULL), so no one else could find them.
-- Fix: Data fix is done to move  both records to the role-based Program Manager approval box.
-- Is code fix required: N 
-- Why no code fix is required: N/A , since we are routingthe Purchase authorization to all program managers
 */
UPDATE cjams.routing
SET
    eventcode = 'PCAUTHR',
    tosecurityusersid = NULL,
    updatedby = 'CJAMS-69287',
    updatedon = now ()
WHERE
    routingid IN (
        '357d803e-e895-4e8e-adb6-4b2825f69c5d', -- auth 4449065
        'e1f3aff6-8a47-45eb-9d93-ad3884cec98c'
    ) -- auth 4449049
    AND eventcode = 'PCAUTH' and  toroleid = 'LDSSPM'
    and routingstatustypeid = 42
    and activeflag = 1;