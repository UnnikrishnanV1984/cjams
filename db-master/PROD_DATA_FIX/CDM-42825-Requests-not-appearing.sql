/*
 Issue Description: CDM-42825-Request-Not-appearing
  Category/ Module  : Case Assignment Dashboard
    Root cause: Due to a glitch/network connectivity error, requests was not processed completely.
  Pull request# for code fix: 
    Reason why no related code fix: 
    data fix issue, 
 Backup before update/ delete:
 */
update
    ivecaseclosurereview
set
    activeflag = 0,
    updatedby = 'CDM-42825',
    updatedon = now()
where
    objectid = '2ee478f0-2ab1-4b34-9e09-c03871371652'
    and activeflag = 1;