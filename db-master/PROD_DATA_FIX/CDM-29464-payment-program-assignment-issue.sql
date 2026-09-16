/*
 Issue Description:CDM-29464
 Category/ Module:program assignment enddate
 Root cause: update
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
 */
update
    personprogramarea
set
    enddate = null,
    updatedon = now(),
    updatedby = 'CDM-29464'
where
    personprogramid = '778809e0-ed9b-41a8-965b-71910394b91d';