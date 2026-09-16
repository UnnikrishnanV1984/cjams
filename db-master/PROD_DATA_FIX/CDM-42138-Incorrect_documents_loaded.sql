/*
 Issue Description:CDM-42138-#3164755:Need documents ending in 9370 and 9410 deleted. They were uploaded to this case record in error.
 Category/ Module: delete document download
 Root cause: user uploaded document by mistake
 provided fix: datafix has been promoted for changing the flag status for documents ending in 9370 and 9410.
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
 */

/*
select * from documentproperties d where ecmsdocumentid in ('670805b253ec5e3c56b4f2e5','6708053f9d29e20c8feb0cad')
*/
/*
select * from documentattachment d2  where documentpropertiesid  in ('8f54170f-54b3-470a-943d-278a1ddf8a0a','a9c4bf62-b929-4a29-91b1-45c956c2d54e')
*/

update
    documentproperties
set
    activeflag = 0,
    updatedby = 'CDM-42138',
    updatedon = now()
where
    ecmsdocumentid in ('670805b253ec5e3c56b4f2e5','6708053f9d29e20c8feb0cad')
    and activeflag = 1;

update
    documentattachment
set
    activeflag = 0,
    updatedby = 'CDM-42138',
    updatedon = now()
where
    documentpropertiesid in ('8f54170f-54b3-470a-943d-278a1ddf8a0a','a9c4bf62-b929-4a29-91b1-45c956c2d54e')
    and activeflag = 1;