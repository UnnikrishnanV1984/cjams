 /*
 Issue Description:CDM-28972
 Category/ Module:contact  status needs to be changed from completed to attempted
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/


update
    progressnote
set
    contactstatus = 'false',
    updatedby = 'CDM-28972',
    updatedon = now()
where
    progressnoteid = '7fd1956d-6f6f-4d68-a695-372d31ec1ccc';