/*
Issue: PLACEMENT
Category/Module: Placement
Root cause: Unable to approve the latest as there are already rejected placements that are in open.This is an existing system behaviour
            and data fix needs to be done to delete the previous two rejected placement.
            Code fix ticket was opened for this and it is not needed and we are doing just data fix to resolve it.
Fix provided: Data fix has been done to delete the two rejected ER Placements after having a discussion with Krishna.
Data/Code fix ticket#: CJAMS-62453
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This issue needs a data fix and as per the system design we dont allow to close and placement when we are having open placement.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update placement 
set activeflag = 0,
    updatedby = 'CJAMS-62453',
    updatedon = now()
where placementid in ('af7df0a5-22ed-415c-bee3-b94655dd509b','34ba668c-ab08-4cbe-a923-b007bfc80109')
and activeflag = 1;    

update placementrevision 
set activeflag = 0,
    updatedby = 'CJAMS-62453',
    updatedon = now()
where placementid in ('af7df0a5-22ed-415c-bee3-b94655dd509b','34ba668c-ab08-4cbe-a923-b007bfc80109')
and activeflag = 1;    

update routing
set activeflag = 0,
    updatedby = 'CJAMS-62453',
    updatedon = now()
where objectid in ('af7df0a5-22ed-415c-bee3-b94655dd509b','34ba668c-ab08-4cbe-a923-b007bfc80109')
and activeflag = 1;

update livingarrangement
set activeflag = 0,
    updatedby = 'CJAMS-62453',
    updatedon = now()
WHERE
    placementid in  ('af7df0a5-22ed-415c-bee3-b94655dd509b','34ba668c-ab08-4cbe-a923-b007bfc80109')
    and activeflag = 1;