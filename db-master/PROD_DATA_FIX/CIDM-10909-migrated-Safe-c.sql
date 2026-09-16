/*
 * CIDM-10909-migrated-Safe-c
 * Customer Email ID: leslie.valerio1@maryland.gov
 * Focus Area: safeC assessment
 * migrated Safe-c assessment client information is not populating
    Safe - c dates
    03/06/2020 - 1:14:05 PM 
    01/07/2019 - 3:33:29 PM
    04/30/2015 - 5:05:34 PM
    Case number - 325190 
 * Root cause: data format error on the migrated data.
 */

UPDATE submissioncollection
SET datavalue = 'MAKENZIE  ELLIOTT',
    updatedby = 'CIDM-10909',
    updatedon = now()
WHERE submissioncollectionid in ('f20ab154-5cc2-4702-87c1-3820e6f99af9', 'ff10573f-b992-4839-be3e-819c8394a609')
  AND activeflag = 1;