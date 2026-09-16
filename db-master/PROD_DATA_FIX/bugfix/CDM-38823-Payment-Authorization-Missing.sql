/*
 Issue Description: CDM-38823
 Category/ Module: FinanceAccountsPayable/Funding approval
 Root cause: Funding approval history status showing as approval in stead of pending because of data error.
 Pull request# for code fix: 
 Reason why no related code fix: Data updation error
 Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
 */
UPDATE routing
SET 
    activeflag = 1,
    updatedby = 'CDM-38823',
    updatedon = now()
WHERE
    routingid = '52ad9923-4fbb-4f10-bfd6-a0bc486d6019'
    AND objectid = '3122727'
    AND activeflag = 0;
