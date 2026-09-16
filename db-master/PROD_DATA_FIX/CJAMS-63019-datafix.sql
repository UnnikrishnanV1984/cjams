/*
 Issue Description:CJAMS-63019
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
    updatedby = 'CJAMS-63019',
    updatedon = now()
where
    documentpropertiesid ='66c29317-45af-48a2-8434-3c679f1d2af5'
    and activeflag = 1;

update
    documentattachment
set
    activeflag = 0,
    updatedby = 'CJAMS-63019',
    updatedon = now()
where
    documentpropertiesid ='66c29317-45af-48a2-8434-3c679f1d2af5'
    and activeflag = 1;