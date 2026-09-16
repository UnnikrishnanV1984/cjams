/*
 Issue Description:221020231934:The 4 documents dated today 1/23/2024 in the closed cps case were uploaded into the wrong case.
 Category/ Module: delete document download
 Root cause: user uploaded document by mistake
 provided fix: datafix has been promoted for changing the flag status for documents uploaded on 01/23/2024 on the case 221020231934.
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
 */

/*
select * from documentproperties d 
where ecmsdocumentid in ('65afde9268490676b9f40396',
'65afde672f95c92814f9fcda','65afde406cdd9153ea035021','65afde092f95c92814f9fc77')

select * from documentattachment d2  
where documentpropertiesid  in 
('e90e5dc2-758e-4f59-bc37-7a51597a99a2',
'318787cf-2853-4426-8549-120da20d0c38',
'1027feea-4a09-4600-b8c8-c92cfcf10691',
'db9e1b45-bb5e-49b9-91ee-cc33638e89ba')

*/

update
    documentproperties
set
    activeflag = 0,
    updatedby = 'CJAMS-49171',
    updatedon = now()
where ecmsdocumentid in 
('65afde9268490676b9f40396',
'65afde672f95c92814f9fcda','65afde406cdd9153ea035021','65afde092f95c92814f9fc77')
    and activeflag = 1;

update
    documentattachment
set
    activeflag = 0,
    updatedby = 'CJAMS-49171',
    updatedon = now()
where documentpropertiesid  in 
('e90e5dc2-758e-4f59-bc37-7a51597a99a2',
'318787cf-2853-4426-8549-120da20d0c38',
'1027feea-4a09-4600-b8c8-c92cfcf10691',
'db9e1b45-bb5e-49b9-91ee-cc33638e89ba') 
and activeflag = 1;