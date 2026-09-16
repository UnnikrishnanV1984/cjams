/*
 Issue Description:CDM-41576
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
    updatedby = 'CDM-41621',
    updatedon = now()
where
    ecmsdocumentid = '66e97ec5b859f909d097cc15'
    and activeflag = 1;

update
    documentattachment
set
    activeflag = 0,
    updatedby = 'CDM-41621',
    updatedon = now()
where
    documentpropertiesid = '0aef77a4-dd4e-4cf1-a375-7e8c29b1e59c'
    and activeflag = 1;