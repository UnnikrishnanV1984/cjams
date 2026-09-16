/*
Issue Description: CDM-44155:Placement approval
Category/Module: Placement
Root cause: Unable to move forward with the placement approval record after supervisor approval.This happens because the exittypekey has to be CIP but
            it has been wrongly updated in the DB as Placement Change in placement.We were unable to reproduce this issue again in local and will closely monitor it
            for future occurrences.
Fix provided: Data fix has been done to update the approval record exit type to CIP in placement revision table.
Data/Code fix ticket#: CDM-44155
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: We are unable to replicate this issue in local and will closely monitor it .
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update placementrevision 
set exittypekey ='CIP',
    updatedby = 'CDM-44155',
    updatedon = now()
where placementid='50a8ce79-11fa-48dd-ae53-14b4b7f2b8e1' and placementrevisionid='3843c6eb-dd13-428e-80a6-7017e95ff0a5' and activeflag=1;