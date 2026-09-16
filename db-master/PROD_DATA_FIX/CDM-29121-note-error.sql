 /*
 Issue Description:CDM-29121
 Category/ Module:contact  status needs to be changed from attempted to completed
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/


update
    progressnote
set
    contactstatus = 'true',
    updatedby = 'CDM-29121',
    updatedon = now()
where
    progressnoteid = 'b132cc8b-e619-44af-87d8-c3bda1d9e713';