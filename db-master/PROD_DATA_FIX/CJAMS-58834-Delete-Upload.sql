/*
 Issue Description:CJAMS-58834
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
    updatedby = 'CJAMS-58834',
    updatedon = now()
where
    documentpropertiesid = '7e2281bd-f994-4a91-9d41-c52458af5066'
    and activeflag = 1;

update
    documentattachment
set
    activeflag = 0,
    updatedby = 'CJAMS-58834',
    updatedon = now()
where
    documentpropertiesid = '7e2281bd-f994-4a91-9d41-c52458af5066'
    and activeflag = 1;