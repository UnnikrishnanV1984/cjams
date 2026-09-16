
/*
Issue Description: 3281049:The worker selected the incorrect name entry for the child as a participant in the visit. We need the participant: "Valentina Hoy" removed and to have participant: VALENTINA HOYHUNTER added. Monthly visit will not show as completed until updated
Category/Module: Bug
Root cause: Users cannot change the contacts nmaes  in  contacts tab, They can able to update 
Fix provided: DB queries to update query to progressnote table
Data/Code fix ticket#: CJAMS-60342
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update  contactparticipant
set participanttypekey  = 'IP',intakeservicerequestactorid = '25f3f28a-5d15-4462-8f2f-3ada0005eb5f',
firstname = 'VALENTINA',lastname ='HOYHUNTER',participantid  = '25f3f28a-5d15-4462-8f2f-3ada0005eb5f',
updatedby = 'CJAMS-60342', updatedon = now()
where contactparticipantid = 'e958b438-7bae-407e-9030-7052172d0b01' and activeflag =1;
          