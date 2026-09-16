/*
Issue Description: CDM-44206
User request remove the case assignment and close the case as intake, 
persons and contacts data are not available and need to removed it on workload.
Category/Module: Support
Root cause: remove the case assignment and close the case  as intake, 
persons and contacts data are not available and need to removed it on workload.
Fix provided: Data fix to remove the case assignment and close the case as intake, 
persons and contacts data are not available and need to removed it on workload.
Data/Code fix ticket#: CDM-43976
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update caseassignment
set enddate = '2025-01-17 00:00:00',
    updatedby = 'CDM-44206',
    updatedon = now()
where caseassignmentid in ('0870ab69-a451-44f7-baab-da051fddacba','b0d002d6-6bf8-4c4b-8c12-c59940c65921')
and activeflag = 1;

UPDATE servicecase
SET statustypekey='Closed', dispositioncode='Closed',
 updatedon = now(),
 updatedby = 'CDM-44206'
   where servicecaseid = '8be78793-4bd8-4cb2-a9a7-7f261db6b044'
and activeflag = 1;

update servicecasedisposition
set intakeserreqstatustypekey = 'Closed',
dispositioncode = 'Closed',
    updatedby = 'CDM-44206',
    updatedon = now()
where servicecasedispositionid = 'ca6dfdc6-fe0f-45fb-a151-b40a87169d2b' and activeflag = 1;

UPDATE cjams.intakeservicerequest
SET intakeserreqstatustypeid='7995cecb-062d-406c-8ea9-b1da4b1877d8',  updatedby='CDM-44206', updatedon=now()
WHERE intakeserviceid='df5b70f0-30c4-4c39-90eb-b1e80d5123a5' and servicerequestnumber='211020132201';

UPDATE IntakeServiceRequestDispositionCode 
SET servicerequesttypeconfigiddispostionid = 'd90db0d3-f665-49db-b3ad-0edb468bc02d',
updatedby = 'CDM-44206',updatedon = now() 
WHERE intakeserviceid = 'df5b70f0-30c4-4c39-90eb-b1e80d5123a5' and activeflag = 1;


