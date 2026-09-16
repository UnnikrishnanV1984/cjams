/*
 Issue Description:CJAMS-59247
 Category/ Module: delete document download
 Root cause: user uploaded document by mistake
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
 */

 update
    documentproperties
set
    activeflag = 0,
    updatedby = 'CJAMS-59065',
    updatedon = now()
where
    documentpropertiesid = '6c6e692c-b83c-4f1f-84b6-9452bd223a4e'
    and activeflag = 1;

update
    documentattachment
set
    activeflag = 0,
    updatedby = 'CJAMS-59065',
    updatedon = now()
where
    documentpropertiesid = '6c6e692c-b83c-4f1f-84b6-9452bd223a4e'
    and activeflag = 1;