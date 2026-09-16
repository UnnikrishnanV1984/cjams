/*
 Issue: Not opened by supervisor
 Category/Module: assignments
 Root cause: :Case as showing to need assigned on my dashboard
 Fix provided: DB query to soft delete record in routing table
 Data/Code fix ticket#: CDM-44242
 Regression Impacts: N/A
 Is Code fix Required?: No
 Code fix ticket#: N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
 Backup before update/ delete:Query:
 */
UPDATE
    routing
SET
    activeflag = 0,
    updatedby = 'cdm-44242',
    updatedon = NOW()
WHERE
    objectid = '7b21d61b-e4dc-4cc7-b9f1-c085f5551de0'
    AND tosecurityusersid = '6af7a326-0572-4e9c-9d19-e15e2949c5fe'
    AND routingid = 'd0f8ffdf-7f9d-4c6c-b2ab-8a68f1ceb448'
    AND activeflag = 1;