/*
-- CJAMS-69027 - Release Program Managers Service Logs who are NO longer employed with BCDSS
-- Root cause: 10 PA service logs are pending Program Manager approval (routingstatustypeid=42)
--             as eventcode='PCAUTH' pinned to two departed (inactive) Program Managers -
--             Teneill Wilson  and Deborah Ramelmeier . Since these users
--             are no longer employed, the requests sit in their individual box and no one else
--             can approve them.
-- Fix: Data fix to release the records to the role-based Program Manager in-box, so any PM in the county can approve them.
-- Is code fix required: N
-- Why no code fix is required: N/A, data-only correction of misrouted records.
 */

UPDATE cjams.routing
SET
    eventcode = 'PCAUTHR',
    tosecurityusersid = NULL,
    updatedby = 'CJAMS-69027',
    updatedon = now ()
WHERE
    objectid IN (
        '1801971','1839593','1839594','1841639','1846304','1870476','1877986',
        '3672102','3818959','3910900'
    )
    AND eventcode = 'PCAUTH'
    AND toroleid = 'LDSSPM'
    AND routingstatustypeid = 42
    AND activeflag = 1;
