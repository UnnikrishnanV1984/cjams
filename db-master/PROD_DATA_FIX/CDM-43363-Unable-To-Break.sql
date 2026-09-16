/*
 Issue Description: Unable to break the link for adoption subsidy 
 Category/Module: Glitch
 Root cause: Data glitch caused a duplicate subsidy rate approval record to appear because of which unable to break the adoption suspension
 Fix provided: DB query to deactivate duplicate the subsidy rate approval record
 Data/Code fix ticket#: CDM-43363
 Regression Impacts: N/A
 Is Code fix Required?: No
 Code fix ticket#: N/A
 Reason why no related code fix: Data error, cannot replicate the issue
 Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
 Backup before update/ delete:Query:
 */
UPDATE
    adoptionagreement
SET
    activeflag = 0,
    updatedby = 'CDM-43363',
    updatedon = now()
WHERE
    adoptionplanningid = '6255cb72-166f-4b72-854e-ee71b710113f'
    AND adoptionagreementid = '1fa618c0-ee27-47c3-8468-6573af9f8cd2';