/*
 Issue Description:CJAMS-59014
 Category/ Module: delete document download
 Root cause: user uploaded document by mistake
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
 */

/*
select activeflag,* from documentproperties where documentpropertiesid in ('6470e373-04da-4290-a90b-7aca87c27f0f','f2a0f2ce-b2df-4243-beb0-b2fdc56d819f')
*/

update
    documentproperties
set
    activeflag = 0,
    updatedby = 'CJAMS-59014',
    updatedon = now()
where
    documentpropertiesid in ('6470e373-04da-4290-a90b-7aca87c27f0f','f2a0f2ce-b2df-4243-beb0-b2fdc56d819f')
    and activeflag = 1;

update
    documentattachment
set
    activeflag = 0,
    updatedby = 'CJAMS-59014',
    updatedon = now()
where
    documentpropertiesid in ('6470e373-04da-4290-a90b-7aca87c27f0f','f2a0f2ce-b2df-4243-beb0-b2fdc56d819f')
    and activeflag = 1;