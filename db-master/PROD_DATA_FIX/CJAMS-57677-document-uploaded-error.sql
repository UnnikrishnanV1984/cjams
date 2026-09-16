/*
 Issue Description:CDM-57677-#221020173136: need to delete file, uploaded to the documents tab in a closed case.
 Category/ Module: delete document download
 Root cause: user uploaded document by mistake
 provided fix: datafix has been promoted for changing the flag status for mentioned document.
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
 */

/*
select * from documentproperties d where ecmsdocumentid in ('67a643ae568f4542a7a7f7fa')
select * from documentattachment d2  where documentpropertiesid  in ('357ef8ac-f157-4786-b688-65c9d664d3e8')
*/

update
    documentproperties
set
    activeflag = 0,
    updatedby = 'CDM-57677',
    updatedon = now()
where
    ecmsdocumentid = '67a643ae568f4542a7a7f7fa'
    and activeflag = 1;

update
    documentattachment
set
    activeflag = 0,
    updatedby = 'CDM-57677',
    updatedon = now()
where
    documentpropertiesid = '357ef8ac-f157-4786-b688-65c9d664d3e8'
    and activeflag = 1;