/* 
    Issue Description: CJAMS-66414 User wants below and comment should be 'The family does not reside in Maryland and the alleged incident did not occur in Maryland. Report made to WV.'
    Category/ Module : CPS Response timer
    Root cause: User error and request to correct
    Pull request# for code fix: N/A
    Reason why no related code fix: N/A
    Status of the code fix if already submitted and expected prod fix date: N/A
*/


UPDATE cpsresponsetimeractions
SET caseworkercomments = 'The family does not reside in Maryland and the alleged incident did not occur in Maryland. Report made to WV.',
    updatedon = now(),
    updatedby = 'CJAMS-66414'
WHERE cpsresponsetimeractionsid = 'bbe31f4c-d6a4-4b7b-a290-97ced40dc2f3'
  AND activeflag = 1;