/*
Issue Description:CDM-42876: Unable to delete SAFE-C. Worker, supervisor, and another supervisor have tried. A pop up says assessment has been deleted, but then the SAFE-C is still there
Category/Module: Assessments: SAFE-C
Root cause: User is unable to delete safe-c assessment as there is a safe-c in review state created on the same day and not approved by the supervisor.
Fix provided: Data fix has been done to delete the safe-c in review state from supervisor dashboard.
Data/Code fix ticket#: CDM-42918
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update assessment
set activeflag = 0,
    updatedby = 'CDM-42876',
    updatedon = now()    
where objectid='f7ee0aff-e618-4dcd-95f3-0a2ff1c2b67a' 
and activeflag =1 
and assessmentid='0f401524-b4df-41ad-b815-3b3b15f6e55d';

update assessmentactor
set activeflag = 0,
    updatedby = 'CDM-42876',
    updatedon = now()    
where assessmentid='0f401524-b4df-41ad-b815-3b3b15f6e55d'
and activeflag =1;

update assessmentcomments
set activeflag = 0,
    updatedby = 'CDM-42876',
    updatedon = now()    
where assessmentid='0f401524-b4df-41ad-b815-3b3b15f6e55d'
and activeflag =1;

update assessment_history
set activeflag = 0,
    updatedby = 'CDM-42876',
    updatedon = now()    
where assessmentid='0f401524-b4df-41ad-b815-3b3b15f6e55d'
and activeflag =1;

update assessmentsubmission
set activeflag = 0,
    updatedby = 'CDM-42876',
    updatedon = now()    
where assessmentid='0f401524-b4df-41ad-b815-3b3b15f6e55d'
and activeflag =1;

update routing
set activeflag = 0,
    updatedby = 'CDM-42876',
    updatedon = now()    
where objectid='f7ee0aff-e618-4dcd-95f3-0a2ff1c2b67a'
and activeflag =1;