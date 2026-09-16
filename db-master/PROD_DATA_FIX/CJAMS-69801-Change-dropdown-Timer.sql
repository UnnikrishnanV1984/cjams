/* 
    Issue Description: CJAMS-69801 User wants below and comment should be 'The family does not reside in Maryland and the alleged incident did not occur in Maryland. Report made to WV.'
    Category/ Module : CPS Response timer
    Root cause: User error and request to correct
    Pull request# for code fix: N/A
    Reason why no related code fix: N/A
    Status of the code fix if already submitted and expected prod fix date: N/A
*/


UPDATE cpsresponsetimeractions
SET cpsresponsetimerreason4 ='OOCN' ,cpsresponsetimerreason5 ='OFMN' ,
    updatedon = now(),
    updatedby = 'CJAMS-69801'
WHERE cpsresponsetimeractionsid = '379228e0-cf9b-45a2-bcbb-f90c6031fd04'
  AND activeflag = 1;