-- CDM-37664 - Reopening appeal case
/* Issue Description: User request to reopened Appeal case so that the finding can be modified per court order

-- case number: 20200244032051
-- intake sevice id: b1ec16fd-e3ff-4c56-8de0-6542a41441ba

-- Category/ Module: Case Timeline 

-- Root cause: User request to reopened Appeal case so that the finding can be modified per court order
-- Fix Provided: Datafix has been provided to open the Appeal case #20200244032051
-- Pull request# N/A

*/

select ca.enddate,* from caseassignment ca WHERE CA.objectid = 'b1ec16fd-e3ff-4c56-8de0-6542a41441ba' and objecttypekey not in ('intake') and CA.activeflag = 1 order by insertedon desc;

UPDATE cjams.caseassignment
SET enddate=null,
updatedby = 'CDM-37664',
updatedon = now()
WHERE caseassignmentid='0941d771-a771-4e5e-8c9a-a885f23f5b17';

select actiondatetime, activeflag, routingstatustypeid, * from routing where objectid = 'b1ec16fd-e3ff-4c56-8de0-6542a41441ba' and eventcode='APPL';

UPDATE cjams.routing
SET activeflag=1,
updatedby = 'CDM-37664',
updatedon = now()
WHERE objectid = 'b1ec16fd-e3ff-4c56-8de0-6542a41441ba' and eventcode='APPL';
