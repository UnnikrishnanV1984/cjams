/* 
    Issue Description: CJAMS-61088 Initial Timeliness Reconciliation
    Category/ Module : CPS Response timer
    Root cause: User error and request to correct
    Pull request# for code fix: N/A
    Reason why no related code fix: N/A
    Status of the code fix if already submitted and expected prod fix date: N/A
*/


UPDATE cpsresponsetimeractions
SET caseworkercomments = 'Worker had a personal emergency that prevented them from making additional reasonable efforts to meet the mandate.'
WHERE intakeserviceid = '100c8468-b4ab-40eb-b9b1-9d173488b93b'
AND cpsresponsetimeractionsid = '6886c8e4-8347-4e01-aa72-57e66dba4102';