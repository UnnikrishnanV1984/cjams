/*
   Issue Description: CDM-32025
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/






-- CDM-32154
--871fb22b-0ac6-42e9-93c2-337c4a28d176
--4eafdce4-9ce9-46fb-bbe0-46dbd1604908
--a3378274-5a52-4025-a975-8788412f64df
--d60833e2-0cd8-4d30-9222-9d144490cac3
--ec5596de-0ae8-4877-b699-d3d1c51e2b38
 update documentproperties set insertedby = 'd60833e2-0cd8-4d30-9222-9d144490cac3', updatedby = 'CDM-32102', updatedon = now()
where documentpropertiesid in ('bd27ae6d-d51b-4bea-b874-19d713f540b0',
'8a66e5fd-5ca0-4436-b6bb-64cb8c28af2f',
'ddc3457d-c6fc-4b75-b596-358ecafe22f8',
'19bba8c0-52ce-4c7a-8ecf-ae93cc6c28f6',
'df81033c-cb41-4483-8977-5910b616cf61');

-- CDM-32154
--871fb22b-0ac6-42e9-93c2-337c4a28d176
--4eafdce4-9ce9-46fb-bbe0-46dbd1604908
--a3378274-5a52-4025-a975-8788412f64df
--d60833e2-0cd8-4d30-9222-9d144490cac3
--ec5596de-0ae8-4877-b699-d3d1c51e2b38
 update documentattachment set insertedby = 'd60833e2-0cd8-4d30-9222-9d144490cac3', updatedby = 'CDM-32102', updatedon = now()
where documentpropertiesid in ('bd27ae6d-d51b-4bea-b874-19d713f540b0',
'8a66e5fd-5ca0-4436-b6bb-64cb8c28af2f',
'ddc3457d-c6fc-4b75-b596-358ecafe22f8',
'19bba8c0-52ce-4c7a-8ecf-ae93cc6c28f6',
'df81033c-cb41-4483-8977-5910b616cf61');

