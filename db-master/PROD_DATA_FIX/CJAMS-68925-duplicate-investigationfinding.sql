/*
-- Issue Description: CJAMS-68925 Delete duplicate investigation finding
-- Category/ Module: Inverstigation Finding  (Case Management) 
-- Root cause: User error
---Fix Provided: Datafix has been provided for deleting the duplicate investigation Findings
*/


update investigationallegation
set activeflag=0, updatedby ='CJAMS-68925', updatedon=now()
where investigationallegationid='8c03f3f6-eabe-4aa4-842e-a4660f91377d' and investigationid='5f0dd8f0-d8e2-4a02-a746-b4596126e9e4' and activeflag=1;