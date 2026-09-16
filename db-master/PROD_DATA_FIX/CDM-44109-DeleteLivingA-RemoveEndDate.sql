/*
Issue Description: Please do the data fix to remove the following 
living arrangement and remove the end date for the Hospitalization record
Category/Module: Support
Root cause: user can not delete exisiting placements.
Fix provided: DB queries to create new record in routing  and placement table.
Data/Code fix ticket#: CDM-44109
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
*/

-- updating livingarrangement (07a99ff2-f1dc-4325-95ad-c516cf852955)
update livingarrangement 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-44109'
where placementid = '07a99ff2-f1dc-4325-95ad-c516cf852955' and activeflag =1;

-- updating placementrevision (07a99ff2-f1dc-4325-95ad-c516cf852955)
update placementrevision
set activeflag = 0, updatedon = now(), updatedby = 'CDM-44109'
where placementid = '07a99ff2-f1dc-4325-95ad-c516cf852955' and activeflag =1;

-- updating placement (07a99ff2-f1dc-4325-95ad-c516cf852955)
update placement
set activeflag = 0, updatedon = now(), updatedby = 'CDM-44109'
where placementid = '07a99ff2-f1dc-4325-95ad-c516cf852955' and activeflag =1;

--placementrevision (removal end date and end time )
update placementrevision
set enddate = null, endtime = null ,updatedon = now(), updatedby = 'CDM-44109'
where placementid = '8c6f2846-1e62-4fc7-9651-e45011d85fd7' and activeflag =1;

--placement (removal end date and end time )
update placement
set enddatetime  = null, endtime = null ,updatedon = now(), updatedby = 'CDM-44109'
where placementid = '8c6f2846-1e62-4fc7-9651-e45011d85fd7' and activeflag =1;

--livingarrangement (removal end date and end time )
update livingarrangement
set livingenddate  = null,updatedon = now(), updatedby = 'CDM-44109'
where placementid = '8c6f2846-1e62-4fc7-9651-e45011d85fd7' and activeflag =1;


--update routing
update routing
set activeflag = 0, updatedon = now(), updatedby = 'CDM-44109'
where routingid in ('cb9af294-a4e0-495b-9b3e-c5dfae0ed71b', '080f1be9-7220-4703-9242-e963208fbb6d','4f5c7129-7960-4d9e-a30c-2f348f84b9a7') and activeflag = 1;


--update routing
update routing
set activeflag = 0, updatedon = now(), updatedby = 'CDM-44109'
where routingid in ('67277f2a-d483-4871-80a0-c80cc0c3911d', 'e27ed6cb-df1f-4c33-9fe8-bbbda4490f66','e3e02a1f-747a-4a0c-ada2-5cb9fd136855','aa952ffc-58c9-469f-9dda-d75711be8027') and activeflag = 1;


