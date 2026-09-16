/*
 Issue Description:CJAMS-62076
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
    updatedby = 'CJAMS-62076',
    updatedon = now()
where
    ecmsdocumentid = '68c8bf86cc57a61282c7def9'
    and activeflag = 1;

update
    documentattachment
set
    activeflag = 0,
    updatedby = 'CJAMS-62076',
    updatedon = now()
where
    documentpropertiesid = '9bc1866e-07cb-493e-8316-dcf726e668c9'
    and activeflag = 1;